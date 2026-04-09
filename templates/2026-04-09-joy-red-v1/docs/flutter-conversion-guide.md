# Flutter Widget 轉換指南 — Joy Red V1

> 將 HTML 版型轉換為 Flutter Widget 的對應表

## Widget 對應總表

| # | HTML 區塊 | Flutter Widget | 備註 |
|---|-----------|---------------|------|
| 1 | `.page` | `Scaffold` + `ScreenWindow` | max-width 450px → 375dp |
| 2 | `.header` | `SliverAppBar` | 漢堡選單 + Logo |
| 3 | `.jackpot-section` | 自訂 `JackpotWidget` | 背景圖 + 翻牌數字 |
| 4 | `.marquee-bar` | 自訂 `MarqueeWidget` | 水平滾動文字 |
| 5 | `.auth-section` | `Row` + `ElevatedButton` | 註冊(灰) / 登入(紅) |
| 6 | `.winner-section` | 自訂 `WinnerTickerWidget` | 水平輪播卡片 |
| 7 | `.category-tabs` | `ListView(scrollDirection: Axis.horizontal)` | 13 分類 Tab |
| 8 | `.platform-section` | 自訂 `GamePlatformSection` | 平台標題 + Grid |
| 9 | `.game-grid-3col` | `GridView.count(crossAxisCount: 3)` | 3 列遊戲 Grid |
| 10 | `.promo-banners` | `ListView(scrollDirection: Axis.horizontal)` | 推廣 banner |
| 11 | `.footer` | 自訂 `FooterWidget` | 三欄 Grid + 聯繫方式 |
| 12 | `.tab-bar` | `BottomNavigationBar` | 5 tab |
| 13 | `.more-drawer` | `Drawer` | 左側 Drawer 含子選單 |

## 關鍵轉換細節

### 1. Category Tab 橫排

```dart
SizedBox(
  height: 72,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (_, i) => GestureDetector(
      onTap: () => selectCategory(i),
      child: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          color: selectedIndex == i ? Color(0xFFD03434) : Colors.transparent,
          borderRadius: BorderRadius.circular(8.4),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(categories[i].icon, width: 31, height: 24),
            SizedBox(height: 4),
            Text(categories[i].name, style: TextStyle(fontSize: 11)),
          ],
        ),
      ),
    ),
  ),
)
```

### 2. 遊戲 Grid（3 列）

```dart
GridView.count(
  crossAxisCount: 3,
  crossAxisSpacing: 8,
  mainAxisSpacing: 8,
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  children: games.map((game) => GameCard(game: game)).toList(),
)
```

### 3. Auth Section（註冊灰 + 登入紅）

```dart
Row(
  children: [
    Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF303030),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.4)),
          minimumSize: Size(207, 45.6),
        ),
        onPressed: () {},
        child: Text('注 册', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ),
    ),
    SizedBox(width: 12),
    Expanded(
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFD03434),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.4)),
          minimumSize: Size(207, 45.6),
        ),
        onPressed: () {},
        child: Text('登 录', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
      ),
    ),
  ],
)
```

### 4. Left Drawer

```dart
Scaffold(
  drawer: Drawer(
    width: 283,
    backgroundColor: Color(0xFF161616),
    child: ListView(
      padding: EdgeInsets.only(top: 60),
      children: [
        ExpansionTile(title: Text('娱乐城'), children: [
          ListTile(title: Text('热门')),
          ListTile(title: Text('捕鱼')),
          // ...
        ]),
        ExpansionTile(title: Text('体育'), children: [
          ListTile(title: Text('足球')),
          // ...
        ]),
        ListTile(leading: Icon(Icons.headset_mic), title: Text('客服')),
        // ...
      ],
    ),
  ),
)
```

### 5. Jackpot 數字動畫

```dart
Timer.periodic(Duration(seconds: 3), (_) {
  setState(() {
    jackpotValue += Random().nextInt(50) + 1;
  });
});
```

## 色彩 Token 對應

```dart
class RedV1Colors {
  static const primary = Color(0xFFD03434);
  static const accentGold = Color(0xFFFFAA09);
  static const accentBlue = Color(0xFF1672F2);
  static const bg1 = Color(0xFF161616);
  static const bg2 = Color(0xFF212121);
  static const bg3 = Color(0xFF303030);
  static const disabled = Color(0xFF999999);
  static const cardBg = Color(0xD9212121); // 85% opacity
}
```
