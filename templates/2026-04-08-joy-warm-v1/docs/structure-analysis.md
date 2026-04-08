# Joy 首頁 HTML 結構分析 — 暖橘棕色主題

> 來源：https://joy.star-link-rel.cc/（theme=11-1-2）
> 分析日期：2026-04-08
> 技術棧：Vue 3 SPA + Vite + CSS Modules（原站），此版為靜態 HTML 復刻

---

## A. 頁面整體 DOM 結構

```
html
└── body (background: #e8e8e8 桌面灰色)
    │
    └── .page（max-width: 450px，居中容器，背景: img_db_dt_bg.avif）
        │
        ├── [Header] .header（60px，sticky top）
        │   ├── .header-left
        │   │   ├── img.header-menu-btn（漢堡選單 icon 37×38px）
        │   │   └── img.header-logo（GAMING logo，139×42）
        │   └── .header-right
        │       ├── button.btn-login（登录，bg: btn_topnav_dl.avif）
        │       └── button.btn-register（注册，bg: btn_topnav_zc.avif）
        │
        ├── [Marquee] .marquee-bar（39px，rgba(0,0,0,0.3) 背景）
        │   ├── .marquee-icon > img（icon_dt_pmd.webp，34×29px）
        │   ├── .marquee-content
        │   │   └── .marquee-text（滾動文字）
        │   └── .marquee-badge-wrap
        │       ├── img（icon_dt_1xx_wd.avif 通知 icon）
        │       └── .marquee-badge（紅色數字 badge）
        │
        ├── [中獎輪播] .winner-section
        │   ├── .winner-section-bg（db_dt_zbcd.avif 背景圖）
        │   └── .winner-scroll-wrap
        │       └── .winner-scroll（水平滾動）
        │           └── .winner-card × N
        │               ├── img.winner-card-thumb（遊戲圖 37×49px）
        │               └── .winner-card-info（文字資訊）
        │
        ├── [分類標籤] .category-tabs（水平滾動）
        │   └── .category-tab × 11（熱門、PG、WG ... PP）
        │       ├── img.category-tab-icon（僅熱門有 fire icon）
        │       └── span（標籤文字）
        │
        ├── [Section Title] .section-title
        │   ├── span.icon（🔥）
        │   └── span（热门游戏）
        │
        ├── [遊戲 Grid] .game-grid（3 欄）
        │   └── .game-card × 12
        │       ├── .game-card-thumb
        │       │   ├── img（遊戲封面）
        │       │   ├── .game-card-border（img_yxbk.avif 邊框裝飾）
        │       │   └── img.game-card-fav（btn_sc_off_2.avif 收藏星星）
        │       └── .game-card-name（遊戲名稱）
        │
        └── (end of .page)

    ├── [側邊欄] .more-drawer-backdrop（overlay）
    │   └── .more-drawer（288px 左側面板）
    │       ├── .more-drawer-close（關閉按鈕）
    │       ├── .more-drawer-search（搜索框）
    │       └── .more-drawer-item × 5（选单项目）
    │
    ├── [Tab Bar] .tab-bar（89px，固定底部）
    │   └── .tab-item × 5
    │       ├── img（Tab icon）
    │       └── span（Tab 文字）
    │
    ├── [Cookie Banner] .cookie-banner（Tab Bar 上方）
    │   ├── .cookie-banner-text
    │   └── .cookie-banner-btn（确认）
    │
    └── [客服浮動] .cs-float（右下角 60×60px）
        └── img（客服頭像）
```

---

## B. 重要的 CSS Class 名稱

### B.1 暖色主題特有

| 區塊 | CSS Class | 備註 |
|------|-----------|------|
| 頁面容器 | `.page` | 背景圖 `img_db_dt_bg.avif`，底色 `#783D21` |
| Header | `.header` | 背景圖 `img_topnav_bg.avif` |
| 卡片 | `.game-card`, `.winner-card` | 卡片色 `#8F4B2B` |
| Tab Bar | `.tab-bar` | 背景圖 `img_db_dt_btm.avif` |

### B.2 主要區塊 Class

| 區塊 | CSS Class |
|------|-----------|
| 頂部導航 | `.header`, `.header-left`, `.header-right` |
| 漢堡選單 | `.header-menu-btn` |
| 跑馬燈 | `.marquee-bar`, `.marquee-content`, `.marquee-text` |
| 中獎輪播 | `.winner-section`, `.winner-scroll`, `.winner-card` |
| 分類標籤 | `.category-tabs`, `.category-tab` |
| 區塊標題 | `.section-title` |
| 遊戲 Grid | `.game-grid`, `.game-card`, `.game-card-thumb` |
| 側邊欄 | `.more-drawer-backdrop`, `.more-drawer`, `.more-drawer-item` |
| Tab Bar | `.tab-bar`, `.tab-item` |
| Cookie | `.cookie-banner` |
| 客服 | `.cs-float` |

---

## C. 色彩方案

### C.1 主題色（:root CSS Variables）

| 變數名稱 | 色值 | 用途 |
|---------|------|------|
| `--body-bg` | `#783D21` | 頁面背景（暖棕色） |
| `--header-bg` | `transparent` | Header 透明（用背景圖） |
| `--card-bg` | `#8F4B2B` | 卡片背景 |
| `--section-bg` | `#783D21` | 區塊背景 |
| `--primary` | `#FF6F00` | 主色（橘色） |
| `--accent-green` | `#54BE20` | 強調色（綠色） |
| `--accent-red` | `#EE401E` | 強調色（紅色） |
| `--accent-gold` | `#FFBB00` | 強調色（金色） |
| `--text-primary` | `#FFFFFF` | 主文字（白色） |
| `--text-secondary` | `#F5C5A8` | 次要文字（淺膚色） |
| `--text-muted` | `#DB9A74` | 弱化文字（暗膚色） |
| `--border` | `#9C5432` | 邊框色 |

### C.2 色彩語意分組

```
暖色背景系：
  #783D21 → 頁面背景（暖棕色）
  #8F4B2B → 卡片背景
  #6B3218 → 側邊欄漸層起始
  #5A2810 → 側邊欄漸層結束

功能色：
  #FF6F00 → 主色（橘色），Active 狀態
  #54BE20 → 綠色強調
  #EE401E → 紅色強調（badge）
  #FFBB00 → 金色（中獎金額）

文字色系：
  #FFFFFF → 主文字（白色）
  #F5C5A8 → 次要文字（淺膚色）
  #DB9A74 → 弱化文字（暗膚色）
  #9C5432 → 邊框/分隔線
```

---

## D. 與 Dark V1 的差異

| 面向 | Dark V1 | Warm V1 |
|------|---------|---------|
| 背景 | `#0C1822` 深海軍藍 | `#783D21` 暖棕色 + 背景圖 |
| 主色 | `#1EFFD7` 青色 | `#FF6F00` 橘色 |
| 強調色 | `#F5D639` 金黃 | `#FFBB00` 金色 + `#54BE20` 綠 + `#EE401E` 紅 |
| 文字 | `#FFFFFF` / `#8899AA` | `#FFFFFF` / `#F5C5A8` / `#DB9A74` |
| Header | 純色背景 `#10212F` | 背景圖 `img_topnav_bg.avif` |
| 漢堡選單 | 無（Tab Bar 的「更多」） | 有（Header 左側 icon） |
| 按鈕樣式 | 純色背景（青/金黃） | 背景圖 `btn_topnav_dl/zc.avif` |
| Tab Bar | 5 tab（更多/首頁/體育/優惠/我的）| 5 tab（首頁/娛樂城/登錄/注冊/我的）|
| Tab Bar 高度 | 75px | 89px |
| 遊戲佈局 | 水平滑動 + 9 分類區塊 | 3 列 grid + 分類標籤切換 |
| 遊戲卡片尺寸 | 72×96px + 名稱 | 126×168px + 邊框裝飾 + 名稱 |
| 體育/娛樂城雙卡 | 有（186px） | 無 |
| 分類標籤 | 無 | 有（水平滾動 11 個標籤）|
| Cookie Banner | 無 | 有 |
| Skin path | `6-1-1` | `11-1-2` |
