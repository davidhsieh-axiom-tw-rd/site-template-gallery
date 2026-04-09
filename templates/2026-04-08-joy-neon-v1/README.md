# Joy Neon V1

开元棋牌首頁 - 霓虹藍主題（深海軍藍 + 亮藍按鈕 + 森林 header）

## 版型特色

- 深海軍藍背景搭配亮藍色（#0A69FF）主色調
- 頂部森林剪影背景圖
- JACKPOT 動態數字計數器
- 7 個遊戲分類的 2 列 Grid 佈局
- 底部 Tab Bar 含突出式存款按鈕
- 28 項「更多」選單 Overlay

## 啟動方式

```bash
cd templates/2026-04-08-joy-neon-v1
python3 -m http.server 8080
```

瀏覽器開啟 http://localhost:8080

### 凍結模式

在 URL 加上 `?freeze=true` 可停止所有動畫，固定數據顯示：

```
http://localhost:8080?freeze=true
```

## 檔案結構

```
2026-04-08-joy-neon-v1/
├── index.html          # 單一 HTML（CSS/JS 全 inline）
├── metadata.json       # 版型中繼資料
├── README.md           # 本檔案
├── screenshot.png      # 截圖
├── assets/
│   ├── bg/             # 背景圖
│   ├── games/          # 遊戲圖片
│   │   └── platforms/  # 平台圖標
│   ├── icons/          # UI 圖標
│   └── ui/             # Logo、Telegram 等
└── docs/
    ├── flutter-token-mapping.md
    ├── flutter-conversion-guide.md
    ├── typography.md
    ├── structure-analysis.md
    ├── homepage-features.md
    └── assets-inventory.json
```

## 色彩方案

| 用途 | 色值 |
|------|------|
| 主色 | #0A69FF |
| 綠色強調 | #09CF31 |
| 紅色強調 | #F8544B |
| 橘金強調 | #FFAA09 |
| 背景 | #061325 |
| 卡片背景 | #1E2A39 |
