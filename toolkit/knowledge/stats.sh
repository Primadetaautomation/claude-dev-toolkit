#!/usr/bin/env bash
# Show knowledge base statistics

OUTPUT_DIR="$HOME/.claude-toolkit/knowledge/extracted"
INDEX_FILE="$OUTPUT_DIR/index.json"

# Colors
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m'

echo -e "${BLUE}📊 Knowledge Base Statistics${NC}"
echo "════════════════════════════════════════════════════════════════"
echo ""

# Check if index exists
if [ ! -f "$INDEX_FILE" ]; then
    echo "Knowledge base not initialized."
    echo "Run 'make knowledge-update' to extract knowledge from your docs."
    exit 0
fi

# Extract stats using jq
EXTRACTED_AT=$(jq -r '.extracted_at' "$INDEX_FILE")
SOURCE_DIR=$(jq -r '.source_dir' "$INDEX_FILE")
FILE_COUNT=$(jq '.files | length' "$INDEX_FILE")
TOTAL_WORDS=$(jq '[.files[].word_count] | add' "$INDEX_FILE")
TOTAL_CONCEPTS=$(jq '[.files[].concepts | length] | add' "$INDEX_FILE")
TOTAL_TERMS=$(jq '[.files[].key_terms | length] | add' "$INDEX_FILE")

echo -e "${GREEN}Overview:${NC}"
echo "  Extracted: $EXTRACTED_AT"
echo "  Source: $SOURCE_DIR"
echo "  Files: $FILE_COUNT"
echo "  Total Words: $TOTAL_WORDS"
echo "  Concepts: $TOTAL_CONCEPTS"
echo "  Key Terms: $TOTAL_TERMS"
echo ""

echo -e "${GREEN}Top Files by Size:${NC}"
jq -r '.files | sort_by(.word_count) | reverse | .[0:5] | .[] |
  "  📄 \(.title) (\(.word_count) words)\n     \(.file)"' "$INDEX_FILE"
echo ""

echo -e "${GREEN}All Concepts:${NC}"
jq -r '[.files[].concepts[]] | unique | sort | .[] | "  • \(.)"' "$INDEX_FILE" | head -30
CONCEPT_COUNT=$(jq -r '[.files[].concepts[]] | unique | length' "$INDEX_FILE")
if [ "$CONCEPT_COUNT" -gt 30 ]; then
    echo "  ... and $((CONCEPT_COUNT - 30)) more"
fi
echo ""

echo "════════════════════════════════════════════════════════════════"
echo ""
echo "Commands:"
echo "  Update:  make knowledge-update"
echo "  Query:   make knowledge-query Q='your question'"
echo ""
