#!/bin/bash
# 用法: ./scripts/freeze-compare.sh <original-screenshot> [clone-freeze-screenshot]
#
# 流程:
# 1. 提示用戶用 Playwright 截圖原始站（凍結彈窗）
# 2. 提示用戶用 Playwright 截圖復刻版（加 ?freeze=true）
# 3. 用 compare.sh 比對兩張截圖
# 4. 輸出品質報告

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(dirname "$SCRIPT_DIR")"
ORIGINAL="${1:?用法: $0 <original-screenshot> [clone-freeze-screenshot]}"
CLONE="${2:-}"

if [ -z "$CLONE" ]; then
    echo "=== 凍結模式比對 ==="
    echo ""
    echo "步驟 1: 已有原始站截圖: $ORIGINAL"
    echo "步驟 2: 請用 Playwright 截圖復刻版（加 ?freeze=true 參數）"
    echo "        URL: http://localhost:9090/templates/XXX/index.html?freeze=true"
    echo "步驟 3: 再次執行本腳本，提供兩張截圖路徑"
    echo ""
    echo "  $0 $ORIGINAL <clone-freeze-screenshot>"
    exit 0
fi

echo "=== 凍結模式品質比對 ==="
echo ""
bash "$SCRIPT_DIR/compare.sh" "$ORIGINAL" "$CLONE"
echo ""
echo "--- 注意 ---"
echo "凍結模式下的差異 = 純樣式差異（排除動態內容干擾）"
echo "這個分數更準確地反映 HTML 復刻的品質"
