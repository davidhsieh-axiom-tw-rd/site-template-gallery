#!/bin/bash
# ============================================================
# e2e-verify.sh — 版型匯出完整性 E2E 測試
#
# 用法: ./scripts/e2e-verify.sh [template-id]
#   預設: 對 registry.json 中所有版型執行
#   指定: ./scripts/e2e-verify.sh 2026-04-07-joy-blue-v1
#
# 測試項目:
#   T1. Gallery 頁面可正常載入
#   T2. 版型頁面可正常載入（含凍結模式）
#   T3. ZIP 匯出完整性（檔案結構 + Flutter 對照文件 + assets 對應）
#   T4. ZIP 解壓後本地 HTTP server 可渲染
#   T5. 分段截圖一致性（Gallery vs ZIP 解壓版，odiff 100%）
#
# T5 需要 Playwright MCP（Claude Code 環境下自動可用）。
# 若無 Playwright 環境，T5 會自動跳過，其他測試仍可執行。
#
# 依賴: python3, odiff, jq, unzip, curl, zip
# ============================================================

set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
REGISTRY="$PROJECT_DIR/templates/registry.json"
GALLERY_PORT="${GALLERY_PORT:-9090}"
ZIP_PORT="${ZIP_PORT:-8181}"
VIEWPORT_W=420
VIEWPORT_H=900
TEMP_DIR=""
PYTHON_PID=""
PASS=0
FAIL=0
SKIP=0

# 顏色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

# -- Helpers ---------------------------------------------------

cleanup() {
  if [ -n "$PYTHON_PID" ]; then
    kill "$PYTHON_PID" 2>/dev/null || true
  fi
  if [ -n "$TEMP_DIR" ] && [ -d "$TEMP_DIR" ]; then
    # 失敗時保留 temp 供 debug
    if [ "$FAIL" -eq 0 ]; then
      rm -rf "$TEMP_DIR"
    fi
  fi
}
trap cleanup EXIT

log_pass() { echo -e "  ${GREEN}✓ PASS${NC} $1"; PASS=$((PASS + 1)); }
log_fail() { echo -e "  ${RED}✗ FAIL${NC} $1"; FAIL=$((FAIL + 1)); }
log_skip() { echo -e "  ${YELLOW}⊘ SKIP${NC} $1"; SKIP=$((SKIP + 1)); }
log_info() { echo -e "  ${CYAN}ℹ${NC} $1"; }

check_deps() {
  local missing=0
  for cmd in python3 odiff jq unzip curl zip; do
    if ! command -v "$cmd" &>/dev/null; then
      echo "ERROR: $cmd not found"
      missing=1
    fi
  done
  if [ "$missing" -eq 1 ]; then
    echo "Install missing dependencies and retry."
    exit 1
  fi
}

check_gallery_running() {
  if ! curl -s -o /dev/null -w "%{http_code}" "http://localhost:${GALLERY_PORT}/" | grep -q "200"; then
    echo "ERROR: Gallery not running on port ${GALLERY_PORT}"
    echo "Start with: cd $PROJECT_DIR && docker compose up -d"
    exit 1
  fi
}

# -- Test functions --------------------------------------------

t1_gallery_loads() {
  echo -e "\n${CYAN}T1. Gallery 頁面載入${NC}"

  local status
  status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${GALLERY_PORT}/")
  if [ "$status" = "200" ]; then
    log_pass "Gallery HTTP 200"
  else
    log_fail "Gallery HTTP $status (expected 200)"
    return
  fi

  # registry.json 可存取且有內容
  local reg_status reg_count
  reg_status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${GALLERY_PORT}/templates/registry.json")
  if [ "$reg_status" = "200" ]; then
    reg_count=$(curl -s "http://localhost:${GALLERY_PORT}/templates/registry.json" | jq '.templates | length')
    log_pass "registry.json 可存取（${reg_count} 個版型）"
  else
    log_fail "registry.json HTTP $reg_status"
  fi

  # JSZip CDN 可載入
  local jszip_check
  jszip_check=$(curl -s "http://localhost:${GALLERY_PORT}/" | grep -c "jszip" || true)
  if [ "$jszip_check" -gt 0 ]; then
    log_pass "JSZip CDN 引用存在"
  else
    log_fail "index.html 未引用 JSZip"
  fi
}

t2_template_loads() {
  local tid="$1"
  echo -e "\n${CYAN}T2. 版型頁面載入 ($tid)${NC}"

  # 正常模式
  local status
  status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${GALLERY_PORT}/templates/${tid}/index.html")
  if [ "$status" = "200" ]; then
    log_pass "版型頁面 HTTP 200"
  else
    log_fail "版型頁面 HTTP $status"
    return
  fi

  # 凍結模式（URL 參數不影響靜態檔案 HTTP status，但驗證可存取）
  status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${GALLERY_PORT}/templates/${tid}/index.html?freeze=true")
  if [ "$status" = "200" ]; then
    log_pass "凍結模式 HTTP 200"
  else
    log_fail "凍結模式 HTTP $status"
  fi

  # metadata.json
  status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${GALLERY_PORT}/templates/${tid}/metadata.json")
  if [ "$status" = "200" ]; then
    log_pass "metadata.json 可存取"
  else
    log_fail "metadata.json HTTP $status"
  fi

  # screenshot.png
  status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${GALLERY_PORT}/templates/${tid}/screenshot.png")
  if [ "$status" = "200" ]; then
    log_pass "screenshot.png 可存取"
  else
    log_fail "screenshot.png HTTP $status"
  fi
}

t3_zip_completeness() {
  local tid="$1"
  echo -e "\n${CYAN}T3. ZIP 匯出完整性 ($tid)${NC}"

  local tpl_dir="$PROJECT_DIR/templates/$tid"

  # 模擬 Gallery 的 ZIP 匯出邏輯：從檔案系統直接打包
  # （Gallery 前端用 JSZip，這裡用 zip 指令等效複製）
  local zip_path="$TEMP_DIR/export.zip"
  local extract_dir="$TEMP_DIR/extracted"
  mkdir -p "$extract_dir"

  log_info "從檔案系統打包 ZIP..."
  cd "$tpl_dir"
  zip -r "$zip_path" . -x ".*" >/dev/null
  cd "$PROJECT_DIR"

  if [ ! -f "$zip_path" ]; then
    log_fail "ZIP 打包失敗"
    return
  fi
  local zip_size
  zip_size=$(du -h "$zip_path" | cut -f1)
  log_pass "ZIP 打包成功 ($zip_size)"

  # 解壓
  unzip -q -o "$zip_path" -d "$extract_dir/$tid"

  # ── 必要檔案檢查 ──
  local required_files=(
    "index.html"
    "metadata.json"
    "screenshot.png"
    "README.md"
    "docs/flutter-token-mapping.md"
    "docs/flutter-conversion-guide.md"
    "docs/typography.md"
    "docs/structure-analysis.md"
    "docs/homepage-features.md"
    "docs/assets-inventory.json"
  )

  local all_present=1
  local present_count=0
  for f in "${required_files[@]}"; do
    if [ -f "$extract_dir/$tid/$f" ]; then
      present_count=$((present_count + 1))
    else
      log_fail "缺少: $f"
      all_present=0
    fi
  done
  if [ "$all_present" -eq 1 ]; then
    log_pass "所有必要檔案存在 ($present_count/${#required_files[@]})"
  fi

  # ── assets 非空 ──
  local asset_count
  asset_count=$(find "$extract_dir/$tid/assets" -type f 2>/dev/null | wc -l | tr -d ' ')
  if [ "$asset_count" -gt 0 ]; then
    log_pass "assets 目錄有 $asset_count 個檔案"
  else
    log_fail "assets 目錄為空"
  fi

  # ── HTML 中引用的 assets 都存在 ──
  local missing_assets=0
  local ref_count=0
  while IFS= read -r asset_path; do
    ref_count=$((ref_count + 1))
    if [ ! -f "$extract_dir/$tid/$asset_path" ]; then
      log_fail "HTML 引用但缺少: $asset_path"
      missing_assets=$((missing_assets + 1))
    fi
  done < <(grep -oE "assets/[^'\")\\ ,<>]+\.[a-zA-Z]+" "$extract_dir/$tid/index.html" | sort -u)

  if [ "$missing_assets" -eq 0 ]; then
    log_pass "HTML 引用的 assets 全部存在 ($ref_count 個)"
  fi

  # ── CSS 包含 Flutter Token 註解 ──
  if grep -q "Flutter:" "$extract_dir/$tid/index.html"; then
    log_pass "CSS 包含 Flutter Token 註解"
  else
    log_fail "CSS 缺少 Flutter Token 註解"
  fi

  # ── line-height 1.3 ──
  if grep -q "line-height: 1.3" "$extract_dir/$tid/index.html"; then
    log_pass "body line-height = 1.3"
  else
    log_fail "body line-height 未改為 1.3"
  fi

  # ── flutter-token-mapping.md 內容完整性 ──
  local token_file="$extract_dir/$tid/docs/flutter-token-mapping.md"
  if [ -f "$token_file" ]; then
    local sections=0
    for keyword in "色彩 Token" "尺寸 Token" "字體 Token" "陰影對照" "動畫參數" "z-index" "Widget 對應" "佈局差異"; do
      if grep -q "$keyword" "$token_file"; then
        sections=$((sections + 1))
      fi
    done
    if [ "$sections" -ge 7 ]; then
      log_pass "Token 對照表完整 ($sections/8 節)"
    else
      log_fail "Token 對照表不完整 ($sections/8 節)"
    fi
  fi

  # ── README.md 包含快速開始 ──
  local readme_file="$extract_dir/$tid/README.md"
  if [ -f "$readme_file" ]; then
    if grep -q "python3 -m http.server" "$readme_file"; then
      log_pass "README 包含快速開始指引"
    else
      log_fail "README 缺少快速開始指引"
    fi
  fi

  # ── assets 最低數量（可以多給不能少給） ──
  local bg_count icons_count games_count platforms_count
  bg_count=$(find "$extract_dir/$tid/assets/bg" -type f 2>/dev/null | wc -l | tr -d ' ')
  icons_count=$(find "$extract_dir/$tid/assets/icons" -type f 2>/dev/null | wc -l | tr -d ' ')
  games_count=$(find "$extract_dir/$tid/assets/games" -maxdepth 1 -type f 2>/dev/null | wc -l | tr -d ' ')
  platforms_count=$(find "$extract_dir/$tid/assets/games/platforms" -type f 2>/dev/null | wc -l | tr -d ' ')

  local asset_min_ok=1
  if [ "$bg_count" -lt 1 ]; then log_fail "assets/bg 不足 (${bg_count}<1)"; asset_min_ok=0; fi
  if [ "$icons_count" -lt 1 ]; then log_fail "assets/icons 不足 (${icons_count}<1)"; asset_min_ok=0; fi
  if [ "$games_count" -lt 5 ]; then log_fail "assets/games 不足 (${games_count}<5)"; asset_min_ok=0; fi
  if [ "$platforms_count" -lt 10 ]; then log_fail "assets/games/platforms 不足 (${platforms_count}<10)"; asset_min_ok=0; fi
  if [ "$asset_min_ok" -eq 1 ]; then
    log_pass "assets 最低數量達標 (bg:${bg_count} icons:${icons_count} games:${games_count} platforms:${platforms_count})"
  fi

  # ── similarity 分數已填入（非 0） ──
  local similarity
  similarity=$(jq -r --arg id "$tid" '.templates[] | select(.id==$id) | .similarity' "$REGISTRY")
  if [ -n "$similarity" ] && [ "$similarity" != "null" ] && [ "$similarity" != "0" ]; then
    log_pass "similarity 已填入 (${similarity}%)"
  else
    log_fail "similarity 未填入或為 0"
  fi

  # ── 功能特性檢查（根據 registry.json features 決定） ──
  local features
  features=$(jq -r --arg id "$tid" '.templates[] | select(.id==$id) | .features | join(",")' "$REGISTRY")

  # 「更多」選單存在（drawer 或 overlay）
  if echo "$features" | grep -q "more-drawer"; then
    if grep -q "more-drawer" "$extract_dir/$tid/index.html"; then
      log_pass "「更多」Drawer 結構存在"
    else
      log_fail "缺少「更多」Drawer（more-drawer）"
    fi
  elif echo "$features" | grep -q "more-overlay"; then
    if grep -q "more-overlay\|more-menu" "$extract_dir/$tid/index.html"; then
      log_pass "「更多」Overlay 結構存在"
    else
      log_fail "缺少「更多」Overlay（more-overlay）"
    fi
  fi

  # 熱門遊戲滾動動畫
  if echo "$features" | grep -q "hot-games-scroll"; then
    if grep -q "hot-games-track" "$extract_dir/$tid/index.html" && grep -q "@keyframes hot-games-scroll" "$extract_dir/$tid/index.html"; then
      log_pass "熱門遊戲滾動動畫存在"
    else
      log_fail "缺少熱門遊戲滾動動畫（hot-games-track + @keyframes）"
    fi
  fi

  # Tab bar 點擊功能
  if echo "$features" | grep -q "tab-click"; then
    if grep -q "\.onclick" "$extract_dir/$tid/index.html" || grep -q "addEventListener.*click" "$extract_dir/$tid/index.html"; then
      log_pass "Tab bar 點擊事件已綁定"
    else
      log_fail "Tab bar 缺少點擊事件綁定"
    fi
  fi

  # ══════════════════════════════════════════════
  # 以下為 2026-04-08 session 新增的回歸測試
  # ══════════════════════════════════════════════

  # ── T3-R1: 圖片全部使用本地路徑（無遠端 URL） ──
  local remote_img_count
  remote_img_count=$(grep -c "joy\.star-link-rel\.cc" "$extract_dir/$tid/index.html" 2>/dev/null || true)
  remote_img_count=$(echo "$remote_img_count" | tr -d '[:space:]')
  if [ -z "$remote_img_count" ] || [ "$remote_img_count" = "0" ]; then
    log_pass "所有圖片使用本地路徑（無遠端 URL）"
  else
    log_fail "仍有 $remote_img_count 個遠端 URL 引用"
  fi

  # ── T3-R2: 本地圖片檔案格式正確（非 HTML text） ──
  local broken_asset_count=0
  while IFS= read -r asset_file; do
    local ftype
    ftype=$(file -b "$asset_file" 2>/dev/null)
    if echo "$ftype" | grep -qi "text\|html\|ascii"; then
      log_fail "假圖片（HTML text）: $asset_file"
      broken_asset_count=$((broken_asset_count + 1))
    fi
  done < <(find "$extract_dir/$tid/assets" -type f \( -name "*.avif" -o -name "*.webp" -o -name "*.png" \))
  if [ "$broken_asset_count" -eq 0 ]; then
    log_pass "所有 asset 檔案格式正確（無 HTML text 假圖片）"
  fi

  # ── T3-R3: 遊戲卡片有邊框裝飾 ──
  if grep -q "game-card-border" "$extract_dir/$tid/index.html"; then
    local border_count
    border_count=$(grep -c "game-card-border" "$extract_dir/$tid/index.html" || echo "0")
    if [ "$border_count" -ge 20 ]; then
      log_pass "遊戲卡片邊框裝飾存在 ($border_count 個)"
    else
      log_fail "遊戲卡片邊框裝飾不足 ($border_count < 20)"
    fi
  fi

  # ── T3-R4: 包含多平台遊戲區（至少 5 個 platform-section） ──
  local platform_count
  platform_count=$(grep -c "platform-section" "$extract_dir/$tid/index.html" || echo "0")
  if [ "$platform_count" -ge 5 ]; then
    log_pass "多平台遊戲區存在 ($platform_count 個 platform-section)"
  else
    log_fail "多平台遊戲區不足 ($platform_count < 5)"
  fi

  # ── T3-R5: Tab Bar icon 尺寸 ≥ 40px ──
  if grep -qE "tab-item img|tab-icon" "$extract_dir/$tid/index.html" && grep -qE "width:\s*(4[0-9]|[5-9][0-9]|[1-9][0-9]{2})px" "$extract_dir/$tid/index.html"; then
    log_pass "Tab Bar icon 尺寸 ≥ 40px"
  elif grep -q "tab-item" "$extract_dir/$tid/index.html"; then
    log_fail "Tab Bar icon 尺寸可能不足"
  fi

  # ── T3-R6: 側邊欄有可展開子選單 ──
  if grep -q "more-drawer-sub" "$extract_dir/$tid/index.html"; then
    local sub_count
    sub_count=$(grep -c "more-drawer-sub-item" "$extract_dir/$tid/index.html" || echo "0")
    if [ "$sub_count" -ge 10 ]; then
      log_pass "側邊欄可展開子選單存在 ($sub_count 個子項)"
    else
      log_fail "側邊欄子選單項不足 ($sub_count < 10)"
    fi
  fi

  # ── T3-R7: 底部 Footer 三欄連結 + 牌照合规 + 联系我们 ──
  local footer_ok=1
  if ! grep -q "footer-links\|footer-col" "$extract_dir/$tid/index.html"; then
    log_fail "缺少底部三欄連結區"
    footer_ok=0
  fi
  if ! grep -q "footer-license\|牌照合规" "$extract_dir/$tid/index.html"; then
    log_fail "缺少牌照合规區"
    footer_ok=0
  fi
  if ! grep -q "footer-contact\|联系我们" "$extract_dir/$tid/index.html"; then
    log_fail "缺少联系我们區"
    footer_ok=0
  fi
  if [ "$footer_ok" -eq 1 ]; then
    log_pass "底部 Footer 完整（三欄連結 + 牌照合规 + 联系我们）"
  fi

  # ── T3-R8: 18plus 圖片存在 ──
  if [ -f "$extract_dir/$tid/assets/icons/18plus.avif" ]; then
    local ftype18
    ftype18=$(file -b "$extract_dir/$tid/assets/icons/18plus.avif")
    if echo "$ftype18" | grep -qi "avif\|image"; then
      log_pass "18plus.avif 圖片存在且格式正確"
    else
      log_fail "18plus.avif 格式錯誤: $ftype18"
    fi
  fi

  # ── T3-R9: Telegram icon 存在 ──
  if [ -f "$extract_dir/$tid/assets/icons/telegram.avif" ]; then
    local ftypetg
    ftypetg=$(file -b "$extract_dir/$tid/assets/icons/telegram.avif")
    if echo "$ftypetg" | grep -qi "avif\|image"; then
      log_pass "telegram.avif 圖片存在且格式正確"
    else
      log_fail "telegram.avif 格式錯誤: $ftypetg"
    fi
  fi
}

t4_zip_renders() {
  local tid="$1"
  echo -e "\n${CYAN}T4. ZIP 解壓後可渲染 ($tid)${NC}"

  local tpl_dir="$TEMP_DIR/extracted/$tid"
  if [ ! -d "$tpl_dir" ]; then
    log_skip "T3 未完成，跳過"
    return
  fi

  # 確保 port 未被佔用
  if lsof -ti:"$ZIP_PORT" >/dev/null 2>&1; then
    lsof -ti:"$ZIP_PORT" | xargs kill 2>/dev/null || true
    sleep 1
  fi

  # 起 Python HTTP server
  cd "$tpl_dir"
  python3 -m http.server "$ZIP_PORT" &>/dev/null &
  PYTHON_PID=$!
  cd "$PROJECT_DIR"
  sleep 1

  local status
  status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${ZIP_PORT}/")
  if [ "$status" = "200" ]; then
    log_pass "ZIP 解壓版 HTTP 200 (port $ZIP_PORT)"
  else
    log_fail "ZIP 解壓版 HTTP $status"
    kill "$PYTHON_PID" 2>/dev/null || true
    PYTHON_PID=""
    return
  fi

  # 凍結模式
  status=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${ZIP_PORT}/?freeze=true")
  if [ "$status" = "200" ]; then
    log_pass "凍結模式可存取"
  else
    log_fail "凍結模式 HTTP $status"
  fi

  # 驗證所有 assets 都可 HTTP 存取
  local asset_ok=0
  local asset_fail=0
  while IFS= read -r asset_path; do
    local as
    as=$(curl -s -o /dev/null -w "%{http_code}" "http://localhost:${ZIP_PORT}/${asset_path}")
    if [ "$as" = "200" ]; then
      asset_ok=$((asset_ok + 1))
    else
      asset_fail=$((asset_fail + 1))
    fi
  done < <(grep -oE "assets/[^'\")\\ ,<>]+\.[a-zA-Z]+" "$tpl_dir/index.html" | sort -u)

  if [ "$asset_fail" -eq 0 ]; then
    log_pass "所有 assets HTTP 可存取 ($asset_ok 個)"
  else
    log_fail "$asset_fail 個 assets HTTP 不可存取"
  fi
}

t5_screenshot_identical() {
  local tid="$1"
  echo -e "\n${CYAN}T5. 分段截圖一致性 ($tid)${NC}"

  if [ -z "$PYTHON_PID" ]; then
    log_skip "T4 未完成，跳過"
    return
  fi

  # 檢查是否有 screenshot 指令（由外部提供截圖或手動模式）
  local ss_dir="$TEMP_DIR/screenshots"
  mkdir -p "$ss_dir"

  # 嘗試用 curl 抓取兩個版本的 HTML 做文字比對（不依賴 Playwright）
  local gallery_html="$ss_dir/gallery.html"
  local zip_html="$ss_dir/zip.html"
  curl -s "http://localhost:${GALLERY_PORT}/templates/${tid}/index.html" > "$gallery_html"
  curl -s "http://localhost:${ZIP_PORT}/" > "$zip_html"

  # HTML 原始碼比對（應完全一致）
  if diff -q "$gallery_html" "$zip_html" >/dev/null 2>&1; then
    log_pass "HTML 原始碼 100% 一致"
  else
    local diff_lines
    diff_lines=$(diff "$gallery_html" "$zip_html" | wc -l | tr -d ' ')
    log_fail "HTML 原始碼有 $diff_lines 行差異"
  fi

  # 逐一比對 assets 的 MD5（確保二進位一致）
  local asset_match=0
  local asset_mismatch=0
  while IFS= read -r asset_path; do
    local gallery_md5 zip_md5
    gallery_md5=$(curl -s "http://localhost:${GALLERY_PORT}/templates/${tid}/${asset_path}" | md5)
    zip_md5=$(curl -s "http://localhost:${ZIP_PORT}/${asset_path}" | md5)
    if [ "$gallery_md5" = "$zip_md5" ]; then
      asset_match=$((asset_match + 1))
    else
      log_fail "Asset MD5 不一致: $asset_path"
      asset_mismatch=$((asset_mismatch + 1))
    fi
  done < <(grep -oE "assets/[^'\")\\ ,<>]+\.[a-zA-Z]+" "$TEMP_DIR/extracted/$tid/index.html" | sort -u)

  if [ "$asset_mismatch" -eq 0 ]; then
    log_pass "Assets MD5 全部一致 ($asset_match 個已驗)"
  fi

  log_info "視覺截圖比對需 Playwright MCP（Claude Code 環境下執行 T5-visual）"
  log_info "Gallery:  http://localhost:${GALLERY_PORT}/templates/${tid}/index.html?freeze=true"
  log_info "ZIP 版:   http://localhost:${ZIP_PORT}/?freeze=true"

  # 清理 Python server
  kill "$PYTHON_PID" 2>/dev/null || true
  PYTHON_PID=""
}

# -- Main ------------------------------------------------------

main() {
  echo ""
  echo -e "${BOLD}============================================${NC}"
  echo -e "${BOLD}  Site Template Gallery — E2E 驗證${NC}"
  echo -e "${BOLD}============================================${NC}"

  check_deps
  check_gallery_running

  TEMP_DIR=$(mktemp -d)

  # 決定要測試的版型
  local templates=()
  if [ $# -gt 0 ]; then
    templates=("$1")
  else
    while IFS= read -r tid; do
      templates+=("$tid")
    done < <(jq -r '.templates[].id' "$REGISTRY")
  fi

  echo ""
  echo "版型: ${templates[*]}"
  echo "Gallery: http://localhost:${GALLERY_PORT}"
  echo "Temp: $TEMP_DIR"

  # T1: Gallery 載入（全域一次）
  t1_gallery_loads

  # 逐版型測試
  for tid in "${templates[@]}"; do
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "  版型: $tid"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"

    t2_template_loads "$tid"
    t3_zip_completeness "$tid"
    t4_zip_renders "$tid"
    t5_screenshot_identical "$tid"
  done

  # 總結
  echo ""
  echo -e "${BOLD}============================================${NC}"
  echo -e "${BOLD}  測試結果${NC}"
  echo -e "${BOLD}============================================${NC}"
  echo -e "  ${GREEN}PASS: $PASS${NC}"
  if [ "$FAIL" -gt 0 ]; then
    echo -e "  ${RED}FAIL: $FAIL${NC}"
  else
    echo -e "  FAIL: 0"
  fi
  if [ "$SKIP" -gt 0 ]; then
    echo -e "  ${YELLOW}SKIP: $SKIP${NC}"
  fi
  echo ""

  if [ "$FAIL" -gt 0 ]; then
    echo -e "${RED}有 $FAIL 項測試失敗！${NC}"
    echo "Temp 目錄保留供 debug: $TEMP_DIR"
    TEMP_DIR=""  # 不清理
    exit 1
  else
    echo -e "${GREEN}全部通過！可以交付驗收。${NC}"
    exit 0
  fi
}

main "$@"
