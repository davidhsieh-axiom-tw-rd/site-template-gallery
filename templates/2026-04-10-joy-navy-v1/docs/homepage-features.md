# Feature Spec -- Joy Navy V1

> Detailed behavior description of each section

## Feature List

### 1. Header

| Item | Description |
|------|------------|
| Logo | AVIF logo image, left side, 44px height |
| Login button | White text, grey border (#2A3F4D), rounded 6px |
| Register button | Blue filled (#1475E1), white text, rounded 6px |
| Background | Deep navy #1A2C38 |
| Height | 68px |

### 2. JACKPOT Animation Area

| Item | Description |
|------|------------|
| Background | cjc1_style_2_bg.webp, contain mode, #0a0a2e fallback |
| Number | Dark red #b71c1c, serif font, every 3s increment random 1-50 |
| Text effect | text-shadow glow |
| Freeze mode | Stop counting, fixed at 10,702,017 |

### 3. Marquee

| Item | Description |
|------|------------|
| Background | #1A2C38 (same as header) |
| Speaker icon | Left side, AVIF animated speaker |
| Text | Horizontal scroll, 20s per loop |
| Mail icon | Right side, envelope with red badge (99) |
| Freeze mode | Stop scroll, static text |

### 4. Winner Ticker

| Item | Description |
|------|------------|
| Background | Navy blue gradient (CSS: #0a1929 -> #0f2e4a -> #14436b -> #1a5a8a) |
| Cards | Horizontal auto-scroll, 25s per loop |
| Card content | Game thumbnail (37x49px) + "Congratulations X***XX won Nx" |
| Card style | Black semi-transparent bg (0.55) + backdrop blur + rounded 20px |
| Loop | Data duplicated 2x for seamless loop |
| Freeze mode | Stop scroll, show first 3 only |

### 5. Category Tabs

| Item | Description |
|------|------------|
| Count | 14 (hot/fish/slot/provider/chess/live/sport/lottery/esport/cockfight/blockchain/trial/recent/fav) |
| Layout | Horizontal scroll, each 68x72px |
| Icon style | Blue translucent rounded square bg (48px, 12px radius) with white icon inside |
| Active | Background becomes opaque blue, text turns blue |
| Click | Scrolls to corresponding platform section |

### 6. Game Platform Sections (11)

| Platform | Cards | Card Type |
|----------|-------|-----------|
| Hot Games | 22 | game-card-border (3-col grid) |
| Fishing | 6 | platform-banner-card (full-width) |
| Slots | 6 | platform-banner-card (full-width) |
| Providers | 3 | provider-banner-card (image only) |
| Chess/Card | 6 | platform-banner-card (full-width) |
| Live Casino | 6 | platform-banner-card (full-width) |
| Sports | 6 | platform-banner-card (full-width) |
| Lottery | 4 | platform-banner-card (full-width) |
| Esports | 2 | platform-banner-card (full-width) |
| Cockfight | 1 | platform-banner-card (full-width) |
| Blockchain | 2 | platform-banner-card (full-width) |

Hot Games section:
- Title row: icon + name + "All" + left/right arrow buttons
- 3-column game card grid with fav star overlay
- Subtitle: "Showing 22 of 79 hot games"
- "Load more" button

Other sections:
- Title row: icon + name + "All >"
- Full-width banner cards with gradient overlay + label
- "Load more" button

### 7. Footer

| Item | Description |
|------|------------|
| 3-column links | Entertainment(10) + Games(11) + Support(3) = 24 links |
| Compliance | 18+ icon + self-ban link (SVG people icon) |
| Contact | 1 Telegram contact (specialist) |

### 8. Tab Bar

| Tab | Label | Icon | Description |
|-----|-------|------|------------|
| 1 | Browse | Grid SVG | -- |
| 2 | Casino | Dice SVG | Default active (blue) |
| 3 | Promo | Gift SVG | -- |
| 4 | Support | Headset SVG | -- |
| 5 | Profile | Person SVG | -- |

### 9. More Overlay

| Item | Description |
|------|------------|
| Trigger | "Browse" tab in Tab Bar |
| Style | Full-screen backdrop (rgba(0,0,0,0.5)) + bottom panel |
| Background | #0F212E |
| Title | "Entertainment" (18px, bold) |
| Grid | 4-column, 11 items |
| Items | Share/Task/Rebate/Rewards/VIP/Events/Fund/Lucky Draw/Credit/Lucky Wheel/Referral |
| Close | Click backdrop area |

## Freeze Mode (?freeze=true)

| Feature | Normal | Frozen |
|---------|--------|--------|
| Marquee | Horizontal scroll | Static text |
| Winner ticker | Auto scroll | Fixed 3 cards |
| Jackpot counter | +random every 3s | Fixed 10,702,017 |
| CSS animations | Playing | animation-play-state: paused |
| CSS transitions | Normal | transition: none |
