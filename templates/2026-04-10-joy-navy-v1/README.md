# Joy Navy V1

Navy/dark-teal theme variant (deep navy background + blue primary + full-width platform banners)

## Skin Info

- **Skin Path**: navy-skin
- **Primary Color**: #1475E1 (blue)
- **Accent Green**: #00C949
- **Accent Red**: #FF2A4E
- **Accent Orange**: #FFA100
- **Background**: #1A2C38 / #0F212E

## Features

- Header with logo left, login + register buttons right (68px height)
- Jackpot animation area with number counter
- Marquee bar with icon and mail notification badge
- Navy gradient winner ticker section
- 14 category tabs with rounded-rect icon backgrounds
- Hot games: 15 cards in 3-col grid
- Non-hot categories: full-width platform banner cards
- Game providers section with 3 provider banners
- More overlay (icon grid) triggered by "娱乐城" tab
- Tab Bar: 浏览 / 娱乐城 / 优惠 / 客服 / 我的 (SVG symbol icons)
- Footer 3-column links + compliance + contact

## How to Run

```bash
cd templates/2026-04-10-joy-navy-v1
python3 -m http.server 8080
```

Open http://localhost:8080

### Freeze Mode

Append `?freeze=true` to stop all animations and fix Jackpot at 10,702,017:

```
http://localhost:8080?freeze=true
```

## File Structure

```
2026-04-10-joy-navy-v1/
├── index.html          # Single HTML (CSS/JS all inline)
├── metadata.json       # Template metadata
├── README.md           # This file
├── assets/
│   ├── bg/             # Background images (jackpot, pattern tile)
│   ├── games/          # Game card images (16 hot games)
│   │   └── platforms/  # Platform banner images (41 banners)
│   ├── icons/          # UI icons, category icons, logos, more menu icons
│   └── ui/             # UI elements (favorite star, avatar placeholder)
```

## Color Scheme

| Usage | Value |
|-------|-------|
| Primary (blue) | #1475E1 |
| Accent green | #00C949 |
| Accent red | #FF2A4E |
| Accent orange | #FFA100 |
| Background 1 | #1A2C38 |
| Background 2 | #0F212E |
| Neutral 1 | #B1BAD3 |
| Neutral 2 | #6F7D91 |
| Neutral 3 | #566671 |
| Border | #2A3F4D |
| Tab Bar bg | #0F212E |

## Differences from Green V1

| Feature | Green V1 | Navy V1 |
|---------|----------|---------|
| Primary color | #0AB76B (green) | #1475E1 (blue) |
| Header height | 50px | 68px (logo 44px) |
| Header layout | Hamburger + logo + register/login | Logo + login/register |
| Category icons | Green circular backgrounds | Blue rounded-rect backgrounds |
| Non-hot sections | 2-col game grid | Full-width platform banner cards |
| Tab bar labels | 更多/首页/登录/注册/我的 | 浏览/娱乐城/优惠/客服/我的 |
| Tab bar icons | Inline SVG paths | SVG symbol references |
| More menu | Full-page drawer | Bottom overlay icon grid |
| Winner bg | Sky-blue gradient | Navy gradient |
| Search bar | Below marquee | Not present |
| Game providers | Not present | Dedicated section with 3 banners |
