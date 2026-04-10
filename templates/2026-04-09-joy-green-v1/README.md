# Joy Green V1

Green theme variant (deep grey-blue background + green primary + pink accent)

## Skin Info

- **Skin Path**: 63-1-1
- **Primary Color**: #0AB76B (green)
- **Accent Pink**: #F84673
- **Background**: #292D3B / #212430

## Features

- Header with GAMING / www.188.com branding + register/login buttons
- Search bar below marquee
- Sky-blue gradient winner ticker section
- 13 category tabs with green circular icon backgrounds
- 9 game platform sections (2-col grid)
- Hot games with 15 cards (3-col grid)
- Two-row hot games horizontal scroll animation
- Left drawer with green gradient header + share/promo cards
- Tab Bar: more / home / login / register / profile
- Footer 3-column links + compliance + contact

## How to Run

```bash
cd templates/2026-04-09-joy-green-v1
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
2026-04-09-joy-green-v1/
├── index.html          # Single HTML (CSS/JS all inline)
├── metadata.json       # Template metadata
├── README.md           # This file
├── screenshot.png      # Screenshot
├── assets/
│   ├── bg/             # Background images
│   ├── games/          # Game card images
│   │   └── platforms/  # Platform thumbnails
│   └── icons/          # UI icons, logos, payment icons
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
| Primary (green) | #0AB76B |
| Accent pink | #F84673 |
| Accent gold | #FFAA09 |
| Accent blue | #1672F2 |
| Background 1 | #292D3B |
| Background 2 | #212430 |
| Background 3 | #353A4A |
| Tab Bar bg | #212430 |
| Neutral 1 | #ABAFBB |
| Neutral 3 | #666A78 |

## Differences from Red V1

| Feature | Red V1 | Green V1 |
|---------|--------|----------|
| Primary color | #D03434 (red) | #0AB76B (green) |
| Header layout | Hamburger + logo + search icon | Hamburger + logo + GAMING text + register/login buttons |
| Search | Icon in header | Dedicated search bar below marquee |
| Category tabs | Square active bg | Green circular icon backgrounds |
| Winner bg | Forest image | Sky-blue gradient |
| Tab bar order | home/promo/login/register/profile | more/home/login/register/profile |
| Drawer header | Red gradient | Green gradient |
| Drawer content | Menu items only | Share banner + promo cards + expandable sections |
| Platform sections | 10 sections | 9 sections (different counts) |
| Hot scroll | Single row | Two rows (opposite directions) |
