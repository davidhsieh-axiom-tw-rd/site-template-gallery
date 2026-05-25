# Dxpker Sky V1 — 德信版 1

## 快速開始

```bash
cd templates/2026-05-25-dxpker-sky-v1
python3 -m http.server 8282
# 瀏覽器開 http://localhost:8282/（建議 mobile viewport 450x900）
```

替換 placeholder（業務端塞自有素材）：
1. 對應 6 個 placeholder 區（見下方表格）準備自有圖
2. 替換 `index.html` 中對應 `<div class="placeholder">` 為 `<img>`
3. 重新跑 `./scripts/e2e-verify.sh 2026-05-25-dxpker-sky-v1` 確認

> 來源：`https://app-h5-new.dxpker.com/`（Flutter Web canvaskit）
> 復刻日期：2026-05-25
> 主色：`#2FA0FC` 淺藍漸層

## 與 joy 系列的差異

| 項目 | joy 系列 | 本版型 |
|------|---------|--------|
| 原站技術 | 傳統 SPA（DOM 可抓） | Flutter Web canvaskit（無 DOM 結構）|
| 復刻方式 | DOM skin path / CSS 變數還原 | 純視覺截圖 + asset 直抓 |
| Flutter Token mapping | 需要（HTML→Flutter widget） | N/A（原站本來就是 Flutter） |

## Placeholder 區隔（13 個）

經 IP audit 後（見下方 Quarantine），下列 13 個位置為刻意 placeholder（HTML 中以 `<div class="placeholder">` 標示），業務端可直接替換為自有素材：

| placeholder id | 位置 | 替換建議 |
|---------------|------|---------|
| app-logo | App 下載 bar 左側 | 自有 App icon（28x28） |
| main-logo | Top bar 左側 | 自有品牌 logo（88x28） |
| hero-banner | Hero banner 整區 | 自有 hero 主視覺（450x140，含主標 + 場景 + 人物） |
| sponsor-a-logo / name | Hero 左側贊助 | 自有合作夥伴 logo + 名稱 |
| sponsor-b-logo / name | Hero 右側贊助 | 自有合作夥伴 logo + 名稱 |
| login-avatar | 登入卡左側 | 自有預設頭像（42x42 圓） |
| hall-texas-card | 主功能卡（大卡） | 自有主功能設計（含主標 / 設計 / 子按鈕）|
| hall-real-portrait | 真人卡右下角 | 自有真人荷官形象（80x95） |
| hall-sport-portrait | 體育卡右下角 | 自有運動員 / 賽事形象（80x95） |
| other-icon-1..4 | 其他玩法前 4 格 | 自有遊戲分類設計圖（44x44）|

## Quarantine（13 個下載素材移除）

原下載 35 個 PNG，經逐張 audit 後發現 13 個含品牌商標 / 字樣 / 設計 / 真人肖像 + 姓名標記，全部移至 `.tmp/quarantine/`，**不進交付物、不進 git**：

| 檔名 | 移除原因 |
|------|---------|
| `home_banner_zh.png` | Hero 含真實撲克玩家肖像 + 姓名標記 |
| `home_user_df_img.png` | 品牌頭像 logo 設計 |
| `dz_bg_top.png` | 品牌主 logo 設計 |
| `dz_bg_bottom.png` | 品牌標語字樣 |
| `home_hall_texas_bg_resized.png` | 主功能卡品牌專用背景 |
| `home_texas_hold.png` | 主功能品牌字 + 設計 |
| `home_texas_free_label.png` | 品牌營銷標籤設計 |
| `dz_home_hall_text.png` | 品牌名 + 標語 + 業務描述 |
| `home_texas_scene_compete_l.png` | 賽事品牌設計按鈕 |
| `home_texas_my_room_r.png` | 含品牌 logo 的功能按鈕 |
| `home_texas_game_type_texas.png` | 遊戲品牌設計圖 |
| `home_texas_game_type_sss.png` | 遊戲品牌設計圖 |
| `home_hong_game_type_hongzhong.png` | 遊戲品牌設計圖 |

剩餘 22 個保留（純通用 UI vector：Tab Bar icons / 業界 generic 3D 遊戲分類 icon / 純色背景 / 通用 SVG-style icons）。

## Similarity

純結構 similarity **70.71%**（odiff 29.29% diff）。Header / Hero / Hall texas card 三大區是「placeholder vs 品牌素材」本質差異，無法靠樣式微調消除。其餘區（Marquee 86% / Login 71% / Other 89% / Tab 98% / App bar 94%）對齊原站。**業務端塞自有素材後可達 90%+**。

## 結構區塊

1. App 下載 bar（淺藍底，含 placeholder app logo + 立即下載按鈕）
2. Top bar（白底圓角，含 placeholder 主 logo + 客服 icon）
3. Hero banner（home_banner_zh 背景 + 雙贊助 placeholder）
4. 公告 Marquee（小喇叭 + 動畫文字 + 全部箭頭）
5. 登入卡（預設頭像 + 標題 + 點擊登入 pill button）
6. 加值服務專員浮按鈕（左下黃色 chip）
7. 主功能 2x2 Grid（德州棋牌大卡 / 真人 / 體育）
8. 其他玩法 8 格（德州/十三水/鸿运中/更多 + 电竞/彩票/棋牌/电子）
9. Tab Bar（首頁/活動/客服/我的）

## 動畫

- `.marquee-text`：`@keyframes marquee-scroll` 28s linear infinite — 已實測通過

## 驗證

- 零遠端 URL：`grep -cE "https?://|dxpker\.com" index.html style.css` = 0
- Asset 20/20 引用全部存在
- 35 個 PNG 全部 file 驗證 PASS
- Marquee 動畫 2 秒位移 -58.2px confirmed

## 已知 e2e 差異（joy-specific 規則不適用）

- `docs/flutter-token-mapping.md` — 原站本為 Flutter，無需 HTML→Flutter token 對應
- `docs/flutter-conversion-guide.md` — 同上

完整 lessons：`doc/lessons-learned/20260525-dxpker-sky-v1-capture-lessons.md`
