# Gallery 相似度 Badge 不顯示修復

## 問題描述

Gallery 頁面（index.html）的卡片截圖左上角應顯示相似度 badge（圓形，顯示百分比），但使用者反映看不到。

## 根本原因分析

多個 CSS 因素導致 badge 在視覺上不夠醒目：

1. **尺寸偏小**：原始 44px 直徑在 16:10 的卡片截圖中不夠顯眼
2. **z-index 不足**：`z-index: 2` 雖然在理論上足以覆蓋 img，但在某些瀏覽器渲染中可能被 overlay 層影響
3. **背景色使用 rgba 帶透明度**：在深色截圖上，半透明背景讓 badge 與背景融合，難以辨識
4. **backdrop-filter 相容性**：`backdrop-filter: blur(4px)` 在部分瀏覽器不支援或導致渲染問題
5. **缺少邊框**：沒有對比邊框，badge 和截圖背景缺乏視覺分離

## 解決方案

修改 `/Users/bobo/Projects/joy-homepage-clone/index.html` 中 `.card-similarity` 的 CSS：

| 屬性 | 修改前 | 修改後 | 原因 |
|------|--------|--------|------|
| width/height | 44px | 50px | 符合規格要求 |
| z-index | 2 | 10 | 確保在所有覆蓋層之上 |
| sim-low background | `rgba(225, 112, 85, 0.9)` | `#d63031` | 純色不透明，醒目紅色 |
| sim-mid background | `rgba(253, 203, 110, 0.9)` | `#fdcb6e` | 純色黃底 |
| sim-high background | `rgba(0, 206, 201, 0.9)` | `#00b894` | 純色綠底 |
| sim-pending background | `rgba(100, 100, 130, 0.75)` | `#636e72` | 純色灰底 |
| font-weight | 700 | 800 | 更粗更易讀 |
| backdrop-filter | blur(4px) | 移除 | 避免相容性問題 |
| border | 無 | `2px solid rgba(255, 255, 255, 0.3)` | 白色半透明邊框增加對比 |
| pointer-events | 預設 | none | 避免攔截圖片點擊事件 |

## 驗證方式

1. 訪問 `http://localhost:9090/` 確認 badge 在卡片左上角明顯可見
2. registry.json 中 similarity=75 應顯示紅底白字 "75%"
3. 點擊截圖圖片仍可正常觸發 Lightbox

## Badge 規格速查

| 相似度 | CSS class | 背景色 | 文字色 |
|--------|-----------|--------|--------|
| 95%+ | sim-high | #00b894 (綠) | 白 |
| 90-94% | sim-mid | #fdcb6e (黃) | #222 (深色) |
| <90% | sim-low | #d63031 (紅) | 白 |
| 0/未定義 | sim-pending | #636e72 (灰) | 白，文字「待測量」 |
