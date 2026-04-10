# Flutter Widget Conversion Guide -- Joy Crimson V1

> Mapping from HTML template to Flutter Widget implementation

## Widget Mapping Table

| # | HTML Block | Flutter Widget | Notes |
|---|-----------|---------------|-------|
| 1 | `.page` | `Scaffold` + `ScreenWindow` | max-width 450px -> 375dp, bg image |
| 2 | `.header` | `SliverAppBar` | Logo + Lucky Wheel + Search icon |
| 3 | `.jackpot-section` | Custom `JackpotWidget` | Background image + counter |
| 4 | `.marquee-bar` | Custom `MarqueeWidget` | Background image + scrolling text |
| 5 | `.winner-section` | Custom `WinnerTickerWidget` | Background image + horizontal card ticker |
| 6 | `.auth-actions-bar` | Custom `AuthActionsBar` | Login/Register + Quick actions |
| 7 | `.category-sidebar` | `ListView` in fixed `SizedBox(width: 80)` | 13 vertical category items |
| 8 | `.game-content` | `Expanded` child | Platform sections |
| 9 | `.game-grid-3col` | `GridView.count(crossAxisCount: 3)` | Hot games 3-col |
| 10 | `.platform-card-full` | Custom `PlatformFullCard` | Full-width 345x135 with bg image |
| 11 | `.hot-games-track` | Custom `HotGamesScrollWidget` | Single-row auto-scroll |
| 12 | `.footer` | Custom `FooterWidget` | 3-column Grid + contact |
| 13 | `.tab-bar` | `BottomNavigationBar` | 5 tabs with bg image |
| 14 | `.more-overlay` | `showModalBottomSheet` | 5-col grid, 29 items |

## Key Conversion Details

### 1. Sidebar Category (Vertical)

```dart
SizedBox(
  width: 80,
  child: ListView.builder(
    itemCount: categories.length,
    itemBuilder: (_, i) => GestureDetector(
      onTap: () => selectCategory(i),
      child: Container(
        width: 80,
        height: 62,
        decoration: BoxDecoration(
          image: selectedIndex == i
            ? DecorationImage(
                image: AssetImage('btn_zc3_2.avif'),
                fit: BoxFit.cover,
              )
            : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(categories[i].icon, width: 32, height: 32),
            SizedBox(height: 2),
            Text(categories[i].name,
              style: TextStyle(
                fontSize: 11,
                color: selectedIndex == i ? Color(0xFFFFE44D) : Color(0xFFE39197),
                fontWeight: selectedIndex == i ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    ),
  ),
)
```

### 2. Header (Crimson theme)

```dart
AppBar(
  backgroundColor: Color(0xFF130606).withOpacity(0.9),
  title: Image.asset('logo.avif', height: 38),
  actions: [
    Image.asset('lucky-wheel.webp', width: 48, height: 48),
    SizedBox(width: 12),
    GestureDetector(
      onTap: () => openSearch(),
      child: Image.asset('icon_search.avif', width: 28, height: 28),
    ),
    SizedBox(width: 12),
  ],
)
```

### 3. Auth Actions Bar

```dart
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    Row(children: [
      OutlinedButton(
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Color(0xFFFFE44D)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          fixedSize: Size(72, 30),
        ),
        onPressed: () {},
        child: Text('登录', style: TextStyle(color: Color(0xFFFFE44D))),
      ),
      SizedBox(width: 10),
      ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFFFFE44D),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          fixedSize: Size(72, 30),
        ),
        onPressed: () {},
        child: Text('注册', style: TextStyle(color: Color(0xFF6F000D))),
      ),
    ]),
    Row(children: [
      _QuickAction(icon: 'icon_deposit.avif', label: '存款', badge: '送66%'),
      _QuickAction(icon: 'icon_vip.avif', label: 'VIP'),
      _QuickAction(icon: 'icon_more.avif', label: '更多', onTap: openMoreOverlay),
    ]),
  ],
)
```

### 4. More Overlay (Bottom Sheet)

```dart
showModalBottomSheet(
  context: context,
  backgroundColor: Color(0xFF300101),
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  ),
  builder: (_) => Container(
    padding: EdgeInsets.all(12),
    child: Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text('更多功能', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Color(0xFFFFE44D))),
        IconButton(onPressed: Navigator.pop, icon: Icon(Icons.close, color: Color(0xFFE39197))),
      ]),
      GridView.count(
        crossAxisCount: 5,
        shrinkWrap: true,
        children: moreMenuItems.map((item) => _MoreMenuItem(item)).toList(),
      ),
    ]),
  ),
);
```

### 5. Tab Bar (with background image)

```dart
Container(
  height: 95,
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('img_db_dt_btm.avif'),
      fit: BoxFit.cover,
    ),
  ),
  child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [
      _TabItem(icon: 'icon_btm_home.avif', label: '首页', active: true),
      _TabItem(icon: 'icon_btm_vip.avif', label: 'VIP'),
      _SpinTabItem(icon: 'icon_btm_spin.webp', label: 'Spin'), // larger, raised
      _TabItem(icon: 'icon_btm_promo.avif', label: '优惠'),
      _TabItem(icon: 'icon_btm_profile.avif', label: '我的'),
    ],
  ),
)
```

## Color Token Mapping

```dart
class CrimsonV1Colors {
  static const primary = Color(0xFFFFE44D);
  static const accentGold = Color(0xFFFFAA09);
  static const accentCrimson = Color(0xFF6F000D);
  static const accentBlue = Color(0xFF1672F2);
  static const bg1 = Color(0xFF300101);
  static const bg2 = Color(0xFF130606);
  static const bg3 = Color(0xFF4A0F0F);
  static const textPrimary = Color(0xFFE39197);
  static const textSecondary = Color(0x99E39197); // 60% opacity
  static const disabled = Color(0xFF999999);
  static const cardBg = Color(0xD9130606); // 85% opacity
}
```
