# Flutter Token 對照表 — Joy Warm V1

> 暖橘棕色主題版型（山脈森林 header + 漸層棕背景）
> 原站：https://joy.star-link-rel.cc/（暖色主題 theme=11-1-2）
> 日期：2026-04-08

## 設計原則

- **原站為準**：所有色彩、尺寸以原站暖色主題實際渲染值為主
- **Flutter 參考**：Flutter 現有的 Token 名稱作為變數命名參考，但值採原站的
- **暖色主題**：此版型為暖色（Warm），與 Joy Dark V1（暗色）互為對照

---

## 一、色彩 Token 對照

### 主色系

| CSS 變數 | 原站值 | Flutter Token | 說明 |
|----------|--------|---------------|------|
| `--body-bg` | `#783D21` | `skin__bg_1` / `skin__home_bg` | 頁面背景（暖棕色） |
| `--header-bg` | `transparent` | — | Header 用背景圖 |
| `--card-bg` | `#8F4B2B` | `skin__bg_2` | 卡片背景（較亮棕） |
| `--section-bg` | `#783D21` | `skin__bg_1` | 區塊背景 |
| `--primary` | `#FF6F00` | `skin__primary` | 主色（橘色） |
| `--text-primary` | `#FFFFFF` | `skin__lead` / `skin__text_primary` | 主文字（白色） |
| `--text-secondary` | `#F5C5A8` | `skin__neutral_1` | 次要文字（淺膚色） |
| `--text-muted` | `#DB9A74` | `skin__neutral_2` / `skin__neutral_3` | 弱化文字 |
| `--border` | `#9C5432` | `skin__border` | 邊框色 |

### 功能色

| 用途 | 原站值 | Flutter Token | 說明 |
|------|--------|---------------|------|
| 主色 / Active | `#FF6F00` | `skin__primary` | 橘色，分類 active |
| 綠色強調 | `#54BE20` | `skin__accent_1` | 綠色 |
| 紅色強調 | `#EE401E` | `skin__accent_2` | 紅色（badge） |
| 金色強調 | `#FFBB00` | `skin__accent_3` | 金色（中獎金額） |
| 登入按鈕 | — | — | 用背景圖 `btn_topnav_dl.avif` |
| 註冊按鈕 | — | — | 用背景圖 `btn_topnav_zc.avif` |
| Tab Bar Active | `#FF6F00` | `skin__primary` | 文字橘色 |
| Cookie 按鈕背景 | `#FF6F00` | `skin__primary` | 橘色 |

### 漸層定義

| 名稱 | CSS 值 | Flutter 對應 |
|------|--------|-------------|
| 側邊欄背景 | `linear-gradient(180deg, #6B3218, #5A2810)` | `LinearGradient(begin: top, end: bottom, colors: [0x6B3218, 0x5A2810])` |
| 全頁背景 | `img_db_dt_bg.avif` (background-image) | `DecorationImage(fit: BoxFit.cover)` |

---

## 二、尺寸 Token 對照

### 設計基準

| 項目 | HTML 版 | Flutter 版 | 說明 |
|------|---------|-----------|------|
| 設計基準寬度 | 450px（容器 max-width） | 375px | Flutter 用 sizeScaler 縮放 |
| 桌面版行為 | max-width 450px 居中，body bg #e8e8e8 | ScreenWindow 強制 375:812 比例 | 佈局差異 |

### 元件尺寸

| 元件 | HTML 值 | Flutter AppDimen | 備註 |
|------|---------|-----------------|------|
| Header 高度 | 60px | `size_54` | 含背景圖 |
| Marquee 高度 | 39px | — | 半透明背景 |
| 中獎輪播卡片 | 152×68px | — | 圓角 20px |
| 分類標籤高度 | 36px | — | 水平滾動 |
| 遊戲卡片 | 126×168px | — | 3:4 比例，圓角 15.75px |
| 遊戲 Grid 間距 | 18px | `AppDimen.size_16` | 3 欄 |
| Tab Bar 高度 | 89px | `size_64` + safe area | 背景圖 |
| 客服浮動按鈕 | 60×60px | `size_60` | 圓形 |
| 側邊欄寬度 | 288px | — | 左側滑入 |

### 間距系統

| 間距用途 | HTML 值 | Flutter 參考 |
|---------|---------|-------------|
| 頁面左右 padding | 18px | `AppDimen.size_16` |
| 遊戲格 gap | 18px | `AppDimen.size_16` |
| Header padding | 10px | — |
| 跑馬燈 padding | 12px | `AppDimen.size_12` |
| Section title padding | 18px | `AppDimen.size_16` |

---

## 三、字體 Token 對照

### Font Family

| HTML | Flutter |
|------|---------|
| `-apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC', 'Hiragino Sans GB', 'Microsoft YaHei', Roboto, sans-serif` | `PingFang SC, Microsoft YaHei, sans-serif` |

### 全局設定

| 項目 | HTML | Flutter | 建議 |
|------|------|---------|------|
| 基礎字體大小 | 16px | 依各元素 | |
| 預設 line-height | 1.3 | 1.3 | 已對齊 |
| `TextLeadingDistribution` | — | `.even` | Flutter 特有 |

### 逐元素文字樣式

| 元素 | font-size | font-weight | letter-spacing | color | Flutter TextStyle |
|------|-----------|-------------|----------------|-------|-------------------|
| 登入/註冊按鈕 | 14.4px | 600 | 2px | #FFFFFF | `textStyle14s` |
| 跑馬燈文字 | 12px | 400 | 0 | #F5C5A8 | `textStyle12n` |
| 分類標籤 | 13px | 500/600 | 0 | #F5C5A8 / #FF6F00 | `textStyle13m` |
| 區塊標題 | 16.8px | 600 | 0 | #FFFFFF | `textStyle16s` |
| 遊戲名稱 | 14.4px | 400 | 0 | #FFFFFF | `textStyle14n` |
| 中獎輪播 | 11px | 400 | 0 | #F5C5A8 | `textStyle11n` |
| 中獎金額 | 11px | 600 | 0 | #FFBB00 | `textStyle11s` |
| Tab Bar 文字 | 10px | 500 | 0 | #F5C5A8 | `textStyle10m` |
| Cookie 文字 | 12px | 400 | 0 | #F5C5A8 | `textStyle12n` |
| 側邊欄項目 | 14.4px | 400 | 0 | #F5C5A8 | `textStyle14n` |

---

## 四、陰影對照

| 元素 | HTML box-shadow | Flutter BoxShadow 建議 |
|------|----------------|----------------------|
| Tab Bar | 無（背景圖覆蓋） | 可省略 |
| 遊戲卡片 | 無（有邊框裝飾圖取代） | — |
| Cookie Banner | 無 | — |
| Overlay | `background: rgba(0,0,0,0.5)` | `ModalBarrier(color: Colors.black54)` |

此主題大量使用背景圖而非 box-shadow，陰影效果內嵌於圖片素材中。

---

## 五、動畫參數對照

| 動畫 | HTML 參數 | Flutter 建議 |
|------|----------|-------------|
| 跑馬燈 | `animation: 20s linear infinite` | `AnimationController + velocity: 30px/s` |
| 中獎輪播 | `animation: 25s linear infinite` | `AnimationController + linear` |
| 分類切換 | 無過渡（CSS class toggle） | `Duration(milliseconds: 300), Curves.easeInOut` |
| Tab 切換 | 無過渡動畫 | `Duration(milliseconds: 300), Curves.easeInOut` |
| 側邊欄開關 | CSS display toggle | `SlideTransition(duration: 300ms)` |
| 客服按鈕 hover | `transform: scale(1.08), 0.2s` | `AnimatedScale(duration: 200ms)` |

---

## 六、z-index → Stack 層疊對照

| z-index | HTML 元素 | Flutter Widget | Stack 順序（底→頂）|
|---------|----------|---------------|-------------------|
| 0 | 背景圖 `img_db_dt_bg.avif` | `DecorationImage` | 1 |
| 1 | `.page`（主內容） | `Scaffold.body` | 2 |
| 100 | `.header`（sticky） | `AppBar`（自動置頂） | 系統管理 |
| 150 | `.cs-float`（客服浮動） | `Positioned(bottom, right)` | 3 |
| 190 | `.cookie-banner` | `Positioned(bottom: tabBarHeight)` | 4 |
| 200 | `.tab-bar`（底部） | `Scaffold.bottomNavigationBar` | 系統管理 |
| 300 | `.more-drawer-backdrop`（側邊欄） | `Drawer` / `ModalRoute` | 5 |

---

## 七、Widget 對應表（HTML class → Flutter Widget）

| HTML 元素/class | Flutter Widget | Flutter 檔案 |
|----------------|---------------|-------------|
| `.header` | `HomeAppBar` | `home_app_bar.dart`（需改造：加背景圖 + 漢堡選單） |
| `.marquee-bar` | `HomeAnnouncement` + `AppMarquee` | `home_announcement.dart` |
| `.winner-section` | `WinnerTickerWidget` | **需新建** |
| `.category-tabs` | `GameCategoryTabs` | **需新建**（水平滾動標籤） |
| `.section-title` | `SectionHeader` | 可沿用 |
| `.game-grid` | `GameGridView` | **需新建**（3 列 grid） |
| `.game-card` | `GameCard` | `game_card.dart`（需改造：加邊框裝飾） |
| `.more-drawer` | `AppDrawer` | **需新建** |
| `.tab-bar` | `AppBottomBar` | `app_bottom_bar.dart`（需改造：5 tab + 背景圖） |
| `.cookie-banner` | `CookieBanner` | **需新建** |
| `.cs-float` | `CustomerServiceFloat` | 可沿用 |

---

## 八、佈局差異與轉換決策

| 面向 | HTML 版（暖色復刻） | Flutter 現有 | 轉換建議 |
|------|-------------------|-------------|---------|
| 主題色 | 暖色（#783D21 暖棕色底 + 背景圖） | 淺色（#F8F8F8 背景） | **以原站為主**，需建立 warm theme |
| Header | 背景圖 + 漢堡選單 | 純色背景 | **以原站為主** |
| 遊戲分類 | 水平標籤切換 + 3 列 grid | 頂部水平 TabBar + 列表 | **以原站為主** |
| 遊戲卡片 | 126×168px + 邊框裝飾圖 | 100×133px 純圖 | **以原站為主** |
| 底部 Tab | 5 tab（首頁/娛樂城/登錄/注冊/我的）| 4 tab | **以原站為主** |
| Tab Bar | 背景圖 89px | 純色 75px | **以原站為主** |
| 桌面版 | max-width 450px 居中，body #e8e8e8 | 375:812 手機框 | 以原站為主 |
| 中獎輪播 | 有（棕色背景圖） | 無 | **需新建** Widget |
| Cookie Banner | 有 | 無 | **需新建** Widget |
| 側邊欄 | 有（左側滑入） | 無 | **需新建** Widget |
