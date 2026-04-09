# Flutter Token 對照表 — Joy Neon V1

> 霓虹藍主題版型（深海軍藍 + 亮藍按鈕 + 森林 header）
> 原站：https://joy.star-link-rel.cc/（霓虹藍主題）
> 日期：2026-04-08

## 設計原則

- **原站為準**：所有色彩、尺寸以原站霓虹藍主題實際渲染值為主
- **Flutter 參考**：Flutter 現有的 Token 名稱作為變數命名參考，但值採原站的
- **暗色主題**：此版型為暗色（Dark），主色為亮藍 #0A69FF

---

## 一、色彩 Token 對照

### 主色系

| CSS 變數 | 原站值 | Flutter Token | 說明 |
|----------|--------|---------------|------|
| `--skin-primary` | `#0A69FF` | `brandPrimary50` | 主色（亮藍） |
| `--skin-accent-1` | `#09CF31` | `statusSuccess` | 綠色強調 |
| `--skin-accent-2` | `#F8544B` | `statusError` | 紅色強調 |
| `--skin-accent-3` | `#FFAA09` | `statusWarning` | 橘金強調 |
| `--skin-bg-1` | `#061325` | `brandPrimary10` | 極深海軍藍背景 |
| `--skin-bg-2` | `#1E2A39` | `brandPrimary20` | 深藍灰背景 |
| `--skin-neutral-1` | `#ADC5DF` | `colorNeutral40` | 淡藍灰文字 |
| `--skin-neutral-2` | `#677B96` | `colorNeutral50` | 中灰藍文字 |
| `--skin-neutral-3` | `#73819A` | `colorNeutral45` | 灰藍文字 |

### 功能色

| 用途 | 原站值 | Flutter Token | 說明 |
|------|--------|---------------|------|
| 登入按鈕 | `transparent + border` | — | 透明背景 + 白色邊框 |
| 註冊按鈕 | `#FFFFFF` | `colorNeutral10` | 白色填充 |
| Tab 選中 | `#0A69FF` | `brandPrimary50` | 亮藍 |
| Jackpot 數字 | `#FFAA09` | `statusWarning` | 橘金 |
| 中獎高亮 | `#FFAA09` | `statusWarning` | 橘金 |
| 存款按鈕 | animated webp | — | 動畫按鈕 |

### 漸層定義

| 名稱 | CSS 值 | Flutter 對應 |
|------|--------|-------------|
| 遊戲名遮罩 | `linear-gradient(to top, rgba(6,19,37,0.9), transparent)` | `LinearGradient(begin: bottom, end: top, colors: [0xE6061325, 0x00061325])` |
| 卡片背景 | `rgba(30, 42, 57, 0.75)` | `Color(0xBF1E2A39)` |

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
| Tab Bar 高度 | 75 | 75 × sizeScaler | `tabBarHeight` |
| Marquee 高度 | 25 | 25 × sizeScaler | — |
| Winner 區高度 | 84 | 84 × sizeScaler | — |
| Jackpot 區高度 | 98 | 98 × sizeScaler | — |
| Game Grid gap | 12 | 12 × sizeScaler | `spacingM` |
| Game Card radius | 12 | 12 × sizeScaler | `radiusL` |
| 全局 padding | 12 | 12 × sizeScaler | `spacingM` |

---

## 三、字體 Token 對照

| 用途 | HTML | Flutter Token |
|------|------|--------------|
| 遊戲分類標題 | 15px / 600 / letter-spacing: 4px | `textLabelM` + `fontWeight600` |
| 按鈕文字 | 14px / 500-600 | `textButtonM` |
| Jackpot 數字 | 28px / 700 / monospace | `textDisplayM` + monospace |
| 跑馬燈 | 12px / normal | `textBodyS` |
| Tab 文字 | 10px / 500 | `textLabelXS` |
| Footer 標題 | 14px / 600 | `textLabelM` |
| Footer 連結 | 12px / normal | `textBodyS` |

---

## 四、陰影對照

| 元素 | CSS box-shadow | Flutter BoxShadow |
|------|---------------|-------------------|
| 遊戲卡片 | `0 2px 8px rgba(0,0,0,0.3)` | `BoxShadow(blurRadius: 8, offset: Offset(0,2), color: Colors.black.withOpacity(0.3))` |
| Tab Bar | `0 -1px 6px rgba(0,0,0,0.3)` | `BoxShadow(blurRadius: 6, offset: Offset(0,-1), color: Colors.black.withOpacity(0.3))` |
| 客服浮動按鈕 | `0 4px 16px rgba(10,105,255,0.4)` | `BoxShadow(blurRadius: 16, offset: Offset(0,4), color: Color(0x660A69FF))` |
| Jackpot 文字 | 3 層 text-shadow | `Shadow(blurRadius: 10, color: Color(0x99FFAA09))` etc |

---

## 五、動畫參數

| 動畫 | CSS duration | Flutter Duration | Curve |
|------|-------------|-----------------|-------|
| 跑馬燈 | 20s linear infinite | `Duration(seconds: 20)` | `Curves.linear` |
| 中獎輪播 | 25s linear infinite | `Duration(seconds: 25)` | `Curves.linear` |
| Jackpot 計數 | 3s interval | `Timer.periodic(Duration(seconds: 3))` | — |
| 客服按鈕 hover | 0.2s | `Duration(milliseconds: 200)` | `Curves.easeOut` |

---

## 六、z-index 對照

| 層級 | 元素 | CSS z-index | Flutter 說明 |
|------|------|------------|-------------|
| 最高 | Tab Bar | 200 | Scaffold bottomNavigationBar |
| 高 | More Overlay | 180 | OverlayEntry |
| 中高 | 客服浮動按鈕 | 150 | FloatingActionButton |
| 中 | Header | 100 | SliverAppBar |
| 基底 | Page 容器 | 1 | Scaffold body |

---

## 七、Widget 對應

| HTML 元素 | Flutter Widget | 說明 |
|-----------|---------------|------|
| `.page` | `Scaffold` + `ScreenWindow` | 頁面容器 |
| `.header` | `SliverAppBar` | 透明 Header |
| `.marquee-bar` | `MarqueeWidget` | 跑馬燈 |
| `.winner-section` | `WinnerTickerWidget` | 中獎輪播 |
| `.nav-section` | `Row` + `ElevatedButton` | 導航列 |
| `.jackpot-section` | `JackpotWidget` | Jackpot 計數 |
| `.game-grid` | `GridView.count(crossAxisCount: 2)` | 遊戲 Grid |
| `.game-card` | `GameCategoryCard` | 分類卡片 |
| `.footer` | `FooterWidget` | 頁尾 |
| `.tab-bar` | `BottomNavigationBar` | 底部導航 |
| `.more-overlay` | `BottomSheet` or `showModalBottomSheet` | 更多選單 |
| `.cs-float` | `FloatingActionButton` | 客服按鈕 |

---

## 八、佈局差異

| 差異點 | HTML 版 | Flutter 版 |
|--------|---------|-----------|
| 容器寬度 | 450px max-width | 375px ScreenWindow |
| 背景圖 | CSS background-image | `DecorationImage` |
| Grid 佈局 | CSS Grid 2-column | `GridView.count(crossAxisCount: 2)` |
| 滾動 | overflow-y auto | `CustomScrollView` + Slivers |
| 更多選單 | Overlay + backdrop | `showModalBottomSheet` |
| Tab Bar | position: fixed | `Scaffold.bottomNavigationBar` |
| 凍結模式 | ?freeze=true query | 不適用（開發用） |
