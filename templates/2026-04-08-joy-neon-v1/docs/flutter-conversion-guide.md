# Flutter Widget 轉換指南 — Joy Neon V1

> 將 HTML 版型轉換為 Flutter Widget 的對應表

## Widget 對應總表

| # | HTML 區塊 | Flutter Widget | 備註 |
|---|-----------|---------------|------|
| 1 | `.page` | `Scaffold` + `ScreenWindow` | max-width 450px → 375dp |
| 2 | `.header` | `SliverAppBar(floating: true, snap: true)` | 透明背景 |
| 3 | `.marquee-bar` | 自訂 `MarqueeWidget` | 水平滾動文字 |
| 4 | `.winner-section` | 自訂 `WinnerTickerWidget` | 水平輪播卡片 |
| 5 | `.nav-section` | `Row` + `ElevatedButton` / `OutlinedButton` | 登入/註冊 + 導航 icon |
| 6 | `.jackpot-section` | 自訂 `JackpotWidget` | 背景圖 + 翻牌數字 |
| 7 | `.game-grid` | `GridView.count(crossAxisCount: 2)` | 2 列遊戲分類 |
| 8 | `.game-card` | 自訂 `GameCategoryCard` | 圓角卡片 + 內容 |
| 9 | `.game-card.tall` | `GameCategoryCard` 跨 2 行 | 用 `StaggeredGridView` 或手動佈局 |
| 10 | `.footer` | 自訂 `FooterWidget` | 三欄 Grid + 聯繫方式 |
| 11 | `.tab-bar` | `BottomNavigationBar` | 5 tab + 突出存款 |
| 12 | `.more-overlay` | `showModalBottomSheet` | 5 列 Grid |
| 13 | `.cs-float` | `FloatingActionButton` | 客服浮動按鈕 |

## 關鍵轉換細節

### 1. 背景圖處理

```dart
// HTML: background-image on .page
// Flutter:
Container(
  decoration: BoxDecoration(
    color: Color(0xFF061325),
    image: DecorationImage(
      image: AssetImage('assets/bg/img_db_dt_bg.avif'),
      fit: BoxFit.fitWidth,
      alignment: Alignment.topCenter,
    ),
  ),
)
```

### 2. 遊戲 Grid（不等高）

```dart
// 热门卡片佔 2 行高度，其他佔 1 行
// 建議用 Column + Row 手動排列，或 flutter_staggered_grid_view
Column(
  children: [
    Row(children: [hotCard(tall: true), Column(children: [fishCard, slotCard])]),
    Row(children: [chessCard, liveCard]),
    Row(children: [sportsCard, moreCard]),
  ],
)
```

### 3. Tab Bar 存款突出按鈕

```dart
// 中間 tab 用 Container 加 Transform.translate 上移
BottomNavigationBar(
  items: [
    // ... 一般 tab
    BottomNavigationBarItem(
      icon: Transform.translate(
        offset: Offset(0, -14),
        child: Image.asset('assets/ui/apng_icon_btm_cz.webp', width: 52),
      ),
      label: '存款',
    ),
    // ... 一般 tab
  ],
)
```

### 4. 更多選單（Bottom Sheet）

```dart
showModalBottomSheet(
  context: context,
  backgroundColor: Color(0xFF061325),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  ),
  builder: (_) => GridView.count(
    crossAxisCount: 5,
    children: moreItems.map((item) => MoreGridItem(item)).toList(),
  ),
);
```

### 5. Jackpot 數字動畫

```dart
// 使用 Timer.periodic 更新數值
// 配合 AnimatedSwitcher 或自訂翻牌效果
Timer.periodic(Duration(seconds: 3), (_) {
  setState(() {
    jackpotValue += Random().nextInt(50) + 1;
  });
});
```

### 6. 中獎輪播

```dart
// 水平 ListView + Timer 自動滾動
// 或用 carousel_slider package
ListView.builder(
  scrollDirection: Axis.horizontal,
  controller: _scrollController,
  itemBuilder: (_, i) => WinnerCard(winners[i % winners.length]),
)
```

## 色彩 Token 對應

```dart
class NeonV1Colors {
  static const primary = Color(0xFF0A69FF);
  static const accent1 = Color(0xFF09CF31);
  static const accent2 = Color(0xFFF8544B);
  static const accent3 = Color(0xFFFFAA09);
  static const bg1 = Color(0xFF061325);
  static const bg2 = Color(0xFF1E2A39);
  static const neutral1 = Color(0xFFADC5DF);
  static const neutral2 = Color(0xFF677B96);
  static const neutral3 = Color(0xFF73819A);
  static const cardBg = Color(0xBF1E2A39); // 75% opacity
}
```
