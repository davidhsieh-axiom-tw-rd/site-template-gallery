# 版型擷取與復刻 — 標準作業提示詞

> 每次擷取新版型時，把此文件內容作為 prompt 的一部分傳入。
> 最後更新：2026-04-11

---

## 任務描述

你要復刻 `https://joy.star-link-rel.cc/` 的首頁。這個網站會定期更換版型（skin），每次換版型時都要：
1. 截圖並與所有現有版型比對（odiff, >90% 相似 = 重複，跳過）
2. 如果是新版型 → 完整復刻成可互動的 HTML
3. 加入 Gallery 展示系統
4. 驗證品質達 90%+ 後才交付

---

## 關鍵原則（踩坑教訓）

### 復刻 = 用原始素材，不造輪子
- **背景圖**：直接用原始 URL（如 `cjc1_style_2_bg.webp`），不要用 CSS 漸層模擬
- **Icon 圖片**：直接用原始站的圖片 URL，不要用 emoji 替代
- **Icon `_1` 後綴**：原站 icon 分兩版（`icon_dtfl_rm.avif` 彩色版 vs `icon_dtfl_rm_1.avif` 扁平版）。分類 tab 和 section header 通常用 `_1` 扁平版，sidebar drawer 用彩色版。**一定要從原站 DOM 確認實際用哪個版本**
- **「更多」選單**：從原始站擷取所有 icon URL + 文字，不要自己編
- **字體/顏色**：從原始站的 CSS 變數擷取精確值，不要猜
- **CSS 量測用 `getComputedStyle`**：不能目測。特別是 padding、font-size、background-color、border-radius
- **`box-sizing: border-box`**：原站框架自帶，復刻版需顯式設定，否則 padding 會撐開高度

### 寬度必須精確
- 原始站 HTML `max-width: 449.775px`，實際渲染 **450px**
- 復刻版 `.page` 設 `max-width: 450px; margin: 0 auto;`
- 桌面版要居中顯示 H5 手機版型，`body { background: #e8e8e8; }`
- **不要用 viewport-based media query 改 grid 列數**（因為容器固定 450px）

### 佈局結構
- **遊戲分類側邊欄**：貫穿整個遊戲區域（熱門 + 所有分類），`position: sticky`
- **熱門遊戲卡片**：3 列 grid（個別遊戲，用 `background-image` 不是 `<img>`）
- **平台遊戲卡片（捕鱼/电子/棋牌等）**：**2 列 grid**（平台卡片），不是 3 列
- **底部 Tab Bar + Cookie Banner**：都要限制在 450px 居中

### JACKPOT 區域
- **`cjc1_style_2_bg.webp` 已包含所有裝飾**（魚、JACKPOT 文字、數字框），不要額外疊加
- 只需在背景圖的數字框位置用 absolute positioning 放數字文字
- **不要使用 `apng_icon_kyd.webp`**（那是幸運抽獎轉盤，不是 JACKPOT 裝飾）

### Drawer 選單
- **從原站實際打開 Drawer 截圖比對**，不要自己猜樣式
- 用 `page.evaluate()` 提取選單 icon 的 `<img src="...">` URL 並下載
- 原站 Drawer：深暗色背景、深暗色卡片、AVIF icon、無分隔線

### 遊戲卡片結構
- 原站用 `<div style="background-image: url(...)">` 不是 `<img>`
- 卡片內有 `<section>` 放遊戲名稱（底部半透明遮罩）
- 右上角收藏星星用 `background-image` 的 `<div>`

### 活動 banner
- 從 `active/ActiveImg*.avif` URL 下載真正的活動圖片
- 不要用其他背景圖充當活動 banner

### 動態內容處理
- Jackpot 數字、跑馬燈、中獎輪播是動態的，每次截圖都不同
- HTML 加入**凍結模式**（`?freeze=true`）：停止動畫、固定假數據
- 比對時用 `--ignore-dynamic` 排除動態區域

---

## 擷取流程（Step by Step）

### Phase 1：探索原始站

```
1. 用 Playwright 打開原始站（450x900 viewport）
2. 關閉所有彈窗（.ui-dialog, .ui-overlay 等）
3. 截取 viewport 截圖
4. 用 JS 擷取：
   - 所有 <img> 的 src + alt
   - 所有 background-image URL
   - CSS 變數（--skin__primary 等）
   - 關鍵元素的 boundingBox（header, jackpot, marquee, winner, login, game-area）
5. 點「更多」按鈕，擷取選單項目的 icon URL + 文字
6. 滾動到底部，觸發 lazy loading，截取各分類區塊
7. 存原始 HTML 原始碼
8. **詢問使用者此版型的 alias**（例如「綜合版8」「電子版2」「U版1」），不能自己猜
```

### Phase 2：與現有版型比對

```
1. 截取 viewport 截圖存到 /tmp/new-capture.png
2. 對每個現有版型執行：
   odiff /tmp/new-capture.png templates/{id}/screenshot.png diff.png --antialiasing --threshold 0.1
3. 如果任何版型相似度 > 90% → 判定重複，報告後結束
4. 如果全部 < 90% → 進入 Phase 3
```

### Phase 3：建立新版型

```
1. 建立 templates/{date}-{name}/ 目錄
2. 下載所有圖片到 assets/ 子目錄
3. 建立 index.html（單頁，CSS/JS 全 inline）
4. 建立 metadata.json
5. 建立 screenshot.png（原始站截圖）
```

### Phase 4：復刻 HTML

**必須遵守的規則：**
- 所有圖片用原始 URL 作為 src
- CSS 變數從原始站精確提取
- Jackpot 背景用 CSS `background-image: url(原始URL)` + `background-size: cover`
- 遊戲分類側邊欄 `position: sticky; top: 0; align-self: flex-start;`
- 分類平台卡片用 `flex-direction: column`（一行一張全寬橫幅）
- 加入凍結模式（`?freeze=true`）
- 加入 `<meta http-equiv="Cache-Control" content="no-cache">`
- `.page { max-width: 450px; margin: 0 auto; overflow: hidden; }`

### Phase 5：分段比對驗證

**分 3 段比對（用元素定位，不用固定 y 座標）：**

```bash
# 用 JS 找到「登 录」按鈕的 y 位置作為分界點
# A-top: 從頂部到登入按鈕
# B-login: 登入按鈕 80px 區域
# C-games: 登入按鈕以下到 viewport 底部

# 比對時 A-top 和 C-games 要用 ignore regions 排除動態內容
odiff origin/A-top.png clone/A-top.png diff.png --antialiasing -i "80:55-370:145,25:150-420:200,0:200-450:HEIGHT"
```

**達標標準：每段 >= 90%（忽略動態內容後）**

### Phase 6：更新 Gallery

```
1. 更新 templates/registry.json 加入新版型
2. 更新 screenshot.png（原始站截圖）
3. git add + commit + push
4. kubectl rollout restart deployment sitegallery -n dt-rel
```

---

## 比對工具使用

### odiff（主要工具）
```bash
# 基本比對
odiff original.png clone.png diff.png --antialiasing --threshold 0.1

# 忽略動態區域（格式：x1:y1-x2:y2,x3:y3-x4:y4）
odiff original.png clone.png diff.png --antialiasing -i "80:55-370:145"

# 輸出的 diff percentage 越小越好（0% = 完全相同）
# similarity = 100 - diff_percentage
```

### ImageMagick（輔助）
```bash
# 並排對照圖（藍條=原始，紅條=復刻）
magick \
  \( -size 450x20 xc:'#003BD5' \) \( origin.png \) -append /tmp/o.png
magick \
  \( -size 450x20 xc:'#EA4E3D' \) \( clone.png \) -append /tmp/c.png
magick /tmp/o.png \( -size 4x920 xc:'#333' \) /tmp/c.png +append compare.png
```

### 分段截圖（Playwright）
```javascript
// 用元素定位找分界點，不用固定 y 座標
const loginY = await page.evaluate(() => {
  for (const el of document.querySelectorAll('*')) {
    if (el.textContent.trim() === '登 录' && el.offsetHeight > 0)
      return el.getBoundingClientRect().y;
  }
});
await page.screenshot({ clip: { x: 0, y: 0, width: 450, height: loginY } });
```

---

## 原始站技術細節

- **框架**：Vue 3 SPA + Vite
- **CSS**：CSS Modules（hash class 如 `._jackpot_v3l6m`）
- **滾動**：虛擬滾動（`.tab-game-list-scroll-box`），fullPage 截圖只截到 viewport
- **彈窗**：進入後彈出宣傳彈窗 + 幸運抽獎彈窗，必須先關閉
- **Cookie banner**：底部固定，擋住內容
- **客服按鈕**：右下角浮動，可拖動
- **Jackpot**：數字用 CSS 翻牌動畫，sprite sheet
- **背景**：`bg_pattern_tile.avif`（菱形紋理）

### 已知的 CSS 變數
```
--skin__primary: #003BD5（藍）
--skin__accent_2: #EA4E3D（紅）
--skin__bg_1: #F8F8F8（背景灰）
--skin__neutral_1: #666666
--skin__neutral_3: #CCCCCC
```

---

## 專案結構

```
joy-homepage-clone/
├── index.html                 ← Gallery 展示頁
├── templates/
│   ├── registry.json          ← 版型註冊表
│   └── {date}-{name}/
│       ├── index.html         ← 復刻 HTML（含凍結模式）
│       ├── screenshot.png     ← 原始站截圖
│       ├── metadata.json      ← 版型元資料 + similarity
│       └── assets/            ← 圖片資源
├── scripts/
│   ├── compare.sh             ← odiff 比對（支援 --ignore-dynamic）
│   ├── update-similarity.sh   ← 更新 registry.json 相似度
│   ├── freeze-compare.sh      ← 凍結模式比對
│   └── capture-and-compare.sh ← 新版型偵測
├── docs/
│   ├── homepage-features.md   ← 功能說明
│   ├── structure-analysis.md  ← DOM/CSS 結構分析
│   └── flutter-conversion-guide.md ← Flutter 轉換指南
├── Dockerfile + nginx.conf    ← Docker 配置
└── docker-compose.yml         ← 本機 port 9090
```

### 部署
- **本機**：`docker compose up -d`（port 9090）
- **REL**：`https://site-gallery.star-link-rel.cc`（K8s, `kubectl rollout restart`）
- **GitHub**：`davidhsieh-axiom-tw-rd/site-template-gallery`（public）

---

## 擷取前必做（Phase 0）

1. **移除所有彈窗遮罩**：進入首頁後，移除所有 z-index > 10 的 fixed/absolute 元素（宣傳彈窗、抽獎、cookie consent 的遮罩會讓背景模糊）
2. **滾動載入全部 lazy content**：原站用虛擬滾動，必須找到主滾動容器（`_main_pjnd2` 等），慢速滾動到最底部（step 500px, delay 200ms），等 1 秒讓 lazy content 載入，再滾回頂部
3. **觀察動態行為**：打開原站觀察 5 秒，記錄哪些區塊有動畫（滾動、跑馬燈、輪播）
4. **展開所有選單**：點擊側邊欄每個可展開項目（电子游戏、娱乐城等），擷取完整子選單內容
5. **icon 必須從原站提取**：SVG path / image URL 直接複製，絕對不用通用 icon library。複雜 SVG（多層 transform）用 Canvas 渲染成 PNG
6. **精確量測**：用 `page.evaluate()` + `getBoundingClientRect()` + `getComputedStyle()` 量測每個元素
7. **擷取底部內容**：滾到最底部，擷取 footer 區域（三欄連結、牌照合規、联系我们等）
8. **點擊「更多」tab 截圖**：必須在原站上實際點擊 Tab bar 的「更多」，截取完整的「更多」選單頁面，確認是 drawer / overlay / 全頁覆蓋哪種形式
9. **逐段截圖**：從頂部到底部每 viewport 高度一張截圖（共 ~7 張），作為復刻比對參考
10. **不要沿用舊版型結構**：每個版型必須獨立從原站確認所有區塊，不能從舊版型「複製貼上」。特別注意底部：有些版型有活動 banner / 付款方式，有些沒有
11. **平台區列數以原站為準**：不同版型的遊戲平台區可能是 2 列或 3 列，必須從原站確認
12. **Banner 圖片文字確認**：下載 banner 圖片後用 Read 工具查看，確認文字是否已嵌入圖片。若只有 icon 沒有文字，需額外疊加 `<span>` 文字

## 下載 assets 必做

1. **所有圖片必須下載到本地**：HTML 中所有 `<img src>` 和 CSS `background-image: url()` 都必須指向本地 `assets/` 路徑，**零遠端 URL**
2. **下載後驗證格式**：
   ```bash
   find assets/ -type f \( -name "*.avif" -o -name "*.webp" \) -exec sh -c \
     'file "$1" | grep -q "text" && echo "BROKEN: $1"' _ {} \;
   ```
   原站不同路徑會返回 HTML 錯誤頁但 HTTP 200，必須用 `file` 指令確認不是 HTML text
3. **路徑變體注意**：同一張圖可能在 `11-1-2/web/home/`、`11-1-2/common/home/`、`11-1-common/common/home/` 等不同路徑。下載失敗時要試其他路徑
4. **HTML 中零遠端 URL 確認**：
   ```bash
   grep -c "joy\.star-link-rel\.cc" index.html  # 必須為 0
   ```

## 交付前必過

1. E2E 測試全部 PASS（`scripts/e2e-verify.sh`，含 9 項回歸測試）
2. 分段比對每個靜態區塊 ≥ 90% 相似度（用 `odiff --antialiasing --threshold 0.3`）
3. 若相似度 < 90%，registry.json 加 `similarityNote` 說明原因，Gallery hover 會顯示 tooltip
4. 「更多」Drawer 截圖比對 ≥ 90%
5. 匯出 ZIP 包含所有 assets（≥ bg:1, icons:1, games:5, platforms:10）
6. similarity 分數已填入 registry.json（誠實數字，不造假）
7. ZIP 匯出後啟動 Web，HTML 和 assets 必須 100% 一致
8. **零遠端 URL**、**零假圖片（HTML text）**

## odiff 比對方法

- **threshold 0.3**（推薦）：正常視覺容差，過濾亞像素色差，適合跨來源比對
- **threshold 0.1**：嚴格比對，只適合同來源完全相同的圖片
- AVIF 圖片從 CDN vs 本地載入會有不可消除的解碼差異（單卡 ~29% diff at 0.1），這是瀏覽器渲染引擎限制
- 分段比對排除動態區域（winner cards 等），加權平均計算整體相似度

## 常見錯誤與修正

| 錯誤 | 原因 | 修正 |
|------|------|------|
| 分類卡片用 3 列 grid | 沒看原始站的分類區塊 | 改為 flex-column 全寬橫幅 |
| Jackpot 用 CSS 漸層背景 | 自己造輪子 | 用原始 webp 背景圖 |
| 「更多」選單用 emoji | 自己造輪子 | 從原始站擷取 icon URL |
| 寬度 420px | 沒量原始站 | 原始站是 450px |
| 桌面版 5 列遊戲 | viewport media query | 刪除 min-width media query |
| 比對分數很低 | 用整頁 SSIM | 用分段 odiff + ignore 動態區域 |
| 截圖對不齊 | 用固定 y 座標 | 用元素定位找分界點 |
| **圖片破圖** | 下載到 HTML 錯誤頁 | 下載後用 `file` 驗證格式 |
| **部分圖破** | CSS background-image 仍用遠端 URL | 全部改本地路徑，grep 確認零殘留 |
| **缺少平台遊戲區** | 沒滾動載入 lazy content | Phase 0 滾到底再回頂 |
| **截圖模糊** | 前景 Dialog 遮罩未移除 | 移除 z-index > 10 的 fixed/absolute 元素 |
| **SVG icon 不顯示** | 多層 transform 座標偏移 | Canvas 渲染成 PNG |
| **遊戲名用漸層遮罩** | 原站沒用遮罩 | 精確量測後再實作，不要假設 |
| **similarity 造假** | 用寬鬆 threshold 或手動填數字 | 誠實分段比對，< 90% 加 similarityNote |
| **按鈕顏色用白色** | 深色背景上目測錯誤 | 必須用 `getComputedStyle()` 量測 border/color/bg |
| **圓角差 4px** | 目測 10px 實際 14.4px | 必須精確量測，不目測 |
| **E2E grep 失敗** | class 名稱不符 | 先讀 `e2e-verify.sh` 確認需要哪些 class：`platform-section`、`footer-links`/`footer-col`、`Flutter:` 註解 |
| **自我禁止 icon 錯誤** | 根據文字猜 icon 形狀 | 每個 icon 跟原站截圖逐一比對 |
| **底部多了活動/付款** | 從舊版型複製，原站沒有 | 滾到底確認原站實際結構，不沿用舊版型 |
| **平台區 2 列 vs 3 列** | 假設跟舊版型一樣 | 每個版型獨立確認列數 |
| **「更多」做成 drawer** | 沒點原站「更多」確認行為 | 必須實際點擊確認是 drawer/overlay/全頁 |
| **Tab click handler 衝突** | openDrawer 被 closeDrawer 立即覆蓋 | 通用 tab handler 要排除「更多」tab |
| **Banner 圖缺文字** | 圖片只有 icon 沒有文字 | 用 Read 查看圖片，文字用 absolute span 疊加 |
| **分類 icon 用錯檔案** | 原站用內嵌 SVG 不是 img | 從 DOM 確認 icon 來源（SVG/AVIF/CSS） |
| **站內信 icon 遺漏** | 沒逐元素比對跑馬燈區域 | 每個區塊逐元素比對，包括小 icon 和 badge |
| **非熱門區混入 game-grid** | 沿用舊版型的混合佈局 | 非熱門分類只用 `platform-banner-card` 全寬橫幅，不混 grid（E2E T3-R10） |
| **橫幅遊戲圖用錯** | 用熱門區 game-*.avif 替代 | 必須從原站 `game_pictures/p/L1/{pid}/{cid}/material.avif` 下載（E2E T3-R11） |
| **sidebar 尺寸目測** | 沒量測直接估 80px | 必須 `getComputedStyle` 取精確值（寬68/高72/圓角8.4/icon 34x26） |
| **「更多」文字推測** | 沒逐一比對原站文字 | 原站點開「更多」，JS 提取每個 item 的文字和 icon URL |
