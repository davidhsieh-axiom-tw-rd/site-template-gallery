# Flutter Token Mapping

> CSS variable to Flutter token correspondence for skin path 22-0-1.

## 1. 色彩 Token

| CSS Variable | Value | Flutter Token | Dart Expression |
|-------------|-------|---------------|-----------------|
| `--skin__primary` | `#171A20` | `skin.primary` | `Color(0xFF171A20)` |
| `--skin__accent_1` | `#12BB00` | `skin.accent1` | `Color(0xFF12BB00)` |
| `--skin__accent_2` | `#ED4E3B` | `skin.accent2` | `Color(0xFFED4E3B)` |

## 2. Background Colors

| CSS Variable | Value | Flutter Token | Dart Expression |
|-------------|-------|---------------|-----------------|
| `--skin__bg_1` | `#F4F4F4` | `skin.bg1` | `Color(0xFFF4F4F4)` |
| `--skin__bg_2` | `#FFFFFF` | `skin.bg2` | `Color(0xFFFFFFFF)` |
| `--body-bg` | `#e8e8e8` | `surfaceBackground` | `Color(0xFFE8E8E8)` |
| `--page-bg` | `#0c1929` | `pageBackground` | `Color(0xFF0C1929)` |

## 3. Neutral Colors

| CSS Variable | Value | Flutter Token | Dart Expression |
|-------------|-------|---------------|-----------------|
| `--skin__neutral_1` | `#6C7077` | `skin.neutral1` | `Color(0xFF6C7077)` |
| `--skin__neutral_2` | `#A2A3A5` | `skin.neutral2` | `Color(0xFFA2A3A5)` |
| `--skin__neutral_3` | `#CCCCCC` | `skin.neutral3` | `Color(0xFFCCCCCC)` |

## 4. Text Colors

| CSS Usage | Value | Flutter Token | Dart Expression |
|-----------|-------|---------------|-----------------|
| `--text-primary` | `#FFFFFF` | `colorNeutral90` | `Color(0xFFFFFFFF)` |
| `--text-secondary` | `rgba(162,163,165,1)` | `colorNeutral60` | `Color(0xFFA2A3A5)` |

## 5. 尺寸 Token

| CSS Variable | Value | Flutter Token | Notes |
|-------------|-------|---------------|-------|
| `--header-height` | `50px` | `headerHeight` | Fixed header |
| `--tab-bar-height` | `74px` | `tabBarHeight` | Bottom navigation |
| `--card-radius` | `12px` | `cardRadius` | Platform card corners |

## 6. 陰影對照 & Overlays

| CSS Usage | Flutter Token | Notes |
|-----------|---------------|-------|
| `rgba(23,26,32,0.75)` | `marqueeBarBg` | Marquee background |
| `rgba(23,26,32,0.95)` | `tabBarBg` | Tab bar background |
| `rgba(23,26,32,0.98)` | `drawerBg` | Drawer menu background |
| `rgba(28,28,28,0.9)` | `footerBg` | Footer background |
| `linear-gradient(transparent, rgba(0,0,0,0.75))` | `gameCardOverlay` | Game name overlay |

## 7. 動畫參數

| CSS Property | Value | Flutter Token |
|-------------|-------|---------------|
| `--animation-state` | `running` / `paused` | `animationEnabled` |
| `marquee-scroll` duration | `20s` | `marqueeSpeed` |
| Jackpot interval | `3000ms` | `jackpotUpdateInterval` |

## 8. 字體 Token

| CSS Usage | Value | Flutter Token |
|-----------|-------|---------------|
| Section title | `21.6px` | `sectionTitleSize` |
| Footer heading | `16.8px` | `footerHeadingSize` |
| Marquee text | `14.4px` | `marqueeTextSize` |
| Tab label | `14.4px` | `tabLabelSize` |
| Brand name | `14px` | `brandNameSize` |
| Button text | `13px` | `buttonTextSize` |
| Game card name | `13px` | `gameCardNameSize` |
| Drawer item | `12px` | `drawerItemSize` |
| Footer link | `12px` | `footerLinkSize` |
| Brand URL | `10px` | `brandUrlSize` |

## 9. z-index 層級

| Element | z-index | Flutter Notes |
|---------|---------|---------------|
| Tab bar | 200 | `NavigationBar` always on top |
| Drawer backdrop | 500 | `Drawer` overlay |
| Drawer panel | 501 | `Drawer` content |
| Marquee | 10 | Below dialogs |

## 10. Widget 對應

| HTML Element | Flutter Widget |
|-------------|---------------|
| `.page` | `Scaffold` + `SingleChildScrollView` |
| `.header` | `SliverAppBar` (pinned) |
| `.banner-carousel` | `PageView` / `CarouselSlider` |
| `.game-grid-3col` | `GridView.count(crossAxisCount: 3)` |
| `.platform-grid` | `GridView.count(crossAxisCount: 2)` |
| `.tab-bar` | `BottomNavigationBar` |
| `.more-drawer` | `Drawer` |
| `.footer` | `Column` in `SliverToBoxAdapter` |

## 11. 佈局差異

| Web (HTML/CSS) | Flutter | Notes |
|---------------|---------|-------|
| `max-width: 450px` | `ConstrainedBox(maxWidth: 450)` | Center on desktop |
| `background-attachment: fixed` | `BoxDecoration(image:)` on `Scaffold` | Background parallax |
| `overflow: hidden` | `ClipRect` | Prevent overflow |
| `position: sticky` | `SliverAppBar(pinned: true)` | Sticky header |
| CSS Grid 3-col | `GridView.count(crossAxisCount: 3)` | Hot games |
| CSS Grid 2-col | `GridView.count(crossAxisCount: 2)` | Platform cards |
