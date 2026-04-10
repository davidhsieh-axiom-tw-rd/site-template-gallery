# Flutter Widget Conversion Guide -- Joy Green V1

> Mapping from HTML template to Flutter Widget implementation

## Widget Mapping Table

| # | HTML Block | Flutter Widget | Notes |
|---|-----------|---------------|-------|
| 1 | `.page` | `Scaffold` + `ScreenWindow` | max-width 450px -> 375dp |
| 2 | `.header` | `SliverAppBar` | Hamburger + Logo + Brand text + Register/Login |
| 3 | `.jackpot-section` | Custom `JackpotWidget` | Background image + counter |
| 4 | `.marquee-bar` | Custom `MarqueeWidget` | Horizontal scrolling text |
| 5 | `.search-bar` | `TextField` with decoration | Rounded search input |
| 6 | `.winner-section` | Custom `WinnerTickerWidget` | Horizontal card ticker |
| 7 | `.category-tabs` | `ListView(scrollDirection: Axis.horizontal)` | 13 circular icon tabs |
| 8 | `.platform-section` | Custom `GamePlatformSection` | Platform title + Grid |
| 9 | `.game-grid-3col` | `GridView.count(crossAxisCount: 3)` | Hot games 3-col |
| 10 | `.game-grid-2col` | `GridView.count(crossAxisCount: 2)` | Platform games 2-col |
| 11 | `.hot-games-container` | Custom `HotGamesScrollWidget` | Two-row auto-scroll |
| 12 | `.promo-banners` | `ListView(scrollDirection: Axis.horizontal)` | Promo banners |
| 13 | `.footer` | Custom `FooterWidget` | 3-column Grid + contact |
| 14 | `.tab-bar` | `BottomNavigationBar` | 5 tabs (more/home/login/register/profile) |
| 15 | `.more-drawer` | `Drawer` | Left drawer with expandable sections |

## Key Conversion Details

### 1. Category Tab (Green Circular)

```dart
SizedBox(
  height: 72,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (_, i) => GestureDetector(
      onTap: () => selectCategory(i),
      child: SizedBox(
        width: 72,
        height: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: Color(0xFF0AB76B),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Image.asset(categories[i].icon, width: 30, height: 30,
                  color: Colors.white, colorBlendMode: BlendMode.srcIn),
              ),
            ),
            SizedBox(height: 4),
            Text(categories[i].name,
              style: TextStyle(
                fontSize: 11,
                color: selectedIndex == i ? Color(0xFF0AB76B) : Colors.white,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
)
```

### 2. Header (Green theme)

```dart
AppBar(
  backgroundColor: Color(0xFF212430),
  leading: IconButton(icon: Icon(Icons.menu), onPressed: openDrawer),
  title: Row(children: [
    Image.asset('logo.avif', height: 28),
    SizedBox(width: 8),
    Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('GAMING', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, letterSpacing: 2)),
      Text('www.188.com', style: TextStyle(fontSize: 10, color: Color(0xFFABAFBB))),
    ]),
  ]),
  actions: [
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF0AB76B),
        shape: StadiumBorder(),
      ),
      onPressed: () {},
      child: Text('注册'),
    ),
    OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Color(0xFF0AB76B), width: 1.5),
        shape: StadiumBorder(),
      ),
      onPressed: () {},
      child: Text('登录', style: TextStyle(color: Color(0xFF0AB76B))),
    ),
  ],
)
```

### 3. Left Drawer (Green)

```dart
Drawer(
  width: 283,
  backgroundColor: Color(0xFF292D3B),
  child: ListView(
    padding: EdgeInsets.zero,
    children: [
      // Green gradient header
      Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF0AB76B), Color(0xFF076b3e), Color(0xFF212430)],
          ),
        ),
        padding: EdgeInsets.fromLTRB(20, 40, 20, 20),
        child: // avatar + login text + arrow
      ),
      // Share banner
      Container(
        margin: EdgeInsets.all(12),
        height: 50,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [Color(0xFF0AB76B), Color(0xFF07a05d)]),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(child: Text('分享赚钱')),
      ),
      // Promo row
      Row(children: [
        Expanded(child: // blue card "优惠中心"),
        Expanded(child: // red card "立即分享"),
      ]),
      // Expandable sections
      ExpansionTile(title: Text('娱乐城'), children: [...]),
      ExpansionTile(title: Text('支持中心'), children: [...]),
      ListTile(leading: Image.asset('menu_lang.avif'), title: Text('简体中文')),
    ],
  ),
)
```

## Color Token Mapping

```dart
class GreenV1Colors {
  static const primary = Color(0xFF0AB76B);
  static const accentPink = Color(0xFFF84673);
  static const accentGold = Color(0xFFFFAA09);
  static const accentBlue = Color(0xFF1672F2);
  static const bg1 = Color(0xFF292D3B);
  static const bg2 = Color(0xFF212430);
  static const bg3 = Color(0xFF353A4A);
  static const neutral1 = Color(0xFFABAFBB);
  static const neutral3 = Color(0xFF666A78);
  static const disabled = Color(0xFF999999);
  static const cardBg = Color(0xD9212430); // 85% opacity
}
```
