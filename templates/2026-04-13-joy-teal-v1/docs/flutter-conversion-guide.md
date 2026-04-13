# Flutter Conversion Guide

> Step-by-step guide for converting this HTML template to Flutter widgets.

## Widget Tree Overview

```
MaterialApp
└── Scaffold
    ├── body: SingleChildScrollView
    │   └── Column
    │       ├── JackpotSection (98px)
    │       ├── MarqueeBar (51px)
    │       ├── HeaderBar (50px)
    │       ├── BannerCarousel
    │       ├── HotGamesGrid (3-col)
    │       ├── PlatformSection × 9 (2-col each)
    │       └── FooterSection
    └── bottomNavigationBar: TabBar (74px)
```

## Key Conversions

### 1. Page Container

```dart
Container(
  constraints: BoxConstraints(maxWidth: 450),
  decoration: BoxDecoration(
    image: DecorationImage(
      image: AssetImage('assets/bg/home_bg.avif'),
      fit: BoxFit.cover,
    ),
  ),
)
```

### 2. Jackpot Section

- Use `Stack` with background image `cjc1_style_2_bg.webp`
- Number display uses `Timer.periodic` for animation
- Font: Georgia serif, 26px, bold, color `#b71c1c`

### 3. Marquee Bar

- Use `Marquee` package or custom `AnimatedBuilder`
- Height: 51px
- Background: `Color(0xFF171A20).withOpacity(0.75)`
- Left icon: `icon_dt_pmd.webp`

### 4. Platform Section Pattern

Each platform section follows the same pattern:

```dart
Column(
  children: [
    // Header row: emoji + title + "see more"
    PlatformHeader(emoji: '🐟', title: '捕鱼游戏'),
    // 2-column grid of platform cards
    GridView.count(
      crossAxisCount: 2,
      childAspectRatio: 210 / 128,
      children: platforms.map((p) => PlatformCard(p)).toList(),
    ),
    // Load more button
    LoadMoreButton(),
  ],
)
```

### 5. Game Card

```dart
Container(
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(12),
    image: DecorationImage(
      image: AssetImage(gameImagePath),
      fit: BoxFit.cover,
    ),
  ),
  child: Stack(
    children: [
      // Favorite star (top-right)
      Positioned(top: 6, right: 6, child: FavStar()),
      // Name overlay (bottom)
      Positioned(
        bottom: 0, left: 0, right: 0,
        child: GradientOverlay(child: Text(gameName)),
      ),
    ],
  ),
)
```

### 6. Drawer Menu

- Trigger: hamburger icon in header
- Slide from left, 80% width
- Background: `Color(0xFF171A20).withOpacity(0.98)`
- Items: 60px height, 12px font
- Use `Drawer` widget with custom decoration

### 7. Tab Bar

- Fixed at bottom, 74px height
- 3 tabs: 娱乐城 / 游戏 / 支持
- Active state: green accent color `#12BB00`
- Glow effect on active tab

## Asset Mapping

| HTML Path | Flutter Asset Path |
|-----------|-------------------|
| `assets/bg/home_bg.avif` | `assets/images/home_bg.webp` |
| `assets/icons/logo.avif` | `assets/images/logo.webp` |
| `assets/games/game-*.avif` | `assets/images/games/game_*.webp` |
| `assets/games/platforms/p-*.avif` | `assets/images/platforms/p_*.webp` |

Note: Flutter prefers `.webp` format; convert `.avif` files during build.
