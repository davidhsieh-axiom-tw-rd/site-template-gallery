# DOM 結構分析 — Joy Red V1

> 頁面 HTML 結構與層級關係

## 頁面總覽

```
body
├── .page (max-width: 450px, 主容器)
│   ├── header.header (50px, 深黑背景)
│   │   ├── .header-left
│   │   │   ├── .header-hamburger (漢堡選單, 觸發 drawer)
│   │   │   └── img.header-logo
│   │   └── .header-right
│   │       └── img.header-search (27x27)
│   │
│   ├── section.jackpot-section (120px, JACKPOT)
│   │   ├── .jackpot-bg
│   │   │   └── img (jackpot-bg.webp)
│   │   └── .jackpot-content
│   │       └── .jackpot-number#jackpotNumber
│   │
│   ├── .marquee-bar (32px, 跑馬燈)
│   │   ├── .marquee-icon (SVG 喇叭)
│   │   └── .marquee-content
│   │       └── span.marquee-text
│   │
│   ├── .auth-section (註冊/登入)
│   │   ├── button.btn-register (灰 #303030)
│   │   └── button.btn-login (紅 #D03434)
│   │
│   ├── section.winner-section (84px, 中獎輪播)
│   │   ├── .winner-section-bg
│   │   │   └── img (winner-bg.webp)
│   │   └── .winner-scroll-wrap
│   │       └── .winner-scroll#winnerScroll (JS 填充)
│   │           └── .winner-card × N
│   │
│   ├── .category-tabs (13 分類 Tab, 橫排捲動)
│   │   └── .category-tab × 13 (72x72, 含 icon + 文字)
│   │
│   ├── .platform-section-wrapper × 10 (遊戲平台區)
│   │   ├── .platform-header
│   │   │   ├── .platform-header-left (icon + 標題)
│   │   │   └── .platform-header-right (更多 >)
│   │   └── .game-grid-3col
│   │       └── .game-card-border × N
│   │           ├── img (遊戲圖片)
│   │           └── img.game-card-fav (收藏星)
│   │
│   ├── .promo-banners (10 張活動圖, 橫排捲動)
│   │   └── .promo-banner-card × 10
│   │
│   └── footer.footer
│       ├── nav.footer-nav (3-column grid)
│       │   ├── .footer-nav-group (娱乐城, 10 links)
│       │   ├── .footer-nav-group (游戏, 11 links)
│       │   └── .footer-nav-group (支持, 3 links)
│       ├── .footer-compliance
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
│   └── .more-drawer (283px wide)
│       ├── .more-drawer-item (娱乐城, expandable)
│       │   └── .more-drawer-sub (5 sub-items)
│       ├── .more-drawer-item (体育, expandable)
│       │   └── .more-drawer-sub (5 sub-items)
│       └── .more-drawer-item × 14 (功能選單)
│
├── nav.tab-bar (fixed, 87.6px)
│   ├── .tab-item.active (首页)
│   ├── .tab-item (优惠)
│   ├── .tab-item (登录)
│   ├── .tab-item (注册)
│   └── .tab-item (我的)
│
└── <script> (IIFE)
```

## 遊戲平台 Grid 結構

```
┌─────────────────────────────────────┐
│ 8px padding                          │
├──────────┬──────────┬──────────┐    │
│ 遊戲 1   │ 遊戲 2   │ 遊戲 3   │    │
│ (1:1)    │ (1:1)    │ (1:1)    │    │
├──────────┼──────────┼──────────┤    │
│ 遊戲 4   │ 遊戲 5   │ 遊戲 6   │    │
│ (1:1)    │ (1:1)    │ (1:1)    │    │
├──────────┼──────────┼──────────┤    │
│ ...      │ ...      │ ...      │    │
└──────────┴──────────┴──────────┘    │
```

## z-index 層級

| z-index | 元素 |
|---------|------|
| 200 | Tab Bar |
| 180 | More Drawer Backdrop |
| 100 | Header |
| 1 | Page 容器 |
