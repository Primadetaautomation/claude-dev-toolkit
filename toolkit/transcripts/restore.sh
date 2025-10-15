#!/usr/bin/env bash
# Restore a conversation transcript
# Usage: ./restore.sh [filename]
#
# If no filename provided, restores the most recent transcript

TRANSCRIPT_DIR="$HOME/.claude-toolkit/transcripts/saved"

if [ ! -d "$TRANSCRIPT_DIR" ]; then
    echo "Error: No transcripts directory found."
    exit 1
fi

# Determine which transcript to restore
if [ -z "$1" ]; then
    # No argument - restore most recent
    TRANSCRIPT_FILE=$(find "$TRANSCRIPT_DIR" -name "transcript_*.txt" -type f | sort -r | head -1)

    if [ -z "$TRANSCRIPT_FILE" ]; then
        echo "Error: No transcripts found."
        exit 1
    fi

    echo "Restoring most recent transcript..."
else
    # Argument provided - check if it's a full path or filename
    if [ -f "$1" ]; then
        TRANSCRIPT_FILE="$1"
    elif [ -f "$TRANSCRIPT_DIR/$1" ]; then
        TRANSCRIPT_FILE="$TRANSCRIPT_DIR/$1"
    else
        echo "Error: Transcript not found: $1"
        exit 1
    fi
fi

echo "📖 Restoring: $(basename "$TRANSCRIPT_FILE")"
echo ""

# Output the transcript content
# This content will be loaded into Claude Code's context
cat "$TRANSCRIPT_FILE"

echo ""
echo "✅ Transcript restored successfully!"
echo "The full conversation history is now in context."
