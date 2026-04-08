# Joy Dark V1 — 版型匯出包

> 原站：https://joy.star-link-rel.cc/（暗色主題 theme=6-1-1）
> 擷取日期：2026-04-08

## 用途

這是從原站暗色主題完整復刻的 HTML 版型，可作為：
1. **Flutter 轉換的視覺藍圖** — 搭配 `docs/` 內的對照文件直接實作
2. **Figma 設計稿的參考** — 所有色碼、尺寸、字體均已精確記錄
3. **版型存檔** — 原站改版後仍可查看原始設計

## 檔案結構

```
2026-04-08-joy-dark-v1/
│
├── README.md                ← 你正在讀的這份（檔案結構說明）
├── index.html               ← 版型主體（HTML + CSS + JS，單檔自包含）
├── metadata.json            ← 版型基本資訊（名稱、日期、來源、主色、功能標籤）
├── screenshot.png           ← 版型預覽截圖（Gallery 展示用）
│
├── assets/                  ← 圖片資源
│   └── bg/                  ← 背景圖（底紋 tile）
│
└── docs/                    ← 轉換參考文件
    ├── flutter-token-mapping.md     ← ⭐ Flutter Token 完整對照字典
    ├── flutter-conversion-guide.md  ← ⭐ 轉換策略 + Widget 對應表
    ├── typography.md                ← 逐元素文字樣式表
    ├── structure-analysis.md        ← DOM 結構 + CSS class 分析
    ├── homepage-features.md         ← 功能說明（每個區塊做什麼）
    └── assets-inventory.json        ← 原始圖片尺寸清單
```

## 各檔案詳細說明

### index.html
- **單檔自包含**：HTML + CSS + JavaScript 全在同一個檔案
- **CSS 變數區**（`:root`）已標注 Flutter Token 對照名稱和原站色值
- **凍結模式**：URL 加 `?freeze=true` 可停止所有動畫（截圖比對用）
- **桌面版**：max-width 450px 居中，模擬手機端展示
- 圖片使用原站 CDN URL（暗色版無本地化 assets，僅保留背景紋理）

### docs/ 轉換參考文件

| 檔案 | 用途 | 轉換時機 |
|------|------|---------|
| `flutter-token-mapping.md` | **最重要**。色彩、尺寸、字體、陰影、動畫、z-index、Widget 對應的完整對照表 | 開始 Flutter 實作前必讀 |
| `flutter-conversion-guide.md` | 轉換策略、設計原則（原站為主）、需新建的 Widget 清單、佈局差異決策 | 規劃架構時參考 |
| `typography.md` | 每個 HTML 元素的 font-size / weight / letter-spacing / color | 實作文字樣式時查表 |
| `structure-analysis.md` | DOM 結構、CSS class 命名、區塊劃分 | 理解頁面結構 |
| `homepage-features.md` | 每個區塊的功能描述（跑馬燈、熱門遊戲、中獎輪播等） | 理解業務需求 |
| `assets-inventory.json` | 原始圖片的 URL、尺寸、類型 | 準備 Flutter assets 時用 |

## 設計原則

1. **原站為主** — 所有色彩、尺寸、佈局以原站暗色主題實際效果為準
2. **Flutter Token 名稱** — CSS 變數命名參考 Flutter 現有 Token，方便對應
3. **值用原站的** — Token 名稱是 Flutter 的，但色碼和數值用原站的

## 色彩方案

| Token | 值 | 用途 |
|-------|------|------|
| --body-bg | #0C1822 | 頁面背景（深海軍藍） |
| --header-bg | #10212F | Header / Tab Bar |
| --card-bg | #162A3A | 卡片背景 |
| --btn-login | #1EFFD7 | 登錄按鈕（青色） |
| --btn-register | #F5D639 | 注冊按鈕（金黃） |
| --text-primary | #FFFFFF | 主文字 |
| --text-secondary | #8899AA | 次要文字 |

## 快速開始

### 本地預覽
```bash
# 解壓後直接用 Python 起 HTTP server
cd 2026-04-08-joy-dark-v1/
python3 -m http.server 8080
# 瀏覽器開啟 http://localhost:8080
```

### 凍結模式（截圖比對用）
```
http://localhost:8080?freeze=true
```

### Flutter 轉換流程
1. 讀 `docs/flutter-conversion-guide.md` 了解整體策略
2. 讀 `docs/flutter-token-mapping.md` 建立色彩/尺寸 Token
3. 參考 `docs/typography.md` 建立 TextStyle
4. 對照 `index.html` 的 CSS 逐區塊實作 Widget
5. 用 `docs/structure-analysis.md` 確認 DOM 對應關係

## 頁面結構

1. Header（66px）— Logo + 登錄/注冊 + Spin
2. Marquee — 公告跑馬燈
3. 热门游戏 — 2 排水平滑動遊戲卡片
4. 中獎輪播（91px）— 森林插圖背景 + 獎勵卡片
5. 體育/娛樂城（186px）— 雙卡片並排
6. 9 個遊戲分類 — 捕魚/電子/棋牌/真人/體育/彩票/電競/鬥雞/區塊鏈
7. Footer — 三欄導航 + 牌照合規 + 聯繫方式
8. Tab Bar（75px）— 更多/首頁/體育/優惠/我的

## 來源

- URL: https://joy.star-link-rel.cc/
- 擷取日期: 2026-04-08
- 主題: 暗色（theme=6-1-1）
