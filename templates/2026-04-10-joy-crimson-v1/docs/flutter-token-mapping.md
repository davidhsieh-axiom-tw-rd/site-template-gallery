# Flutter Token 對照表 — Joy Crimson V1

> 深紅金色中式宮廷風格（深紅背景 + 金色主色 + 粉紅文字）
> 來源：https://joy.star-link-rel.cc/（skin 5-1-1）
> 日期：2026-04-10

## 設計原則

- **原站為準**：所有色彩、尺寸以原站深紅主題實際渲染值為主
- **Flutter Token 對照**：Flutter Token 名稱作為變數命名參考，數值以原站為準
- **深色模式**：本版型為深色模式，主色為金 #FFE44D，背景深紅 #300101

---

## 一、色彩 Token 對照

### 主色系

| CSS Variable | Value | Flutter Token | Description |
|-------------|-------|---------------|-------------|
| `--skin-primary` | `#FFE44D` | `brandPrimary50` | 主色（金） |
| `--skin-accent-gold` | `#FFAA09` | `statusWarning` | 金色強調 |
| `--skin-accent-blue` | `#1672F2` | `eventLuckWheelSilver` | 藍色強調 |
| `--skin-accent-crimson` | `#6F000D` | — | 深紅強調 |
| `--skin-disabled` | `#999` | `disabledBgColor` | 禁用灰 |
| `--skin-bg-1` | `#300101` | `brandPrimary10` | 深紅背景 |
| `--skin-bg-2` | `#130606` | `brandPrimary20` | 更深紅（Header/Tab Bar） |
| `--skin-bg-3` | `#4a0f0f` | `colorNeutral30` | 較淺紅（按鈕） |

### 功能色

| 用途 | 值 | Flutter Token | 說明 |
|------|---|---------------|------|
| 登录按鈕 | transparent + `#FFE44D` 邊框 | `brandPrimary50` | 金色描邊 |
| 注册按鈕 | `#FFE44D` bg + `#6F000D` text | `brandPrimary50` | 金色填充 |
| Sidebar active 背景 | `btn_zc3_2.avif` | — | 分類背景圖 |
| Jackpot 數字 | `#b71c1c` | — | 深紅（源自背景圖） |
| 中獎高亮 | `#FFAA09` | `statusWarning` | 金色 |
| Badge | `#F84673` | — | 粉紅 badge |
| Platform title | `#FFE44D` | `brandPrimary50` | 金色 |

### 漸層定義

| 名稱 | CSS 值 | Flutter 等效 |
|------|--------|-------------|
| 遊戲名遮罩 | `linear-gradient(transparent, rgba(0,0,0,0.75))` | `LinearGradient(begin: top, end: bottom, colors: [transparent, 0xBF000000])` |
| 卡片背景 | `rgba(19, 6, 6, 0.85)` | `Color(0xD9130606)` |
| Winner 卡片 | `rgba(48, 1, 1, 0.7)` | `Color(0xB3300101)` |

---

## 二、尺寸 Token 對照

### 設計基準

| 項目 | HTML | Flutter | 備註 |
|------|------|---------|------|
| 設計寬度 | 450px（容器 max-width） | 375px | Flutter 用 sizeScaler |
| 桌面版行為 | max-width 450px 居中 | ScreenWindow 強制 375:812 比例 | 佈局差異 |

### 區塊尺寸

| 元素 | HTML px | Flutter dp | Token |
|------|---------|-----------|-------|
| Header 高度 | 66 | 66 x sizeScaler | `headerHeight` |
| Tab Bar 高度 | 95 | 95 x sizeScaler | `tabBarHeight` |
| Jackpot 區高度 | 98 | 98 x sizeScaler | — |
| 跑馬燈高度 | 38 | 38 x sizeScaler | — |
| 中獎區高度 | 84 | 84 x sizeScaler | — |
| Sidebar 寬度 | 80 | 80 x sizeScaler | — |
| Sidebar item | 80×62 | 80×62 x sizeScaler | — |
| Sidebar icon | 32×32 | 32 x sizeScaler | — |
| 遊戲卡片 | 1:1 | — | — |
| 熱門滾動卡片 | 92×92 | 92 x sizeScaler | — |
| 平台全寬卡片 | 345×135 | 100% x 135 | — |
| 遊戲 Grid 間距 | 6 | 6 x sizeScaler | `spacingXS` |
| 遊戲卡片圓角 | 10 | 10 x sizeScaler | `radiusM` |
| 登录按鈕 | 72×30 | — | — |
| 注册按鈕 | 72×30 | — | — |

---

## 三、字體 Token 對照

| 元素 | font-size | font-weight | color | letter-spacing |
|------|-----------|-------------|-------|---------------|
| 平台標題 | 16px | 600 | #FFE44D | — |
| 登录按鈕 | 13px | 600 | #FFE44D | — |
| 注册按鈕 | 13px | 600 | #6F000D | — |
| Jackpot 數字 | 26px | 900 | #b71c1c | 5px |
| 跑馬燈文字 | 12px | normal | #E39197 | — |
| 中獎卡片 | 11px | normal | #E39197 | — |
| 中獎高亮 | 11px | 600 | #FFAA09 | — |
| Sidebar 文字 | 11px | normal | #E39197 | — |
| Sidebar 選中 | 11px | 600 | #FFE44D | — |
| Tab Bar 文字 | 11px | 500 | rgba(227,145,151,0.6) | — |
| Tab Bar 選中 | 11px | 600 | #FFE44D | — |
| Footer 標題 | 16.8px | 600 | #FFE44D | — |
| Footer 連結 | 12px | normal | rgba(227,145,151,0.6) | — |
| More menu 項目 | 10px | normal | #E39197 | — |
| 遊戲名 | 11px | 700 | #FFFFFF | — |
| Quick action | 10px | normal | #E39197 | — |

---

## 四、陰影對照

| 元素 | CSS box-shadow | Flutter BoxShadow |
|------|---------------|-------------------|
| Tab Bar | background-image (no shadow) | — |
| Telegram icon | `0 2px 8px rgba(255,228,77,0.15)` | `BoxShadow(blurRadius: 8, offset: Offset(0,2), color: Color(0x26FFE44D))` |
| Winner card | `backdrop-filter: blur(4px)` | `BackdropFilter` |

---

## 五、動畫參數

| 動畫 | CSS duration | Flutter Duration | Curve |
|------|-------------|-----------------|-------|
| 跑馬燈 | 20s linear infinite | `Duration(seconds: 20)` | `Curves.linear` |
| 中獎輪播 | 25s linear infinite | `Duration(seconds: 25)` | `Curves.linear` |
| 熱門遊戲滾動 | 30s linear infinite | `Duration(seconds: 30)` | `Curves.linear` |
| Jackpot 計數器 | 3s interval | `Timer.periodic(Duration(seconds: 3))` | — |

---

## 六、z-index 對照

| 層級 | 元素 | CSS z-index | Flutter 說明 |
|------|------|------------|-------------|
| 最高 | Tab Bar | 200 | Scaffold bottomNavigationBar |
| 高 | More Overlay | 180 | BottomSheet |
| 中 | Header | 100 | SliverAppBar |
| 基底 | Page 容器 | 1 | Scaffold body |

---

## 七、Widget 對應

| HTML 元素 | Flutter Widget | 說明 |
|-----------|---------------|------|
| `.page` | `Scaffold` | 根容器（深紅背景圖） |
| `.header` | `SliverAppBar` | Logo + Lucky Wheel + Search |
| `.jackpot-section` | `JackpotWidget` | Jackpot 計數 + 背景圖 |
| `.marquee-bar` | `MarqueeWidget` | 跑馬燈（有背景圖） |
| `.winner-section` | `WinnerTickerWidget` | 中獎輪播（有背景圖） |
| `.auth-actions-bar` | `AuthActionsBar` | 登录/注册 + 快捷按鈕 |
| `.category-sidebar` | `SidebarWidget` | 垂直分類列表 |
| `.game-content` | `GameContentArea` | 遊戲主區域 |
| `.platform-card-full` | `PlatformFullCard` | 全寬平台卡片 |
| `.hot-games-track` | `HotGamesScrollWidget` | 熱門遊戲滾動 |
| `.footer` | `FooterWidget` | 頁尾三欄連結 |
| `.tab-bar` | `BottomNavigationBar` | 底部 Tab Bar（有背景圖） |
| `.more-overlay` | `BottomSheet` | 更多選單（overlay） |

---

## 八、佈局差異

| 項目 | HTML 實作 | Flutter 差異 |
|------|----------|-------------|
| 容器寬度 | `max-width: 450px` 居中 | Flutter 用 375px 設計稿 + sizeScaler |
| 遊戲區域 | Sidebar + Content (flex layout) | Flutter Row(children: [Sidebar, Expanded(Content)]) |
| 分類選擇 | 垂直 sidebar sticky | Flutter SliverPersistentHeader or fixed Column |
| 平台全寬卡片 | background-image div (345x135) | Flutter Container + DecorationImage |
| 熱門遊戲滾動 | CSS @keyframes 單排 | Flutter AnimatedList |
| 更多選單 | Bottom overlay panel | Flutter showModalBottomSheet |
| Tab Bar 背景 | CSS background-image | Flutter Container + DecorationImage |
| 頁面背景 | CSS background url (repeat-y) | Flutter BoxDecoration + DecorationImage |
