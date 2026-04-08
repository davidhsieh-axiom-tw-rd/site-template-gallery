# Flutter Token 對照表 — Joy Dark V1

> 暗色主題版型（深海軍藍 + 青色/金黃按鈕）
> 原站：https://joy.star-link-rel.cc/（暗色主題 theme=6-1-1）
> 日期：2026-04-08

## 設計原則

- **原站為準**：所有色彩、尺寸以原站暗色主題實際渲染值為主
- **Flutter 參考**：Flutter 現有的 Token 名稱作為變數命名參考，但值採原站的
- **暗色主題**：此版型為暗色（Dark），與 Joy Blue V1（淺色）互為對照

---

## 一、色彩 Token 對照

### 主色系

| CSS 變數 | 原站值 | Flutter Token | 說明 |
|----------|--------|---------------|------|
| `--body-bg` | `#0C1822` | `brandPrimary10` | 頁面背景（深海軍藍） |
| `--header-bg` | `#10212F` | `brandPrimary20` | Header / Tab Bar 背景 |
| `--card-bg` | `#162A3A` | `colorNeutral20` | 卡片背景（稍淡藍） |
| `--section-bg` | `#0F1E2B` | `brandPrimary15` | 區塊背景 |
| `--text-primary` | `#FFFFFF` | `colorNeutral10` | 主文字（白色） |
| `--text-secondary` | `#8899AA` | `colorNeutral40` | 次要文字 |

### 功能色

| 用途 | 原站值 | Flutter Token | 說明 |
|------|--------|---------------|------|
| 登入按鈕背景 | `#1EFFD7` | `brandAccent50` | 青色，暗色主題主按鈕 |
| 註冊按鈕背景 | `#F5D639` | `statusWarning` | 金黃色 |
| 按鈕文字 | `#0E161D` | `colorNeutral90` | 深色文字（在亮色按鈕上） |
| Tab 選中 | `#1EFFD7` | `brandAccent50` | 與登入按鈕同色 |
| 分類選中指示條 | `#1EFFD7` | `brandAccent50` | 底部 2px 線 |
| 遊戲分類標題 | `#1EFFD7` | `brandAccent50` | 分類名稱高亮 |
| 中獎輪播背景 | `linear-gradient(180deg, #0D2A1F 0%, #0A1F18 100%)` | — | 暗色森林綠 |
| 體育卡片背景 | `linear-gradient(135deg, #1A3A2E, #0D2520)` | — | 暗綠漸層 |
| 娛樂城卡片背景 | `linear-gradient(135deg, #3A1A2E, #250D20)` | — | 暗紫漸層 |

### 漸層定義

| 名稱 | CSS 值 | Flutter 對應 |
|------|--------|-------------|
| 中獎輪播背景 | `linear-gradient(180deg, #0D2A1F, #0A1F18)` | `LinearGradient(begin: top, end: bottom, colors: [0x0D2A1F, 0x0A1F18])` |
| 體育卡片 | `linear-gradient(135deg, #1A3A2E, #0D2520)` | `LinearGradient(begin: topLeft, end: bottomRight, colors: [0x1A3A2E, 0x0D2520])` |
| 娛樂城卡片 | `linear-gradient(135deg, #3A1A2E, #250D20)` | `LinearGradient(begin: topLeft, end: bottomRight, colors: [0x3A1A2E, 0x250D20])` |
| 遊戲卡片佔位 | `linear-gradient(135deg, #1A2A38, #142230)` | `LinearGradient(begin: topLeft, end: bottomRight, colors: [0x1A2A38, 0x142230])` |

---

## 二、尺寸 Token 對照

### 設計基準

| 項目 | HTML 版 | Flutter 版 | 說明 |
|------|---------|-----------|------|
| 設計基準寬度 | 450px（容器 max-width） | 375px | Flutter 用 sizeScaler 縮放 |
| 桌面版行為 | max-width 450px 居中 | ScreenWindow 強制 375:812 比例 | 佈局差異 |

### 元件尺寸

| 元件 | HTML 值 | Flutter AppDimen | 備註 |
|------|---------|-----------------|------|
| Header 高度 | 66px | `size_54` | 含 Spin 按鈕 |
| Marquee 高度 | 36px | — | 跑馬燈區塊 |
| 遊戲卡片 | 100×133px | — | 3:4 比例 |
| 中獎輪播高度 | 91px | — | 森林背景 |
| 雙卡片高度 | 186px | — | 體育/娛樂城 |
| 分類遊戲格 Grid | 3 欄 10px gap | 3 欄 8px gap | |
| Tab Bar 高度 | 75px | `size_64` | 底部固定 |

### 間距系統

| 間距用途 | HTML 值 | Flutter 參考 |
|---------|---------|-------------|
| 頁面左右 padding | 12px | `AppDimen.size_16` |
| 卡片內 padding | 12px | — |
| 遊戲格 gap | 10px | `AppDimen.size_8` |
| 區塊間距 | 16px | `AppDimen.size_16` |
| 按鈕 padding | 6px 16px | — |

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
| Header Logo | 139×42px | — | — | — | 圖片，非文字 |
| 登入按鈕 | 13px | 600 | 2px | #0E161D | `textStyle14s` ~= |
| 註冊按鈕 | 13px | 600 | 2px | #0E161D | `textStyle14s` ~= |
| 跑馬燈文字 | 12px | 400 | 0 | #FFFFFF | `textStyle12n` |
| 遊戲卡片名 | 12px | 400 | 0 | #FFFFFF | `textStyle12n` |
| 分類標題 | 14px | 600 | 0 | #1EFFD7 | `textStyle14s` |
| 「更多」連結 | 12px | 400 | 0 | #8899AA | `textStyle12n` |
| 中獎玩家名 | 12px | 500 | 0 | #FFFFFF | `textStyle12m` |
| 中獎金額 | 12px | 600 | 0 | #F5D639 | `textStyle12s` |
| Footer 標題 | 14px | 600 | 0 | #FFFFFF | `textStyle14s` |
| Footer 連結 | 12px | 400 | 0 | #8899AA | `textStyle12n` |
| Tab Bar 文字 | 10px | 500 | 0 | #8899AA | `textStyle10m` |

---

## 四、陰影對照

| 元素 | HTML box-shadow | Flutter BoxShadow 建議 |
|------|----------------|----------------------|
| 主容器 | `0 0 30px rgba(0,0,0,0.5)` | `BoxShadow(blurRadius: 30, color: Colors.black.withOpacity(0.5))` |
| 遊戲卡片 | `0 2px 8px rgba(0,0,0,0.3)` | `BoxShadow(offset: Offset(0,2), blurRadius: 8, color: Colors.black.withOpacity(0.3))` |
| 中獎卡片 | `0 2px 8px rgba(0,0,0,0.3)` | `BoxShadow(offset: Offset(0,2), blurRadius: 8, ...)` |
| Tab Bar | `0 -2px 10px rgba(0,0,0,0.3)` | `BoxShadow(offset: Offset(0,-2), blurRadius: 10, color: Colors.black.withOpacity(0.3))` |
| 體育/娛樂城卡片 | `0 4px 15px rgba(0,0,0,0.3)` | `BoxShadow(offset: Offset(0,4), blurRadius: 15, ...)` |

---

## 五、動畫參數對照

| 動畫 | HTML 參數 | Flutter 建議 |
|------|----------|-------------|
| 跑馬燈 | `animation: 20s linear infinite` | `AnimationController + velocity: 30px/s` |
| 中獎輪播 | `animation: 25s linear infinite` | `AnimationController + linear` |
| 分類切換 | 頁面跳轉，無過渡 | `Duration(milliseconds: 300), Curves.easeInOut` |
| Tab 切換 | 無過渡動畫 | `Duration(milliseconds: 300), Curves.easeInOut` |
| 遊戲卡片 hover | `transform: scale(1.05), 0.2s` | `AnimatedScale(duration: 200ms)` |

---

## 六、z-index → Stack 層疊對照

| z-index | HTML 元素 | Flutter Widget | Stack 順序（底→頂）|
|---------|----------|---------------|-------------------|
| 0 | `body::before`（底紋） | `Positioned.fill` + `Opacity(0.04)` | 1 |
| 1 | `.page`（主內容） | `Scaffold.body` | 2 |
| 100 | `.header`（sticky） | `AppBar`（自動置頂） | 系統管理 |
| 200 | `.tab-bar`（底部） | `Scaffold.bottomNavigationBar` | 系統管理 |

---

## 七、Widget 對應表（HTML class → Flutter Widget）

| HTML 元素/class | Flutter Widget | Flutter 檔案 |
|----------------|---------------|-------------|
| `.header` | `HomeAppBar` | `home_app_bar.dart` |
| `.marquee-bar` | `HomeAnnouncement` + `AppMarquee` | `home_announcement.dart` |
| `.hot-games` | `HotGameSection` + `GameCard` | 水平滑動列表 |
| `.winner-section` | `WinnerTickerWidget` | **需新建** |
| `.dual-cards` | `DualCardSection` | **需新建** |
| `.category-section` | `GameCategorySection` + `GameCard` | `game_category_section.dart` |
| `.footer` | `AppFooter` | **需新建** |
| `.tab-bar` | `AppBottomBar` | `app_bottom_bar.dart` |

---

## 八、佈局差異與轉換決策

| 面向 | HTML 版（暗色復刻） | Flutter 現有 | 轉換建議 |
|------|-------------------|-------------|---------|
| 主題色 | 暗色（#0C1822 深海軍藍底） | 淺色（#F8F8F8 背景） | **以原站暗色為主**，需建立 dark theme |
| 遊戲分類 | 9 個獨立區塊（3 欄 grid） | 頂部水平 TabBar + 列表 | **以原站為主** |
| 熱門遊戲 | 水平滑動 2 排 × 5 列 | 垂直 GridView | **以原站為主** |
| 底部 Tab | 5 tab（更多/首頁/體育/優惠/我的） | 4 tab | **以原站為主** |
| 桌面版 | max-width 450px 居中 | 375:812 手機框 | 以原站為主 |
| 中獎輪播 | 有（森林綠背景） | 無 | **需新建** Widget |
| 體育/娛樂城 | 雙卡片並排（186px） | 無 | **需新建** Widget |
