# Platform Card 圖片溢出修復 + Gallery 功能擴充

## 問題描述

1. **版型跑版**：分類遊戲區塊（捕魚、電子、棋牌等 9 個分類）的平台卡片圖片溢出容器，撐開整個區域
2. **Gallery 功能不足**：缺少匯出 HTML 功能和相似度標示

## 根本原因分析

### 跑版問題
- `.platform-card-thumb` 內的 `<img>` 雖然設了 `width: 100%` 和 `height: 100%`，但在某些瀏覽器/圖片載入情境下，`<img>` 的固有尺寸（intrinsic size）會撐開 `aspect-ratio: 1` 的容器
- Grid 子元素缺少 `min-width: 0`，導致 `1fr` 的 grid item 可能被內容撐大
- 全域 `img` 規則缺少 `height: auto`，某些情境下圖片高度不受限制

### 根本解法
將 `.platform-card-thumb img` 和 `.game-card-thumb img` 改為 `position: absolute`，完全脫離文件流，由父元素的 `aspect-ratio: 1` + `position: relative` 控制尺寸。這樣無論圖片本身有多大，都不會影響容器大小。

## 解決方案

### 檔案 1: `templates/2026-04-07-joy-blue-v1/index.html`

| 修改項 | 說明 |
|--------|------|
| `.game-card-thumb img` | 改為 `position: absolute; top: 0; left: 0` |
| `.platform-card-thumb` | 加入 `position: relative` |
| `.platform-card-thumb img` | 改為 `position: absolute; top: 0; left: 0` |
| `.game-card`, `.platform-card` | 加入 `min-width: 0; overflow: hidden` |
| `.platform-grid` | 加入 `overflow: hidden` |
| 全域 `img` | 加入 `height: auto` |
| `.cookie-banner` | 加入 `border-top: 1px solid #f0f0f0` 增加視覺分隔 |

### 檔案 2: `index.html`（Gallery）

| 修改項 | 說明 |
|--------|------|
| 新增 `.card-similarity` CSS | 圓形 badge，支援高/中/低/待測量四種狀態 |
| 新增 `simBadge()` JS 函式 | 根據 similarity 值產生對應 badge HTML |
| 新增 `exportHTML()` JS 函式 | fetch 版型 HTML 並觸發 Blob 下載 |
| 修改 `renderCard()` | 加入相似度 badge 和匯出按鈕 |
| 調整 `.btn` 和 `.card-actions` | 支援三個按鈕不溢出（flex-wrap, 縮小 padding） |

### 檔案 3: `templates/registry.json`

- 新增 `similarity` 欄位（初始值 0，表示尚未測量）

## 驗證方式

1. HTML 語法驗證通過（Python html.parser）
2. JSON 語法驗證通過
3. 關鍵 CSS class 和 JS 函式存在性驗證通過
4. 需用瀏覽器視覺確認：
   - 平台卡片圖片不溢出，維持 1:1 正方形
   - Gallery 卡片顯示相似度 badge（灰色「待測量」）
   - 匯出按鈕可點擊並觸發 HTML 下載
