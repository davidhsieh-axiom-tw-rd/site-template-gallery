#!/bin/bash
# ============================================================
# verify-quality.sh - 驗證 HTML 復刻與原始截圖的相似度
# 用法: ./scripts/verify-quality.sh <template-dir> [rendered-screenshot]
# 依賴: ImageMagick 7+, Playwright (for HTML rendering)
#
# 輸出分區品質報告，指出哪個區塊需要精修。
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
COMPARE_SCRIPT="$SCRIPT_DIR/compare.sh"
MAGICK="/opt/homebrew/bin/magick"
QUALITY_THRESHOLD=90

# -- Helpers ---------------------------------------------------

usage() {
  echo "用法: $0 <template-dir> [rendered-screenshot]"
  echo ""
  echo "驗證 HTML 復刻品質（含分區報告）："
  echo "  1. 用 Playwright 渲染 template-dir/index.html 並截圖"
  echo "  2. 與 template-dir/screenshot.png (原始截圖) 比對"
  echo "  3. 輸出分區品質分數與精修建議"
  echo ""
  echo "範例:"
  echo "  $0 templates/2026-04-07-joy-blue-v1"
  echo "  $0 templates/2026-04-07-joy-blue-v1 /tmp/rendered.png"
  exit 1
}

check_deps() {
  if [ ! -x "$MAGICK" ]; then
    echo "ERROR: ImageMagick not found at $MAGICK"
    echo "Install: brew install imagemagick"
    exit 1
  fi

  if [ ! -x "$COMPARE_SCRIPT" ]; then
    echo "ERROR: compare.sh not found at $COMPARE_SCRIPT"
    exit 1
  fi
}

# Compute RMSE similarity for a region of two images (by percentage)
compute_region_similarity() {
  local img1="$1"
  local img2="$2"
  local tmpdir="$3"
  local region_name="$4"
  local y_start_pct="$5"
  local y_end_pct="$6"

  local height
  height=$("$MAGICK" identify -format "%h" "$img1")
  local width
  width=$("$MAGICK" identify -format "%w" "$img1")

  local y_start
  y_start=$(echo "$height * $y_start_pct / 100" | bc)
  local seg_height
  seg_height=$(echo "$height * ($y_end_pct - $y_start_pct) / 100" | bc)

  if [ "$seg_height" -lt 1 ]; then
    seg_height=1
  fi

  local seg1="$tmpdir/region_${region_name}_1.png"
  local seg2="$tmpdir/region_${region_name}_2.png"
  local seg_diff="$tmpdir/region_${region_name}_diff.png"

  "$MAGICK" "$img1" -crop "${width}x${seg_height}+0+${y_start}" +repage "$seg1"
  "$MAGICK" "$img2" -crop "${width}x${seg_height}+0+${y_start}" +repage "$seg2"

  # Resize seg2 to match seg1 dimensions
  local seg_dims
  seg_dims=$("$MAGICK" identify -format "%wx%h" "$seg1")
  "$MAGICK" "$seg2" -resize "${seg_dims}!" "$seg2"

  local rmse_raw
  rmse_raw=$("$MAGICK" compare -metric RMSE "$seg1" "$seg2" "$seg_diff" 2>&1 || true)

  local normalized
  normalized=$(echo "$rmse_raw" | grep -oE '\(([0-9.]+)\)' | tr -d '()' || true)

  if [ -z "$normalized" ]; then
    normalized=$(echo "$rmse_raw" | grep -oE '^[0-9.]+' | head -1 || true)
    if [ -n "$normalized" ]; then
      normalized=$(echo "$normalized / 65535" | bc -l)
    fi
  fi

  if [ -z "$normalized" ]; then
    echo "N/A"
    return
  fi

  echo "(1 - $normalized) * 100" | bc -l | xargs printf "%.0f"
}

# -- Main ------------------------------------------------------

if [ $# -lt 1 ]; then
  usage
fi

TEMPLATE_DIR="$1"

# Validate template directory
if [ ! -d "$TEMPLATE_DIR" ]; then
  echo "ERROR: Directory not found: $TEMPLATE_DIR"
  exit 1
fi

INDEX_HTML="$TEMPLATE_DIR/index.html"
SCREENSHOT_ORIG="$TEMPLATE_DIR/screenshot.png"

if [ ! -f "$INDEX_HTML" ]; then
  echo "ERROR: index.html not found in $TEMPLATE_DIR"
  exit 1
fi

if [ ! -f "$SCREENSHOT_ORIG" ]; then
  echo "ERROR: screenshot.png (original) not found in $TEMPLATE_DIR"
  exit 1
fi

check_deps

TEMPLATE_NAME=$(basename "$TEMPLATE_DIR")

echo "========================================"
echo " Quality Verification"
echo "========================================"
echo "Template:  $TEMPLATE_NAME"
echo "HTML:      $INDEX_HTML"
echo "Original:  $SCREENSHOT_ORIG"
echo "Threshold: ${QUALITY_THRESHOLD}%"
echo "----------------------------------------"

# Step 1: Get rendered screenshot
RENDER_DIR=$(mktemp -d)
RENDER_FILE="$RENDER_DIR/rendered.png"
trap 'rm -rf "$RENDER_DIR"' EXIT

echo ""
echo "[Step 1] 渲染 HTML"
echo "---"

if [ $# -ge 2 ] && [ -f "$2" ]; then
  cp "$2" "$RENDER_FILE"
  echo "使用提供的渲染截圖: $2"
else
  echo "NOTE: 需使用 Playwright MCP 渲染 HTML 並截圖。"
  echo ""
  echo "請在 Claude Code 中執行以下步驟："
  echo "  1. 使用 Playwright MCP 開啟 file://$PWD/$INDEX_HTML"
  echo "  2. 設定 viewport: 375x812 (iPhone 尺寸)"
  echo "  3. 擷取全頁截圖，儲存至: $RENDER_FILE"
  echo ""
  echo "或者將已渲染的截圖作為第二個參數傳入："
  echo "  $0 $TEMPLATE_DIR <rendered-screenshot-path>"
  echo ""
  rm -rf "$RENDER_DIR"
  exit 1
fi

echo ""
echo "[Step 2] 品質比對 (compare.sh)"
echo "---"

# Run compare.sh for overall metrics
RESULT=$("$COMPARE_SCRIPT" "$RENDER_FILE" "$SCREENSHOT_ORIG" 2>&1 || true)

# Extract metrics from compare.sh output
SSIM=$(echo "$RESULT" | grep "^SSIM:" | sed 's/SSIM: //' | sed 's/%//')
PERCEPTUAL=$(echo "$RESULT" | grep "^PERCEPTUAL:" | sed 's/PERCEPTUAL: //' | sed 's/%//')
OVERALL=$(echo "$RESULT" | grep "^OVERALL:" | sed 's/OVERALL: //' | sed 's/%.*//')

if [ -z "$PERCEPTUAL" ] || [ "$PERCEPTUAL" = "N/A" ]; then
  echo "ERROR: Could not compute perceptual similarity."
  echo "compare.sh output:"
  echo "$RESULT"
  exit 1
fi

echo ""
echo "[Step 3] 分區品質分析"
echo "---"

# Resize both images to same dimensions for segment analysis
DIMENSIONS=$("$MAGICK" identify -format "%wx%h" "$RENDER_FILE")
IMG1_WORK="$RENDER_DIR/work_rendered.png"
IMG2_WORK="$RENDER_DIR/work_original.png"
"$MAGICK" "$RENDER_FILE" -resize "$DIMENSIONS!" "$IMG1_WORK"
"$MAGICK" "$SCREENSHOT_ORIG" -resize "$DIMENSIONS!" "$IMG2_WORK"

# 4 regions: Header / Jackpot / Game Grid / Footer
REGION_HEADER=$(compute_region_similarity "$IMG1_WORK" "$IMG2_WORK" "$RENDER_DIR" "header" 0 15)
REGION_JACKPOT=$(compute_region_similarity "$IMG1_WORK" "$IMG2_WORK" "$RENDER_DIR" "jackpot" 15 25)
REGION_GRID=$(compute_region_similarity "$IMG1_WORK" "$IMG2_WORK" "$RENDER_DIR" "grid" 25 70)
REGION_FOOTER=$(compute_region_similarity "$IMG1_WORK" "$IMG2_WORK" "$RENDER_DIR" "footer" 70 100)

echo ""
echo "========================================"
echo " QUALITY REPORT for: $TEMPLATE_NAME"
echo "========================================"

# Helper: print region line with status indicator
print_region() {
  local label="$1"
  local range="$2"
  local value="$3"

  if [ "$value" = "N/A" ]; then
    printf "  %-20s %s\n" "$label ($range):" "N/A"
    return
  fi

  local is_pass
  is_pass=$(echo "$value >= $QUALITY_THRESHOLD" | bc -l)

  if [ "$is_pass" -eq 1 ]; then
    printf "  %-20s %s%%\n" "$label ($range):" "$value"
  else
    printf "  %-20s %s%% ← 需要精修\n" "$label ($range):" "$value"
  fi
}

print_region "Header" "0-15%" "$REGION_HEADER"
print_region "Jackpot" "15-25%" "$REGION_JACKPOT"
print_region "Game Grid" "25-70%" "$REGION_GRID"
print_region "Footer" "70-100%" "$REGION_FOOTER"

echo "  ----------------------------------------"
echo "  OVERALL:  ${OVERALL}%"
echo "  TARGET:   ${QUALITY_THRESHOLD}%"

IS_PASS=$(echo "$OVERALL >= $QUALITY_THRESHOLD" | bc -l)

if [ "$IS_PASS" -eq 1 ]; then
  echo "  STATUS:   PASS"
else
  echo "  STATUS:   NEEDS_IMPROVEMENT"

  # Find the worst region to suggest priority fix
  WORST_REGION=""
  WORST_VALUE=999

  for region_name in "Header" "Jackpot" "Game Grid" "Footer"; do
    case "$region_name" in
      "Header")    val="$REGION_HEADER" ;;
      "Jackpot")   val="$REGION_JACKPOT" ;;
      "Game Grid") val="$REGION_GRID" ;;
      "Footer")    val="$REGION_FOOTER" ;;
    esac

    if [ "$val" != "N/A" ]; then
      is_worse=$(echo "$val < $WORST_VALUE" | bc -l)
      if [ "$is_worse" -eq 1 ]; then
        WORST_VALUE="$val"
        WORST_REGION="$region_name"
      fi
    fi
  done

  if [ -n "$WORST_REGION" ]; then
    echo "  PRIORITY: Fix $WORST_REGION area first"
  fi
fi

echo ""
echo "========================================"
echo " 詳細指標"
echo "========================================"
echo "  SSIM:       ${SSIM}%"
echo "  Perceptual: ${PERCEPTUAL}%"
echo ""

if [ "$IS_PASS" -ne 1 ]; then
  echo "建議改善方向："
  echo "  1. 優先修正標記「需要精修」的區塊"
  echo "  2. 比對色彩差異 — 確認主色系、背景色正確"
  echo "  3. 比對佈局差異 — 確認元素位置、間距一致"
  echo "  4. 比對字體差異 — 確認字型、字號、粗細"
  echo ""
  echo "可用以下指令產生差異圖："
  echo "  $MAGICK compare $RENDER_FILE $SCREENSHOT_ORIG /tmp/diff.png"
  echo ""
fi
