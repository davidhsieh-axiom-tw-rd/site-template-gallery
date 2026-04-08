# Typography 文字樣式表 — Joy Dark V1

> 從原站暗色主題 computed style 提取的完整文字規格
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
| color | #FFFFFF |

## 逐元素樣式表

### Header

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| Logo | `.header-logo` | — | — | — | — | 圖片 139×42px |
| 登入按鈕 | `.btn-login` | 13px | 600 | 2px | #0E161D | 青色背景 |
| 註冊按鈕 | `.btn-register` | 13px | 600 | 2px | #0E161D | 金黃背景 |

### 跑馬燈

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 公告文字 | `.marquee-text` | 12px | 400 | 0 | #FFFFFF | |

### 熱門遊戲

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 區塊標題 | `.section-title` | 16px | 700 | 0 | #FFFFFF | |
| 遊戲名稱 | `.game-card-name` | 12px | 400 | 0 | #FFFFFF | 單行截斷 |

### 中獎輪播

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 玩家名 | `.winner-name` | 12px | 500 | 0 | #FFFFFF | 白色文字 |
| 遊戲名 | `.winner-game` | 11px | 400 | 0 | #8899AA | 次要色 |
| 金額 | `.winner-amount` | 12px | 600 | 0 | #F5D639 | 金黃色 |

### 遊戲分類

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 分類標題 | `.category-title` | 14px | 600 | 0 | #1EFFD7 | 青色 |
| 「更多」連結 | `.category-more` | 12px | 400 | 0 | #8899AA | 次要色 |
| 遊戲名稱 | `.game-card-name` | 12px | 400 | 0 | #FFFFFF | 單行截斷 |

### Footer

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 區塊標題 | `.footer-nav-group h4` | 14px | 600 | 0 | #FFFFFF | 白色 |
| 連結文字 | `.footer-nav-group a` | 12px | 400 | 0 | #8899AA | 次要色 |
| 版權聲明 | `.footer-copyright` | 11px | 400 | 0 | #556677 | 更暗文字 |

### Tab Bar

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| Tab 標籤 | `.tab-label` | 10px | 500 | 0 | #8899AA | 選中時 #1EFFD7 |
