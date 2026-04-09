# Joy Red V1 版型復刻經驗教訓

> 日期：2026-04-09
> 版型：`2026-04-09-joy-red-v1`（Joy Red V1）
> 原站：`https://joy.star-link-rel.cc/`
> Skin 路徑：`72-1-2`

---

## 問題 1：JACKPOT 背景圖已包含所有裝飾元素

### 現象
JACKPOT 區域疊加了額外的轉盤裝飾圖（`apng_icon_kyd.webp`），導致出現不該有的幸運抽獎轉盤。

### 根本原因
`cjc1_style_2_bg.webp` 背景圖**已經包含**藍鯊魚（左）、JACKPOT 彩色文字、紅金邊框數字框、小丑魚（右）。不需要額外疊加任何裝飾圖片。

### 解決方案
- 移除 `.jackpot-decor-left` / `.jackpot-decor-right` 的 img 元素（設 `display: none`）
- 用 `background: url('assets/bg/cjc1_style_2_bg.webp') center / contain no-repeat` 讓背景圖完整顯示
- 數字只需用 absolute positioning 放在背景圖的數字框位置

### 教訓
**在使用背景圖之前，先用 `Read` 工具查看圖片內容**，確認它包含哪些元素，避免重複疊加。

---

## 問題 2：JACKPOT 字體精靈圖需要裁切

### 現象
`cjc1_style_1_font_sprite.avif` 顯示了 "0123456789JACKPOT" 全部字符。

### 根本原因
精靈圖 836×72px 是水平排列，包含數字和 JACKPOT 文字。原站用 CSS sprite 技術只顯示特定部分。

### 解決方案
由於背景圖 `cjc1_style_2_bg.webp` 已包含 JACKPOT 文字，直接棄用字體精靈圖。

### 教訓
**精靈圖（sprite sheet）需要用 `magick identify` 查看尺寸，理解排列方式後再使用。**

---

## 問題 3：遊戲卡片用 background-image 而非 img tag

### 現象
遊戲卡片圖片顯示不正確，沒有遊戲名稱覆蓋層。

### 根本原因
原站的遊戲卡片 DOM 結構是 `<div style="background-image: url(...)">` + 內部 `<section>` 放遊戲名稱，不是 `<img>` tag。

### 解決方案
```html
<div class="game-card-border" style="background-image:url('assets/games/game-xxx.avif')">
  <div class="game-card-fav"></div>
  <div class="game-card-name"><h4>遊戲名</h4></div>
</div>
```

### 教訓
**從原站提取 DOM 結構時，注意 `background-image` 和 `<img>` 的區別。** 用 `page.evaluate()` 取得 `outerHTML` 確認實際結構。

---

## 問題 4：平台遊戲區是 2 列，熱門遊戲才是 3 列

### 現象
所有遊戲區都用了 3 列 grid，但原站除了「热门游戏」外，其他平台區（捕鱼/电子/棋牌等）都是 2 列。

### 根本原因
沒有仔細滾動原站查看各區塊的佈局差異。

### 解決方案
新增 `.game-grid-2col { grid-template-columns: repeat(2, 1fr); }`，只有 `platform-hot` 保持 3 列。

### 教訓
**每個區塊都要滾動到原站對應位置截圖比對，不能假設佈局一致。**

---

## 問題 5：Drawer 選單樣式必須從原站提取

### 現象
Drawer 選單用了白色卡片 + 紅色頭部 + SVG icon，但原站是深暗色卡片 + 深暗色漸層頭部 + AVIF icon。

### 根本原因
沒有打開原站的 Drawer 截圖比對，而是自己「猜測」樣式。

### 解決方案
1. 打開原站 Drawer，截圖
2. 用 `page.evaluate()` 提取選單項的 icon `<img src="...">` URL
3. 下載原站的 AVIF icon（`icon_sy_zc_ss.avif` 等）
4. 匹配原站的深暗色配色

### 教訓
**每個互動元素（Drawer、Popover、Dialog）都要在原站上實際打開並截圖，不要憑印象做。**

---

## 問題 6：活動 banner 圖片不能用佔位圖

### 現象
Footer 上方的活動 banner 區顯示了森林背景圖（`banner.avif` = `winner-forest.avif` 同一張圖）。

### 根本原因
下載 assets 時把活動圖片 URL 和中獎輪播背景 URL 搞混了。

### 解決方案
從原站下載真正的活動圖片 `active/ActiveImg*.avif`（9 張），替換 banner 區的圖片來源。

### 教訓
**下載 assets 後，用 `Read` 工具逐一查看圖片內容，確認用途正確。**

---

## 新版型特徵摘要

| 項目 | 值 |
|------|-----|
| Skin 路徑 | `72-1-2` |
| 主色 | `#D03434`（紅色） |
| 背景 | `#161616`（極深黑） |
| Tab Bar | `#212121` |
| Game Grid | 热门 3 列 / 其他 2 列 |
| Drawer | 深暗色漸層 + 5 項選單 |
| E2E | 34/34 PASS |
| Similarity | 81%（靜態區域 93%） |
