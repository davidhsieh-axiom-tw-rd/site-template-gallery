# compare.sh 改進：Perceptual Hash + 分區比對

## 問題描述

原始的 `compare.sh` 僅使用 SSIM (Structural Similarity Index) 做比對，受動態內容影響很大：
- Jackpot 數字每秒變化
- 跑馬燈位置隨時間偏移
- 中獎輪播內容不同

導致即使靜態佈局接近的兩個頁面也只有 ~67% 相似度，無法有效判斷版型是否重複。

## 根本原因分析

SSIM 是逐像素的結構比對，對任何像素差異都很敏感。動態內容（Jackpot 計數器、跑馬燈、輪播）造成的像素差異被 SSIM 視為「結構不同」，但從版型辨識角度這些差異應被忽略或降低權重。

## 解決方案

### 1. compare.sh 改進（`scripts/compare.sh`）

新增三種比對模式：
- **SSIM**：保留原有的結構相似度指標
- **Perceptual Hash**：將兩張圖縮至 256x256 灰階後用 RMSE 比對，對動態內容更寬容（作為主要判定指標）
- **分區比對**：將圖片切成 TOP (0-25%)、MIDDLE (25-70%)、BOTTOM (70-100%) 三段分別比對

輸出格式更新為包含所有指標，STATUS 改用 PERCEPTUAL 作為主要判定（閾值 90%）。

### 2. verify-quality.sh 改進（`scripts/verify-quality.sh`）

新增 4 區品質報告：Header (0-15%)、Jackpot (15-25%)、Game Grid (25-70%)、Footer (70-100%)，標記需要精修的區塊，並建議優先修正得分最低的區域。

### 3. 新增 update-similarity.sh（`scripts/update-similarity.sh`）

用 python3 讀取修改 `templates/registry.json`，更新指定版型的 `similarity` 值。支援目錄名稱或完整路徑作為輸入。

### 4. capture-and-compare.sh 修正（`scripts/capture-and-compare.sh`）

更新解析邏輯，從 `grep "^SIMILARITY:"` 改為 `grep "^PERCEPTUAL:"`，配合 compare.sh 新輸出格式。

## 驗證方式

```bash
# 語法檢查
bash -n scripts/compare.sh
bash -n scripts/verify-quality.sh
bash -n scripts/update-similarity.sh
bash -n scripts/capture-and-compare.sh

# 功能測試：同一張圖比對自己應得 100%
./scripts/compare.sh templates/2026-04-07-joy-blue-v1/screenshot.png templates/2026-04-07-joy-blue-v1/screenshot.png

# update-similarity 更新與錯誤處理
./scripts/update-similarity.sh 2026-04-07-joy-blue-v1 85
./scripts/update-similarity.sh nonexistent-template 50  # 應報錯

# verify-quality 分區報告
./scripts/verify-quality.sh templates/2026-04-07-joy-blue-v1 templates/2026-04-07-joy-blue-v1/screenshot.png
```
