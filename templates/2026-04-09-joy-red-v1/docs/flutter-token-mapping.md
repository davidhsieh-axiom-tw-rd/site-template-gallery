# Flutter Token 對照表 — Joy Red V1

> 紅色主題版型（深黑背景 + 紅色按鈕 + 金黃強調）
> 原站：https://joy.star-link-rel.cc/（紅色主題 skin 72-1-2）
> 日期：2026-04-09

## 設計原則

- **原站為準**：所有色彩、尺寸以原站紅色主題實際渲染值為主
- **Flutter 參考**：Flutter 現有的 Token 名稱作為變數命名參考，但值採原站的
- **暗色主題**：此版型為暗色（Dark），主色為紅色 #D03434

---

## 一、色彩 Token 對照

### 主色系

| CSS 變數 | 原站值 | Flutter Token | 說明 |
|----------|--------|---------------|------|
| `--skin-primary` | `#D03434` | `brandPrimary50` | 主色（紅色） |
| `--skin-accent-gold` | `#FFAA09` | `statusWarning` | 橘金強調 |
| `--skin-accent-blue` | `#1672F2` | `eventLuckWheelSilver` | 藍色強調 |
| `--skin-disabled` | `#999` | `disabledBgColor` | 禁用灰 |
| `--skin-bg-1` | `#161616` | `brandPrimary10` | 極深黑背景 |
| `--skin-bg-2` | `#212121` | `brandPrimary20` | 深灰背景（Tab Bar） |
| `--skin-bg-3` | `#303030` | `colorNeutral30` | 暗灰按鈕背景 |

### 功能色

| 用途 | 原站值 | Flutter Token | 說明 |
|------|--------|---------------|------|
| 登入按鈕 | `#D03434` | `brandPrimary50` | 紅色填充 |
| 註冊按鈕 | `#303030` | `colorNeutral30` | 暗灰填充 |
| Category Tab (active) | `#D03434` | `brandPrimary50` | 紅色背景 |
| Jackpot 數字 | `#FFAA09` | `statusWarning` | 橘金 |
| 中獎高亮 | `#FFAA09` | `statusWarning` | 橘金 |

### 漸層定義

| 名稱 | CSS 值 | Flutter 對應 |
|------|--------|-------------|
| 遊戲名遮罩 | `linear-gradient(to top, rgba(22,22,22,0.9), transparent)` | `LinearGradient(begin: bottom, end: top, colors: [0xE6161616, 0x00161616])` |
| 卡片背景 | `rgba(33, 33, 33, 0.85)` | `Color(0xD9212121)` |

---

## 二、尺寸 Token 對照

### 設計基準

| 項目 | HTML 版 | Flutter 版 | 說明 |
|------|---------|-----------|------|
| 設計基準寬度 | 450px（容器 max-width） | 375px | Flutter 用 sizeScaler 縮放 |
| 桌面版行為 | max-width 450px 居中 | ScreenWindow 強制 375:812 比例 | 佈局差異 |

### 區塊尺寸

| 元素 | HTML px | Flutter dp | Token |
|------|---------|-----------|-------|
| Header 高度 | 50 | 50 × sizeScaler | `headerHeight` |
| Tab Bar 高度 | 87.6 | 87.6 × sizeScaler | `tabBarHeight` |
| Jackpot 區高度 | 120 | 120 × sizeScaler | — |
| Winner 區高度 | 84 | 84 × sizeScaler | — |
| Category Tab 尺寸 | 72×72 | 72 × sizeScaler | — |
| Category Tab 圓角 | 8.4 | 8.4 × sizeScaler | `radiusM` |
| Game Grid gap | 8 | 8 × sizeScaler | `spacingS` |
| Game Card radius | 12 | 12 × sizeScaler | `radiusL` |
| 登入/註冊按鈕 | 207×45.6 | 207×45.6 × sizeScaler | — |
| 按鈕圓角 | 8.4 | 8.4 × sizeScaler | `radiusM` |

---

## 三、字體 Token 對照

| 用途 | HTML | Flutter Token |
|------|------|--------------|
| 平台標題 | 16.8px / 600 | `textLabelL` + `fontWeight600` |
| 按鈕文字 | 15px / 600 / letter-spacing: 2px | `textButtonM` |
| Jackpot 數字 | 32px / 700 / monospace | `textDisplayL` + monospace |
| 跑馬燈 | 12px / normal | `textBodyS` |
| Category Tab | 11px / normal | `textLabelXS` |
| Tab Bar 文字 | 10px / 500 | `textLabelXS` |
| Footer 標題 | 16.8px / 600 | `textLabelL` |
| Footer 連結 | 12px / normal | `textBodyS` |

---

## 四、陰影對照

| 元素 | CSS box-shadow | Flutter BoxShadow |
|------|---------------|-------------------|
| Tab Bar | `0 -1px 6px rgba(0,0,0,0.3)` | `BoxShadow(blurRadius: 6, offset: Offset(0,-1), color: Colors.black.withOpacity(0.3))` |
| Jackpot 文字 | 3 層 text-shadow | `Shadow(blurRadius: 10, color: Color(0x99FFAA09))` etc |
| Telegram icon | `0 2px 8px rgba(208,52,52,0.2)` | `BoxShadow(blurRadius: 8, offset: Offset(0,2), color: Color(0x33D03434))` |

---

## 五、動畫參數

| 動畫 | CSS duration | Flutter Duration | Curve |
|------|-------------|-----------------|-------|
| 跑馬燈 | 20s linear infinite | `Duration(seconds: 20)` | `Curves.linear` |
| 中獎輪播 | 25s linear infinite | `Duration(seconds: 25)` | `Curves.linear` |
| 熱門遊戲滾動 | 30s linear infinite | `Duration(seconds: 30)` | `Curves.linear` |
| Jackpot 計數 | 3s interval | `Timer.periodic(Duration(seconds: 3))` | — |

---

## 六、z-index 對照

| 層級 | 元素 | CSS z-index | Flutter 說明 |
|------|------|------------|-------------|
| 最高 | Tab Bar | 200 | Scaffold bottomNavigationBar |
| 高 | More Drawer | 180 | Drawer |
| 中 | Header | 100 | SliverAppBar |
| 基底 | Page 容器 | 1 | Scaffold body |

---

## 七、Widget 對應

| HTML 元素 | Flutter Widget | 說明 |
|-----------|---------------|------|
| `.page` | `Scaffold` + `ScreenWindow` | 頁面容器 |
| `.header` | `SliverAppBar` | Header（漢堡選單 + Logo） |
| `.jackpot-section` | `JackpotWidget` | Jackpot 計數 + 背景圖 |
| `.marquee-bar` | `MarqueeWidget` | 跑馬燈 |
| `.auth-section` | `Row` + `ElevatedButton` | 註冊/登入 |
| `.winner-section` | `WinnerTickerWidget` | 中獎輪播 |
| `.category-tabs` | `ListView.builder(scrollDirection: Axis.horizontal)` | 13 分類 Tab |
| `.platform-section` | `GamePlatformSection` | 遊戲平台區 |
| `.game-grid-3col` | `GridView.count(crossAxisCount: 3)` | 3 列遊戲 Grid |
| `.footer` | `FooterWidget` | 頁尾 |
| `.tab-bar` | `BottomNavigationBar` | 底部導航（5 tab） |
| `.more-drawer` | `Drawer` | 左側 Drawer |

---

## 八、佈局差異

| 差異點 | HTML 版 | Flutter 版 |
|--------|---------|-----------|
| 容器寬度 | 450px max-width | 375px ScreenWindow |
| Game Grid | 3-column CSS Grid | `GridView.count(crossAxisCount: 3)` |
| Category Tabs | 橫向捲動 flex | `ListView(scrollDirection: Axis.horizontal)` |
| Drawer | position: fixed left | `Scaffold.drawer` |
| Tab Bar | position: fixed | `Scaffold.bottomNavigationBar` |
| 凍結模式 | ?freeze=true query | 不適用（開發用） |
