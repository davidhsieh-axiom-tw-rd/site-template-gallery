# Typography 文字樣式表 — Joy Blue V1

> 從原站 computed style 提取的完整文字規格
> 轉換 Flutter 時直接參考此表建立 TextStyle

## Font Family

```
-apple-system, BlinkMacSystemFont, 'Segoe UI', 'PingFang SC',
'Hiragino Sans GB', 'Microsoft YaHei', Roboto, sans-serif
```

Flutter 對應：`PingFang SC, Microsoft YaHei, sans-serif`

## 全局預設

| 屬性 | 值 |
|------|---|
| font-size | 16px |
| line-height | 1.3 |
| color | #333333 |

## 逐元素樣式表

### Header

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 品牌名 | `.header-brand-name` | 18px | 700 (bold) | 1px | #FFFFFF | 白色文字 |
| 站台網址 | `.header-brand-url` | 11px | 400 | 0 | rgba(255,255,255,0.7) | 半透明白 |

### Jackpot 區

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| Jackpot 標籤 | `.jackpot-label` | 12px | 600 | 1px | #FFFFFF | 白色 |
| Jackpot 數字 | `.jackpot-number` | 22.4px (1.4rem) | 900 | 1px | #FFFFFF | italic, serif 字體 |
| Jackpot 幣種 | `.jackpot-currency` | 10px | 600 | 0 | rgba(255,255,255,0.8) | |

### 登入/註冊區

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 登入按鈕 | `.btn-login` | 13px | 500 | 3px | #FFFFFF | 大間距中文 |
| 註冊按鈕 | `.btn-register` | 13px | 500 | 3px | #FFFFFF | 大間距中文 |
| 試玩按鈕 | `.btn-demo` | 13px | 500 | 2px | #003BD5 | 主色文字 |

### 跑馬燈

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 公告文字 | `.marquee-text` | 繼承(16px) | 400 | 0 | #333333 | |

### 中獎輪播

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 玩家名 | `.winner-name` | 13px | 500 | 0 | #333333 | |
| 遊戲名 | `.winner-game` | 12px | 400 | 0 | #666666 | 次要色 |
| 金額 | `.winner-amount` | 13px | 600 | 0 | #EA4E3D | accent 色 |

### 遊戲分類

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 分類名稱 | `.category-item span` | 12px | 400 | 2px | #333333 | 選中時 #003BD5 |
| 分類標題 | `.category-game-title span` | 15px | 600 | 0 | #333333 | |
| 「更多」連結 | `.category-game-title a` | 12px | 400 | 0 | #003BD5 | |

### 遊戲卡片

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 遊戲名稱 | `.game-card-name` | 12px | 400 | 0 | #333333 | 單行截斷 |
| 廠商名 | `.game-card-provider` | 10px | 400 | 0 | #999999 | |

### Footer

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 區塊標題 | `.footer-nav-group h4` | 14px | 600 | 0 | #333333 | |
| 連結文字 | `.footer-nav-group a` | 12px | 400 | 0 | #666666 | |
| 版權聲明 | `.footer-copyright` | 11px | 400 | 0 | #999999 | |

### Tab Bar

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| Tab 標籤 | `.tab-label` | 10px | 500 | 0 | #999999 | 選中時 #003BD5 |
