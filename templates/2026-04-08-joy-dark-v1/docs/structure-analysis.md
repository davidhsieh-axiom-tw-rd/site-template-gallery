# Joy 首頁 HTML 結構分析 — 暗色主題

> 來源：https://joy.star-link-rel.cc/（theme=6-1-1）
> 分析日期：2026-04-08
> 技術棧：Vue 3 SPA + Vite + CSS Modules（原站），此版為靜態 HTML 復刻

---

## A. 頁面整體 DOM 結構

```
html
└── body
    ├── body::before（底紋 bg_pattern_tile.avif，opacity: 0.04）
    │
    └── .page（max-width: 450px，居中容器）
        │
        ├── [Header] .header（66px，sticky top）
        │   ├── .header-left
        │   │   └── img.header-logo（GAMING logo，139×42）
        │   └── .header-right
        │       ├── button.btn-login（登录）
        │       ├── button.btn-register（注册）
        │       └── img.header-spin（Spin 按鈕，54×54）
        │
        ├── [Marquee] .marquee-bar（36px，跑馬燈）
        │   ├── .marquee-icon（喇叭 icon，20×20）
        │   └── .marquee-content
        │       └── .marquee-text（滾動文字）
        │
        ├── [熱門遊戲] .hot-games
        │   ├── .section-header
        │   │   ├── .section-title（🔥 热门游戏）
        │   │   └── .section-more（更多 >）
        │   └── .hot-games-scroll（水平滑動）
        │       └── .hot-games-grid（2 排 × 5 列）
        │           └── .game-card × 10
        │               ├── .game-card-img（100×133px，3:4 比例）
        │               └── .game-card-name（遊戲名稱）
        │
        ├── [中獎輪播] .winner-section（91px）
        │   ├── 背景：森林綠漸層 + 插圖
        │   └── .winner-scroll（水平滾動）
        │       └── .winner-card × N
        │           ├── .winner-avatar（頭像）
        │           ├── .winner-info（玩家名 + 遊戲名）
        │           └── .winner-amount（獎金）
        │
        ├── [雙卡片] .dual-cards（186px）
        │   ├── .promo-card.sports（體育 — 綠色系）
        │   │   ├── .promo-card-title（体育赛事）
        │   │   ├── .promo-card-desc（描述文字）
        │   │   └── .promo-card-btn（立即投注）
        │   └── .promo-card.casino（娛樂城 — 紫色系）
        │       ├── .promo-card-title（真人娱乐）
        │       ├── .promo-card-desc（描述文字）
        │       └── .promo-card-btn（立即进入）
        │
        ├── [遊戲分類] × 9 個區塊
        │   每個 .category-section：
        │   ├── .category-header
        │   │   ├── .category-icon（分類 icon）
        │   │   ├── .category-title（分類名稱）
        │   │   └── .category-more（全部 >）
        │   └── .category-games（3 欄 grid）
        │       └── .game-card × 3-6
        │
        ├── [Footer] .footer
        │   ├── .footer-nav（三欄導航連結）
        │   │   └── .footer-nav-group × 3
        │   │       ├── h4（區塊標題）
        │   │       └── a × N（連結）
        │   ├── .footer-license（牌照 + 18+ 圖標）
        │   ├── .footer-contact（聯繫我們 + Telegram）
        │   └── .footer-copyright（版權聲明）
        │
        └── [Tab Bar] .tab-bar（75px，固定底部）
            └── .tab-item × 5
                ├── .tab-icon（SVG icon）
                └── .tab-label（文字標籤）
```

---

## B. 重要的 CSS Class 名稱

### B.1 暗色主題特有

| 區塊 | CSS Class | 備註 |
|------|-----------|------|
| 頁面容器 | `.page` | 背景 `--body-bg: #0C1822` |
| Header | `.header` | 背景 `--header-bg: #10212F` |
| 卡片 | `.game-card`, `.winner-card` | 背景 `--card-bg: #162A3A` |
| Tab Bar | `.tab-bar` | 背景 `--tab-bar-bg: #10212F` |

### B.2 主要區塊 Class

| 區塊 | CSS Class |
|------|-----------|
| 頂部導航 | `.header`, `.header-left`, `.header-right` |
| 跑馬燈 | `.marquee-bar`, `.marquee-content`, `.marquee-text` |
| 熱門遊戲 | `.hot-games`, `.hot-games-scroll`, `.hot-games-grid` |
| 中獎輪播 | `.winner-section`, `.winner-scroll`, `.winner-card` |
| 雙卡片 | `.dual-cards`, `.promo-card`, `.promo-card.sports`, `.promo-card.casino` |
| 遊戲分類 | `.category-section`, `.category-header`, `.category-games` |
| 遊戲卡片 | `.game-card`, `.game-card-img`, `.game-card-name` |
| Footer | `.footer`, `.footer-nav`, `.footer-nav-group`, `.footer-license`, `.footer-contact` |
| Tab Bar | `.tab-bar`, `.tab-item`, `.tab-icon`, `.tab-label` |

---

## C. 色彩方案

### C.1 主題色（:root CSS Variables）

| 變數名稱 | 色值 | 用途 |
|---------|------|------|
| `--body-bg` | `#0C1822` | 頁面背景（深海軍藍） |
| `--header-bg` | `#10212F` | Header/Tab Bar 背景 |
| `--card-bg` | `#162A3A` | 卡片/區塊背景 |
| `--section-bg` | `#0F1E2B` | 區塊背景 |
| `--btn-login` | `#1EFFD7` | 登入按鈕（青色） |
| `--btn-register` | `#F5D639` | 註冊按鈕（金黃） |
| `--btn-text` | `#0E161D` | 按鈕文字（深色） |
| `--text-primary` | `#FFFFFF` | 主文字 |
| `--text-secondary` | `#8899AA` | 次要文字 |
| `--tab-active` | `#1EFFD7` | Tab 選中色 |
| `--tab-bar-bg` | `#10212F` | Tab Bar 背景 |

### C.2 色彩語意分組

```
暗色背景系：
  #0C1822 → 頁面背景（深海軍藍）
  #10212F → Header / Tab Bar
  #0F1E2B → 區塊背景
  #162A3A → 卡片背景

亮色功能色：
  #1EFFD7 → 主按鈕、選中狀態（青色）
  #F5D639 → 次按鈕、金額高亮（金黃）
  #0E161D → 按鈕上的深色文字

文字色系：
  #FFFFFF → 主文字
  #8899AA → 次要文字
  #556677 → 弱化文字（版權聲明）
```

---

## D. 與 Blue V1 的差異

| 面向 | Blue V1 | Dark V1 |
|------|---------|---------|
| 背景 | `#F8F8F8` 淺灰 | `#0C1822` 深海軍藍 |
| 主色 | `#003BD5` 藍色 | `#1EFFD7` 青色 |
| 強調色 | `#EA4E3D` 紅色 | `#F5D639` 金黃 |
| 文字 | `#333333` 深灰 | `#FFFFFF` 白色 |
| 遊戲佈局 | 側邊欄 + 垂直列表 | 水平滑動 + 獨立區塊 |
| Jackpot | 有（海洋背景） | 無 |
| 中獎輪播 | 淺藍背景 | 森林綠背景 |
| 雙卡片 | 無 | 有（體育/娛樂城） |
