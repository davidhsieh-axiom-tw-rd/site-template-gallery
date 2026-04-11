# DOM Structure Analysis -- Joy Navy V1

> Page HTML structure and hierarchy

## Page Overview

```
body
+-- .page (max-width: 450px, main container)
|   +-- header.header (68px, #1A2C38 bg)
|   |   +-- .header-left
|   |   |   +-- img.header-logo (44px height)
|   |   +-- .header-right
|   |       +-- button.header-btn-login (grey border outlined)
|   |       +-- button.header-btn-register (blue filled #1475E1)
|   |
|   +-- section.jackpot-section (98px, JACKPOT)
|   |   +-- .jackpot-content
|   |       +-- .jackpot-number#jackpotNumber
|   |
|   +-- .marquee-bar (36px)
|   |   +-- .marquee-icon (speaker AVIF)
|   |   +-- .marquee-content
|   |   |   +-- span.marquee-text
|   |   +-- .marquee-mail (envelope icon + badge)
|   |
|   +-- section.winner-section (84px, navy gradient)
|   |   +-- .winner-section-bg (CSS gradient)
|   |   +-- .winner-scroll-wrap
|   |       +-- .winner-scroll#winnerScroll (JS populated)
|   |           +-- .winner-card x N
|   |
|   +-- .category-tabs (14 tabs, horizontal scroll)
|   |   +-- .category-tab x 14
|   |       +-- .cat-icon-wrap (blue rounded square 48px, 12px radius)
|   |       |   +-- img
|   |       +-- span (label)
|   |
|   +-- .platform-section-wrapper x 11
|   |   +-- #platform-hot (Hot Games)
|   |   |   +-- .platform-header
|   |   |   |   +-- .platform-header-left (icon + title)
|   |   |   |   +-- .platform-header-right (all + arrow buttons)
|   |   |   +-- .game-grid-3col
|   |   |   |   +-- .game-card-border x 22
|   |   |   |       +-- .game-card-fav (star)
|   |   |   |       +-- .game-card-name > h4
|   |   |   +-- .platform-subtitle
|   |   |   +-- button.load-more-btn
|   |   |
|   |   +-- #platform-fish (Fishing) .. #platform-blockchain
|   |       +-- .platform-header
|   |       |   +-- .platform-header-left (icon + title)
|   |       |   +-- .platform-header-right (all >)
|   |       +-- .platform-banner-list
|   |       |   +-- .platform-banner-card x N
|   |       |       +-- .banner-label > h4
|   |       +-- button.load-more-btn
|   |
|   |   +-- #platform-provider (Game Providers)
|   |       +-- .provider-banner-list
|   |           +-- .provider-banner-card x 3
|   |               +-- img
|   |
|   +-- footer.footer
|       +-- nav.footer-links.footer-nav (3-column grid)
|       |   +-- .footer-col.footer-nav-group (entertainment, 10 links)
|       |   +-- .footer-col.footer-nav-group (games, 11 links)
|       |   +-- .footer-col.footer-nav-group (support, 3 links)
|       +-- .footer-license.footer-compliance
|       |   +-- span (compliance text)
|       |   +-- img (18plus.avif)
|       |   +-- a.self-ban (SVG + text)
|       +-- .footer-contact
|           +-- h4 (contact us)
|           +-- .footer-contact-items
|               +-- .footer-contact-item (telegram)
|
+-- .more-overlay-backdrop#moreOverlayBackdrop (fixed, overlay)
|   +-- .more-overlay#moreOverlayPanel
|       +-- .more-overlay-title (entertainment)
|       +-- .more-overlay-grid
|           +-- .more-overlay-item x 11
|               +-- .more-icon > img
|               +-- span.more-label
|
+-- nav.tab-bar (fixed, 78px)
|   +-- .tab-item (browse)
|   +-- .tab-item.active (casino)
|   +-- .tab-item (promo)
|   +-- .tab-item (support)
|   +-- .tab-item (profile)
|
+-- <script> (IIFE)
```

## Game Platform Sections Structure

### Hot Games (3-col grid)
```
+----------+----------+----------+
| Game 1   | Game 2   | Game 3   |
| 133:178  | 133:178  | 133:178  |
+----------+----------+----------+
| Game 4   | Game 5   | Game 6   |
| ...      | ...      | ...      |
+----------+----------+----------+
```

### Platform Banner Cards (full-width vertical list)
```
+------------------------------------+
| Platform Banner 1 (full-width, 80px)|
| background-image + gradient overlay |
| +-- .banner-label > h4             |
+------------------------------------+
| Platform Banner 2                   |
+------------------------------------+
| ...                                 |
+------------------------------------+
```

## Platform Sections Summary

| Section | ID | Card Type | Card Count |
|---------|-----|-----------|------------|
| Hot Games | platform-hot | game-card-border (3-col) | 22 |
| Fishing | platform-fish | platform-banner-card | 6 |
| Slots | platform-slot | platform-banner-card | 6 |
| Providers | platform-provider | provider-banner-card | 3 |
| Chess/Card | platform-chess | platform-banner-card | 6 |
| Live Casino | platform-live | platform-banner-card | 6 |
| Sports | platform-sport | platform-banner-card | 6 |
| Lottery | platform-lottery | platform-banner-card | 4 |
| Esports | platform-esport | platform-banner-card | 2 |
| Cockfight | platform-cockfight | platform-banner-card | 1 |
| Blockchain | platform-blockchain | platform-banner-card | 2 |

## z-index Levels

| z-index | Element |
|---------|---------|
| 500 | More Overlay Backdrop |
| 200 | Tab Bar |
| 100 | Header |
| 1 | Page container |
