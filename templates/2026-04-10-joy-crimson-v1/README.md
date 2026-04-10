# Joy Crimson V1

Deep crimson-gold Chinese palace theme (deep red background + gold primary + pink text)

## Skin Info

- **Skin Path**: 5-1-1
- **Primary Color**: #FFE44D (gold)
- **Accent Crimson**: #6F000D
- **Background**: #300101 / #130606
- **Text**: #E39197 (pink tint)

## Features

- Header with Logo + Lucky Wheel animation + Search icon
- Vertical sidebar with 13 game categories (80px, sticky)
- JACKPOT animation with cjc1_style_2_bg.webp background
- Marquee with img_bg_bj.avif background + speaker icon + mail badge
- Winner ticker with winner-bg.avif background
- Login/Register buttons (gold outlined/filled) + Quick actions (deposit/VIP/more)
- 3-col hot games grid (15 cards, 92x92)
- Full-width platform cards (345x135) with category background images
- Hot games horizontal scroll animation
- More overlay dropdown panel (5-col grid, 29 items)
- Tab Bar with img_db_dt_btm.avif background (首页/VIP/Spin/优惠/我的)
- Footer 3-column links + compliance + contact

## How to Run

```bash
cd templates/2026-04-10-joy-crimson-v1
python3 -m http.server 8080
```

Open http://localhost:8080

### Freeze Mode

Append `?freeze=true` to stop all animations and fix Jackpot at 10,000,000:

```
http://localhost:8080?freeze=true
```

## File Structure

```
2026-04-10-joy-crimson-v1/
├── index.html          # Single HTML (CSS/JS all inline)
├── metadata.json       # Template metadata
├── README.md           # This file
├── screenshot.png      # Screenshot
├── assets/
│   ├── bg/             # Background images
│   ├── games/          # Game card images
│   │   └── platforms/  # Platform thumbnails
│   └── icons/          # UI icons, logos, tab bar icons
└── docs/
    ├── flutter-token-mapping.md
    ├── flutter-conversion-guide.md
    ├── typography.md
    ├── structure-analysis.md
    ├── homepage-features.md
    └── assets-inventory.json
```

## Color Scheme

| Usage | Value |
|-------|-------|
| Primary (gold) | #FFE44D |
| Accent gold | #FFAA09 |
| Accent crimson | #6F000D |
| Background 1 | #300101 |
| Background 2 | #130606 |
| Background 3 | #4a0f0f |
| Text primary (pink) | #E39197 |
| Text secondary | rgba(227,145,151,0.6) |
| Tab Bar bg | img_db_dt_btm.avif |

## Differences from Green V1

| Feature | Green V1 | Crimson V1 |
|---------|----------|------------|
| Primary color | #0AB76B (green) | #FFE44D (gold) |
| Background | #292D3B (grey-blue) | #300101 (deep crimson) |
| Text color | #FFFFFF (white) | #E39197 (pink tint) |
| Header layout | Hamburger + logo + brand text + register/login | Logo + Lucky Wheel + search icon |
| Login/Register | In header (green) | Below winner section (gold) |
| Category tabs | Horizontal scroll (green circular) | Vertical sidebar (80px, btn_zc3_2.avif bg) |
| Game layout | Full-width platform sections | Sidebar + content layout |
| Platform sections | 2-col card grid | Full-width 345x135 cards + grid |
| More menu | Left drawer (full page) | Bottom overlay dropdown (5-col grid) |
| Tab bar | 5 tabs (more/home/login/register/profile) | 5 tabs (home/VIP/Spin/promo/profile) with bg image |
| Tab bar bg | Solid color #212430 | Image img_db_dt_btm.avif |
| Marquee bg | Solid color | Image img_bg_bj.avif |
| Page bg | Solid color | Image img_db_dt_bg.avif pattern |
