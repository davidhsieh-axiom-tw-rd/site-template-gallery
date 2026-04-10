# Feature Spec -- Joy Crimson V1

> Detailed behavior description of each section

## Feature List

### 1. Header (66px)

| Item | Description |
|------|------------|
| Logo | AVIF logo image, left side, 38px height |
| Lucky Wheel | Animated WEBP, right side, 48px |
| Search icon | AVIF icon, rightmost, 28px, clickable |
| Background | Semi-transparent deep crimson rgba(19,6,6,0.9) |

### 2. JACKPOT Animation Area (98px)

| Item | Description |
|------|------------|
| Background | cjc1_style_2_bg.webp, contain mode |
| Number | Dark red #b71c1c, serif font, every 3s increment random 1-50 |
| Text effect | text-shadow glow |
| Freeze mode | Stop counting, fixed at 10,702,017 |

### 3. Marquee (38px)

| Item | Description |
|------|------------|
| Background | img_bg_bj.avif image |
| Speaker icon | Left side, gold SVG |
| Text | Horizontal scroll, 20s per loop, #E39197 color |
| Mail icon | Right side with red badge "10" |
| Freeze mode | Stop scroll, static text |

### 4. Winner Ticker (84px)

| Item | Description |
|------|------------|
| Background | winner-bg.avif image |
| Cards | Horizontal auto-scroll, 25s per loop |
| Card content | Game thumbnail + "恭喜 X***XX 中奖 X倍" |
| Card style | Semi-transparent crimson bg with gold border tint |
| Loop | Data duplicated 2x for seamless loop |
| Freeze mode | Stop scroll, show first 3 only |

### 5. Login/Register + Quick Actions

| Item | Description |
|------|------------|
| Login button | 72x30, transparent bg, 1px #FFE44D border, gold text, 6px radius |
| Register button | 72x30, #FFE44D bg, #6F000D text, 6px radius |
| Deposit | icon + "存款" + pink badge "送66%" |
| VIP | icon + "VIP" |
| More | icon + "更多", opens overlay panel |

### 6. Game Area: Sidebar + Content

#### Sidebar (80px)

| Item | Description |
|------|------------|
| Width | 80px fixed |
| Position | Sticky top |
| Items | 13 categories (热门/捕鱼/电子/棋牌/真人/体育/彩票/电竞/斗鸡/区块链/试玩/最近/收藏) |
| Each item | 80x62px, icon (32px) + label (11px) |
| Active | btn_zc3_2.avif background image, gold text |
| Click | Scrolls to corresponding platform section |

#### Hot Games (3-col grid)

| Item | Description |
|------|------------|
| Cards | 15, 1:1 aspect ratio, 3-col grid |
| Card style | 10px radius, fav star overlay, name gradient overlay |
| Below | subtitle + "加载更多" button |

#### Hot Games Scroll

| Item | Description |
|------|------------|
| Speed | 30s per loop |
| Card size | 92x92px each |
| Loop | 8 cards duplicated for seamless infinite scroll |

### 7. Platform Sections (with full-width cards)

Some platform sections include a full-width card (345x135px) at the top:

| Section | Full-width Card | Grid Cards |
|---------|----------------|------------|
| Fishing | 2 (JDB, WG) | 6 |
| Slots | 1 (PG) | 6 |
| Chess | 1 (KY) | 6 |
| Live | 1 (AG) | 6 |
| Sports | 0 | 4 |
| Lottery | 1 (OB) | 3 |
| Esports | 0 | 2 |
| Cockfight | 0 | 1 |
| Blockchain | 0 | 2 |

Full-width card features:
- Background image specific to category (img_bg1_xxx.avif)
- Platform logo on left
- Platform name text
- Mini game thumbnails on right (56x75px)

### 8. Footer

| Item | Description |
|------|------------|
| 3-column links | 娱乐城(10) + 游戏(11) + 支持(3) = 24 links |
| Title color | #FFE44D (gold) |
| Link color | rgba(227,145,151,0.6) |
| Compliance | 18+ icon + self-ban link |
| Contact | 2 Telegram contacts |
| Borders | rgba(255,228,77,0.1) gold tint |

### 9. Tab Bar (95px)

| Tab | Icon | Description |
|-----|------|------------|
| 首页 | icon_btm_home.avif | Default active (gold) |
| VIP | icon_btm_vip.avif | -- |
| Spin | icon_btm_spin.webp | Center, raised (56px), animated |
| 优惠 | icon_btm_promo.avif | -- |
| 我的 | icon_btm_profile.avif | -- |

Background: img_db_dt_btm.avif image

### 10. More Overlay (Bottom Panel)

| Item | Description |
|------|------------|
| Trigger | Quick action "更多" button |
| Style | Bottom overlay panel (not full-page drawer) |
| Header | "更多功能" + close button |
| Grid | 5 columns, 29 items |
| Each item | Icon (36px) + label (10px) |
| Background | #300101 with rounded top corners |
| Close | Click close button or backdrop area |

## Freeze Mode (?freeze=true)

| Feature | Normal | Frozen |
|---------|--------|--------|
| Marquee | Horizontal scroll | Static text |
| Winner ticker | Auto scroll | Fixed 3 cards |
| Hot games scroll | Auto scroll | Stopped |
| Jackpot counter | +random every 3s | Fixed 10,702,017 |
| CSS animations | Playing | animation-play-state: paused |
| CSS transitions | Normal | transition: none |
