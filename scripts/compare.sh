#!/bin/bash
# ============================================================
# compare.sh - 比對兩張截圖的結構相似度
# 用法: ./scripts/compare.sh <image1> <image2> [--ignore-dynamic]
# 依賴: ImageMagick 7+, odiff (brew install odiff)
#
# 比對模式:
#   1. odiff  — 像素差異比對（主要指標），支援忽略動態區域
#   2. SSIM   — 結構相似度（參考指標）
#   3. odiff 灰階模糊版 — 更寬容的佈局比對
# ============================================================

set -euo pipefail

MAGICK="/opt/homebrew/bin/magick"
ODIFF="/opt/homebrew/bin/odiff"
THRESHOLD=90

# -- Helpers ---------------------------------------------------

usage() {
  echo "用法: $0 <image1> <image2> [--ignore-dynamic]"
  echo ""
  echo "比對兩張截圖的相似度。"
  echo "  --ignore-dynamic  忽略動態區域（Jackpot、跑馬燈、中獎輪播）"
  echo ""
  echo "  > ${THRESHOLD}% → STATUS: DUPLICATE"
  echo "  <= ${THRESHOLD}% → STATUS: NEW_TEMPLATE"
  exit 1
}

check_deps() {
  if [ ! -x "$MAGICK" ]; then
    echo "ERROR: ImageMagick not found at $MAGICK"
    echo "Install: brew install imagemagick"
    exit 1
  fi
  if [ ! -x "$ODIFF" ]; then
    echo "ERROR: odiff not found at $ODIFF"
    echo "Install: brew install odiff"
    exit 1
  fi
}

# Compute SSIM similarity percentage
compute_ssim() {
  local img1="$1" img2="$2"
  local ssim_raw
  ssim_raw=$("$MAGICK" compare -metric SSIM "$img1" "$img2" null: 2>&1 || true)
  local dissimilarity
  dissimilarity=$(echo "$ssim_raw" | grep -oE '\(([0-9.]+)\)' | tr -d '()' || true)
  if [ -z "$dissimilarity" ]; then
    dissimilarity=$(echo "$ssim_raw" | grep -oE '^[0-9.]+' | head -1 || true)
  fi
  if [ -z "$dissimilarity" ]; then
    echo "N/A"; return
  fi
  echo "(1 - $dissimilarity) * 100" | bc -l | xargs printf "%.1f"
}

# Compute odiff similarity (returns percentage similar)
compute_odiff() {
  local img1="$1" img2="$2" diff_out="$3"
  shift 3
  local extra_args=()
  if [ $# -gt 0 ]; then extra_args=("$@"); fi

  local odiff_out
  if [ ${#extra_args[@]} -gt 0 ]; then
    odiff_out=$("$ODIFF" "$img1" "$img2" "$diff_out" \
      --antialiasing \
      --threshold 0.1 \
      "${extra_args[@]}" 2>&1 || true)
  else
    odiff_out=$("$ODIFF" "$img1" "$img2" "$diff_out" \
      --antialiasing \
      --threshold 0.1 2>&1 || true)
  fi

  # odiff outputs lines like:
  # "Changed pixels: 1234"
  # "Diff percentage: 1.23%"
  # or just a number on failure
  local diff_pct
  diff_pct=$(echo "$odiff_out" | grep -oE '[0-9]+\.[0-9]+' | tail -1 || true)

  if [ -z "$diff_pct" ]; then
    # Check if images are identical (exit code 0, no percentage)
    if echo "$odiff_out" | grep -qi "identical\|same\|0 pixels"; then
      echo "100.0"
    else
      echo "N/A"
    fi
    return
  fi

  # Convert diff percentage to similarity percentage
  echo "100 - $diff_pct" | bc -l | xargs printf "%.1f"
}

# Compute odiff with grayscale+blur preprocessing (layout comparison)
compute_odiff_relaxed() {
  local img1="$1" img2="$2" tmpdir="$3"
  local blur1="$tmpdir/blur1.png" blur2="$tmpdir/blur2.png"
  local diff_out="$tmpdir/diff_relaxed.png"

  # Grayscale + blur + resize 50% — smooths out text/font rendering differences
  "$MAGICK" "$img1" -resize 50% -colorspace Gray -blur 0x3 "$blur1"
  "$MAGICK" "$img2" -resize 50% -colorspace Gray -blur 0x3 "$blur2"

  compute_odiff "$blur1" "$blur2" "$diff_out"
}

# -- Main ------------------------------------------------------

if [ $# -lt 2 ]; then
  usage
fi

IMAGE1="$1"
IMAGE2="$2"
IGNORE_DYNAMIC=false
if [ "${3:-}" = "--ignore-dynamic" ]; then
  IGNORE_DYNAMIC=true
fi

if [ ! -f "$IMAGE1" ]; then
  echo "ERROR: File not found: $IMAGE1"
  exit 1
fi
if [ ! -f "$IMAGE2" ]; then
  echo "ERROR: File not found: $IMAGE2"
  exit 1
fi

check_deps

# Create temp directory
TMPDIR_COMPARE=$(mktemp -d)
trap 'rm -rf "$TMPDIR_COMPARE"' EXIT

# Resize both images to same dimensions
DIMENSIONS=$("$MAGICK" identify -format "%wx%h" "$IMAGE1")
IMG1="$TMPDIR_COMPARE/img1.png"
IMG2="$TMPDIR_COMPARE/img2.png"
"$MAGICK" "$IMAGE1" -resize "$DIMENSIONS!" "$IMG1"
"$MAGICK" "$IMAGE2" -resize "$DIMENSIONS!" "$IMG2"

# -- 1. odiff (pixel diff) ------------------------------------
ODIFF_ARGS=()
if [ "$IGNORE_DYNAMIC" = true ]; then
  # Get image height to calculate dynamic region coordinates
  IMG_H=$("$MAGICK" identify -format "%h" "$IMG1")
  IMG_W=$("$MAGICK" identify -format "%w" "$IMG1")

  # Dynamic regions (approximate percentages of viewport):
  # Jackpot: y=6%~18%, Marquee: y=18%~22%, Winner ticker: y=22%~30%
  local_y1=$(echo "$IMG_H * 6 / 100" | bc)
  local_y2=$(echo "$IMG_H * 30 / 100" | bc)

  ODIFF_ARGS=(--ignore-regions "[{\"x1\":0,\"y1\":$local_y1,\"x2\":$IMG_W,\"y2\":$local_y2}]")
fi

DIFF_IMG="$TMPDIR_COMPARE/diff.png"
if [ ${#ODIFF_ARGS[@]} -gt 0 ]; then
  ODIFF_PERCENT=$(compute_odiff "$IMG1" "$IMG2" "$DIFF_IMG" "${ODIFF_ARGS[@]}")
else
  ODIFF_PERCENT=$(compute_odiff "$IMG1" "$IMG2" "$DIFF_IMG")
fi

# -- 2. SSIM (reference) --------------------------------------
SSIM_PERCENT=$(compute_ssim "$IMG1" "$IMG2")

# -- 3. odiff relaxed (grayscale+blur, layout comparison) ------
RELAXED_PERCENT=$(compute_odiff_relaxed "$IMG1" "$IMG2" "$TMPDIR_COMPARE")

# -- Output ----------------------------------------------------
echo "IMAGE1: $IMAGE1"
echo "IMAGE2: $IMAGE2"
echo "---"
echo "ODIFF:   ${ODIFF_PERCENT}%  (pixel diff, antialiasing-aware)"
echo "SSIM:    ${SSIM_PERCENT}%  (structural similarity)"
echo "RELAXED: ${RELAXED_PERCENT}%  (grayscale+blur layout comparison)"
if [ "$IGNORE_DYNAMIC" = true ]; then
  echo "MODE:    ignore-dynamic (Jackpot/Marquee/Ticker masked)"
fi
echo "---"

# Use ODIFF as primary metric
OVERALL="$ODIFF_PERCENT"
echo "OVERALL: ${OVERALL}%"

if [ "$OVERALL" = "N/A" ]; then
  echo "STATUS: ERROR"
  exit 1
fi

IS_DUPLICATE=$(echo "$OVERALL > $THRESHOLD" | bc -l)
if [ "$IS_DUPLICATE" -eq 1 ]; then
  echo "STATUS: DUPLICATE"
else
  echo "STATUS: NEW_TEMPLATE"
fi

# Copy diff image if it exists and is useful
if [ -f "$DIFF_IMG" ] && [ -s "$DIFF_IMG" ]; then
  cp "$DIFF_IMG" "${IMAGE1%.*}-diff.png" 2>/dev/null || true
fi
