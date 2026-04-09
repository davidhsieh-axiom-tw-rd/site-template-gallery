# DOM 結構分析 — Joy Neon V1

> 頁面 HTML 結構與層級關係

## 頁面總覽

```
body
├── .page (max-width: 450px, 主容器)
│   ├── header.header (50px, 透明背景)
│   │   ├── .header-left
│   │   │   └── img.header-logo (139x42)
│   │   └── .header-right
│   │       └── img.header-search (27x27)
│   │
│   ├── .marquee-bar (25px, 圓角半透明)
│   │   ├── .marquee-icon (SVG 喇叭)
│   │   ├── .marquee-content
│   │   │   └── span.marquee-text (跑馬燈)
│   │   └── .marquee-badge-wrap
│   │       ├── img (訊息 icon)
│   │       └── span.marquee-badge ("10")
│   │
│   ├── section.winner-section (84px, 中獎輪播)
│   │   ├── .winner-section-bg
│   │   │   └── img (banner.avif)
│   │   └── .winner-scroll-wrap
│   │       └── .winner-scroll#winnerScroll (JS 填充)
│   │           └── .winner-card × N
│   │               ├── img.winner-card-thumb
│   │               └── span.winner-card-info
│   │
│   ├── .nav-section (50px, 導航)
│   │   ├── .nav-left
│   │   │   ├── button.btn-login
│   │   │   └── button.btn-register
│   │   └── .nav-right
│   │       ├── .nav-icon-item (VIP)
│   │       ├── .nav-icon-item (分享赚钱)
│   │       └── .nav-icon-item#moreNavBtn (更多)
│   │
│   ├── section.jackpot-section (98px, JACKPOT)
│   │   ├── img.jackpot-title (sprite)
│   │   └── .jackpot-number#jackpotNumber
│   │
│   ├── .game-grid (2-column CSS Grid)
│   │   ├── .game-card.tall (热门, span 2 rows)
│   │   │   ├── .game-card-header
│   │   │   ├── .hot-game-showcase
│   │   │   │   ├── img.hot-main-img
│   │   │   │   ├── img.hot-game-fav
│   │   │   │   └── .hot-game-overlay
│   │   │   └── .hot-game-dots (8 dots)
│   │   ├── .game-card (捕鱼)
│   │   ├── .game-card (电子)
│   │   ├── .game-card (棋牌)
│   │   ├── .game-card (真人)
│   │   ├── .game-card (体育)
│   │   └── .game-card (更多)
│   │
│   └── footer.footer
│       ├── nav.footer-nav (3-column grid)
│       │   ├── .footer-nav-group (娱乐城, 10 links)
│       │   ├── .footer-nav-group (游戏, 11 links)
│       │   └── .footer-nav-group (支持, 3 links)
│       ├── .footer-compliance
│       │   ├── span (牌照合规)
│       │   ├── img (18plus.avif)
│       │   └── a.self-ban (自我禁止 + SVG)
│       └── .footer-contact
│           ├── h4 (联系我们)
│           └── .footer-contact-items
│               ├── .footer-contact-item (telegram 专员)
│               └── .footer-contact-item (telegram 客服)
│
├── .more-overlay-backdrop#moreOverlay (fixed overlay)
│   └── .more-overlay (bottom sheet)
│       ├── .more-overlay-header
│       │   ├── span (更多)
│       │   └── .more-overlay-close#moreClose
│       └── .more-grid (5-column, 28 items)
│           └── .more-grid-item × 28
│
├── nav.tab-bar (fixed, 75px)
│   ├── .tab-item.active (首页)
│   ├── .tab-item (优惠)
│   ├── .tab-item.deposit (存款, 突出)
│   ├── .tab-item (提现)
│   └── .tab-item (我的)
│
└── .cs-float (客服浮動按鈕)

<script> (IIFE)
```

## Grid 佈局結構

```
┌──────────────────────────────────┐
│ 12px padding                      │
├──────────┬─────┬──────────┐      │
│          │     │ 捕 鱼    │      │
│  热 门   │ gap │ (118px)  │      │
│ (249px)  │ 12px├──────────┤      │
│  tall    │     │ 电 子    │      │
│          │     │ (118px)  │      │
├──────────┼─────┼──────────┤      │
│ 棋 牌    │     │ 真 人    │      │
│ (118px)  │     │ (118px)  │      │
├──────────┼─────┼──────────┤      │
│ 体 育    │     │ 更 多    │      │
│ (118px)  │     │ (118px)  │      │
└──────────┴─────┴──────────┘      │
```

## z-index 層級

| z-index | 元素 |
|---------|------|
| 200 | Tab Bar |
| 180 | More Overlay Backdrop |
| 150 | 客服浮動按鈕 |
| 100 | Header |
| 1 | Page 容器 |
