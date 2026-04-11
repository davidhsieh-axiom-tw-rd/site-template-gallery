# Flutter Token Mapping -- Joy Navy V1

> Navy blue theme (deep navy background + blue primary + green/red/orange accents)
> Source: https://joy.star-link-rel.cc/ (skin navy)
> Date: 2026-04-10

## Design Principles

- **Original site first**: All colors and sizes based on actual rendered values from the navy theme
- **Flutter Token reference**: Flutter Token names used as variable naming reference, values from original site
- **Dark mode**: This template is a dark mode design with primary color #1475E1

---

## 1. 色彩 Token（Color Token Mapping）

### Primary Colors

| CSS Variable | Value | Flutter Token | Description |
|-------------|-------|---------------|-------------|
| `--skin-primary` | `#1475E1` | `brandPrimary50` | Primary blue |
| `--skin-bg-1` | `#1A2C38` | `bgPrimary` | Deep navy background |
| `--skin-bg-2` | `#0F212E` | `bgSecondary` | Deeper navy (Tab Bar, cards) |
| `--text-primary` | `#FFFFFF` | `textPrimary` | Primary text white |
| `--text-secondary` | `#B1BAD3` | `textSecondary` | Secondary text light grey-blue |
| `--skin-neutral-1` | `#B1BAD3` | `colorNeutral10` | Neutral light |
| `--skin-neutral-2` | `#6F7D91` | `colorNeutral20` | Neutral mid |
| `--skin-neutral-3` | `#566671` | `colorNeutral30` | Neutral dark |
| `--skin-border` | `#2A3F4D` | `borderDefault` | Border color |

### Accent Colors

| Usage | Value | Flutter Token | Description |
|-------|-------|---------------|-------------|
| Green accent | `#00C949` | `accentGreen` | Win/success |
| Red accent | `#FF2A4E` | `accentRed` | Loss/error/badge |
| Orange accent | `#FFA100` | `accentOrange` | Highlight/winner amount |
| Button primary | `#1475E1` | `btnColor1` | Primary button fill |

### Functional Colors

| Usage | Value | Flutter Token | Description |
|-------|-------|---------------|-------------|
| Register button (header) | `#1475E1` | `brandPrimary50` | Blue filled |
| Login button (header) | transparent + `#2A3F4D` border | `borderDefault` | Border outlined |
| Category Tab icon bg | `rgba(20,117,225,0.15)` | `brandPrimary50.withOpacity(0.15)` | Translucent blue circle |
| Category Tab active bg | `rgba(20,117,225,0.9)` | `brandPrimary50.withOpacity(0.9)` | Opaque blue circle |
| Jackpot number | `#b71c1c` | -- | Dark red (from background image) |
| Winner highlight | `#FFA100` | `accentOrange` | Gold |

### Gradients

| Name | CSS Value | Flutter Equivalent |
|------|-----------|-------------------|
| Game name overlay | `linear-gradient(transparent, rgba(0,0,0,0.75))` | `LinearGradient(begin: top, end: bottom, colors: [transparent, 0xBF000000])` |
| Card background | `rgba(15, 33, 46, 0.85)` | `Color(0xD90F212E)` |
| Winner section | `linear-gradient(135deg, #0a1929, #0f2e4a, #14436b, #1a5a8a)` | Navy blue gradient |
| Banner card overlay | `linear-gradient(transparent 40%, rgba(0,0,0,0.85))` | Bottom dark overlay |

---

## 2. 尺寸 Token（Size Token Mapping）

### Design Basis

| Item | HTML | Flutter | Notes |
|------|------|---------|-------|
| Design width | 450px (container max-width) | 375px | Flutter uses sizeScaler |
| Desktop behavior | max-width 450px centered | ScreenWindow forced 375:812 ratio | Layout difference |

### Block Sizes

| Element | HTML px | Flutter dp | Token |
|---------|---------|-----------|-------|
| Header height | 68 | 68 x sizeScaler | `headerHeight` |
| Tab Bar height | 78 | 78 x sizeScaler | `tabBarHeight` |
| Jackpot area height | 98 | 98 x sizeScaler | -- |
| Winner area height | 84 | 84 x sizeScaler | -- |
| Category Tab size | 68x72 | 68x72 x sizeScaler | -- |
| Category icon square | 48x48 | 48 x sizeScaler | -- |
| Category icon radius | 12px | 12 x sizeScaler | `radiusM` |
| Game Grid gap | 10px | 10 x sizeScaler | `spacingS` |
| Game card radius | 14px | 14 x sizeScaler | `radiusL` |
| Platform banner radius | 12px | 12 x sizeScaler | `radiusM` |

---

## 3. 字體 Token（Font Token Mapping）

| Element | font-size | font-weight | color | letter-spacing |
|---------|-----------|-------------|-------|---------------|
| Platform title | 18px | 600 | #FFFFFF | -- |
| Header login btn | 14px | 600 | #FFFFFF | -- |
| Header register btn | 14px | 600 | #FFFFFF | -- |
| Jackpot number | 26px | 900 | #b71c1c | 5px |
| Marquee text | 12px | normal | #B1BAD3 | -- |
| Winner card info | 11px | normal | #B1BAD3 | -- |
| Winner highlight | 11px | 600 | #FFA100 | -- |
| Category Tab text | 12px | normal | #B1BAD3 | -- |
| Category Tab active | 12px | normal | #1475E1 | -- |
| Tab Bar text | 10px | 500 | rgba(255,255,255,0.5) | -- |
| Tab Bar active | 10px | 600 | #1475E1 | -- |
| Footer title | 16.8px | 600 | #FFFFFF | -- |
| Footer link | 13.2px | normal | rgba(255,255,255,0.5) | -- |
| Footer compliance | 13px | 500 | #B1BAD3 | -- |
| Game card name | 13px | 700 | #FFFFFF | -- |
| Subtitle | 12px | normal | rgba(255,255,255,0.4) | -- |
| Banner label | 15.6px | 600 | #FFFFFF | -- |
| More overlay title | 18px | 600 | #FFFFFF | -- |
| More overlay label | 12px | normal | #B1BAD3 | -- |

---

## 4. 陰影對照（Shadow Mapping）

| Element | CSS box-shadow | Flutter BoxShadow |
|---------|---------------|-------------------|
| Tab Bar | `0 -2px 10px rgba(0,0,0,0.3)` | `BoxShadow(blurRadius: 10, offset: Offset(0,-2), color: Colors.black.withOpacity(0.3))` |
| Winner card | `none (border: 1px solid rgba(255,255,255,0.08))` | `Border(color: Colors.white.withOpacity(0.08))` |

---

## 5. 動畫參數（Animation Parameters）

| Animation | CSS duration | Flutter Duration | Curve |
|-----------|-------------|-----------------|-------|
| Marquee | 20s linear infinite | `Duration(seconds: 20)` | `Curves.linear` |
| Winner ticker | 25s linear infinite | `Duration(seconds: 25)` | `Curves.linear` |
| Jackpot counter | 3s interval | `Timer.periodic(Duration(seconds: 3))` | -- |

---

## 6. z-index Mapping

| Level | Element | CSS z-index | Flutter |
|-------|---------|------------|---------|
| Highest | More Overlay | 500 | OverlayEntry |
| High | Tab Bar | 200 | Scaffold bottomNavigationBar |
| Mid | Header | 100 | SliverAppBar |
| Base | Page container | 1 | Scaffold body |

---

## 7. Widget 對應（Widget Mapping）

| HTML Element | Flutter Widget | Description |
|-------------|---------------|-------------|
| `.page` | `Scaffold` | Root container |
| `.header` | `SliverAppBar` | Fixed Header |
| `.jackpot-section` | `JackpotWidget` | Jackpot counter + background |
| `.marquee-bar` | `MarqueeWidget` | Scrolling announcement |
| `.winner-section` | `WinnerTickerWidget` | Winner card ticker |
| `.category-tabs` | `CategoryTabsWidget` | Game category tabs |
| `.game-grid-3col` | `GridView.count(crossAxisCount: 3)` | Hot games 3-col |
| `.platform-banner-list` | `PlatformBannerList` | Platform banner cards (vertical) |
| `.footer` | `FooterWidget` | Footer 3-column links |
| `.tab-bar` | `BottomNavigationBar` | Bottom Tab Bar |
| `.more-overlay` | `OverlayEntry` / `BottomSheet` | More overlay grid |

---

## 8. 佈局差異（Layout Differences）

| Item | HTML Implementation | Flutter Difference |
|------|--------------------|--------------------|
| Container width | `max-width: 450px` centered | Flutter uses 375px design + sizeScaler |
| Platform sections | Vertical banner list (full-width cards) | Flutter Column + Card list |
| Hot games grid | CSS Grid 3-col | Flutter GridView.count(3) |
| Category tabs scroll | CSS overflow-x: auto | Flutter TabBar + SingleChildScrollView |
| Game cards | background-image div | Flutter Container + DecorationImage |
| Jackpot animation | CSS sprite background-position | Flutter SpriteWidget or CustomPainter |
| More overlay | JS toggle class | Flutter showModalBottomSheet or Overlay |
