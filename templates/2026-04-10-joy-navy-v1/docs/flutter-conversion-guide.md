# Flutter Widget Conversion Guide -- Joy Navy V1

> Mapping from HTML template to Flutter Widget implementation

## Widget Mapping Table

| # | HTML Block | Flutter Widget | Notes |
|---|-----------|---------------|-------|
| 1 | `.page` | `Scaffold` + `ScreenWindow` | max-width 450px -> 375dp |
| 2 | `.header` | `SliverAppBar` | Logo left + Login/Register buttons right |
| 3 | `.jackpot-section` | Custom `JackpotWidget` | Background image + counter |
| 4 | `.marquee-bar` | Custom `MarqueeWidget` | Horizontal scrolling text + mail icon |
| 5 | `.winner-section` | Custom `WinnerTickerWidget` | Horizontal card ticker (navy gradient bg) |
| 6 | `.category-tabs` | `ListView(scrollDirection: Axis.horizontal)` | 14 rounded-square icon tabs |
| 7 | `.game-grid-3col` | `GridView.count(crossAxisCount: 3)` | Hot games 3-col grid |
| 8 | `.platform-banner-list` | Custom `PlatformBannerSection` | Full-width vertical banner cards |
| 9 | `.provider-banner-list` | Custom `ProviderBannerSection` | 3 provider banner images |
| 10 | `.footer` | Custom `FooterWidget` | 3-column Grid + compliance + contact |
| 11 | `.tab-bar` | `BottomNavigationBar` | 5 tabs (browse/casino/promo/support/profile) |
| 12 | `.more-overlay` | `showModalBottomSheet` or `OverlayEntry` | Icon grid overlay |

## Key Conversion Details

### 1. Category Tab (Navy Rounded Square)

```dart
SizedBox(
  height: 72,
  child: ListView.builder(
    scrollDirection: Axis.horizontal,
    itemCount: categories.length,
    itemBuilder: (_, i) => GestureDetector(
      onTap: () => selectCategory(i),
      child: SizedBox(
        width: 68,
        height: 72,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: selectedIndex == i
                    ? Color(0xFF1475E1).withOpacity(0.9)
                    : Color(0xFF1475E1).withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Image.asset(categories[i].icon, width: 32, height: 32,
                  color: Colors.white, colorBlendMode: BlendMode.srcIn),
              ),
            ),
            SizedBox(height: 4),
            Text(categories[i].name,
              style: TextStyle(
                fontSize: 12,
                color: selectedIndex == i ? Color(0xFF1475E1) : Color(0xFFB1BAD3),
              ),
            ),
          ],
        ),
      ),
    ),
  ),
)
```

### 2. Header (Navy theme)

```dart
AppBar(
  backgroundColor: Color(0xFF1A2C38),
  leading: null, // No hamburger in navy theme
  title: Row(children: [
    Image.asset('logo.avif', height: 44),
  ]),
  actions: [
    OutlinedButton(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: Color(0xFF2A3F4D), width: 1.5),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: () {},
      child: Text('登录', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600)),
    ),
    SizedBox(width: 8),
    ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF1475E1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
      ),
      onPressed: () {},
      child: Text('注册', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
    ),
  ],
)
```

### 3. Platform Banner Card (Navy)

```dart
Container(
  width: double.infinity,
  height: 80,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    image: DecorationImage(
      image: AssetImage(platform.bannerImage),
      fit: BoxFit.cover,
    ),
  ),
  child: Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      gradient: LinearGradient(
        begin: Alignment(0, -0.4),
        end: Alignment.bottomCenter,
        colors: [Colors.transparent, Colors.black.withOpacity(0.85)],
      ),
    ),
    alignment: Alignment.bottomLeft,
    padding: EdgeInsets.all(12),
    child: Text(platform.name,
      style: TextStyle(fontSize: 15.6, fontWeight: FontWeight.w600, color: Colors.white)),
  ),
)
```

### 4. More Overlay (Navy)

```dart
showModalBottomSheet(
  context: context,
  backgroundColor: Color(0xFF0F212E),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  ),
  builder: (_) => Container(
    padding: EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text('娱乐城', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: Colors.white)),
        SizedBox(height: 16),
        GridView.count(
          crossAxisCount: 4,
          shrinkWrap: true,
          childAspectRatio: 0.85,
          children: overlayItems.map((item) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFF1A2C38),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Image.asset(item.icon),
              ),
              SizedBox(height: 6),
              Text(item.label, style: TextStyle(fontSize: 12, color: Color(0xFFB1BAD3))),
            ],
          )).toList(),
        ),
      ],
    ),
  ),
)
```

## Color Token Mapping

```dart
class NavyV1Colors {
  static const primary = Color(0xFF1475E1);
  static const accentGreen = Color(0xFF00C949);
  static const accentRed = Color(0xFFFF2A4E);
  static const accentOrange = Color(0xFFFFA100);
  static const bg1 = Color(0xFF1A2C38);
  static const bg2 = Color(0xFF0F212E);
  static const neutral1 = Color(0xFFB1BAD3);
  static const neutral2 = Color(0xFF6F7D91);
  static const neutral3 = Color(0xFF566671);
  static const border = Color(0xFF2A3F4D);
  static const cardBg = Color(0xD90F212E); // 85% opacity
}
```

## Key Differences from Green V1

| Aspect | Green V1 | Navy V1 |
|--------|----------|---------|
| Primary color | `#0AB76B` (green) | `#1475E1` (blue) |
| Background | `#292D3B` (grey-blue) | `#1A2C38` (dark navy) |
| Category icon shape | Circle (44px) | Rounded square (48px, 12px radius) |
| Header | Hamburger + brand text | Logo only (no hamburger) |
| Login button | Green outlined | Grey border outlined |
| Non-hot sections | 2-col game cards | Full-width banner cards |
| More menu | Left drawer | Bottom overlay |
| Tab Bar labels | CN: more/home/login/register/profile | CN: browse/casino/promo/support/profile |
