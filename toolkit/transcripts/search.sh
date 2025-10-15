#!/usr/bin/env bash
# Search across all saved transcripts
# Usage: ./search.sh "search term"

if [ -z "$1" ]; then
    echo "Usage: $0 'search term'"
    exit 1
fi

TRANSCRIPT_DIR="$HOME/.claude-toolkit/transcripts/saved"
SEARCH_TERM="$1"

if [ ! -d "$TRANSCRIPT_DIR" ]; then
    echo "Error: No transcripts directory found."
    exit 1
fi

echo ""
echo "Searching for: \"$SEARCH_TERM\""
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Search across all transcripts
found=0
find "$TRANSCRIPT_DIR" -name "transcript_*.txt" -type f | sort -r | while read -r file; do
    # Search with context (3 lines before/after)
    result=$(grep -i -B 3 -A 3 "$SEARCH_TERM" "$file" 2>/dev/null)

    if [ -n "$result" ]; then
        found=$((found + 1))
        filename=$(basename "$file")

        echo "📄 Found in: $filename"
        echo "───────────────────────────────────────────────────────────────"
        echo "$result" | head -50  # Limit output per file
        echo ""
        echo "───────────────────────────────────────────────────────────────"
        echo ""
    fi
done

if [ $found -eq 0 ]; then
    echo "No matches found for: \"$SEARCH_TERM\""
fi

echo ""
