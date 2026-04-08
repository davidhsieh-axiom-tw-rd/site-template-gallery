# HTML → Flutter 轉換指南 — Joy Warm V1

> 基於 vone-site-client-flutter-ui 的研究分析 + 原站暖色主題實際渲染
> 日期：2026-04-08
> 原站：https://joy.star-link-rel.cc/（theme=11-1-2）

## 設計原則

1. **原站為主** — 所有色彩、尺寸、佈局以原站暖色主題實際效果為準
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
| 主題 | 暖色（棕色底 + 山脈森林背景圖） | 淺色藍白 | **以原站為主** — 新建 warm theme |
| Header | 背景圖 + 漢堡選單 | 純色背景 | **以原站為主** — 改造 AppBar |
| 遊戲分類 | 水平標籤 + 3 列 grid | 水平 TabBar 切換 | **以原站為主** — 類似但需改尺寸 |
| 遊戲卡片 | 126×168px + 邊框裝飾 | 100×133px | **以原站為主** — 加邊框圖層 |
| 底部 Tab | 5 tab + 背景圖 89px | 4 tab 純色 75px | **以原站為主** |
| 中獎輪播 | 棕色背景圖 + 卡片 | 無 | **需新建** |
| Cookie Banner | 有 | 無 | **需新建** |
| 側邊欄 | 左側滑入 288px | 無 | **需新建** |

## 色彩對應表

> 完整對照見 `flutter-token-mapping.md`

| 用途 | 原站值（採用） | Flutter Token 名稱 |
|------|-------------|-------------------|
| 頁面背景 | `#783D21` | `skin__bg_1` |
| 卡片背景 | `#8F4B2B` | `skin__bg_2` |
| 主色 | `#FF6F00` | `skin__primary` |
| 綠色強調 | `#54BE20` | `skin__accent_1` |
| 紅色強調 | `#EE401E` | `skin__accent_2` |
| 金色強調 | `#FFBB00` | `skin__accent_3` |
| 主文字 | `#FFFFFF` | `skin__text_primary` |
| 次要文字 | `#F5C5A8` | `skin__neutral_1` |
| 弱化文字 | `#DB9A74` | `skin__neutral_2` |
| 邊框 | `#9C5432` | `skin__border` |

## Widget 對應表

| HTML 元素/class | 功能 | Flutter Widget 建議 | 是否需新建 |
|----------------|------|-------------------|-----------|
| `.header` | 頂部導航（背景圖） | `HomeAppBar` | 改造（加背景圖 + 漢堡選單） |
| `.marquee-bar` | 公告跑馬燈 | `HomeAnnouncement` + `AppMarquee` | 沿用 |
| `.winner-section` | 中獎輪播 | `WinnerTickerWidget` | **新建** |
| `.category-tabs` | 遊戲分類標籤 | `GameCategoryTabs` | **新建** |
| `.game-grid` | 遊戲卡片 3 列 grid | `GameGridView` | **新建** |
| `.game-card` | 單一遊戲卡片 | `GameCard` | 改造（加邊框裝飾） |
| `.more-drawer` | 側邊欄選單 | `AppDrawer` | **新建** |
| `.tab-bar` | 底部 Tab Bar | `AppBottomBar` | 改造（5 tab + 背景圖） |
| `.cookie-banner` | Cookie 同意橫幅 | `CookieBanner` | **新建** |
| `.cs-float` | 客服浮動按鈕 | `CustomerServiceFloat` | 沿用 |

## 需新建的 Flutter 元件清單

### P0 — 核心功能
1. **WarmThemeColor** — 暖色主題色彩定義（#783D21 系列）
2. **WinnerTickerWidget** — 中獎輪播（棕色背景圖 + 卡片水平滾動）
3. **GameCategoryTabs** — 遊戲分類水平標籤（11 個標籤 + 背景圖切換）
4. **GameGridView** — 3 列遊戲 grid（126×168px 卡片 + 邊框裝飾）

### P1 — 完整體驗
5. **AppDrawer** — 側邊欄選單（左側滑入 288px，5 個功能項目）
6. **CookieBanner** — Cookie 同意橫幅

### P2 — 可選
7. **BackgroundImagePage** — 全頁背景圖容器（img_db_dt_bg.avif）

## 動畫參數速查

| 動畫 | 參數 | Flutter 建議 |
|------|------|-------------|
| 跑馬燈 | 20s linear | `AnimationController` velocity ~30px/s |
| 中獎輪播 | 25s linear | 同跑馬燈模式 |
| 側邊欄開關 | display toggle | `SlideTransition(duration: Duration(milliseconds: 300))` |
| 客服按鈕 hover | scale(1.08) 0.2s | `AnimatedScale(duration: Duration(milliseconds: 200))` |

## 首頁 Flutter 參考檔案

| 組件 | Flutter 路徑 |
|------|-------------|
| 首頁 | `lib/presentation/feature/home/page/home_page.dart` |
| AppBar | `lib/presentation/feature/home/widgets/home_app_bar.dart` |
| 跑馬燈 | `lib/presentation/feature/home/widgets/app_marquee.dart` |
| 遊戲卡片 | `lib/presentation/feature/commons/game/game_card.dart` |
| 底部 Tab | `lib/presentation/commons/app_bottom_bar.dart` |
| 主題色 | `lib/presentation/theme/light_blue_theme_color.dart` |
| 尺寸 | `lib/presentation/theme/app_dimen.dart` |
| 字體 | `lib/presentation/theme/app_typography.dart` |

## 暖色主題特殊注意事項

1. **大量使用背景圖**：Header、Tab Bar、按鈕、分類標籤、遊戲邊框均使用 AVIF 背景圖而非純色 / 漸層，Flutter 需用 `DecorationImage`
2. **遊戲卡片邊框裝飾**：`img_yxbk.avif` 疊加在遊戲圖片上方，Flutter 需用 `Stack` + `Positioned.fill`
3. **Tab Bar 背景圖**：`img_db_dt_btm.avif` 取代純色，需注意 safe area inset 計算
4. **分類標籤多種背景**：active / inactive 有不同背景圖（`btn_dt_zbcd1/2/3.avif`）
