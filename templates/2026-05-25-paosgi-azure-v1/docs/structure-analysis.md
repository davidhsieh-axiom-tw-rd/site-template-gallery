# 結構分析

7 區塊垂直堆疊（mobile-first，450 wide）：

```
.page
├── .top-bar          (logo + tagline + 登入/註冊)
├── .tab-nav          (7 Tab，橫向 overflow-x:auto)
├── .hero             (160h 漸層 + $ 籌碼 illustration + CTA)
├── .cat-section      (6 分類 3x2 grid)
├── .hot-section      (熱門遊戲 + 4 tab + 3 dealer 卡 + dots)
├── .app-section      (APP 下載藍卡)
└── .footer           (關於 + 連結 + 版權)
```
