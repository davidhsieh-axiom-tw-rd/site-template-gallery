# Paosgi Azure V1 — 藍青版 1

> 來源：`https://paosgi.com/`（Nuxt 3 SPA + Cloudflare JS challenge）
> 復刻日期：2026-05-25
> 主色：`#4A8FE7` 中藍漸層

## 快速開始

```bash
cd templates/2026-05-25-paosgi-azure-v1
python3 -m http.server 8282
# 開 http://localhost:8282/（mobile viewport 450x900）
```

## 模式

**完全自製 wireframe + monochromatic illustration**——未下載 paosgi 任何素材。

跟 dxpker-sky-v1 相同 approach：純自製抽象 SVG（monogram logo + 6 遊戲分類 icon + dealer/athlete illustration + hero objects），業界通用遊戲分類名作為 label。

## 結構

7 個 section（mobile-first 450 寬）：

1. **Top bar** — BRAND logo lockup + Sample Tagline + 登入/註冊
2. **Tab nav** — 首頁/彩票/視訊/電子/體育/棋牌/捕魚（橫向滾動）
3. **Hero banner** — 藍漸層 + $ 籌碼 + chip stack illustration + 主視覺標題 + CTA
4. **遊戲大廳** — 6 大分類 3x2 grid（彩票/真人/體育/電子/棋牌/捕魚）+ 中英雙標
5. **熱門遊戲** — 4 個 tab（真人/彩票/電子/體育）+ 3 個 dealer illustration 卡片
6. **APP 下載** — iPhone/Android 雙下載按鈕
7. **Footer** — 關於/合作/客服/條款 + 版權

## Placeholder 區隔（IP 守線）

| Placeholder 位置 | 業務端替換建議 |
|----|----|
| BRAND logo (top bar) | 自有品牌 logo |
| Sample Tagline | 自有 slogan |
| Hero 主視覺標題 + 副標 | 自有主視覺 + 文案 |
| 熱門遊戲 dealer illustration x3 | 自有真人荷官形象 |
| Footer copy | 自有版權資訊 |

## 自製 SVG 清單

所有 SVG 為純自製通用幾何 primitives，**非任何 paosgi 視覺資產衍生**：

| ID | 用途 |
|---|---|
| `#logo-mark` | 圓 + 內菱形 + S 形 monogram |
| `#logo-horizontal` | mark + BRAND wordmark |
| `#ic-lottery` ... `#ic-fishing` | 6 個通用遊戲分類圖 |
| `#il-dealer` / `#il-athlete` | 女性 dealer / 持球運動員 illustration |
| `#ph-hero-objects` | $ 籌碼 + chip stack |
