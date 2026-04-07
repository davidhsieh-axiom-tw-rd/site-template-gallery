# Joy 首頁 HTML 結構分析

> 來源：https://joy.star-link-rel.cc/  
> 分析日期：2026-04-07  
> 技術棧：Vue 3 SPA + Vite + CSS Modules（帶 hash 的 scoped class）

---

## A. 頁面整體 DOM 結構

```
html
└── body [data-theme="0"] [data-club="0"]
    ├── #app
    │   └── .lobby-root（或根 Vue mount 點）
    │       │
    │       ├── [固定層] .fixed-box（Cookie 橫幅，底部固定）
    │       │
    │       ├── [固定層] .floatBox（浮動快捷入口，右下角）
    │       │   ├── .floatBoxLeft / .floatBoxRight
    │       │   ├── .fast-entry-item × N（每個快捷按鈕）
    │       │   │   ├── ._fastBackground（背景圖層）
    │       │   │   ├── ._fastImg（圖示圖層）
    │       │   │   └── ._txtBox > ._fastText（文字）
    │       │   └── ._mini-toggle / ._expand（展開收起）
    │       │
    │       ├── [固定層] .DragChatButtonWidget（客服浮動按鈕，右下藍色耳機）
    │       │
    │       ├── [固定層] .tab-bar（底部 Tab Bar，高度 1.24rem）
    │       │   ├── .tab-item.active（首页）icon: icon_btm_sy
    │       │   ├── .tab-item（优惠）
    │       │   ├── .tab-item（登录）icon: icon_btm_dl
    │       │   ├── .tab-item（注册）icon: icon_btm_tx
    │       │   └── .tab-item（我的）
    │       │
    │       ├── [主內容] .page-body-layout
    │       │   │
    │       │   ├── [Header] 頂部導航
    │       │   │   ├── img[alt="logo"]（GAMING logo，330×100）
    │       │   │   └── img[alt="搜索"]（搜索圖標，80×70）
    │       │   │
    │       │   ├── [Jackpot] ._jackpot_v3l6m（Jackpot 區塊）
    │       │   │   ├── ._banner-container_fbefn（背景：海洋主題）
    │       │   │   │   ├── background: cjc1_style_2_bg.webp
    │       │   │   │   └── background: cjc1_style_1_font_sprite.avif（字型精靈）
    │       │   │   └── 數字輪播（CSS 變數控制）
    │       │   │       ├── --jackpot-card-width
    │       │   │       ├── --jackpot-card-height
    │       │   │       ├── --jackpot-font-color
    │       │   │       └── --jackpot-font-stroke-color
    │       │   │
    │       │   ├── [跑馬燈/公告] 公告欄
    │       │   │   ├── 喇叭圖標（icon_dt_pmd.webp）
    │       │   │   ├── 滾動文字（marquee/CSS animation）
    │       │   │   └── 信封圖標 + 未讀 badge
    │       │   │
    │       │   ├── [中獎輪播] .winner-container / .scale-component
    │       │   │   ├── .list-box（輪播容器）
    │       │   │   │   └── .winner-card × N（每條中獎記錄）
    │       │   │   │       ├── .user-name-box（遮蔽用戶 ID）
    │       │   │   │       ├── .poster-box（遊戲縮圖）
    │       │   │   │       └── .celebrate-icon（慶祝圖標）
    │       │   │   └── 背景：淺藍色 + 山景插圖（bg_pattern_tile.avif）
    │       │   │
    │       │   ├── [登入/快捷] 登入區塊
    │       │   │   ├── .ui-button（登录，白底藍框）
    │       │   │   ├── .ui-button（注册，藍底白字）
    │       │   │   └── .fast-entry 快捷入口列
    │       │   │       ├── img[alt="VIP"]（icon_dt_1vip.avif）
    │       │   │       ├── img[alt="分享赚钱"]（icon_dt_1tg.avif）
    │       │   │       └── img[alt="更多"]（icon_dt_1gd.avif）
    │       │   │
    │       │   ├── [主遊戲區] .core-area-layout（左右分欄）
    │       │   │   │
    │       │   │   ├── .core-area-left（遊戲分類側邊欄）
    │       │   │   │   └── .slide-tab-list
    │       │   │   │       ├── .tab-item（热门）icon: icon_dtfl_rm_1.avif
    │       │   │   │       ├── .tab-item（捕鱼）icon: icon_dtfl_by_1.avif
    │       │   │   │       ├── .tab-item（电子）icon: icon_dtfl_dz_1.avif
    │       │   │   │       ├── .tab-item（棋牌）icon: icon_dtfl_qp_1.avif
    │       │   │   │       ├── .tab-item（真人）icon: icon_dtfl_zr_1.avif
    │       │   │   │       ├── .tab-item（体育）icon: icon_dtfl_ty_1.avif
    │       │   │   │       ├── .tab-item（彩票）icon: icon_dtfl_cp_1.avif
    │       │   │   │       ├── .tab-item（电竞）icon: icon_dtfl_dianjing_1.avif
    │       │   │   │       ├── .tab-item（斗鸡）icon: icon_dtfl_douji_1.avif
    │       │   │   │       ├── .tab-item（区块链）icon: icon_dtfl_qkl_1.avif
    │       │   │   │       └── .tab-item（试玩）icon: icon_dtfl_sw_1.avif
    │       │   │   │
    │       │   │   └── .core-area-right
    │       │   │       │
    │       │   │       ├── .scene-switcher（热门/最近/收藏 tab 切換）
    │       │   │       │
    │       │   │       ├── .tab-game-list-design（遊戲列表區）
    │       │   │       │   ├── .tab-game-list-box
    │       │   │       │   │   └── .tab-game-list-scroll-box
    │       │   │       │   │       └── .game-card × N（遊戲卡片，3列網格）
    │       │   │       │   │           ├── background-image（遊戲封面 avif）
    │       │   │       │   │           ├── .game-name-normal（遊戲名稱）
    │       │   │       │   │           └── .btn_sc_off_2（收藏星號）
    │       │   │       │   └── .tab-game-list-pagination（加載更多）
    │       │   │       │
    │       │   │       └── [各分類區塊] × 9 個分類
    │       │   │           每個分類（捕鱼/电子/棋牌/真人/体育/彩票/电竞/斗鸡/区块链）：
    │       │   │           ├── .section-header（分類圖標 + 名稱 + 全部連結）
    │       │   │           └── .game-card × N（平台遊戲列表）
    │       │   │
    │       │   └── [Footer] .footerBox
    │       │       ├── .assembly-box（主體組件集合）
    │       │       │   ├── .link-list-box（導航連結）
    │       │       │   │   ├── .textlink-box（娱乐城 欄）
    │       │       │   │   │   └── .textlink-item × 10（分享/任务/返水/VIP/活动...）
    │       │       │   │   ├── .textlink-box（游戏 欄）
    │       │       │   │   │   └── .textlink-item × 11（热门/捕鱼/电子...）
    │       │       │   │   └── .textlink-box（支持 欄）
    │       │       │   │       └── .textlink-item × 3（在线客服/帮助中心/有奖反馈）
    │       │       │   ├── .license-compliance（牌照合規）
    │       │       │   │   ├── .license-compliance-list
    │       │       │   │   └── .forbidden-self（自我禁止連結）
    │       │       │   └── .contactUs（聯繫我們）
    │       │       │       ├── .contact-us-title（联系我们）
    │       │       │       └── .socialItem × 2
    │       │       │           ├── img[alt="小飛機專員"]（telegram.avif）
    │       │       │           └── img[alt="小飛機客服"]（telegram.avif）
    │       │       └── .marketing-box（行銷區塊）
    │       │           └── .marketing-box-item × N
    │       │
    │       └── [彈窗層] .ui-dialog（各類彈窗，z-index 最高）
    │           ├── .loginRegisterDialog（登入/註冊彈窗）
    │           │   ├── .loginRegisterFragment（表單區域）
    │           │   └── .loginRegisterPopupClose（關閉按鈕）
    │           ├── 宣傳彈窗（今日不再提示）
    │           └── 幸運抽獎彈窗（深綠色寶箱主題）
    │
    └── [SVG Sprite] 內嵌 SVG 圖標系統（inline svg）
```

---

## B. 重要的 CSS Class 名稱

### B.1 命名體系

此專案使用兩套命名系統並存：

| 系統 | 格式範例 | 用途 |
|------|---------|------|
| CSS Modules（scoped） | `._banner-container_fbefn_45` | Vue 元件內部 scoped 樣式 |
| BEM 全域 class | `.lobby-form-item__label` | 跨元件共用 UI 元件 |
| 語意 class | `.winner-container`、`.footerBox` | 較新元件 |

### B.2 主要區塊 Class 前綴

| 區塊 | CSS Class |
|------|-----------|
| 頂部導航 | `header`（推測）、`search-bar-layout` |
| Jackpot | `._jackpot_[hash]`、`._banner-container_[hash]` |
| 跑馬燈/公告 | 無獨立 class，嵌在 header 下 |
| 中獎輪播 | `.winner-container`、`.winner-card`、`.scale-component`、`.list-box` |
| 登入/註冊按鈕 | `.ui-button`（BEM），對話框: `.loginRegisterDialog` |
| VIP/分享/更多 快捷 | `.fast-entry-item`、`._fastBtn`、`._fastBackground` |
| 遊戲分類側邊欄 | `.core-area-left`、`.slide-tab-list` |
| 遊戲列表區域 | `.core-area-layout`、`.tab-game-list-design`、`.tab-game-list-box` |
| 遊戲卡片 | `.game-card`、`.game-name-normal` |
| 場景切換 tab | `.scene-switcher` |
| Footer 主容器 | `.footerBox` |
| Footer 組件集 | `.assembly-box` |
| Footer 連結列 | `.link-list-box`、`.textlink-box`、`.textlink-item` |
| Footer 牌照 | `.license-compliance`、`.license-compliance-list` |
| Footer 聯繫 | `.contactUs`、`.socialItem`、`.channel-box`、`.channel-item` |
| 底部 Tab Bar | `.tab-bar`（推測）、icon class: `icon_btm_sy/cz/dl/tx` |
| Cookie 橫幅 | `.fixed-box`、`.cookie-style2`、`.cookie-content` |
| 浮動快捷入口 | `.floatBox`、`.floatBoxLeft`、`.floatBoxRight`、`.fast-entry-item` |
| 客服按鈕 | `.DragChatButtonWidget`、`.draggable-item` |

### B.3 UI 元件 class（共用）

| 元件 | Class |
|------|-------|
| 輸入框 | `.ui-input`、`.lobby-form-item`、`.lobby-form-item__input` |
| 按鈕 | `.ui-button`、`.ui-button__text` |
| 彈窗 | `.ui-dialog`、`.ui-dialog__content`、`.ui-dialog__main` |
| 分頁 | `.ui-pagination` |
| Tab | `scene-switcher` |
| Loading | `.loading__box`、`.loading` |

---

## C. 關鍵 Inline Style 與動態樣式

### C.1 CSS Variable（Jackpot 元件）

```css
/* Jackpot 數字翻牌動態控制 */
--jackpot-card-width: [動態]
--jackpot-card-height: [動態]
--jackpot-card-count-to-bottom: [動態]
--jackpot-font-color: [依主題]
--jackpot-card-count-box-height: [動態]
--jackpot-font-letter-spacing: [動態]
--jackpot-card-count-box-scale: [動態]
--jackpot-font-size: [動態]
--jackpot-font-family: [動態]
--jackpot-font-stroke-color: [依主題]
--jackpot-font-stroke: [動態]
```

### C.2 全域佈局 CSS Variables

```css
:root {
  --lobby__px: 1px;
  --lobby__rem-unit: 100;        /* 1rem = 100px（大尺寸設計稿） */
  --lobby__max-width: 100%;
  --lobby__vh: 1vh;
  --lobby__screen-height: calc(var(--lobby__vh) * 100);
  --tabbar-height: 1.24rem;      /* Tab Bar 高度 ~124px */
  --animate-duration: 0.3s;
  --float-box-y-axis-gap: [動態]; /* 浮動面板 Y 軸間距 */
}
```

### C.3 背景圖片（inline background-image）

```css
/* 頁面底紋 */
background-image: url('bg_pattern_tile.avif')  /* 菱形紋理 */

/* Jackpot 橫幅背景 */
background-image: url('cjc1_style_2_bg.webp')        /* 海洋主題背景 */
background-image: url('cjc1_style_1_font_sprite.avif') /* 數字字型精靈 */

/* 遊戲封面（動態注入） */
background-image: url('game_pictures/g/CL/{vendor}/{type}/{gameId}/default.avif')

/* 登入/註冊按鈕裝飾 */
background-image: url('btn_zc1_1.avif')   /* 注册按鈕左裝飾 */
background-image: url('btn_zc1_2.avif')   /* 注册按鈕右裝飾 */
```

### C.4 data 屬性控制的樣式

```html
<!-- 主題切換 -->
<body data-theme="0">      <!-- 主題 0（預設藍白） -->

<!-- 集團識別 -->
<body data-club="0">       <!-- 影響 footerBox 背景是否透明 -->

<!-- Footer 欄位列數 -->
<div data-columns="1">     <!-- 單欄 -->
<div data-columns="2">     <!-- 雙欄 -->
```

---

## D. 色彩方案

### D.1 主題色（:root CSS Variables）

| 變數名稱 | 色值 | 用途 |
|---------|------|------|
| `--skin__primary` | `#003BD5` | 主品牌色（按鈕、選中狀態、連結） |
| `--skin__lead` | `#333333` | 主文字色 |
| `--skin__neutral_1` | `#666666` | 次要文字色 |
| `--skin__neutral_2` | `#999999` | 弱化文字色（placeholder、標籤） |
| `--skin__bg_1` | `#F8F8F8` | 頁面背景色（淺灰） |
| `--skin__bg_2` | `#FFFFFF` | 卡片/彈窗背景色（純白） |
| `--skin__border` | `#E3E3E3` | 邊框、分隔線顏色 |
| `--skin__accent_1` | `#04BE02` | 成功/正向色（綠色） |
| `--skin__accent_2` | `#EA4E3D` | 錯誤/警告色（紅色）|
| `--skin__accent_3` | `#FFAA09` | 提示/警告色（橙黃色） |
| `--skin__btn_color_1` | `#003BD5` | 主按鈕背景色 |
| `--skin__btn_color_2` | `#003BD5` | 次按鈕背景色 |
| `--skin__filter_bg` | `#F8F8F8` | 篩選器背景色 |
| `--skin__filter_active` | `#003BD5` | 篩選器選中色 |
| `--skin__table_bg` | `#FFFFFF` | 表格背景色 |

### D.2 元件特定顏色（inline 或局部定義）

| 位置 | 色值 | 用途 |
|------|------|------|
| 浮動入口倒計時描邊 | `#bc3216` | 棕紅色描邊 |
| 浮動入口按鈕背景 | `rgba(0,0,0,.6)` | 半透明黑底 |
| 浮動入口圖標 | `#fff` | 白色圖標 |
| 陰影 | `rgba(0, 0, 0, 0.06)` | 通用陰影 |
| 白色半透明 | `rgba(255,255,255,.4)` | loading 動畫、疊層 |
| 彈窗遮罩 | `rgba(0,0,0,.3)` | 彈窗背景遮罩 |

### D.3 事件/活動特殊色

| 變數 | 色值 | 用途 |
|------|------|------|
| `--skin__event-luck-wheel-silver` | `#1672f2` | 幸運轉盤銀色 |
| `--skin__event-luck-wheel-gold` | `#ffaa09` | 幸運轉盤金色 |
| `--skin__event-luck-wheel-diamond` | `#b751ff` | 幸運轉盤鑽石色 |
| `--skin__disabled-bg-color` | `#999` | 禁用狀態背景 |
| `--skin__event-text-color` | `#fff` | 活動文字色 |
| `--skin__disabled-font-color` | `#fff` | 禁用狀態文字 |

### D.4 色彩語意分組

```
藍色系（品牌色）：
  #003BD5 → 主按鈕、選中狀態、連結、logo
  #1672f2 → 幸運轉盤銀色、客服按鈕

灰色系（中性色）：
  #F8F8F8 → 頁面背景
  #FFFFFF → 卡片/彈窗背景
  #E3E3E3 → 邊框/分隔線
  #999999 → 弱化文字
  #666666 → 次要文字
  #333333 → 主文字

強調色系：
  #04BE02 → 成功、線上狀態（綠）
  #EA4E3D → 錯誤、警告（紅）
  #FFAA09 → 提示、Jackpot 金色（橙黃）
  #b751ff → 鑽石級別（紫）
  #bc3216 → 棕紅描邊

幸運抽獎彈窗背景色（截圖推斷）：
  深綠色系 → 幸運抽獎彈窗背景
```

---

## E. 資源路徑規則

### 圖片 CDN 路徑格式

```
# 靜態 UI 資源
https://joy.star-link-rel.cc/siteadmin/skin/lobby_asset/{theme}/{area}/{path}.avif
  theme: 1-0-55（深色主題）/ 1-0-common（通用）/ common
  area: common / web / mobile

# 遊戲封面（分兩種）
https://joy.star-link-rel.cc/game_pictures/g/{region}/{vendorId}/{type}/{gameId}/default.avif
https://joy.star-link-rel.cc/game_pictures/p/{region}/{vendorId}/{type}/default.avif
  region: CL（中文）/ L1
  type: 1=老虎機 / 2=捕魚 / 3=電子 / 4=彩票 / 5=棋牌 / 6=電競 / 7=體育 / 8=斗雞 / 11=區塊鏈

# 上傳圖片（動態）
https://joy.star-link-rel.cc/siteadmin/upload/img/{filename}.avif

# CSS/JS Assets
https://joy.star-link-rel.cc/assets/theme-0/{ChunkName}.{hash}.css
https://joy.star-link-rel.cc/assets/vendors/{lib}.{hash}.css
```

### 遊戲分類 icon 命名規則

```
icon_dtfl_rm_1.avif   → 热门
icon_dtfl_by_1.avif   → 捕鱼
icon_dtfl_dz_1.avif   → 电子
icon_dtfl_qp_1.avif   → 棋牌
icon_dtfl_zr_1.avif   → 真人
icon_dtfl_ty_1.avif   → 体育
icon_dtfl_cp_1.avif   → 彩票
icon_dtfl_dianjing_1.avif → 电竞
icon_dtfl_douji_1.avif    → 斗鸡
icon_dtfl_qkl_1.avif      → 区块链
icon_dtfl_sw_1.avif       → 试玩
```

### 頂部 icon 命名規則

```
icon_dt_1ss.avif   → 搜索
icon_dt_pmd.webp   → 喇叭（公告）
icon_dt_1xx_wd.avif → 信箱
icon_dt_1vip.avif  → VIP
icon_dt_1tg.avif   → 分享赚钱
icon_dt_1gd.avif   → 更多
```

---

## F. CSS Chunk 對應表

| Chunk 檔案 | 對應功能 |
|-----------|---------|
| `commonChunk` | 全域基礎樣式、CSS 變數、動畫工具類 |
| `Common` | Jackpot、Banner 元件 |
| `L1Index` | 首頁（L1 = 一級頁面） |
| `WinnerIndex` | 中獎輪播元件 |
| `FloatBarIndex` | 浮動快捷按鈕面板 |
| `FastEntryIndex` | 快捷入口按鈕 |
| `0_EntryLoginRegisterChunk` | 登入/註冊入口 |
| `LoginRegisterIndex` | 登入/註冊彈窗 |
| `AsyncFooter` | Footer 主容器 |
| `AssemblyIndex` | Footer 組件集合（連結/牌照/聯繫） |
| `LinkIndex` | Footer 連結列表 |
| `OfficeChannelIndex` | Footer 官方頻道 |
| `ContactUsIndex` | 聯繫我們 |
| `MixinTextIndex` | 文字混排樣式 |
| `1_SubGameChunk` | 遊戲分類子頁面 |
| `StyleIndex` | 主題樣式變體 |
| `CodeStyleIndex` | Loading 動畫 |
| `GlobalLazyInitIndex` | 延遲載入隱藏元素 |
| `FixedInBottomNoClose` | Cookie 橫幅 |
| `FindUsIndex` | 找到我們/聯繫方式彈窗 |
| `DragChatButtonWidgetIndex` | 可拖動客服按鈕 |
| `MessagePopupIndex` | 訊息彈窗 |
| `vendor-swiper` | Swiper 輪播庫 |
```
