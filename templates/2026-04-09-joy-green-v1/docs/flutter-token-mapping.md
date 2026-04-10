# Flutter Token 對照表 — Joy Green V1

> 綠色主題（深灰藍背景 + 綠色主色 + 粉紅強調色）
> 來源：https://joy.star-link-rel.cc/（skin 63-1-1）
> 日期：2026-04-09

## 設計原則

- **原站為準**：所有色彩、尺寸以原站綠色主題實際渲染值為主
- **Flutter Token 對照**：Flutter Token 名稱作為變數命名參考，數值以原站為準
- **深色模式**：本版型為深色模式，主色為綠 #0AB76B

---

## 一、色彩 Token 對照

### 主色系

| CSS Variable | Value | Flutter Token | Description |
|-------------|-------|---------------|-------------|
| `--skin-primary` | `#0AB76B` | `brandPrimary50` | 主色（綠） |
| `--skin-accent-gold` | `#FFAA09` | `statusWarning` | 金色強調 |
| `--skin-accent-blue` | `#1672F2` | `eventLuckWheelSilver` | 藍色強調 |
| `--skin-disabled` | `#999` | `disabledBgColor` | 禁用灰 |
| `--skin-bg-1` | `#292D3B` | `brandPrimary10` | 深灰藍背景 |
| `--skin-bg-2` | `#212430` | `brandPrimary20` | 更深灰藍（Tab Bar） |
| `--skin-bg-3` | `#353A4A` | `colorNeutral30` | 較淺（按鈕） |

### 功能色

| 用途 | 值 | Flutter Token | 說明 |
|------|---|---------------|------|
| 注册按鈕（header） | `#0AB76B` | `brandPrimary50` | 綠色填充 |
| 登录按鈕（header） | transparent + `#0AB76B` 邊框 | `brandPrimary50` | 綠色描邊 |
| 分類 Tab icon 背景 | `#0AB76B` | `brandPrimary50` | 綠色圓形 |
| Jackpot 數字 | `#b71c1c` | — | 深紅（源自背景圖） |
| 中獎高亮 | `#FFAA09` | `statusWarning` | 金色 |
| 粉紅強調 | `#F84673` | — | Drawer 粉紅 |

### 漸層定義

| 名稱 | CSS 值 | Flutter 等效 |
|------|--------|-------------|
| 遊戲名遮罩 | `linear-gradient(transparent, rgba(0,0,0,0.75))` | `LinearGradient(begin: top, end: bottom, colors: [transparent, 0xBF000000])` |
| 卡片背景 | `rgba(33, 36, 48, 0.85)` | `Color(0xD9212430)` |
| 中獎區 | `linear-gradient(135deg, #1a3a5c, #2a7ab5, #3d9cd4)` | 天藍色漸層 |
| Drawer header | `linear-gradient(180deg, #0AB76B, #076b3e, #212430)` | 綠色漸層 |

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
| Header 高度 | 50 | 50 x sizeScaler | `headerHeight` |
| Tab Bar 高度 | 87.6 | 87.6 x sizeScaler | `tabBarHeight` |
| Jackpot 區高度 | 98 | 98 x sizeScaler | — |
| 中獎區高度 | 84 | 84 x sizeScaler | — |
| 分類 Tab 尺寸 | 72×72 | 72 x sizeScaler | — |
| 分類 icon 圓形 | 44×44 | 44 x sizeScaler | — |
| 遊戲 Grid 間距 | 10 | 10 x sizeScaler | `spacingS` |
| 遊戲卡片圓角 | 18 | 18 x sizeScaler | `radiusL` |
| 搜索欄圓角 | 24 | 24 x sizeScaler | — |

---

## 三、字體 Token 對照

| 元素 | font-size | font-weight | color | letter-spacing |
|------|-----------|-------------|-------|---------------|
| 平台標題 | 18px | 600 | #FFFFFF | — |
| Header 品牌名 | 14px | 700 | #FFFFFF | 2px |
| Header 品牌 URL | 10px | normal | rgba(171,175,187,1) | 0.5px |
| 注册按鈕 | 13px | 600 | #FFFFFF | — |
| 登录按鈕 | 13px | 600 | #0AB76B | — |
| Jackpot 數字 | 26px | 900 | #b71c1c | 5px |
| 跑馬燈文字 | 12px | normal | rgba(171,175,187,1) | — |
| 中獎卡片 | 11px | normal | rgba(171,175,187,1) | — |
| 中獎高亮 | 11px | 600 | #FFAA09 | — |
| 分類 Tab 文字 | 11px | normal | #FFFFFF | — |
| Tab Bar 文字 | 10px | 500 | rgba(255,255,255,0.5) | — |
| Tab Bar 選中 | 10px | 600 | #0AB76B | — |
| Footer 標題 | 16.8px | 600 | #FFFFFF | — |
| Footer 連結 | 12px | normal | rgba(255,255,255,0.5) | — |
| Drawer 選單項 | 15px | normal | #e0e0e0 | — |

---

## 四、陰影對照

| 元素 | CSS box-shadow | Flutter BoxShadow |
|------|---------------|-------------------|
| Tab Bar | `0 -1px 6px rgba(0,0,0,0.3)` | `BoxShadow(blurRadius: 6, offset: Offset(0,-1), color: Colors.black.withOpacity(0.3))` |
| Telegram icon | `0 2px 8px rgba(10,183,107,0.2)` | `BoxShadow(blurRadius: 8, offset: Offset(0,2), color: Color(0x330AB76B))` |

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
| 高 | Drawer | 180 | Drawer |
| 中 | Header | 100 | SliverAppBar |
| 基底 | Page 容器 | 1 | Scaffold body |

---

## 七、Widget 對應

| HTML 元素 | Flutter Widget | 說明 |
|-----------|---------------|------|
| `.page` | `Scaffold` | 根容器 |
| `.header` | `SliverAppBar` | 固定 Header |
| `.jackpot-section` | `JackpotWidget` | Jackpot 計數 + 背景圖 |
| `.marquee-bar` | `MarqueeWidget` | 跑馬燈公告 |
| `.search-bar` | `SearchBarWidget` | 搜索欄 |
| `.winner-section` | `WinnerTickerWidget` | 中獎輪播 |
| `.category-tabs` | `CategoryTabsWidget` | 遊戲分類 Tab |
| `.hot-games-section` | `HotGamesWidget` | 熱門遊戲（3列 + 滾動） |
| `.platform-section` | `PlatformSectionWidget` | 平台遊戲區（2列） |
| `.footer` | `FooterWidget` | 頁尾三欄連結 |
| `.tab-bar` | `BottomNavigationBar` | 底部 Tab Bar |
| `.more-drawer` | `Drawer` | 更多選單 |

---

## 八、佈局差異

| 項目 | HTML 實作 | Flutter 差異 |
|------|----------|-------------|
| 容器寬度 | `max-width: 450px` 居中 | Flutter 用 375px 設計稿 + sizeScaler |
| 虛擬滾動 | CSS overflow scroll | Flutter ListView/CustomScrollView |
| 熱門遊戲滾動 | CSS @keyframes 雙排 | Flutter AnimatedList 或 PageView |
| 分類 Tab 水平滾動 | CSS overflow-x: auto | Flutter TabBar + SingleChildScrollView |
| 遊戲卡片 | background-image div | Flutter Container + DecorationImage |
| Jackpot 動畫 | CSS sprite background-position | Flutter SpriteWidget 或 CustomPainter |
| Drawer 展開 | JS toggle class | Flutter ExpansionTile |
