# HTML → Flutter 轉換指南 — Joy Dark V1

> 基於 vone-site-client-flutter-ui 的研究分析 + 原站暗色主題實際渲染
> 日期：2026-04-08
> 原站：https://joy.star-link-rel.cc/（theme=6-1-1）

## 設計原則

1. **原站為主** — 所有色彩、尺寸、佈局以原站暗色主題實際效果為準
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
| 主題 | 暗色（深海軍藍底） | 淺色藍白 | **以原站為主** — 新建 dark theme |
| 熱門遊戲 | 水平滑動 2 排 × 5 列 | 垂直 GridView | **以原站為主** — 改為水平滑動 |
| 遊戲分類 | 9 個獨立區塊 | 水平 TabBar 切換 | **以原站為主** — 獨立區塊 |
| 底部 Tab | 5 tab（更多/首頁/體育/優惠/我的） | 4 tab | **以原站為主** |
| Tab Bar 高度 | 75px | 64dp | 以原站為主 |
| 中獎輪播 | 森林綠背景 + 獎勵卡片 | 無 | **需新建** |
| 雙卡片 | 體育/娛樂城並排 186px | 無 | **需新建** |

## 色彩對應表

> 完整對照見 `flutter-token-mapping.md`

| 用途 | 原站值（採用） | Flutter Token 名稱 |
|------|-------------|-------------------|
| 頁面背景 | `#0C1822` | `brandPrimary10` |
| Header 背景 | `#10212F` | `brandPrimary20` |
| 卡片背景 | `#162A3A` | `colorNeutral20` |
| 登入按鈕 | `#1EFFD7` | `brandAccent50` |
| 註冊按鈕 | `#F5D639` | `statusWarning` |
| 主文字 | `#FFFFFF` | `colorNeutral10` |
| 次要文字 | `#8899AA` | `colorNeutral40` |

## Widget 對應表

| HTML 元素/class | 功能 | Flutter Widget 建議 | 是否需新建 |
|----------------|------|-------------------|-----------|
| `.header` | 頂部導航 | `HomeAppBar` | 改造（暗色） |
| `.marquee-bar` | 公告跑馬燈 | `HomeAnnouncement` + `AppMarquee` | 沿用 |
| `.hot-games` | 熱門遊戲水平列表 | `HotGameHorizontalList` | **新建** |
| `.winner-section` | 中獎輪播 | `WinnerTickerWidget` | **新建** |
| `.dual-cards` | 體育/娛樂城並排 | `DualPromotionCard` | **新建** |
| `.category-section` | 遊戲分類區塊 | `GameCategoryBlock` | **新建** |
| `.footer` | 頁尾導航+版權 | `AppFooter` | **新建** |
| `.tab-bar` | 底部 Tab | `AppBottomBar` | 改造（5 tab + 暗色） |

## 需新建的 Flutter 元件清單

### P0 — 核心功能
1. **DarkThemeColor** — 暗色主題色彩定義（#0C1822 系列）
2. **HotGameHorizontalList** — 水平滑動遊戲列表（2 排 × 5 列）
3. **WinnerTickerWidget** — 中獎輪播（森林綠背景 + 獎勵卡片）
4. **DualPromotionCard** — 體育/娛樂城雙卡片（186px 高）

### P1 — 完整體驗
5. **GameCategoryBlock** — 獨立遊戲分類區塊（非 TabBar 切換）
6. **AppFooter** — 頁尾區域（三欄 + 牌照 + 聯繫）

### P2 — 可選
7. **SpinButton** — Header Spin 按鈕（54×54 圓形動畫）

## 動畫參數速查

| 動畫 | 參數 | Flutter 建議 |
|------|------|-------------|
| 跑馬燈 | 20s linear | `AnimationController` velocity ~30px/s |
| 中獎輪播 | 25s linear | 同跑馬燈模式 |
| 遊戲卡片 hover | scale(1.05) 0.2s | `AnimatedScale(duration: Duration(milliseconds: 200))` |

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
