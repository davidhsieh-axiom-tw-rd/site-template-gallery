# Navy V1 — 分類 Icon _1 後綴與 CSS 量測教訓

## 日期
2026-04-11

## 問題描述
Joy Navy V1（綜合版7，skin 60-1-1）復刻後，分類 Tab 相似度僅 75%，整體靜態區域平均 89%，未達 90% 目標。

### 現象
- 分類 tab icon 風格與原站明顯不同（我們用彩色版，原站用扁平線條版）
- Section header icon 同樣使用錯誤風格
- 分類 tab 容器背景色和圓角與原站不符
- Tab 高度不正確（86px vs 原站 68px）

## 根本原因分析

### 1. Icon 檔名後綴差異
原站的分類 tab 和 section header 使用 `_1` 後綴版本的 icon：
- `icon_dtfl_rm_1.avif`（扁平/線條風格）← 原站實際使用
- `icon_dtfl_rm.avif`（彩色/填充風格）← 我們錯用的版本

CDN 路徑：`/siteadmin/skin/lobby_asset/60-1-common/common/_sprite/icon_dtfl_*_1.avif`

### 2. 分類 Tab CSS 差異
| 屬性 | 原站 | 我們（修正前） |
|------|------|---------------|
| 容器 background | `#0F212E` (--skin-bg-2) | `#1A2C38` (--skin-bg-1) |
| 容器 border-radius | 12px | 無 |
| 容器 padding | 0 | 12px 8px 6px |
| Tab width | 77px | 64px |
| Tab height | 68px (border-box) | 68px (content-box → 實際 86px) |
| Icon 尺寸 | 31x24px | 36x36px |
| 文字 font-size | 14.4px | 12px |
| 文字 color | #B1BAD3 (--skin-neutral-1) | #6F7D91 (--skin-neutral-2) |

### 3. Section header 格式不一致
原站所有 section 的右側都有 `< >` 箭頭按鈕，我們只有熱門區有，其他用 `全部 >` 文字。

## 解決方案

### 修改檔案
| 檔案 | 修改內容 |
|------|---------|
| `index.html` CSS | 分類 tab 容器、tab 項目、icon 尺寸、文字樣式 |
| `index.html` HTML | 13 個分類 tab icon + 11 個 section header icon 改用 `_1` 版本 |
| `index.html` HTML | 10 個 section header-right 改用統一箭頭格式 |
| `assets/icons/` | 新增 14 個 `_1` 後綴 icon 檔案 |

### 關鍵修正
```css
/* 分類 tab 容器 */
.category-tabs {
  background: var(--skin-bg-2);  /* 從 --skin-bg-1 改 */
  border-radius: 12px;           /* 新增 */
  padding: 0;                    /* 從 12px 8px 6px 改 */
}

/* Tab 項目 */
.category-tab {
  width: 77px;                   /* 從 64px 改 */
  box-sizing: border-box;        /* 新增，確保 padding 包含在 height 內 */
  padding: 3.6px 6px 6px;        /* 新增 */
}

/* Icon 尺寸 */
.cat-icon-wrap img {
  width: 32px; height: 24px;     /* 從 36x36 改 */
}

/* 文字 */
.category-tab span {
  font-size: 14px;               /* 從 12px 改 */
  color: var(--skin-neutral-1);  /* 從 --skin-neutral-2 改 */
}
```

## 驗證結果

| 分段 | 修正前 | 修正後 |
|------|--------|--------|
| Header | 97.1% | 94.7% |
| CategoryTabs | **75.0%** | **93.3%** |
| TabBar | 94.3% | 94.9% |
| 靜態區域平均 | 89% | **94.3%** |
| E2E | 34/34 PASS | 34/34 PASS |

## 經驗法則

1. **原站 icon 一定要檢查是否有 `_1` 後綴版本** — `_1` 通常是扁平/線條風格，無後綴是彩色/填充風格。不同 skin 可能用不同版本。
2. **`box-sizing: border-box` 必須顯式設定** — 原站框架自帶 border-box，復刻版沒有，會導致 padding 撐開實際高度。
3. **所有量測都要用 `getComputedStyle`** — 不能用截圖目測，特別是 font-size、padding、background-color。
4. **Section header 格式要統一** — 從原站 snapshot 確認所有 section 的右側結構是否一致。
5. **分類 tab 的 sidebar drawer 和 section header 可能用不同風格的 icon** — sidebar drawer 通常用彩色版（沒有 `_1`），category tabs 和 section headers 用扁平版（`_1`）。
