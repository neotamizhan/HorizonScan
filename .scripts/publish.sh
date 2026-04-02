#!/usr/bin/env bash
# publish.sh — HorizonScan report JSON generation, index update, and git push
# Usage: bash publish.sh YYYY-MM-DD NN
# where NN is the sequential report number

set -euo pipefail

DATE="${1:?Usage: publish.sh YYYY-MM-DD NN}"
REPORT_NUM="${2:?Usage: publish.sh YYYY-MM-DD NN}"
REPO="/Users/siddhu/coding/HorizonScan"
REPORTS_DIR="$REPO/reports"
MD_DIR="/Users/siddhu/Desktop/Daily Digest"
JSON_FILE="$REPORTS_DIR/$DATE.json"
INDEX_FILE="$REPORTS_DIR/index.json"
MD_FILE="$MD_DIR/HorizonScan_$DATE.md"

echo "📄 Generating JSON from digest..."
# Claude writes the JSON inline during Step 3 of the EXECUTION SEQUENCE above.
# This script assumes the JSON file already exists at $JSON_FILE.
# If it does not exist, exit with an error.
if [[ ! -f "$JSON_FILE" ]]; then
  echo "❌ ERROR: JSON file not found at $JSON_FILE"
  echo "   Ensure Claude has written the JSON before calling this script."
  exit 1
fi

echo "📋 Updating index.json..."
python3 - <<'PYEOF'
import json, sys, os
index_path = os.environ.get("INDEX_FILE")
date_str = os.environ.get("DATE")
try:
    with open(index_path, "r") as f:
        index = json.load(f)
except (FileNotFoundError, json.JSONDecodeError):
    index = []
if date_str not in index:
    index.insert(0, date_str)
# Keep sorted newest-first
index.sort(reverse=True)
with open(index_path, "w") as f:
    json.dump(index, f, indent=2)
print(f"  index.json updated: {len(index)} entries")
PYEOF

echo "🚀 Committing and pushing to GitHub..."
cd "$REPO"
git add "reports/$DATE.json" "reports/index.json"
git commit -m "report: add $DATE digest (#$REPORT_NUM)"
git push

echo "✅ publish.sh complete: $DATE report #$REPORT_NUM published."
