# DOM Structure Analysis -- Joy Green V1

> Page HTML structure and hierarchy

## Page Overview

```
body
├── .page (max-width: 450px, main container)
│   ├── header.header (50px, #212430 bg)
│   │   ├── .header-left
│   │   │   ├── .header-hamburger (trigger drawer)
│   │   │   ├── img.header-logo
│   │   │   └── .header-brand-text (GAMING + www.188.com)
│   │   └── .header-right
│   │       ├── button.header-btn-register (green filled)
│   │       └── button.header-btn-login (green outlined)
│   │
│   ├── section.jackpot-section (98px, JACKPOT)
│   │   └── .jackpot-content
│   │       └── .jackpot-number#jackpotNumber
│   │
│   ├── .marquee-bar (32px)
│   │   ├── .marquee-icon (SVG speaker)
│   │   └── .marquee-content
│   │       └── span.marquee-text
│   │
│   ├── .search-bar (search below marquee)
│   │   ├── svg.search-bar-icon
│   │   └── span.search-bar-placeholder
│   │
│   ├── section.winner-section (84px, sky-blue gradient)
│   │   ├── .winner-section-bg (CSS gradient + img fallback)
│   │   └── .winner-scroll-wrap
│   │       └── .winner-scroll#winnerScroll (JS populated)
│   │           └── .winner-card x N
│   │
│   ├── .category-tabs (13 tabs, horizontal scroll)
│   │   └── .category-tab x 13
│   │       ├── .cat-icon-wrap (green circle 44px)
│   │       │   └── img
│   │       └── span (label)
│   │
│   ├── .platform-section-wrapper x 10 (9 categories + hot scroll)
│   │   ├── .platform-header
│   │   │   ├── .platform-header-left (icon + title)
│   │   │   └── .platform-header-right (all + arrows)
│   │   ├── .platform-subtitle
│   │   └── .game-grid-3col / .game-grid-2col
│   │       └── .game-card-border x N
│   │           ├── .game-card-fav (star)
│   │           └── .game-card-name > h4
│   │
│   ├── .hot-games-container x 2 (two-row scroll)
│   │   └── .hot-games-track
│   │       └── .game-card-border x N (100x134)
│   │
│   ├── .promo-banners (9 activity banners)
│   │   └── .promo-banner-card x 9
│   │
│   ├── .payment-methods
│   │   └── .payment-icons > .pay-icon x 7
│   │
│   └── footer.footer
│       ├── nav.footer-links.footer-nav (3-column grid)
│       │   ├── .footer-col.footer-nav-group (娱乐城, 10 links)
│       │   ├── .footer-col.footer-nav-group (游戏, 11 links)
│       │   └── .footer-col.footer-nav-group (支持, 3 links)
│       ├── .footer-license.footer-compliance
│       │   ├── span (牌照合规)
│       │   ├── img (18plus.avif)
│       │   └── a.self-ban (自我禁止)
│       └── .footer-contact
│           ├── h4 (联系我们)
│           └── .footer-contact-items
│               ├── .footer-contact-item (telegram 专员)
│               └── .footer-contact-item (telegram 客服)
│
├── .more-drawer-backdrop#drawerBackdrop (fixed, left drawer)
│   └── .more-drawer (283px wide, #292D3B bg)
│       ├── .drawer-header (green gradient)
│       │   ├── .drawer-header-title
│       │   └── .drawer-header-login (avatar + text + arrow)
│       ├── .drawer-banner-area
│       │   ├── .drawer-share-banner (green)
│       │   └── .drawer-promo-row
│       │       ├── .drawer-promo-card.blue (优惠中心)
│       │       └── .drawer-promo-card.red (立即分享)
│       ├── .drawer-menu-card (娱乐城, expandable)
│       ├── .drawer-menu-card (支持中心, expandable)
│       ├── .drawer-menu-card (简体中文)
│       └── .more-drawer-sub x 2 (hidden, E2E)
│
├── nav.tab-bar (fixed, 87.6px)
│   ├── .tab-item (更多) ← opens drawer
│   ├── .tab-item.active (首页)
│   ├── .tab-item (登录)
│   ├── .tab-item (注册)
│   └── .tab-item (我的)
│
└── <script> (IIFE)
```

## Game Platform Grid Structure

### Hot Games (3-col)
```
┌──────────┬──────────┬──────────┐
│ Game 1   │ Game 2   │ Game 3   │
│ 133:178  │ 133:178  │ 133:178  │
├──────────┼──────────┼──────────┤
│ Game 4   │ Game 5   │ Game 6   │
│ ...      │ ...      │ ...      │
└──────────┴──────────┴──────────┘
```

### Platform Games (2-col)
```
┌─────────────────┬─────────────────┐
│ Platform 1      │ Platform 2      │
│ 133:178         │ 133:178         │
├─────────────────┼─────────────────┤
│ Platform 3      │ Platform 4      │
│ ...             │ ...             │
└─────────────────┴─────────────────┘
```

## z-index Levels

| z-index | Element |
|---------|---------|
| 200 | Tab Bar |
| 180 | More Drawer Backdrop |
| 100 | Header |
| 1 | Page container |
