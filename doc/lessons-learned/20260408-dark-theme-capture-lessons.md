# Dark Theme (Joy Dark V1) 版型擷取教訓

> 日期：2026-04-08
> 版型：`2026-04-08-joy-dark-v1`

## 問題 1：熱門遊戲是持續滾動，不是靜態 grid

### 現象
復刻版的「热门游戏」區塊做成靜態 2 排 grid，但原站是**持續水平自動滾動**的長條（類似跑馬燈）。

### 根本原因
- 原站用 `transform: translateX()` 持續移動一個 7423px 寬的容器
- 容器 `overflow: hidden`，內部卡片單行排列持續向左流動
- 截圖時看到 2 排是因為截圖只截到 viewport 內的靜態畫面，誤以為是 grid

### 解決方案
- 改為單行 `display: flex` + `@keyframes` 動畫（`translateX(-50%)`）
- 卡片複製一份（10+10=20 張）實現無縫循環
- 凍結模式 `animation: none !important` 停止滾動

### 教訓
**擷取階段必須觀察動態行為，不能只看截圖靜態畫面。** 截圖會把所有動畫凍結，導致誤判佈局結構。

---

## 問題 2：比對時遮蔽太多區域導致漏檢

### 現象
用 `--ignore-dynamic` 或手動遮蔽遊戲圖片區域後得到 99.9% 相似度，但實際上漏掉了熱門遊戲的滾動行為差異。

### 根本原因
遮蔽整塊「熱門遊戲」區域 = 完全跳過該區塊的比對，自然不會發現行為差異。

### 解決方案
- 比對分數只反映**像素相似度**，無法檢測**動畫行為**差異
- 必須額外做**行為比對**：手動開啟復刻版，肉眼確認動畫/互動是否與原站一致

### 教訓
**odiff 像素比對 + 行為人工驗證 = 完整比對。** 不能只靠像素分數就宣告完成。

---

## 問題 3：自造 icon 而非使用原站素材

### 現象
- Tab bar 用了 Material Design 風格的通用 SVG icon（房子、地球、禮物等），但原站是自定義設計
- 跑馬燈通知 badge 用了鈴鐺 SVG，但原站用的是信封圖片 `icon_dt_1xx_wd.avif`

### 根本原因
CAPTURE-PROMPT.md 明確說「直接用原始素材，不造輪子」，但在實作 tab bar 和跑馬燈 icon 時沒有去原站提取實際的 SVG path / image URL。

### 解決方案
- Tab bar：從原站 DOM 提取 `<symbol>` 定義（`#icon_btm_cd`、`#icon_btm_sy` 等），取出 path data 直接使用
- 跑馬燈 badge：用原站的 `<img>` + avif URL

### 教訓
**所有視覺元素都必須從原站提取，包括 icon SVG path。** 不要用通用 icon library 替代。

---

## 問題 4：精確測量差異大

### 現象
按鈕尺寸、padding、font-size 等都有偏差：
- 按鈕 padding: clone 用 `6px 16px`，原站用 `0px 3px`
- Header padding: 改成 18px 但原站實際是 12px
- 熱門遊戲卡片: clone 80x80 方形，原站 72x96 直式

### 根本原因
第一版 HTML 是根據截圖「目測」寫的，沒有用 JS 從原站 DOM 精確量測 `getBoundingClientRect()` 和 `getComputedStyle()`。

### 解決方案
用 Playwright `page.evaluate()` 逐元素量測：
```javascript
const b = el.getBoundingClientRect();
const s = getComputedStyle(el);
// width, height, padding, fontSize, borderRadius 全部精確取值
```

### 教訓
**Phase 1 擷取時就要用 JS 精確量測所有關鍵元素尺寸，不要用目測。** 建議加入自動化量測腳本。

---

## 問題 5：原站強制導向註冊頁

### 現象
直接訪問 `https://joy.star-link-rel.cc/` 會被重定向到 `/home/register`，無法看到首頁。

### 解決方案
1. 點「免费试玩」進入訪客模式
2. 用 Vue Router `$router.push('/home')` 直接導航
3. 用 JS 關閉所有彈窗（`ui-overlay`、`ui-dialog`、抽獎彈窗等）

### 教訓
**登入/註冊攔截是常見的，需要準備繞過方案。** 可以用 Vue Router 直接 push，或找「試玩」入口。

---

## 問題 6：版型缺「更多」選單頁面

### 現象
首版交付只有首頁，沒有實作「更多」(More) tab 對應的選單頁面。

### 根本原因
CAPTURE-PROMPT.md 的流程只聚焦首頁復刻，沒有要求擷取次級頁面。但「更多」選單是版型不可分割的一部分，Flutter 轉換也需要參考。

### 解決方案
- 用 Vue Router push 到 `/more-menu` 擷取完整結構
- 在 index.html 加入 overlay panel，點擊「更多」tab 切換顯示
- 5 個區塊（首页常用功能、优惠中心、资金管理、支持中心、账户安全）
- icon 大多是 SVG sprite（無法個別提取），用 placeholder + 有圖片 URL 的直接引用

### 教訓
**每個版型都要包含「更多」選單的復刻，列入 E2E 測試。** 後續更新 CAPTURE-PROMPT.md 加入 Phase 1.5: 擷取「更多」頁面。

---

## 問題 7：匯出 ZIP 缺少 assets（HTML 只用遠端 URL）

### 現象
Dark V1 的 HTML 全部使用原站遠端 URL，沒有下載任何圖片到本地 `assets/` 目錄。匯出 ZIP 時只有 1 個 bg 檔案，Blue V1 則有 70+ 個 assets。

### 根本原因
CAPTURE-PROMPT.md Phase 3 說「下載所有圖片到 assets/ 子目錄」，但實作時跳過了這步，直接用遠端 URL。

### 解決方案
從 HTML 中擷取所有遠端圖片 URL，按分類下載到 `assets/` 目錄：
- `bg/` — 背景相關
- `icons/` — icon 圖片
- `ui/` — UI 元素（按鈕、卡片圖）
- `games/` — 遊戲縮圖
- `games/platforms/` — 平台卡片圖

### 匯出規範（必須遵守）
每個版型匯出的 ZIP **至少**要包含：
1. `index.html` — 版型主體
2. `metadata.json` — 版型元資料
3. `screenshot.png` — 預覽截圖
4. `README.md` — 說明文件
5. `assets/bg/` — 背景圖（≥1 個）
6. `assets/icons/` — icon 圖（≥1 個）
7. `assets/games/` — 遊戲圖（≥5 個）
8. `assets/games/platforms/` — 平台圖（≥10 個）
9. `docs/` — 完整 Flutter 轉換文件（6 個）

### 教訓
**可以多給，不能少給。** HTML 用遠端 URL 沒問題，但 assets 目錄必須同時下載一份本地備份，確保離線匯出時所有資源都在。

---

## 更新 CAPTURE-PROMPT.md 建議

1. 加入「Phase 0: 動態行為觀察」步驟 — 開啟原站觀察 5 秒，記錄哪些區塊有動畫
2. 加入「精確量測腳本」— 提供一段標準化的 JS 來量測所有關鍵元素
3. 比對流程增加「行為驗證」步驟 — 不只看像素分數，還要人工確認動畫行為
4. 強調 icon 必須從原站提取（SVG path / image URL），絕對不能自造
5. 加入「Phase 1.5: 擷取更多選單」— 每個版型都要復刻「更多」頁面
6. E2E 測試加入「更多」選單存在性驗證
