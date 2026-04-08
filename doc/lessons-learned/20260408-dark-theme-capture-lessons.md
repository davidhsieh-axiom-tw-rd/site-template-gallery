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

## 更新 CAPTURE-PROMPT.md 建議

1. 加入「Phase 0: 動態行為觀察」步驟 — 開啟原站觀察 5 秒，記錄哪些區塊有動畫
2. 加入「精確量測腳本」— 提供一段標準化的 JS 來量測所有關鍵元素
3. 比對流程增加「行為驗證」步驟 — 不只看像素分數，還要人工確認動畫行為
4. 強調 icon 必須從原站提取（SVG path / image URL），絕對不能自造
