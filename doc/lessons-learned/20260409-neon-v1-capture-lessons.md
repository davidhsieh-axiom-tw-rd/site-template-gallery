# Joy Neon V1 版型復刻經驗教訓

> 日期：2026-04-09
> 版型：`2026-04-08-joy-neon-v1`（Joy Neon V1）
> 原站：`https://joy.star-link-rel.cc/`
> Skin 路徑：`61-1-22`（新路徑，不同於之前的 `11-1-2` / `6-1-1`）

---

## 問題 1：登入/註冊按鈕顏色不是白色

### 現象
復刻版的登入按鈕用了白色邊框+白色文字，註冊按鈕用了白色填充+深色文字。但實際原站截圖比對時 Nav 區域只有 35% 相似度。

### 根本原因
原站的登入按鈕是 **藍色邊框 + 藍色文字**（`#0A69FF`），註冊按鈕是 **藍色填充 + 白色文字**。不是常見的白色/灰色配色。

### 解決方案
用 `page.evaluate()` + `getComputedStyle()` 精確量測按鈕樣式：
- `border: 1px solid rgb(10, 105, 255)`
- `border-radius: 6px`（不是 18px 圓角）
- `width: 72px; height: 30px`
- `font-size: 13.2px`

### 驗證方式
odiff 分段比對 Nav 區域

### 教訓
**不要用截圖目測按鈕顏色，要用 `getComputedStyle()` 精確擷取。** 深色背景上的藍色和白色很難分辨。

---

## 問題 2：遊戲卡片圖片圓角差異

### 現象
遊戲卡片圖片的圓角目測約 10px，但比對時卡片區域有明顯差異。

### 根本原因
原站遊戲卡片縮圖的 `border-radius` 是 `14.3976px`（非整數），而非目測的 10px。

### 解決方案
使用 `getBoundingClientRect()` + `getComputedStyle()` 量測：
```css
.game-card-content img {
  border-radius: 14.4px;  /* 原站精確值 */
  width: 84px;
  height: 84px;
}
```

### 教訓
**圓角、字體大小等 CSS 值必須精確量測，不能目測。** 4px 的圓角差異在 odiff 比對中會產生明顯像素差。

---

## 問題 3：E2E 測試需要特定 CSS class 名稱

### 現象
E2E 測試 4 項失敗：
1. CSS 缺少 `Flutter:` 註解
2. 遊戲區塊缺少 `platform-section` class
3. Footer 缺少 `footer-links` / `footer-col` class
4. `similarity` 為 0

### 根本原因
`e2e-verify.sh` 用 `grep` 檢查特定 class 名稱和字串，不是語義分析。新版型的 HTML 用了不同的 class 名稱但功能相同。

### 解決方案
1. CSS 變數註解加 `Flutter:` 前綴（如 `/* Flutter: brandPrimary50 → ... */`）
2. 遊戲分類區塊加 `platform-section` class
3. Footer nav 加 `footer-links` / `footer-col` class
4. 做 odiff 比對填入真實 similarity 分數

### 驗證方式
`bash scripts/e2e-verify.sh 2026-04-08-joy-neon-v1` → 30/30 PASS

### 教訓
**建立新版型時，先讀 `e2e-verify.sh` 的 grep 檢查項目，確保 HTML 使用正確的 class 命名慣例。** 特別是：
- `Flutter:` 註解（T3 line 240）
- `platform-section` class（T3-R4 line 382）
- `footer-links` / `footer-col` class（T3-R7 line 409）
- `footer-license` / `牌照合规` 文字（T3-R7 line 413）
- `footer-contact` / `联系我们` 文字（T3-R7 line 417）

---

## 問題 4：AVIF 圖片 CDN vs 本地解碼差異

### 現象
遊戲卡片區域（Game Grid）odiff 比對只有 73.8% 相似度，即使 CSS 佈局完全正確。

### 根本原因
同一張 AVIF 圖片從原站 CDN 載入 vs 從本地檔案載入時，瀏覽器的 AVIF 解碼器會產生不可消除的亞像素色差。這與 Warm V1（85%）是相同的已知問題。

### 解決方案
無法技術上消除。誠實記錄在 `similarityNote` 中：
```json
"similarityNote": "...遊戲卡片區（74%）受限於 AVIF CDN vs 本地解碼差異..."
```

### 教訓
**AVIF 解碼差異是不可消除的底線，接受並誠實記錄。** 不要為了衝高分數而造假。

---

## 問題 5：自我禁止圖示誤用

### 現象
Footer 的「自我禁止」使用了禁止符號（圓圈加斜線），但原站用的是雙人頭像圖示。

### 根本原因
沒有仔細觀察原站的 icon 形狀，直覺認為「禁止」就是禁止符號。

### 解決方案
改用雙人 SVG icon（people group icon），更接近原站的人形圖示。

### 教訓
**每個 icon 都要跟原站截圖逐一比對，不要根據文字含義推斷 icon 形狀。**

---

## 新版型特徵摘要

| 項目 | 值 |
|------|-----|
| Skin 路徑 | `61-1-22` |
| 主色 | `#0A69FF`（亮藍） |
| 背景 | `#061325`（極深海軍藍） |
| Game Grid | 2 列 207px grid, 7 區塊 |
| 「更多」選單 | Popover（非 Drawer） |
| E2E | 30/30 PASS |
| Similarity | 82%（排除動態區域） |
