# HTML → Flutter 轉換指南

> 基於 vone-site-client-flutter-ui 的研究分析
> 日期：2026-04-07

## Flutter 專案位置

`/Users/bobo/Projects/vone-all/vone-site-client-flutter-ui/`

## 關鍵佈局差異

| 區域 | HTML 版 | Flutter 版 |
|------|---------|-----------|
| 遊戲分類 | 左側垂直側邊欄 | 頂部水平吸頂 TabBar |
| 主佈局 | 雙欄（left + right） | 單欄 CustomScrollView + Slivers |
| 底部 Tab | 5 個 tab（含登入/註冊） | 4 個 tab（已登入狀態） |
| Tab Bar 高度 | 56px | 64dp |
| 遊戲卡片比例 | 1:1 正方形 | 111:148（直式長方形） |

## 色彩對應表

| HTML CSS 變數 | 值 | Flutter AppColor | 值 | 差異 |
|--------------|------|-----------------|------|------|
| `--skin__primary` | `#003BD5` | `brandPrimary50` | `#1563CA` | 色差明顯 |
| `--skin__bg_1` | `#F8F8F8` | `brandPrimary10` | `#EBF1FF` | 色差明顯 |
| `--skin__bg_2` | `#FFFFFF` | `colorNeutral10` | `#FFFFFF` | 一致 |
| `--skin__accent_2` | `#EA4E3D` | `statusRed` | `#D00218` | 色差 |
| `--skin__accent_1` | `#04BE02` | `statusGreen` | `#75C913` | 色差 |

## 尺寸系統對應

- **HTML**: `1rem = 100px`（設計稿 750px 基準）
- **Flutter**: `375px` 基準寬度 × `sizeScaler`
- **換算**: HTML `0.01rem` ≈ Flutter `AppDimen.size_1`

## HTML 需額外擷取的資訊

為了精確轉換 Flutter，HTML 復刻中應嵌入以下 metadata：

1. **每個區塊的精確尺寸**（px 值）
   - Header 高度、Jackpot 高度、跑馬燈高度
   - 遊戲卡片寬高、間距
   - 按鈕尺寸、圓角
   - Footer 高度

2. **完整色彩表**
   - 所有 CSS 變數值（已在 structure-analysis.md）
   - 漸層色值（按鈕、背景）
   - 陰影值

3. **字體資訊**
   - font-size、font-weight、line-height
   - letter-spacing

4. **動畫參數**
   - Jackpot 數字翻牌速度
   - 跑馬燈滾動速度（Flutter 用 30dp/s）
   - 輪播自動播放間隔（Flutter 用 3s）

## 轉換策略建議

1. **沿用 Flutter 現有架構** — 不重寫，而是調整主題色和組件參數
2. **新增 JoyBlue ThemeCode** — 在 `light_blue_theme_color.dart` 基礎上建立 Joy 專屬色彩
3. **Jackpot 組件** — Flutter 目前沒有，需新建（可用 Lottie，專案已安裝）
4. **中獎輪播** — Flutter 目前沒有，需新建
5. **佈局選擇** — 建議沿用 Flutter 的 TabBar 模式而非 HTML 的側邊欄

## 首頁關鍵檔案

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
