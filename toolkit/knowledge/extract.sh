#!/usr/bin/env bash
# Extract knowledge from documentation files
# Simplified knowledge extraction using basic concept identification

set -e

# Configuration
DOCS_DIR="${KNOWLEDGE_CONTENT_DIR:-./docs}"
OUTPUT_DIR="$HOME/.claude-toolkit/knowledge/extracted"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}📚 Knowledge Extraction${NC}"
echo "================================"
echo ""

# Check if docs directory exists
if [ ! -d "$DOCS_DIR" ]; then
    echo "Error: Documentation directory not found: $DOCS_DIR"
    echo "Set KNOWLEDGE_CONTENT_DIR environment variable or create ./docs/"
    exit 1
fi

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Count markdown files
FILE_COUNT=$(find "$DOCS_DIR" -name "*.md" -type f | wc -l | tr -d ' ')

if [ "$FILE_COUNT" -eq 0 ]; then
    echo "No markdown files found in $DOCS_DIR"
    exit 0
fi

echo "Found $FILE_COUNT markdown file(s) in $DOCS_DIR"
echo ""

# Extract concepts from each file
INDEX_FILE="$OUTPUT_DIR/index.json"
echo "{" > "$INDEX_FILE"
echo "  \"extracted_at\": \"$TIMESTAMP\"," >> "$INDEX_FILE"
echo "  \"source_dir\": \"$DOCS_DIR\"," >> "$INDEX_FILE"
echo "  \"files\": [" >> "$INDEX_FILE"

FIRST=true
find "$DOCS_DIR" -name "*.md" -type f | while read -r file; do
    filename=$(basename "$file")
    relative_path="${file#$DOCS_DIR/}"

    echo -e "${GREEN}Processing:${NC} $relative_path"

    # Extract basic metadata
    title=$(head -20 "$file" | grep "^#" | head -1 | sed 's/^#* *//' || echo "$filename")
    word_count=$(wc -w < "$file" | tr -d ' ')

    # Extract headers as concepts
    concepts=$(grep "^##" "$file" | sed 's/^##* *//' | jq -R . | jq -s . || echo "[]")

    # Extract bold terms as key concepts
    bold_terms=$(grep -o '\*\*[^*]*\*\*' "$file" | sed 's/\*\*//g' | sort -u | head -20 | jq -R . | jq -s . || echo "[]")

    # Create JSON entry
    if [ "$FIRST" = false ]; then
        echo "    ," >> "$INDEX_FILE"
    fi
    FIRST=false

    cat >> "$INDEX_FILE" << EOF
    {
      "file": "$relative_path",
      "title": $(echo "$title" | jq -R .),
      "word_count": $word_count,
      "concepts": $concepts,
      "key_terms": $bold_terms
    }
EOF
done

# Close JSON
echo "" >> "$INDEX_FILE"
echo "  ]" >> "$INDEX_FILE"
echo "}" >> "$INDEX_FILE"

echo ""
echo -e "${GREEN}✅ Extraction complete!${NC}"
echo "Index saved to: $INDEX_FILE"
echo ""
echo "Next steps:"
echo "  make knowledge-query Q='your question'"
echo "  make knowledge-stats"
echo ""
