# Flutter Token 對照與 ZIP 匯出完整包

## 問題描述

版型復刻的 HTML 版本完成後，後續需要轉換為 Flutter 或 Figma。但 HTML 中缺少足夠的轉換參考資訊（Flutter Token 命名、精確尺寸、文字樣式、動畫參數等），且匯出功能只下載單一 `index.html`，無法包含轉換所需的完整文件。

## 根本原因分析

1. **HTML 與 Flutter 的設計系統差異大** — Flutter 用 `AppDimen.sizeScaler` 基於 375px 縮放，HTML 用固定 px；Flutter 用 Token 命名（`brandPrimary50`），HTML 用語義化 CSS 變數（`--skin-primary`）
2. **匯出功能過於簡單** — 原本只 fetch + download 單一 HTML 檔，assets 和文件都沒包含
3. **版型文件散落在 `docs/` 全域目錄** — 未來有多個版型時會混在一起

## 解決方案

### 1. 版型目錄結構規範化

每個版型獨立資料夾，包含 `docs/` 子目錄：
```
templates/{id}/
├── README.md              ← 檔案結構說明（新增）
├── index.html             ← 版型（CSS 變數加 Flutter Token 註解）
├── metadata.json
├── screenshot.png
├── assets/
└── docs/                  ← 版型專屬轉換文件
    ├── flutter-token-mapping.md
    ├── flutter-conversion-guide.md
    ├── typography.md
    ├── structure-analysis.md
    ├── homepage-features.md
    └── assets-inventory.json
```

### 2. Flutter Token 對照字典（flutter-token-mapping.md）

完整 8 節對照表：
- 色彩 Token（主色、功能色、漸層）
- 尺寸 Token（元件高度、間距、卡片比例）
- 字體 Token（font-size / weight / letter-spacing / line-height）
- 陰影對照
- 動畫參數
- z-index → Stack 層疊
- Widget 對應表（HTML class → Flutter Widget）
- 佈局差異與轉換決策

**設計原則**：原站色彩為主，Flutter Token 名稱作為變數命名參考，值用原站的。

### 3. HTML CSS 改進

- `:root` 加入完整 Flutter Token 名稱對照註解
- 新增漸層和尺寸 CSS 變數（`--gradient-jackpot-top` 等）
- `body line-height` 從 `1.5` 改 `1.3`（對齊 Flutter `AppTextStyle` 預設）
- 逐元素補齊 `letter-spacing`（含 Flutter TextStyle 註解）

### 4. Gallery 匯出改為 ZIP

- 引入 JSZip CDN（`jszip@3.10.1`）
- 匯出打包：HTML + docs + metadata + screenshot + assets
- 自動從 HTML 中提取 `assets/` 引用（regex: `['"]?(assets\/[^'")\s,<>]+\.\w+)`）
- 不在 HTML 中引用的多餘 assets 不會打包（正確行為）

### 5. 驗證：ZIP 解壓後與 Gallery 100% 一致

- 解壓 ZIP → Python HTTP server → 凍結模式 → 分段截圖
- odiff 比對三段（A-top / B-login / C-games）：**全部 Images are identical**
- 確認匯出包完整可用

## 修改的檔案

| 檔案 | 變更 |
|------|------|
| `index.html`（Gallery） | 匯出改 ZIP、JSZip CDN、按鈕文字「匯出 ZIP」、README.md 加入打包清單 |
| `templates/.../index.html` | CSS 變數 Token 註解、漸層/尺寸新變數、line-height 1.3、letter-spacing 補齊 |
| `templates/.../README.md` | **新增** — 檔案結構說明 |
| `templates/.../docs/flutter-token-mapping.md` | **新增** — 完整 Token 對照字典 |
| `templates/.../docs/flutter-conversion-guide.md` | **更新** — 原站為主原則 + Widget 對應表 |
| `templates/.../docs/typography.md` | **新增** — 逐元素文字樣式表 |
| `templates/.../docs/structure-analysis.md` | 從 `docs/` 複製到版型目錄 |
| `templates/.../docs/homepage-features.md` | 從 `docs/` 複製到版型目錄 |
| `templates/.../docs/assets-inventory.json` | 從 `docs/` 複製到版型目錄 |

## 驗證方式

```bash
# 1. Gallery 匯出 ZIP
# 瀏覽器點「匯出 ZIP」按鈕

# 2. 解壓並起 HTTP server
unzip Joy-Blue-V1.zip -d /tmp/test/
cd /tmp/test/2026-04-07-joy-blue-v1/
python3 -m http.server 8080

# 3. 凍結模式截圖比對
# Gallery: http://localhost:9090/templates/.../index.html?freeze=true
# ZIP:     http://localhost:8080?freeze=true
# odiff 三段比對應全部 "Images are identical"
```

## E2E 測試腳本

建立了可複用的 `scripts/e2e-verify.sh`，每次交付前必跑：

```bash
./scripts/e2e-verify.sh                        # 測試所有版型
./scripts/e2e-verify.sh 2026-04-07-joy-blue-v1 # 測試指定版型
```

### 測試清單（20 項）

| # | 測試 | 說明 |
|---|------|------|
| T1 | Gallery 頁面載入 | HTTP 200 + registry.json + JSZip CDN |
| T2 | 版型頁面載入 | 正常模式 + 凍結模式 + metadata.json + screenshot.png |
| T3 | ZIP 匯出完整性 | 10 個必要檔案 + assets 非空 + HTML 引用 assets 對應 + Flutter Token 註解 + line-height 1.3 + Token 對照表 8/8 節 + README 快速開始 |
| T4 | ZIP 解壓可渲染 | Python HTTP server + 凍結模式 + 所有 assets HTTP 可存取 |
| T5 | 分段截圖一致性 | HTML 原始碼 diff + Assets MD5 + Playwright MCP 視覺比對（odiff identical） |

### macOS 相容注意

- 不能用 `grep -P`（PCRE），macOS 不支援，改用 `grep -oE`
- Playwright 不在全域 node_modules，視覺截圖比對用 Playwright MCP 另外做
- `zip` 指令打包時用 `-x ".*"` 排除隱藏檔

## 關鍵教訓

1. **每個版型必須獨立資料夾** — 文件、assets、metadata 全部自包含，不依賴外部路徑
2. **匯出必須包含完整參考文件** — 只給 HTML 不夠，轉換者需要 Token 對照和樣式表
3. **asset 打包用 HTML 引用掃描** — 不要打包目錄下所有檔案，只打包 HTML 中實際引用的
4. **凍結模式 + odiff 是驗證匯出完整性的最佳方式** — 確保匯出包在獨立環境下渲染完全一致
5. **原站為主的設計原則很重要** — Flutter Token 名稱用來溝通，但值以原站為準
6. **所有比對都要列入 E2E 測試** — 不是一次性驗證，是可複用的自動化測試，每次交付前必跑
7. **macOS grep 不支援 -P** — 用 `grep -oE` 替代，避免腳本在 macOS 上靜默失敗
