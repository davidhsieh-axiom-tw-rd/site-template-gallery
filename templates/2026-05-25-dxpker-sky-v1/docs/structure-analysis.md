# 結構分析

## 11 區塊一覽

```
.page (450px wide, mobile-first)
├── .app-bar              ← App 下載提示（淺藍底）
├── .top-bar              ← 品牌 logo + 客服
├── .hero                 ← Hero banner + 雙贊助
│   └── .hero-sponsors    ← 兩個俱樂部 placeholder
├── .marquee              ← 公告跑馬燈（動畫）
├── .login-card           ← 未登入提示
├── .floating-cs          ← 加值服務專員浮按鈕
├── .hall-grid (2x2)      ← 主功能 grid
│   ├── .hall-texas       ← 德州棋牌大卡（grid-row 1/3）
│   ├── .hall-real        ← 真人卡（含 placeholder portrait）
│   └── .hall-sport       ← 體育卡（含 placeholder portrait）
├── .other-section        ← 其他玩法（4 列 x 2 行）
└── .tab-bar              ← 底部 Tab Bar（fixed）
```

## 動畫元素

| 元素 | 動畫 | 實測位移 |
|------|------|--------|
| `.marquee-text` | `@keyframes marquee-scroll` 28s linear infinite | 2 秒 -58.2px ✓ |

## Z-index 層級

| 元素 | z-index |
|------|--------|
| `.tab-bar` | 100（fixed bottom） |
| `.floating-cs` | 5（absolute over hall-grid） |
| `.placeholder::after` 文字標籤 | inherit |

## 互動行為（原站，未在本版型實作）

- 4 個 Tab 中「活動」/「客服」/「我的」未登入 → 跳 `#/login`
- 「點擊登入」按鈕 → 跳 `#/login`
- Marquee「全部 >」→ 跳公告列表（未實作）
