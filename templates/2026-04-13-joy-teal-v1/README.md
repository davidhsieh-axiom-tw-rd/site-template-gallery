# JOY Teal V1

Deep blue gradient skin with green accent color. Skin path: `22-0-1`.

## Quick Start

```bash
cd templates/2026-04-13-joy-teal-v1
python3 -m http.server 8080
```

Then open http://localhost:8080 in your browser (set width to 450px for best results).

### Freeze Mode

Append `?freeze=true` to stop all animations and fix data for screenshot comparison:

```
http://localhost:8080?freeze=true
```

## Skin Variables

| Token | Value | Usage |
|-------|-------|-------|
| `--skin__primary` | `#171A20` | Deep dark background |
| `--skin__accent_1` | `#12BB00` | Green accent (buttons, active states) |
| `--skin__accent_2` | `#ED4E3B` | Red accent (alerts) |
| `--skin__bg_1` | `#F4F4F4` | Light background |
| `--skin__bg_2` | `#FFFFFF` | White background |
| `--skin__neutral_1` | `#6C7077` | Dark grey text |
| `--skin__neutral_2` | `#A2A3A5` | Medium grey text |
| `--skin__neutral_3` | `#CCCCCC` | Light grey borders |

## Page Structure

1. JACKPOT area (98px) - animated counter
2. Marquee bar (51px) - scrolling announcement
3. Header (50px) - logo + login/register + hamburger
4. Banner carousel - horizontal scrolling
5. Hot games (3-col grid, 30 games)
6. Fishing games (2-col, 8 platforms)
7. Slot games (2-col, 6 platforms)
8. Card games (2-col, 6 platforms)
9. Live casino (2-col, 6 platforms)
10. Sports (2-col, 6 platforms)
11. Lottery (2-col, 4 platforms)
12. Esports (2-col, 2 platforms)
13. Cockfight (2-col, 1 platform)
14. Blockchain (2-col, 2 platforms)
15. Footer - contact + links + license
16. Tab bar (fixed, 3 tabs)
17. Drawer menu (left slide, hamburger trigger)

## Assets

```
assets/
├── bg/           (5 files) - backgrounds and jackpot sprite
├── icons/        (5 files) - logo, marquee, 18+, telegram, fav star
├── banners/      (1 file)  - banner carousel images
└── games/
    ├── game-*.avif (30 files) - hot game cards
    └── platforms/
        └── p-*.avif (63 files) - platform category cards
```

## Docs

- `docs/flutter-token-mapping.md` - CSS var to Flutter token mapping
- `docs/flutter-conversion-guide.md` - HTML to Flutter conversion guide
- `docs/typography.md` - Font sizes and text styles
- `docs/structure-analysis.md` - Page structure breakdown
- `docs/homepage-features.md` - Interactive features documentation
- `docs/assets-inventory.json` - Complete asset manifest
