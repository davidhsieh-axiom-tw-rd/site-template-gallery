# Structure Analysis

> Detailed breakdown of the joy-teal-v1 page structure.

## Layout Overview

- **Max width**: 450px (centered on desktop)
- **Background**: Deep blue gradient image (`home_bg.avif`), `cover`, `fixed`
- **Body background**: `#e8e8e8` (visible on wider screens)
- **Overflow**: hidden on `.page` container

## Section Breakdown

### 1. Jackpot Section (98px)

| Property | Value |
|----------|-------|
| Height | 98px |
| Background | `cjc1_style_2_bg.webp`, center, contain |
| Content position | Absolute, bottom 18px, centered |
| Number font | Georgia serif, 26px, 900 weight |
| Number color | `#b71c1c` (dark red) |
| Animation | Counter increments every 3s |

### 2. Marquee Bar (51px)

| Property | Value |
|----------|-------|
| Height | 51px |
| Background | `rgba(23,26,32,0.75)` |
| Left icon | `icon_dt_pmd.webp` (24x24) |
| Right icon | Mail SVG (envelope) |
| Text size | 14.4px |
| Scroll speed | 20s linear infinite |

### 3. Header (50px)

| Property | Value |
|----------|-------|
| Height | 50px |
| Background | transparent |
| Left | Logo (34px height) + brand text |
| Right | Login btn (outline) + Register btn (filled green) + hamburger |

### 4. Banner Carousel

| Property | Value |
|----------|-------|
| Padding | 10px 12px |
| Card width | 90% of container |
| Card radius | 12px |
| Scroll | Horizontal, native scrollbar hidden |

### 5. Hot Games Section

| Property | Value |
|----------|-------|
| Grid | 3 columns |
| Gap | 10px |
| Card aspect ratio | 133:178 |
| Card radius | 12px |
| Overlay | Bottom gradient + white text |
| Fav star | Top-right, 31x31 |
| Count | 30 games |

### 6-14. Platform Sections (2-col grid)

Each platform section shares this pattern:

| Property | Value |
|----------|-------|
| Grid | 2 columns |
| Gap | 10px |
| Card aspect ratio | 210:128 |
| Card radius | 12px |
| Header | Emoji + title (21.6px) + "see more" |
| Load more button | Green outline, 13px |

### 15. Footer

| Property | Value |
|----------|-------|
| Background | `rgba(28,28,28,0.9)` |
| Padding | 20px 16px |
| Contact section | 2 Telegram icons, 42x42 |
| Links grid | 3 columns (娱乐城/游戏/支持) |
| License | 18+ icon + self-ban link |

### 16. Tab Bar (74px)

| Property | Value |
|----------|-------|
| Position | Fixed bottom |
| Height | 74px |
| Background | `rgba(23,26,32,0.95)` |
| Tabs | 3 (娱乐城/游戏/支持) |
| Active color | `#12BB00` |
| Arrow | Top center, toggle visibility |

### 17. Drawer Menu

| Property | Value |
|----------|-------|
| Trigger | Hamburger icon in header |
| Width | 80% of page |
| Background | `rgba(23,26,32,0.98)` |
| Backdrop | 20% dark overlay on right |
| Item height | 60px |
| Item font size | 12px |
| Icon size | 22x22 (inline SVG) |

## CSS Class Naming

| Class | Purpose |
|-------|---------|
| `.page` | Main container (450px max) |
| `.platform-section` | Each game category section |
| `.game-card-border` | Individual game/platform card |
| `.game-grid-3col` | 3-column layout (hot games) |
| `.game-grid-2col` | 2-column layout (platforms) |
| `.more-drawer` | Drawer menu container |
| `.tab-bar` | Bottom tab navigation |
| `.footer-links` | Footer link columns |
| `.footer-license` | Footer compliance area |
| `.footer-contact` | Footer contact section |
