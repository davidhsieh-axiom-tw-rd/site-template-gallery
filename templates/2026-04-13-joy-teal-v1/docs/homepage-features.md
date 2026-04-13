# Homepage Features

> Interactive features and behaviors documentation.

## 1. Freeze Mode

**Trigger**: Append `?freeze=true` to URL.

**Effects**:
- All CSS animations paused (`animation-play-state: paused`)
- All CSS transitions disabled (`transition: none`)
- Marquee text becomes static
- Jackpot counter stops incrementing
- Hot games scroll stops (if enabled)

**Implementation**:
```javascript
var FREEZE_MODE = urlParams.get('freeze') === 'true';
if (FREEZE_MODE) {
  document.body.classList.add('freeze-mode');
  document.documentElement.style.setProperty('--animation-state', 'paused');
}
```

## 2. Jackpot Counter

- **Initial value**: 8,036,348
- **Update interval**: 3 seconds
- **Increment**: Random 1-50 per tick
- **Format**: Locale string with commas
- **Disabled in**: Freeze mode

## 3. Marquee Scrolling

- **Speed**: 20s per cycle
- **Direction**: Right to left
- **Content**: Announcement text with emoji
- **CSS animation**: `marquee-scroll` keyframe

## 4. Banner Carousel

- **Type**: Horizontal scroll (native)
- **Card width**: 90% of container
- **Snap**: None (free scroll)
- **Scrollbar**: Hidden

## 5. Drawer Menu

**Trigger**: Hamburger icon (header right) or Tab Bar "更多"

**Behavior**:
- Slides in from left (80% width)
- Dark semi-transparent backdrop on right 20%
- Click backdrop to close
- Click close button (X) to close
- Menu items scroll to corresponding sections

**Content Structure**:
1. Logo + close button
2. Action buttons (找回余额 / 提现)
3. Promo banner (送66%存款)
4. Tab row (娱乐城/优惠中心/支持中心/个人中心)
5. Category items (13 categories)
6. E2E hidden sub-menus

## 6. Tab Bar

**Tabs**: 娱乐城 / 游戏 / 支持

**Behavior**:
- Click to switch active state (green highlight + glow)
- Down-arrow button at top to hide/show tab bar

**Active State**:
- Icon fill: `#12BB00`
- Text color: `#12BB00`
- Radial glow effect behind icon

## 7. Game Card Interactions

- **Favorite star**: Top-right corner, tap to toggle (visual only)
- **Card tap**: Navigate to game (placeholder)
- **Load more**: Button below each section grid

## 8. Drawer Category Navigation

Clicking a category in the drawer:
1. Closes the drawer
2. Waits 300ms for close animation
3. Scrolls to the corresponding platform section

Category-to-section mapping:
| Drawer Item | Target Section |
|------------|---------------|
| 热门 | `#platform-hot` |
| 捕鱼 | `#platform-fish` |
| 电子 | `#platform-slot` |
| 棋牌 | `#platform-chess` |
| 真人 | `#platform-live` |
| 体育 | `#platform-sport` |
| 彩票 | `#platform-lottery` |
| 电竞 | `#platform-esport` |
| 斗鸡 | `#platform-cockfight` |
| 区块链 | `#platform-blockchain` |
