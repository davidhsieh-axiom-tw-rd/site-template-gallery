# Typography

> Font size and text style specifications for joy-teal-v1.

## Font Stack

```css
font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC',
             'Hiragino Sans GB', 'Microsoft YaHei', Roboto, sans-serif;
```

## Base Settings

| Property | Value | CSS Variable | Notes |
|----------|-------|-------------|-------|
| Base font size | `16px` | `html { font-size: 16px }` | Root rem base |
| Line height | `1.3` | `body { line-height: 1.3 }` | Global default |
| Text rendering | `auto` | `-webkit-text-size-adjust: 100%` | Prevent mobile scaling |

## Text Styles

### Headings & Titles

| Element | Size | Weight | Color | Usage |
|---------|------|--------|-------|-------|
| Section title | 21.6px | 600 | `#FFFFFF` | Game category headers |
| Footer heading | 16.8px | 600 | `#FFFFFF` | Footer section titles |
| Brand name | 14px | 700 | `#FFFFFF` | Header "GAMING" text |

### Body Text

| Element | Size | Weight | Color | Usage |
|---------|------|--------|-------|-------|
| Marquee text | 14.4px | 400 | `#FFFFFF` | Scrolling announcement |
| Tab label | 14.4px | 500/600 | `#FFFFFF` / `#12BB00` | Tab bar labels |
| Button text | 13px | 600 | `#FFFFFF` | Login/Register buttons |
| Game card name | 13px | 700 | `#FFFFFF` | Game name overlay |
| "See more" text | 13px | 400 | `rgba(162,163,165,1)` | Platform header right |

### Small Text

| Element | Size | Weight | Color | Usage |
|---------|------|--------|-------|-------|
| Footer link | 12px | 400 | `rgba(255,255,255,0.5)` | Footer navigation links |
| Drawer item | 12px | 400 | `#e0e0e0` | Drawer menu labels |
| Contact label | 12px | 400 | `rgba(162,163,165,1)` | Telegram labels |
| Brand URL | 10px | 400 | `rgba(162,163,165,1)` | Header "www.188.com" |

### Special Text

| Element | Size | Weight | Font | Color | Usage |
|---------|------|--------|------|-------|-------|
| Jackpot number | 26px | 900 | Georgia, serif | `#b71c1c` | Jackpot counter |

## Letter Spacing

| Element | Value | Usage |
|---------|-------|-------|
| Brand name | `2px` | Header "GAMING" |
| Jackpot number | `5px` | Jackpot digits |
| Brand URL | `0.5px` | Header URL |
