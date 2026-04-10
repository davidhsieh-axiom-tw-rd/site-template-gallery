# Joy Crimson V1 版型復刻經驗教訓

> 日期：2026-04-10
> 版型：`2026-04-10-joy-crimson-v1`（Joy Crimson V1）
> 原站：`https://joy.star-link-rel.cc/`
> Skin 路徑：`5-1-1`

---

## 問題 1：非熱門分類不應有個別遊戲卡片 Grid

### 現象
復刻版的捕魚、電子、棋牌等分類區域，混合了「全寬平台橫幅卡片」和「3 列個別遊戲卡片 grid」。原站只有全寬橫幅，沒有個別遊戲 grid。

### 根本原因
參考 Green V1 的結構建立 HTML 時，直接沿用了 Green V1 的「平台卡片 + 遊戲 grid」混合佈局，沒有比對原站各分類的實際佈局。

### 解決方案
- 非熱門分類一律只有 `platform-banner-card`（全寬橫幅），移除所有 `game-grid-2col` / `game-grid-3col`
- 熱門區保留 3 列 grid 不動
- 加入 E2E 測試 T3-R10 保護

### 教訓
**每個版型的分類佈局必須獨立確認**。原站的「熱門」用 3 列 grid，其他分類用全寬橫幅，不能假設所有分類佈局相同。

---

## 問題 2：橫幅卡片的遊戲預覽圖用錯圖片

### 現象
橫幅卡片右側的遊戲預覽圖使用了熱門區的遊戲卡片圖（`game-*.avif`），但原站用的是專屬的平台素材圖（`game_pictures/p/L1/{platformID}/{categoryID}/material.avif`）。

### 根本原因
下載 assets 時沒有追蹤橫幅卡片內部的遊戲預覽圖 URL，直接用了手邊有的遊戲卡片圖湊數。

### 解決方案
- 用 Playwright MCP 逐個分類點擊 sidebar，提取每張橫幅的實際 background-image URL
- 下載到 `assets/games/platforms/banners/` 目錄，命名格式 `{platformID}_{categoryID}_{type}.avif`
- 加入 E2E 測試 T3-R11 保護

### 教訓
**橫幅卡片的圖片必須從原站提取，不能用其他圖片替代**。URL 規律：`game_pictures/p/L1/{platformID}/{categoryID}/material.avif`，categoryID 對應：1=棋牌、2=捕魚、3=電子、4=真人、5=體育、6=鬥雞、7=電競、8=彩票、11=區塊鏈。

---

## 問題 3：左側分類欄樣式不精確

### 現象
- 寬度 80px（原站 68px）、高度 62px（原站 72px）
- 缺少圓角（原站 8.4px）
- 只有 active tab 有背景圖（原站所有 tab 都有）
- Icon 用正方形 32x32（原站是扁平 34x26）
- Active 狀態用金色粗體（原站不變色不加粗）

### 根本原因
CSS 值用估算而非量測。沒有對每個屬性用 `getComputedStyle()` 精確取值。

### 解決方案
- 寬度 68px、高度 72px、圓角 8.4px
- 所有 tab 都設 `background: url('btn_zc3_2.avif')`
- Icon 34x26、文字 12px
- Active 狀態不加粗不變色

### 教訓
**sidebar/tab 等小元素的尺寸差幾 px 肉眼可辨，必須用 `getComputedStyle` + `getBoundingClientRect` 精確量測，不能目測或參考舊版型。**

---

## 問題 4：「更多」選單文字標籤與原站不一致

### 現象
部分選單項目的文字名稱與原站不同（如「优惠」vs「活动」、「设置」vs「个人资料」、「奖励」vs「待领取」等），且數量和順序也有差異。

### 根本原因
沒有逐一比對原站「更多」選單的每個項目文字，部分文字是推測的。

### 解決方案
用 Playwright MCP 在原站上實際打開「更多」選單，用 JS 提取每個項目的文字和 icon URL，逐一比對修正。

### 教訓
**「更多」選單的文字和 icon 必須從原站逐一提取，不能推測或從其他版型複製。**

---

## 新增 E2E 測試

| 測試 ID | 保護的問題 | 檢查內容 |
|---------|-----------|---------|
| T3-R10 | 問題 1 | 含 `platform-banner-card` 的版型，非熱門區不應有 `game-grid` |
| T3-R11 | 問題 2 | `platform-banner-card` 內的遊戲圖必須來自 `banners/` 目錄（非 `game-*.avif`） |

---

*最後更新：2026-04-10*
