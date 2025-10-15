#!/usr/bin/env bash
# Query the knowledge base
# Simple grep-based search across extracted knowledge

if [ -z "$1" ]; then
    echo "Usage: $0 'search query'"
    exit 1
fi

QUERY="$1"
OUTPUT_DIR="$HOME/.claude-toolkit/knowledge/extracted"
INDEX_FILE="$OUTPUT_DIR/index.json"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}🔍 Knowledge Query${NC}"
echo "================================"
echo -e "Query: ${YELLOW}\"$QUERY\"${NC}"
echo ""

# Check if index exists
if [ ! -f "$INDEX_FILE" ]; then
    echo "Error: Knowledge base not found. Run 'make knowledge-update' first."
    exit 1
fi

# Get source directory
DOCS_DIR=$(jq -r '.source_dir' "$INDEX_FILE")

# Search in index for matching concepts/terms
echo -e "${GREEN}Matching Concepts:${NC}"
jq -r --arg query "$QUERY" '
  .files[] |
  select(
    (.concepts[]? | ascii_downcase | contains($query | ascii_downcase)) or
    (.key_terms[]? | ascii_downcase | contains($query | ascii_downcase)) or
    (.title | ascii_downcase | contains($query | ascii_downcase))
  ) |
  "  📄 \(.title)\n     File: \(.file)\n     Concepts: \(.concepts | join(", "))\n"
' "$INDEX_FILE" || echo "  No concept matches found."

echo ""
echo -e "${GREEN}Content Search:${NC}"

# Search actual file content
FOUND=0
jq -r '.files[].file' "$INDEX_FILE" | while read -r file; do
    full_path="$DOCS_DIR/$file"

    if grep -i -q "$QUERY" "$full_path" 2>/dev/null; then
        FOUND=$((FOUND + 1))
        echo -e "${BLUE}📄 $file${NC}"
        grep -i -n -C 2 "$QUERY" "$full_path" | head -20
        echo ""
    fi
done

if [ $FOUND -eq 0 ]; then
    echo "  No content matches found."
fi

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
