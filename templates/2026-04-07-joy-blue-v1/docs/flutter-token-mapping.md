# Flutter Token 對照表 — Joy Blue V1

> 原站色彩為主（Flutter 應模仿原站），此表為轉換時的對照字典
> 原站：https://joy.star-link-rel.cc/
> 日期：2026-04-07

## 設計原則

- **原站為準**：所有色彩、尺寸以原站實際渲染值為主
- **Flutter 參考**：Flutter 現有的 Token 名稱作為變數命名參考，但值採原站的
- **雙主題**：原站僅有淺色主題（Joy Blue），暗色主題為未來擴展

---

## 一、色彩 Token 對照

### 主色系

| CSS 變數 | 原站值 | Flutter Token | Flutter 現有值 | 說明 |
|----------|--------|---------------|---------------|------|
| `--skin-primary` | `#003BD5` | `brandPrimary50` | `#1563CA` | **用原站值** |
| `--skin-accent` | `#EA4E3D` | `statusRed` | `#D00218` | 強調/錯誤色 |
| `--background` | `#F8F8F8` | `brandPrimary10` | `#EBF1FF` | 頁面背景 |
| `--card-bg` | `#FFFFFF` | `colorNeutral10` | `#FFFFFF` | 卡片背景 |
| `--skin-neutral-1` | `#666666` | `colorNeutral40` | — | 次要文字 |
| `--skin-neutral-3` | `#CCCCCC` | `colorNeutral20` | — | 分隔線/邊框 |

### 功能色

| 用途 | 原站值 | Flutter Token | 說明 |
|------|--------|---------------|------|
| 登入按鈕背景 | `#003BD5` | `brandPrimary50` | 純色，非漸層 |
| 註冊按鈕背景 | `#EA4E3D` | `statusRed` | 純色 |
| Jackpot 數字框背景 | `linear-gradient(180deg, #2ecc71 0%, #1a9f56 100%)` | — | 原站獨有，需新建 |
| Jackpot 數字框邊框 | `#e74c3c` | — | 3px solid |
| 中獎輪播背景 | `linear-gradient(180deg, #e8f4fd 0%, #d4eaf7 100%)` | — | 淡藍漸層 |
| 分類選中指示條 | `#003BD5` | `brandPrimary50` | 3px 寬，左側 |
| 分類選中背景 | `rgba(0, 59, 213, 0.08)` | `brandPrimary50.withOpacity(0.08)` | 半透明 |
| Tab Bar 背景 | `#FFFFFF` | `colorNeutral10` | 帶頂部陰影 |
| 客服按鈕背景 | `#003BD5` | `brandPrimary50` | 圓形 50px |
| 客服按鈕陰影 | `rgba(0, 59, 213, 0.35)` | — | 4px blur 16px |

### 漸層定義

| 名稱 | CSS 值 | Flutter 對應 |
|------|--------|-------------|
| Jackpot 數字框 | `linear-gradient(180deg, #2ecc71, #1a9f56)` | `LinearGradient(begin: top, end: bottom, colors: [0x2ecc71, 0x1a9f56])` |
| 中獎輪播背景 | `linear-gradient(180deg, #e8f4fd, #d4eaf7)` | `LinearGradient(begin: top, end: bottom, colors: [0xe8f4fd, 0xd4eaf7])` |
| 遊戲卡片佔位 | `linear-gradient(135deg, #e8e8e8, #d0d0d0)` | `LinearGradient(begin: topLeft, end: bottomRight, colors: [0xe8e8e8, 0xd0d0d0])` |
| Banner Indicator（選中） | 固定金色 `#F6D9B3 → #C8A178 → #CDAA85` | 不跟主題，硬編碼 |
| Banner Indicator（未選） | 固定 `#7C6D5A → #66533E → #664B2E` | 不跟主題，硬編碼 |

---

## 二、尺寸 Token 對照

### 設計基準

| 項目 | HTML 版 | Flutter 版 | 說明 |
|------|---------|-----------|------|
| 設計基準寬度 | 450px（容器 max-width） | 375px | Flutter 用 sizeScaler 縮放 |
| 桌面版行為 | max-width 450px 居中 | ScreenWindow 強制 375:812 比例 | 佈局差異 |

### 元件尺寸（Figma 原始 px 值）

| 元件 | HTML 值 | Flutter AppDimen | Figma 原始值 | 備註 |
|------|---------|-----------------|-------------|------|
| Header 高度 | 54px | `size_44` | 44px | HTML 偏大 |
| Banner 高度 | 自適應 | `size_150` | 150px | |
| 跑馬燈高度 | 36px | — | ~36px | Flutter 自適應 |
| 中獎輪播高度 | 84px | — | — | Flutter 無此元件 |
| 分類 Tab 高度 | — | `size_36` | 36px | HTML 是側邊欄 |
| 底部 Tab 高度 | 56px | `size_64` | 64px | HTML 偏小 |
| 遊戲卡片寬高比 | 1:1 | — | 111:148 | **關鍵差異** |
| 遊戲格 Grid | 3 欄 10px gap | 3 欄 8px gap | | |
| 客服按鈕 | 50×50px 圓形 | — | — | Flutter 無此元件 |
| Category Sidebar | 80px 寬 | — | — | Flutter 是水平 Tab |

### 間距系統

| 間距用途 | HTML 值 | Flutter 參考 |
|---------|---------|-------------|
| 頁面左右 padding | 12px | `AppDimen.size_16`（16px） |
| 卡片內 padding | 12px | — |
| 遊戲格 gap | 10px | `AppDimen.size_8`（8px） |
| 區塊間距 | 8-16px | `AppDimen.size_8` ~ `size_16` |
| 按鈕 padding（登入/註冊） | 8px 16px | — |

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

| 元素 | font-size | font-weight | letter-spacing | line-height | Flutter TextStyle |
|------|-----------|-------------|----------------|-------------|-------------------|
| Header 品牌名 | 18px | 700 | 1px | — | `textStyle18s` |
| Header URL | 11px | 400 | 0 | — | `textStyle11n` |
| Jackpot 數字 | 22.4px (1.4rem) | 900 | 1px | — | — (custom) |
| 登入按鈕 | 13px | 500 | 3px | — | `textStyle14m` ~= |
| 註冊按鈕 | 13px | 500 | 3px | — | `textStyle14m` ~= |
| 公告跑馬燈 | 繼承 | 400 | 0 | — | `textStyle11n` |
| 中獎玩家名 | 13px | 500 | 0 | — | `textStyle14m` ~= |
| 分類名稱 | 12px | 400 | 2px | — | `textStyle12n` |
| 遊戲卡片名 | 12px | 400 | 0 | 1.3 | `textStyle12n` |
| 分類標題 | 15px | 600 | 0 | — | `textStyle14s` |
| Footer 標題 | 14px | 600 | 0 | — | `textStyle14s` |
| Tab Bar 文字 | 10px | 500 | 0 | — | `textStyle10m` |

---

## 四、陰影對照

| 元素 | HTML box-shadow | Flutter BoxShadow 建議 |
|------|----------------|----------------------|
| 主容器 | `0 0 20px rgba(0,0,0,0.1)` | `BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(0.1))` |
| Jackpot 數字框 | `0 2px 8px rgba(0,0,0,0.2)` | `BoxShadow(offset: Offset(0,2), blurRadius: 8, color: Colors.black.withOpacity(0.2))` |
| 中獎卡片 | `0 1px 3px rgba(0,0,0,0.06)` | `BoxShadow(offset: Offset(0,1), blurRadius: 3, color: Colors.black.withOpacity(0.06))` |
| 分類項目 | `0 1px 3px rgba(0,0,0,0.06)` | 同上 |
| Tab Bar | `0 -1px 6px rgba(0,0,0,0.08)` | `BoxShadow(offset: Offset(0,-1), blurRadius: 6, color: Colors.black.withOpacity(0.08))` |
| 客服按鈕 | `0 4px 16px rgba(0,59,213,0.35)` | `BoxShadow(offset: Offset(0,4), blurRadius: 16, color: Color(0x003BD5).withOpacity(0.35))` |

---

## 五、動畫參數對照

| 動畫 | HTML 參數 | Flutter 建議 |
|------|----------|-------------|
| Banner 輪播 | 自動 3s（JavaScript） | `carousel_slider: autoPlayInterval: 3s` |
| 跑馬燈 | `animation: 20s linear infinite` | `AnimationController + velocity: 30px/s` |
| 中獎輪播 | `animation: 30s linear infinite` | `AnimationController + linear` |
| Jackpot 數字 | `setInterval 100ms` | `AnimatedSwitcher(duration: 100ms)` |
| 分類切換 | `transition: 0.15s` | `Duration(milliseconds: 300), Curves.easeInOut` |
| Tab 切換 | `transition: 0.2s` | `Duration(milliseconds: 300), Curves.easeInOut` |
| 客服按鈕 hover | `transform: scale(1.08), 0.2s` | `AnimatedScale(duration: 200ms)` |
| Cookie banner | `transition: transform 0.3s` | `AnimatedSlide(duration: 300ms)` |

---

## 六、z-index → Stack 層疊對照

| z-index | HTML 元素 | Flutter Widget | Stack 順序（底→頂）|
|---------|----------|---------------|-------------------|
| 0 | `body::before`（底紋） | `Positioned.fill` + `Opacity(0.06)` | 1 |
| 1 | `.page`（主內容） | `Scaffold.body` | 2 |
| 2 | `.jackpot-content` | 內嵌在 `SliverToBoxAdapter` | 3 |
| 100 | `.header`（sticky） | `AppBar`（自動置頂） | 系統管理 |
| 150 | `.cs-float`（客服） | `Positioned(bottom, right)` in Stack | 4 |
| 190 | `.cookie-banner` | `Positioned(bottom)` in Stack | 5 |
| 200 | `.tab-bar`（底部） | `Scaffold.bottomNavigationBar` | 系統管理 |
| 999 | `.more-menu-overlay` | `showModalBottomSheet` | 系統管理 |

---

## 七、Widget 對應表（HTML class → Flutter Widget）

| HTML 元素/class | Flutter Widget | Flutter 檔案 |
|----------------|---------------|-------------|
| `.header` | `HomeAppBar` | `home_app_bar.dart` |
| `.banner-area` + `.banner-indicators` | `AppBanner` (carousel_slider) | `app_banner.dart` |
| `.marquee-bar` | `HomeAnnouncement` + `AppMarquee` | `home_announcement.dart` |
| `.winner-section` | — | 原站獨有，Flutter 需新建 |
| `.jackpot-section` | — | 原站獨有，Flutter 需新建 |
| `.account-info` / `.guest-login` | `AccountInfoWidget` / `GuestAccountInfo` | `account_info_widget.dart` |
| `.category-sidebar` | `HomeCategoryBar`（改頂部水平） | `home_category_bar.dart` |
| `.game-grid` | `GameCategorySection` + `GameCard` | `game_category_section.dart` |
| `.platform-card` | — | 原站獨有（全寬橫幅） |
| `.tab-bar` | `AppBottomBar` | `app_bottom_bar.dart` |
| `.cs-float` | `BackToTopButton`（改客服按鈕） | 需新建 |
| `.more-menu-overlay` | `showModalBottomSheet` | 需新建 |
| `.cookie-banner` | — | 視需求 |

---

## 八、佈局差異與轉換決策

| 面向 | HTML 版（原站復刻） | Flutter 現有 | 轉換建議 |
|------|-------------------|-------------|---------|
| 遊戲分類 | 左側 80px sticky sidebar | 頂部水平 pinned TabBar | **以原站為主**，改回側邊欄 |
| 遊戲卡片 | 1:1 正方形 | 111:148 直式 | **以原站為主**，用 1:1 |
| 底部 Tab | 5 tab（首頁/活動/客服/登入/註冊） | 4 tab（首頁/優惠/推廣/我的） | **以原站為主** |
| 桌面版 | max-width 450px 居中 | 375:812 手機框 | **以原站為主** |
| Jackpot | 有 | 無 | 需新建 Widget |
| 中獎輪播 | 有 | 無 | 需新建 Widget |
| 底紋圖片 | CSS `background-repeat` + opacity 0.06 | — | `Stack` + `Opacity` + `Image.repeat` |
