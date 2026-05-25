# Typography 字型對應

原站使用字型（從 `performance.getEntriesByType('resource')` 取得）：

| 用途 | 字型檔 |
|------|--------|
| 主中文字型 | PingFangSC-Subset.ttf（蘋方 Subset） |
| 英文 / 數字 | DIN-Regular / DIN-Medium / DIN-Bold / DIN-BlackItalic |
| 副字型 | proxima-nova.ttf |
| Material icons | MaterialIcons-Regular.otf |
| Web fallback | Noto Sans SC / Noto Sans HK（Google Fonts） |

本版型 CSS 字型棧：

```css
font-family: -apple-system, BlinkMacSystemFont, "PingFang SC", "Microsoft YaHei", sans-serif;
```

未綁定 DIN 系列（Gallery 為 UI template，未授權使用 DIN 字型授權檔）。業務端要塞自有字型可在 `<head>` 加 `@font-face` 自行載入。

字級設定：

| 用途 | px |
|------|----|
| 主標題 | 14-15 |
| 副標 | 11-13 |
| Footer / placeholder label | 9-10 |
| Tab Bar label | 10 |
| line-height | 1.3 |
