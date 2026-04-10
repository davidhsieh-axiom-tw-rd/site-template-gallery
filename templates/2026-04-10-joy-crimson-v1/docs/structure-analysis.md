# DOM Structure Analysis -- Joy Crimson V1

> Page HTML structure and hierarchy

## Page Overview

```
body
├── .page (max-width: 450px, bg image: img_db_dt_bg.avif)
│   ├── header.header (66px, rgba(19,6,6,0.9))
│   │   ├── .header-left
│   │   │   └── img.header-logo
│   │   └── .header-right
│   │       ├── img.header-lucky-wheel (48px animated)
│   │       └── img.header-search-icon (28px)
│   │
│   ├── section.jackpot-section (98px, cjc1_style_2_bg.webp)
│   │   └── .jackpot-content
│   │       └── .jackpot-number#jackpotNumber
│   │
│   ├── .marquee-bar (38px, img_bg_bj.avif bg)
│   │   ├── .marquee-icon (SVG speaker)
│   │   ├── .marquee-content
│   │   │   └── span.marquee-text
│   │   └── .marquee-mail
│   │       ├── img (icon_mail.avif)
│   │       └── span.badge ("10")
│   │
│   ├── section.winner-section (84px, winner-bg.avif)
│   │   ├── .winner-section-bg > img
│   │   └── .winner-scroll-wrap
│   │       └── .winner-scroll#winnerScroll (JS populated)
│   │           └── .winner-card x N
│   │
│   ├── .auth-actions-bar
│   │   ├── .auth-buttons
│   │   │   ├── button.btn-login (72x30, gold outlined)
│   │   │   └── button.btn-register (72x30, gold filled)
│   │   └── .quick-actions
│   │       ├── .quick-action (存款, +badge "送66%")
│   │       ├── .quick-action (VIP)
│   │       └── .quick-action#quickMoreBtn (更多, opens overlay)
│   │
│   ├── .game-main (flex: sidebar + content)
│   │   ├── .category-sidebar (80px, sticky, 13 items)
│   │   │   └── .sidebar-item x 13
│   │   │       ├── img (category icon)
│   │   │       └── span (label)
│   │   │
│   │   └── .game-content
│   │       ├── .platform-section-wrapper#platform-hot (hot, 3-col grid, 15 cards)
│   │       │   ├── .platform-header
│   │       │   ├── .game-grid-3col > .game-card-border x 15
│   │       │   ├── .platform-subtitle
│   │       │   └── button.load-more-btn
│   │       │
│   │       ├── .hot-games-container (horizontal scroll)
│   │       │   └── .hot-games-track (8+8 duplicated, 92x92)
│   │       │
│   │       ├── .platform-section-wrapper#platform-fish
│   │       │   ├── .platform-header
│   │       │   ├── .platform-card-full x 2 (img_bg1_by.avif)
│   │       │   ├── .game-grid-2col > .game-card-border x 6
│   │       │   └── button.load-more-btn
│   │       │
│   │       ├── .platform-section-wrapper#platform-slot
│   │       │   ├── .platform-card-full (img_bg1_dz.avif)
│   │       │   └── .game-grid-2col x 6
│   │       │
│   │       ├── .platform-section-wrapper#platform-chess
│   │       │   ├── .platform-card-full (img_bg1_qp-zr.avif)
│   │       │   └── .game-grid-2col x 6
│   │       │
│   │       ├── .platform-section-wrapper#platform-live
│   │       │   ├── .platform-card-full (img_bg1_qp-zr.avif)
│   │       │   └── .game-grid-2col x 6
│   │       │
│   │       ├── .platform-section-wrapper#platform-sport (4 cards)
│   │       ├── .platform-section-wrapper#platform-lottery
│   │       │   └── .platform-card-full (img_bg1_cp.avif) + 3 cards
│   │       ├── .platform-section-wrapper#platform-esport (2 cards)
│   │       ├── .platform-section-wrapper#platform-cockfight (1 card)
│   │       └── .platform-section-wrapper#platform-blockchain (2 cards)
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
├── .more-overlay-backdrop#moreOverlayBackdrop (fixed, overlay)
│   └── .more-overlay.more-menu (bottom panel, 5-col grid)
│       ├── .more-overlay-header (更多功能 + close)
│       ├── .more-menu-grid (29 items)
│       │   └── .more-menu-item x 29
│       │       ├── img (icon)
│       │       └── span (label)
│       └── .more-drawer-sub x 2 (hidden, E2E)
│
├── nav.tab-bar (fixed, 95px, img_db_dt_btm.avif bg)
│   ├── .tab-item.active (首页)
│   ├── .tab-item (VIP)
│   ├── .tab-item.spin-tab (Spin) ← raised center
│   ├── .tab-item (优惠)
│   └── .tab-item (我的)
│
└── <script> (IIFE)
```

## Game Area Layout

### Sidebar + Content (flex)
```
┌──────────┬──────────────────────────────┐
│ Sidebar  │ Game Content                 │
│ (80px)   │                              │
│          │ ┌──────────────────────────┐  │
│ [热门]◀  │ │ Hot Games (3-col grid)   │  │
│ [捕鱼]   │ │ 92x92 cards, 15 total   │  │
│ [电子]   │ ├──────────────────────────┤  │
│ [棋牌]   │ │ Hot Scroll (horizontal)  │  │
│ [真人]   │ ├──────────────────────────┤  │
│ [体育]   │ │ Platform Full Card       │  │
│ [彩票]   │ │ (345x135, bg image)      │  │
│ [电竞]   │ ├──────────────────────────┤  │
│ [斗鸡]   │ │ Platform Grid (3-col)    │  │
│ [区块链]  │ │ ...                      │  │
│ [试玩]   │ └──────────────────────────┘  │
│ [最近]   │                              │
│ [收藏]   │                              │
└──────────┴──────────────────────────────┘
```

### Full-width Platform Card
```
┌─────────────────────────────────────────┐
│                                         │
│  [Logo]   ← bg image (img_bg1_xxx)  [G1][G2] │
│  Name                                   │
│                                         │
└─────────────────────────────────────────┘
```

## z-index Levels

| z-index | Element |
|---------|---------|
| 200 | Tab Bar |
| 180 | More Overlay Backdrop |
| 100 | Header |
| 1 | Page container |
