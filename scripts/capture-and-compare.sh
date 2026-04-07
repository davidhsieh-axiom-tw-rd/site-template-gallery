#!/bin/bash
# ============================================================
# capture-and-compare.sh - 擷取網站截圖並與現有版型比對
# 用法: ./scripts/capture-and-compare.sh <url> [template-name]
# 依賴: ImageMagick 7+, Playwright (for capture)
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TEMPLATES_DIR="$PROJECT_DIR/templates"
COMPARE_SCRIPT="$SCRIPT_DIR/compare.sh"
MAGICK="/opt/homebrew/bin/magick"
THRESHOLD=90

# -- Helpers ---------------------------------------------------

usage() {
  echo "用法: $0 <url> [template-name]"
  echo ""
  echo "  <url>            要擷取截圖的網站 URL"
  echo "  [template-name]  (選填) 新版型名稱，預設格式: YYYY-MM-DD-site"
  echo ""
  echo "流程:"
  echo "  1. 擷取 URL 的全頁截圖"
  echo "  2. 與 templates/*/screenshot.png 逐一比對"
  echo "  3. 如果全部 < ${THRESHOLD}% 相似度，建立新版型目錄"
  echo "  4. 輸出比對報告"
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

# -- Main ------------------------------------------------------

if [ $# -lt 1 ]; then
  usage
fi

URL="$1"
TODAY=$(date +%Y-%m-%d)
TEMPLATE_NAME="${2:-$TODAY-captured}"

check_deps

echo "========================================"
echo " Capture & Compare"
echo "========================================"
echo "URL:      $URL"
echo "Template: $TEMPLATE_NAME"
echo "Date:     $TODAY"
echo "----------------------------------------"

# Step 1: Capture screenshot
CAPTURE_DIR=$(mktemp -d)
CAPTURE_FILE="$CAPTURE_DIR/screenshot.png"

echo ""
echo "[Step 1] 截圖擷取"
echo "---"
echo "NOTE: 需使用 Playwright MCP 擷取截圖。"
echo "請在 Claude Code 中執行以下步驟："
echo ""
echo "  1. 使用 Playwright MCP 瀏覽 $URL"
echo "  2. 等待頁面完全載入"
echo "  3. 擷取全頁截圖，儲存至: $CAPTURE_FILE"
echo ""

# Check if screenshot was provided manually
if [ ! -f "$CAPTURE_FILE" ]; then
  echo "等待截圖檔案..."
  echo "如果您已手動擷取截圖，請將檔案複製到: $CAPTURE_FILE"
  echo ""

  # Allow user to provide existing screenshot as 3rd argument
  if [ $# -ge 3 ] && [ -f "$3" ]; then
    cp "$3" "$CAPTURE_FILE"
    echo "使用提供的截圖: $3"
  else
    echo "ERROR: 截圖尚未擷取。"
    echo ""
    echo "替代方案："
    echo "  1. 手動截圖後重新執行: $0 $URL $TEMPLATE_NAME <screenshot-path>"
    echo "  2. 使用 Playwright MCP 在 Claude Code 中擷取"
    echo ""
    rm -rf "$CAPTURE_DIR"
    exit 1
  fi
fi

echo ""
echo "[Step 2] 比對現有版型"
echo "---"

MAX_SIMILARITY=0
MAX_MATCH=""
HAS_TEMPLATES=false

for TMPL_DIR in "$TEMPLATES_DIR"/*/; do
  TMPL_SCREENSHOT="$TMPL_DIR/screenshot.png"
  if [ -f "$TMPL_SCREENSHOT" ]; then
    HAS_TEMPLATES=true
    TMPL_NAME=$(basename "$TMPL_DIR")
    echo -n "  vs $TMPL_NAME ... "

    RESULT=$("$COMPARE_SCRIPT" "$CAPTURE_FILE" "$TMPL_SCREENSHOT" 2>&1 || true)
    # Use PERCEPTUAL as the primary metric (matches compare.sh primary indicator)
    SIM=$(echo "$RESULT" | grep "^PERCEPTUAL:" | sed 's/PERCEPTUAL: //' | sed 's/%//')

    if [ -n "$SIM" ]; then
      echo "${SIM}%"
      IS_HIGHER=$(echo "$SIM > $MAX_SIMILARITY" | bc -l)
      if [ "$IS_HIGHER" -eq 1 ]; then
        MAX_SIMILARITY=$SIM
        MAX_MATCH="$TMPL_NAME"
      fi
    else
      echo "comparison failed"
    fi
  fi
done

if [ "$HAS_TEMPLATES" = false ]; then
  echo "  (no existing templates found)"
fi

echo ""
echo "========================================"
echo " 比對報告"
echo "========================================"

IS_DUPLICATE=$(echo "$MAX_SIMILARITY > $THRESHOLD" | bc -l)

if [ "$IS_DUPLICATE" -eq 1 ]; then
  echo "STATUS:        DUPLICATE"
  echo "BEST MATCH:    $MAX_MATCH"
  echo "SIMILARITY:    ${MAX_SIMILARITY}%"
  echo ""
  echo "此截圖與現有版型 '$MAX_MATCH' 高度相似 (> ${THRESHOLD}%)。"
  echo "如果確定要建立新版型，請手動建立目錄。"
else
  echo "STATUS:        NEW_TEMPLATE"
  if [ -n "$MAX_MATCH" ]; then
    echo "CLOSEST MATCH: $MAX_MATCH (${MAX_SIMILARITY}%)"
  fi

  NEW_DIR="$TEMPLATES_DIR/$TEMPLATE_NAME"
  if [ -d "$NEW_DIR" ]; then
    echo ""
    echo "WARNING: 目錄已存在: $NEW_DIR"
    echo "跳過建立步驟。"
  else
    mkdir -p "$NEW_DIR/assets"
    cp "$CAPTURE_FILE" "$NEW_DIR/screenshot.png"

    # Create metadata.json
    cat > "$NEW_DIR/metadata.json" <<METAEOF
{
  "name": "$TEMPLATE_NAME",
  "description": "",
  "date": "$TODAY",
  "source_url": "$URL",
  "features": [],
  "color_scheme": {
    "primary": "#000000",
    "accent": "#000000",
    "background": "#FFFFFF"
  }
}
METAEOF

    echo ""
    echo "已建立新版型目錄: $NEW_DIR"
    echo "  - screenshot.png (已複製)"
    echo "  - metadata.json  (已建立，請編輯補充)"
    echo "  - assets/        (空目錄)"
    echo ""
    echo "下一步："
    echo "  1. 編輯 $NEW_DIR/metadata.json 填入版型資訊"
    echo "  2. 復刻 HTML 並儲存為 $NEW_DIR/index.html"
    echo "  3. 更新 templates/registry.json 加入新版型"
  fi
fi

echo ""

# Cleanup
rm -rf "$CAPTURE_DIR"
