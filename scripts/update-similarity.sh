#!/bin/bash
# ============================================================
# update-similarity.sh - 更新 registry.json 中版型的 similarity 值
# 用法: ./scripts/update-similarity.sh <template-dir> <similarity-value>
# 依賴: python3
# ============================================================

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
REGISTRY="$PROJECT_DIR/templates/registry.json"

# -- Helpers ---------------------------------------------------

usage() {
  echo "用法: $0 <template-dir> <similarity-value>"
  echo ""
  echo "更新 registry.json 中對應版型的 similarity 值。"
  echo ""
  echo "參數:"
  echo "  <template-dir>      版型目錄名稱或完整路徑"
  echo "                      例: 2026-04-07-joy-blue-v1"
  echo "                      例: templates/2026-04-07-joy-blue-v1"
  echo "  <similarity-value>  相似度值 (0-100 之間的數字)"
  echo ""
  echo "範例:"
  echo "  $0 2026-04-07-joy-blue-v1 85"
  echo "  $0 templates/2026-04-07-joy-blue-v1 92.5"
  exit 1
}

# -- Main ------------------------------------------------------

if [ $# -lt 2 ]; then
  usage
fi

TEMPLATE_INPUT="$1"
SIMILARITY_VALUE="$2"

# Extract template ID from directory path (support both "name" and "path/name")
TEMPLATE_ID=$(basename "$TEMPLATE_INPUT")

# Validate similarity value is a number between 0 and 100
if ! echo "$SIMILARITY_VALUE" | grep -qE '^[0-9]+\.?[0-9]*$'; then
  echo "ERROR: similarity-value 必須是數字 (0-100)，收到: $SIMILARITY_VALUE"
  exit 1
fi

IS_VALID=$(echo "$SIMILARITY_VALUE >= 0 && $SIMILARITY_VALUE <= 100" | bc -l)
if [ "$IS_VALID" -ne 1 ]; then
  echo "ERROR: similarity-value 必須在 0-100 之間，收到: $SIMILARITY_VALUE"
  exit 1
fi

# Validate registry.json exists
if [ ! -f "$REGISTRY" ]; then
  echo "ERROR: registry.json not found at $REGISTRY"
  exit 1
fi

# Use python3 to update the JSON
python3 -c "
import json
import sys

registry_path = '$REGISTRY'
template_id = '$TEMPLATE_ID'
similarity = $SIMILARITY_VALUE

with open(registry_path, 'r', encoding='utf-8') as f:
    data = json.load(f)

found = False
for tmpl in data.get('templates', []):
    if tmpl.get('id') == template_id:
        old_value = tmpl.get('similarity', 'N/A')
        # Use int if value is a whole number, otherwise float with 1 decimal
        if similarity == int(similarity):
            tmpl['similarity'] = int(similarity)
        else:
            tmpl['similarity'] = round(similarity, 1)
        found = True
        print(f'Updated: {template_id}')
        print(f'  similarity: {old_value} -> {tmpl[\"similarity\"]}')
        break

if not found:
    print(f'ERROR: Template \"{template_id}\" not found in registry.json', file=sys.stderr)
    print(f'Available templates:', file=sys.stderr)
    for tmpl in data.get('templates', []):
        print(f'  - {tmpl.get(\"id\", \"unknown\")}', file=sys.stderr)
    sys.exit(1)

with open(registry_path, 'w', encoding='utf-8') as f:
    json.dump(data, f, indent=2, ensure_ascii=False)
    f.write('\n')

print(f'Registry updated: {registry_path}')
"
