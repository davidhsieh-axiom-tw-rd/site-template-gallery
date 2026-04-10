# Feature Spec -- Joy Green V1

> Detailed behavior description of each section

## Feature List

### 1. Header

| Item | Description |
|------|------------|
| Hamburger menu | Top-left three bars, opens left drawer |
| Logo | AVIF logo image, left side |
| Brand text | "GAMING" + "www.188.com" below logo |
| Register button | Green filled (#0AB76B), rounded pill shape |
| Login button | Green outlined (#0AB76B border), transparent bg |
| Background | Deep grey-blue #212430 |

### 2. JACKPOT Animation Area

| Item | Description |
|------|------------|
| Background | cjc1_style_2_bg.webp, contain mode |
| Number | Dark red #b71c1c, serif font, every 3s increment random 1-50 |
| Text effect | text-shadow glow |
| Freeze mode | Stop counting, fixed at 10,702,017 |

### 3. Marquee

| Item | Description |
|------|------------|
| Background | #292D3B |
| Speaker icon | Left side, gold SVG |
| Text | Horizontal scroll, 20s per loop |
| Freeze mode | Stop scroll, static text |

### 3b. Search Bar

| Item | Description |
|------|------------|
| Position | Below marquee |
| Background | #212430, rounded pill (24px radius) |
| Icon | Magnifying glass SVG, left side |
| Placeholder | "搜索游戏" |

### 4. Winner Ticker

| Item | Description |
|------|------------|
| Background | Sky-blue gradient (CSS) + forest image fallback |
| Cards | Horizontal auto-scroll, 25s per loop |
| Card content | Game thumbnail + "恭喜 X***XX 中奖 X倍" |
| Loop | Data duplicated 2x for seamless loop |
| Freeze mode | Stop scroll, show first 3 only |

### 5. Category Tabs

| Item | Description |
|------|------------|
| Count | 13 (热门/捕鱼/电子/棋牌/真人/体育/彩票/电竞/斗鸡/区块链/试玩/最近/收藏) |
| Layout | Horizontal scroll, each 72x72px |
| Icon style | Green circle bg (#0AB76B, 44px diameter) with white icon inside |
| Active | Text turns green, no background fill on tab |
| Click | Scrolls to corresponding platform section |

### 6. Game Platform Sections (9)

| Platform | Cards | Grid |
|----------|-------|------|
| Hot Games | 15 | 3-col |
| Fishing | 12 | 2-col |
| Slots | 12 | 2-col |
| Chess/Card | 10 | 2-col |
| Live Casino | 12 | 2-col |
| Sports | 6 | 2-col |
| Lottery | 4 | 2-col |
| Esports | 2 | 2-col |
| Cockfight | 1 | 2-col |
| Blockchain | 2 | 2-col |

Each section:
- Title row: icon + name + "全部 >" (hot section has arrow buttons)
- Game cards with fav star overlay
- "加载更多" button

### 6k. Hot Games Scroll

| Item | Description |
|------|------------|
| Rows | 2 (first row forward, second row reverse) |
| Speed | 30s per loop |
| Card size | 100x134px each |
| Loop | Duplicated for seamless infinite scroll |

### 7. Promo Banners

| Item | Description |
|------|------------|
| Count | 9 |
| Layout | Horizontal scroll, 280px each |
| Border radius | 10px |

### 8. Footer

| Item | Description |
|------|------------|
| 3-column links | 娱乐城(10) + 游戏(11) + 支持(3) = 24 links |
| Compliance | 18+ icon + self-ban link |
| Contact | 2 Telegram contacts |

### 9. Tab Bar

| Tab | Icon | Description |
|-----|------|------------|
| 更多 | Hamburger SVG | Opens left drawer |
| 首页 | Home SVG | Default active (green) |
| 登录 | Login SVG | -- |
| 注册 | Register SVG | -- |
| 我的 | Profile SVG | -- |

### 10. Left Drawer

| Item | Description |
|------|------------|
| Trigger | Hamburger menu OR "更多" tab |
| Width | 283px |
| Header | Green gradient (#0AB76B -> #076b3e -> #212430) |
| Share banner | Green gradient card "分享赚钱" |
| Promo row | Blue "优惠中心" + Red "立即分享" |
| Expandable | 娱乐城 (5 sub), 支持中心 (3 sub) |
| Language | 简体中文 selector |
| Close | Click backdrop area |

## Freeze Mode (?freeze=true)

| Feature | Normal | Frozen |
|---------|--------|--------|
| Marquee | Horizontal scroll | Static text |
| Winner ticker | Auto scroll | Fixed 3 cards |
| Hot games scroll | Auto scroll | Stopped |
| Jackpot counter | +random every 3s | Fixed 10,702,017 |
| CSS animations | Playing | animation-play-state: paused |
| CSS transitions | Normal | transition: none |
