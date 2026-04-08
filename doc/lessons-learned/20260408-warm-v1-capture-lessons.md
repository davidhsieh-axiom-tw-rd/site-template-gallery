# Joy Warm V1 版型擷取教訓

> 日期：2026-04-08
> 版型：`2026-04-08-joy-warm-v1`
> 最終相似度：85%（threshold 0.3）

---

## 問題 1：下載的圖片是 HTML 錯誤頁面（假圖片）

### 現象
icon 和 UI 裝飾圖顯示為破圖。用 `file` 指令檢查發現 10 個 `.avif` 檔案實際內容是 `HTML document text`。

### 根本原因
原站的 skin asset 路徑有多種變體（`11-1-2/web/home/`、`11-1-2/common/home/`、`11-1-common/common/home/`），curl 下載時用了錯誤路徑，原站回傳 HTML 錯誤頁但 HTTP 200，curl 照存。

### 解決方案
```bash
# 下載後必須驗證檔案格式
find assets/ -type f \( -name "*.avif" -o -name "*.webp" \) -exec sh -c \
  'file "$1" | grep -q "text" && echo "BROKEN: $1"' _ {} \;
```

### 教訓
**下載 assets 後必須用 `file` 指令驗證每個檔案的格式**。已加入 E2E 測試 T3-R2。

---

## 問題 2：HTML 中混用遠端 URL 和本地路徑

### 現象
遊戲卡片的 `<img src>` 改成了本地路徑（載入正常），但 CSS `background-image: url(...)` 和其他裝飾圖仍指向原站遠端 URL，被 CORS/referer 擋住導致破圖。

### 根本原因
implementer agent 只被指示改 `<img>` 的 src，沒被要求改 CSS 中的 `background-image` URL。

### 解決方案
用 grep 找出所有殘留遠端 URL，用 sed 批次替換為本地路徑：
```bash
# 確認零殘留
grep -c "joy\.star-link-rel\.cc" index.html  # 必須為 0
```

### 教訓
**所有圖片引用（`<img src>`、CSS `background-image`、JS 中的 URL）都必須統一改為本地路徑**。已加入 E2E 測試 T3-R1。

---

## 問題 3：未滾動載入 lazy loading 內容就開始復刻

### 現象
復刻版只有「热门游戏」區塊，缺少 PG/WG/LG/MG/CQ9/JDB/BBIN/Playtech/PA/PP 共 10 個平台遊戲區。

### 根本原因
原站使用虛擬滾動（`_list-slide-layout`），遊戲區只在滾動到附近時才載入 DOM。第一次擷取時沒有充分滾動就開始復刻。

### 解決方案
擷取前必須：
1. 找到主滾動容器（`_main_pjnd2` class）
2. 慢速滾動到底部（step 500px, delay 200ms）
3. 等待 1 秒讓所有 lazy content 載入
4. 再滾回頂部開始擷取

### 教訓
**Phase 1 擷取必須先滾動到最底部載入所有內容，再滾回頂部開始作業**。已加入 E2E 測試 T3-R4（平台區 >= 5）。

---

## 問題 4：原站 Dialog 遮罩導致截圖模糊

### 現象
原站截圖全部模糊，以為是 skeleton loading placeholder，後來發現是前景的 Dialog/彈窗遮罩造成的背景模糊。

### 根本原因
原站進入首頁後會彈出多個彈窗（宣傳、抽獎、cookie consent），這些彈窗的遮罩層會讓背景模糊。必須先關閉所有彈窗才能取得清晰截圖。

### 解決方案
```javascript
// 移除所有彈窗和遮罩
const selectors = ['[class*="popup"]', '[class*="modal"]', '[class*="dialog"]',
  '[class*="overlay"]', '[class*="mask"]', '[class*="lottery"]', '[class*="lucky"]',
  '[class*="float-notice"]', '[class*="activity"]'];
selectors.forEach(sel => {
  document.querySelectorAll(sel).forEach(el => {
    const z = parseInt(getComputedStyle(el).zIndex) || 0;
    const pos = getComputedStyle(el).position;
    if (z > 10 || pos === 'fixed' || pos === 'absolute') el.remove();
  });
});
```

### 教訓
**截圖前必須移除所有 z-index > 10 的 fixed/absolute 元素（彈窗遮罩）**。之前的 CAPTURE-PROMPT 只說「關閉彈窗」但沒有具體到移除遮罩。

---

## 問題 5：SVG icon 的座標系統問題

### 現象
「自我禁止」icon 從原站複製了完整的 SVG path data，但在克隆版中不可見。

### 根本原因
原站的 SVG 使用多層 `transform: translate()` 把路徑從遠處座標（`-5633, -13022`）映射到 viewBox（`0 0 80 60`）。直接複製時漏了 path 元素上的 `transform="translate(114 3842.003)"`。

### 解決方案
用 Canvas API 在原站瀏覽器中把 SVG 渲染成 PNG base64，下載為本地圖片。
```javascript
const svgData = new XMLSerializer().serializeToString(svg);
const blob = new Blob([svgData], { type: 'image/svg+xml' });
const img = new Image();
img.onload = () => {
  const canvas = document.createElement('canvas');
  canvas.getContext('2d').drawImage(img, 0, 0);
  // canvas.toDataURL('image/png') → 存為本地 PNG
};
```

### 教訓
**複雜 SVG（多層 transform）不要直接複製 path，用 Canvas 渲染成 PNG 圖片**。

---

## 問題 6：odiff 像素比對的 threshold 選擇

### 現象
用 threshold 0.1 比對時，整體相似度只有 54%。但肉眼看結構明顯正確。

### 根本原因
threshold 0.1 對亞像素色差極度敏感。同一張 AVIF 圖從 CDN URL 和本地檔案載入時，瀏覽器 AVIF 解碼器會產生微小的色彩差異（同一卡片即有 ~29% diff）。

### 解決方案
- threshold 0.1：嚴格比對，只適合相同來源的圖片
- **threshold 0.3**：正常視覺容差，過濾亞像素色差，適合跨來源比對
- threshold 0.5：寬鬆比對

### 教訓
**跨來源圖片比對用 threshold 0.3**，同來源用 0.1。AVIF 圖片的 CDN vs 本地解碼差異是不可消除的底線。

---

## 問題 7：registry.json 排序

### 現象
最新版型排在最後面。

### 解決方案
按照最後擷取時間排序，最新的在前面。

---

## E2E 回歸測試清單（本次新增 9 項）

| ID | 測試 | 保護問題 |
|----|------|---------|
| T3-R1 | 無遠端 URL | 問題 2 |
| T3-R2 | asset 格式正確 | 問題 1 |
| T3-R3 | 邊框裝飾 >= 20 | 缺邊框 |
| T3-R4 | 平台區 >= 5 | 問題 3 |
| T3-R5 | Tab Bar icon >= 40px | icon 太小 |
| T3-R6 | 側邊欄子選單 >= 10 | 選單不可展開 |
| T3-R7 | Footer 完整 | 缺底部區域 |
| T3-R8 | 18plus.avif 有效 | 問題 1 |
| T3-R9 | telegram.avif 有效 | 問題 1 |
