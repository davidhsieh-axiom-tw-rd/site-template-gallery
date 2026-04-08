# Typography 文字樣式表 — Joy Warm V1

> 從原站暖色主題 computed style 提取的完整文字規格
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
| 登入按鈕 | `.btn-login` | 14.4px | 600 | 2px | #FFFFFF | 背景圖 btn_topnav_dl.avif |
| 註冊按鈕 | `.btn-register` | 14.4px | 600 | 2px | #FFFFFF | 背景圖 btn_topnav_zc.avif |

### 跑馬燈

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 公告文字 | `.marquee-text` | 12px | 400 | 0 | #F5C5A8 | 次要文字色 |
| Badge 數字 | `.marquee-badge` | 9px | 600 | 0 | #FFFFFF | 紅色背景 |

### 中獎輪播

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 遊戲名/玩家名 | `.winner-card-info` | 11px | 400 | 0 | #F5C5A8 | 次要文字色 |
| 中獎金額 | `.winner-card-info .highlight` | 11px | 600 | 0 | #FFBB00 | 金色高亮 |

### 遊戲分類標籤

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 標籤文字（未選中）| `.category-tab` | 13px | 500 | 0 | #F5C5A8 | 次要色 |
| 標籤文字（選中）| `.category-tab.active` | 13px | 600 | 0 | #FF6F00 | 橘色主色 |

### 區塊標題

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| Section 標題 | `.section-title` | 16.8px | 600 | 0 | #FFFFFF | 白色 |
| 🔥 icon | `.section-title .icon` | 18px | — | 0 | — | Emoji |

### 遊戲卡片

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 遊戲名稱 | `.game-card-name` | 14.4px | 400 | 0 | #FFFFFF | 白色，單行截斷 |

### 側邊欄

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 選單項目 | `.more-drawer-item` | 14.4px | 400 | 0 | #F5C5A8 | 次要文字色 |
| 搜索框 placeholder | `.more-drawer-search input` | 14px | 400 | 0 | #DB9A74 | 弱化文字色 |

### Tab Bar

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| Tab 標籤 | `.tab-item span` | 10px | 500 | 0 | #F5C5A8 | 選中時 #FF6F00 |

### Cookie Banner

| 元素 | class | font-size | font-weight | letter-spacing | color | 備註 |
|------|-------|-----------|-------------|----------------|-------|------|
| 說明文字 | `.cookie-banner-text` | 12px | 400 | 0 | #F5C5A8 | 次要色 |
| 連結文字 | `.cookie-banner-text a` | 12px | 400 | 0 | #FF6F00 | 橘色（可點擊） |
| 確認按鈕 | `.cookie-banner-btn` | 13px | 600 | 0 | #FFFFFF | 橘色背景 |
