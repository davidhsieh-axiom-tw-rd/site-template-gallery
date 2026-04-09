# Joy Red V1

开元棋牌首頁 - 紅色主題（深黑背景 + 紅色按鈕 + 金黃強調）

## 版型特色

- 深黑背景 (#161616) 搭配紅色 (#D03434) 主色調
- 13 個遊戲分類 Tab（横排捲動）
- 10 個遊戲平台區，3 列 Grid 佈局
- 左側 Drawer 選單含可展開子選單
- JACKPOT 動態數字計數器
- 底部 Tab Bar: 首页/优惠/登录/注册/我的
- Footer 三欄連結 + 牌照合规 + 联系我们

## 啟動方式

```bash
cd templates/2026-04-09-joy-red-v1
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
2026-04-09-joy-red-v1/
├── index.html          # 單一 HTML（CSS/JS 全 inline）
├── metadata.json       # 版型中繼資料
├── README.md           # 本檔案
├── screenshot.png      # 截圖
├── assets/
│   ├── bg/             # 背景圖
│   ├── games/          # 遊戲圖片
│   │   └── platforms/  # 平台圖標
│   └── icons/          # UI 圖標、Logo、Telegram 等
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
| 主色（紅色） | #D03434 |
| 金黃強調 | #FFAA09 |
| Body 背景 | #161616 |
| Tab Bar 背景 | #212121 |
| Register 按鈕 | #303030 |
