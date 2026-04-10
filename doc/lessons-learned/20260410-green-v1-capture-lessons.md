# Joy Green V1 版型復刻經驗教訓

> 日期：2026-04-10
> 版型：`2026-04-09-joy-green-v1`（Joy Green V1）
> 原站：`https://joy.star-link-rel.cc/`
> Skin 路徑：`63-1-1`

---

## 問題 1：從舊版型複製了原站不存在的內容

### 現象
復刻版底部多了「活動 banner」(9張)、「付款方式」(7個 icon)、「熱門推薦」(雙排水平滾動) 等原站根本沒有的區塊。

### 根本原因
基於 Red V1 結構建立 HTML 時，直接沿用了 Red V1 的底部結構，沒有滾動到原站底部確認實際內容。

### 解決方案
- 刪除所有原站不存在的 section
- 原站底部結構：最後一個平台區 → Footer 三欄 → 牌照合規 → 聯繫我們。沒有其他東西。

### 教訓
**新版型不能假設跟舊版型結構相同。** 必須滾動到原站最底部，逐段截圖確認實際內容，不能從舊版型「複製貼上」。

---

## 問題 2：平台遊戲區佈局錯誤（2 列 vs 3 列）

### 現象
復刻版的捕魚/電子/棋牌等平台遊戲區用 2 列 grid，但原站是 3 列。

### 根本原因
CAPTURE-PROMPT.md 上一版寫了「平台遊戲卡片用 2 列 grid」，這是某個舊版型的規則，但不適用於所有版型。

### 解決方案
把 `.game-grid-2col` 的 `grid-template-columns: repeat(2, 1fr)` 改為 `repeat(3, 1fr)`。

### 教訓
**每個版型的佈局必須從原站實際量測，不能沿用舊版型的規則。** CAPTURE-PROMPT 要改為「平台區列數以原站為準」。

---

## 問題 3：「更多」選單做成了左側 Drawer 而非全頁覆蓋

### 現象
Tab bar 的「更多」按鈕點擊後，應該出現全頁面覆蓋的選單頁（佔滿整個 450px），但復刻版做成了左側 283px 滑出的 drawer。

### 根本原因
沒有在原站上實際點擊「更多」tab 觀察行為，直接假設是 drawer。

### 解決方案
- `.more-drawer` 改為 `width: 100%`
- 移除半透明背景（全頁覆蓋不需要）
- 頂部放 logo + X 關閉按鈕（跟原站一致）

### 教訓
**「更多」選單的行為（drawer/overlay/full-page）必須在原站上實際點擊確認。** 不同版型可能有不同實作方式。

---

## 問題 4：Tab bar click handler 互相衝突

### 現象
點擊「更多」tab 後 drawer 閃現又立即消失。

### 根本原因
Tab bar 有兩層 click handler：
1. `openDrawer()` — 加上 `active` class 打開 drawer
2. 通用 tab handler — 最後呼叫 `closeDrawer()` 立即關閉

第二個 handler 總是在第一個之後觸發，立刻撤銷 drawer 開啟。

### 解決方案
在通用 tab handler 中加判斷：`if (this.dataset.tab !== 'more') closeDrawer();`

### 教訓
**多層 event handler 必須考慮執行順序。** Tab bar 的通用 handler 不能無條件 closeDrawer。

---

## 問題 5：Banner 圖片缺少文字覆蓋

### 現象
「更多」頁面的分享赚钱/优惠中心/立即分享三個 banner 只顯示圖案（icon），沒有文字。原站的截圖上有文字。

### 根本原因
原站的 AVIF banner 圖片（`btn_sy_zc_tg.avif` 等）只包含 icon 圖案，文字「分享赚钱」等是原站在 HTML 中另外疊加的 `<span>`。復刻版直接用 `<img>` 沒有加文字。

### 解決方案
用 `position: relative` 容器 + `position: absolute` 的 `<span>` 在圖片上疊加白色文字。

### 教訓
**下載 banner 圖片後，用 Read 工具查看圖片內容，確認文字是否已嵌入圖片。** 如果圖片只有 icon 沒有文字，就需要額外疊加。

---

## 問題 6：Category Tab icon 用了錯誤的 icon 檔案

### 現象
分類 Tab 的 icon 形狀跟原站不同（原站是火焰/魚/777，復刻版用了不同的圖案）。

### 根本原因
1. 原站的分類 Tab 用的是**內嵌 SVG icon**（不是 `<img>` tag），在 `._circle-icon_xdcup_58` 容器裡
2. 復刻版用了從另一個路徑下載的 AVIF 圖片（`icon_dtfl_*_1.avif`），這是 Red V1 版型的 icon
3. 原站的 `icon_dt_*_0.avif`（23x23px）是用在**平台 section header** 中，不是分類 Tab

### 解決方案
用 Playwright `page.evaluate()` 將原站 SVG icon 渲染到 Canvas → 導出 PNG → 存到 `assets/icons/svg-cat-*.png`，在 HTML 中引用 PNG。

### 教訓
**分類 icon 的來源必須從原站 DOM 確認。** 不同版型可能用 SVG、AVIF 或 CSS icon，不能假設。`<img src>` 的 icon 和內嵌 SVG icon 是不同東西。

---

## 問題 7：站內信 icon 遺漏

### 現象
跑馬燈右側的站內信 icon（信封 + 紅色 badge "10"）在復刻版中缺失。

### 根本原因
擷取階段沒有仔細觀察跑馬燈區域的所有元素。`icon_dt_1xx_wd.avif` 圖片雖然下載了但沒放到 HTML 中。

### 解決方案
在 `.marquee-bar` 右側加入 `<img src="assets/icons/icon_mail.avif">` + 紅色 badge。

### 教訓
**每個區塊的所有元素都要逐一比對，包括小 icon 和 badge。** 不能只看主要內容就跳過附屬元素。

---

## 新版型特徵摘要

| 項目 | 值 |
|------|-----|
| Skin 路徑 | `63-1-1` |
| 主色 | `#0AB76B`（綠色） |
| 背景 | `#292D3B`（深灰藍） |
| 強調色 | `#F84673`（粉紅） |
| 分類 Tab | 10 + 試玩/最近/收藏，SVG icon in 54px 圓形 |
| 平台區 | 3 列 grid（不是 2 列） |
| 「更多」 | 全頁覆蓋（不是左側 drawer） |
| Footer | 三欄 → 牌照合規 → 聯繫我們（無付款方式） |
| E2E | 34/34 PASS |
| Similarity | 93%（靜態區域加權平均） |
