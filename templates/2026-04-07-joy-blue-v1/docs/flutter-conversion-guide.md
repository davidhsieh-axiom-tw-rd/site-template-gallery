# HTML → Flutter 轉換指南 — Joy Blue V1

> 基於 vone-site-client-flutter-ui 的研究分析 + 原站實際渲染
> 日期：2026-04-07
> 原站：https://joy.star-link-rel.cc/

## 設計原則

1. **原站為主** — 所有色彩、尺寸、佈局以原站實際效果為準，Flutter 應模仿原站
2. **HTML 為藍圖** — 此 HTML 復刻版是 Flutter 實作的視覺參考
3. **Token 名稱沿用 Flutter** — 變數命名參考 Flutter 現有 Token，方便對應
4. **值用原站的** — Token 名稱是 Flutter 的，但色碼、尺寸用原站的

## 配套文件

| 文件 | 說明 |
|------|------|
| `flutter-token-mapping.md` | 完整 Token 對照表（色彩、尺寸、字體、陰影、動畫、z-index） |
| `typography.md` | 逐元素文字樣式表 |
| `structure-analysis.md` | DOM 結構 + CSS class 對照 |
| `homepage-features.md` | 功能說明 |
| `assets-inventory.json` | 原始圖片尺寸記錄 |

## Flutter 參考專案

`vone-site-client-flutter-ui`（Clean Architecture，505 個 Dart 檔）

## 關鍵佈局差異

| 區域 | 原站（HTML 復刻版） | Flutter 現有 | 轉換決策 |
|------|-------------------|-------------|---------|
| 遊戲分類 | 左側垂直側邊欄（80px sticky） | 頂部水平吸頂 TabBar | **以原站為主** — 改回側邊欄 |
| 主佈局 | 雙欄（sidebar + content） | 單欄 CustomScrollView + Slivers | 以原站為主 |
| 底部 Tab | 5 tab（首頁/活動/客服/登入/註冊） | 4 tab（首頁/優惠/推廣/我的） | **以原站為主** |
| Tab Bar 高度 | 56px | 64dp | 以原站為主 |
| 遊戲卡片比例 | 1:1 正方形 | 111:148（直式） | **以原站為主** — 用 1:1 |
| 桌面版 | max-width 450px 居中 | ScreenWindow 375:812 手機框 | 以原站為主 |

## 色彩對應表

> 完整對照見 `flutter-token-mapping.md`

| 用途 | 原站值（採用） | Flutter Token 名稱 | Flutter 現有值（參考） |
|------|-------------|-------------------|---------------------|
| 主色 | `#003BD5` | `brandPrimary50` | `#1563CA` |
| 強調色 | `#EA4E3D` | `statusRed` | `#D00218` |
| 頁面背景 | `#F8F8F8` | `brandPrimary10` | `#EBF1FF` |
| 卡片背景 | `#FFFFFF` | `colorNeutral10` | `#FFFFFF` |
| 次要文字 | `#666666` | `colorNeutral40` | — |
| 分隔線 | `#CCCCCC` | `colorNeutral20` | — |

## 尺寸系統

- **原站 HTML**: 容器 max-width 450px，font-size 16px 基準
- **Flutter 參考**: 375px 基準寬度 × `sizeScaler`
- **轉換**: 以原站 px 值直接使用，Flutter 端再決定是否走 sizeScaler

## Widget 對應表

| HTML 元素/class | 功能 | Flutter Widget 建議 | 是否需新建 |
|----------------|------|-------------------|-----------|
| `.header` | 頂部導航 | `HomeAppBar` | 改造 |
| `.banner-area` | Banner 輪播 | `AppBanner` (carousel_slider) | 沿用 |
| `.marquee-bar` | 公告跑馬燈 | `HomeAnnouncement` + `AppMarquee` | 沿用 |
| `.jackpot-section` | Jackpot 獎池 | `JackpotWidget` | **新建** |
| `.winner-section` | 中獎輪播 | `WinnerTickerWidget` | **新建** |
| `.guest-login` | 登入/註冊/試玩 | `GuestAccountInfo` | 改造 |
| `.category-sidebar` | 左側分類列 | `CategorySidebar` | **新建**（原版 TabBar 是水平的） |
| `.game-grid` | 遊戲卡片格 | `GameCard` in `GridView` | 改造（比例 1:1） |
| `.platform-card` | 平台橫幅卡片 | `PlatformBannerCard` | **新建** |
| `.footer` | 頁尾導航+版權 | `AppFooter` | **新建** |
| `.tab-bar` | 底部 Tab | `AppBottomBar` | 改造（5 tab） |
| `.cs-float` | 客服浮動按鈕 | `FloatingServiceButton` | **新建** |
| `.more-menu-overlay` | 更多功能選單 | `showModalBottomSheet` | **新建** |
| `.cookie-banner` | Cookie 提示 | `CookieBanner` | **新建** |
| `body::before` | 底紋圖片 | `Stack` + `Opacity(0.06)` + `Image.repeat` | **新建** |

## 需新建的 Flutter 元件清單

### P0 — 核心功能
1. **JackpotWidget** — 獎池數字動畫（setInterval 模式或 AnimatedSwitcher）
2. **WinnerTickerWidget** — 中獎輪播（水平自動滾動）
3. **CategorySidebar** — 左側垂直分類列（sticky，80px 寬）
4. **PlatformBannerCard** — 全寬橫幅平台卡片（aspect-ratio 2.5:1）

### P1 — 完整體驗
5. **FloatingServiceButton** — 客服浮動按鈕（右下角 50px 圓形）
6. **MoreMenuOverlay** — 更多功能選單（28 個 icon）
7. **AppFooter** — 頁尾區域

### P2 — 可選
8. **CookieBanner** — Cookie 提示橫幅

## 動畫參數速查

| 動畫 | 參數 | Flutter 建議 |
|------|------|-------------|
| Banner 輪播 | 3s 間隔 | `carousel_slider: autoPlayInterval: Duration(seconds: 3)` |
| 跑馬燈 | 20s linear | `AnimationController` velocity ~30px/s |
| 中獎輪播 | 30s linear | 同跑馬燈模式 |
| Jackpot 數字 | 100ms 翻牌 | `AnimatedSwitcher(duration: Duration(milliseconds: 100))` |
| 分類切換 | 0.15s | `Duration(milliseconds: 150)` |
| 客服 hover | scale(1.08) 0.2s | `AnimatedScale(duration: Duration(milliseconds: 200))` |

## 首頁 Flutter 參考檔案

| 組件 | Flutter 路徑 |
|------|-------------|
| 首頁 | `lib/presentation/feature/home/page/home_page.dart` |
| AppBar | `lib/presentation/feature/home/widgets/home_app_bar.dart` |
| 分類 Tab | `lib/presentation/feature/home/widgets/home_category_bar.dart` |
| 遊戲區塊 | `lib/presentation/feature/home/widgets/game_category_section.dart` |
| 跑馬燈 | `lib/presentation/feature/home/widgets/app_marquee.dart` |
| Banner | `lib/presentation/feature/commons/app_banner/widgets/app_banner.dart` |
| 遊戲卡片 | `lib/presentation/feature/commons/game/game_card.dart` |
| 底部 Tab | `lib/presentation/commons/app_bottom_bar.dart` |
| 主題色 | `lib/presentation/theme/light_blue_theme_color.dart` |
| 尺寸 | `lib/presentation/theme/app_dimen.dart` |
| 漸層 | `lib/presentation/theme/app_linear_gradient.dart` |
| 陰影 | `lib/presentation/theme/app_shadow.dart` |
| 字體 | `lib/presentation/theme/app_typography.dart` |
