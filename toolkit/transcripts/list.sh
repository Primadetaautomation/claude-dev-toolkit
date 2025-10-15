#!/usr/bin/env bash
# List all saved transcripts with metadata

TRANSCRIPT_DIR="$HOME/.claude-toolkit/transcripts/saved"

if [ ! -d "$TRANSCRIPT_DIR" ]; then
    echo "No transcripts found."
    echo "Transcripts will be saved automatically before compaction."
    exit 0
fi

echo ""
echo "Saved Conversation Transcripts"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# Count transcripts
count=$(find "$TRANSCRIPT_DIR" -name "transcript_*.txt" 2>/dev/null | wc -l | tr -d ' ')

if [ "$count" -eq 0 ]; then
    echo "No transcripts found."
    echo ""
    echo "Transcripts are automatically saved before each compaction."
    echo "Install the PreCompact hook to enable this feature."
    exit 0
fi

# List transcripts with details
find "$TRANSCRIPT_DIR" -name "transcript_*.txt" -type f | sort -r | head -20 | while read -r file; do
    filename=$(basename "$file")

    # Extract timestamp and session ID from filename
    # Format: transcript_YYYYMMDD_HHMMSS_SESSIONID.txt
    timestamp=$(echo "$filename" | sed -E 's/transcript_([0-9]{8}_[0-9]{6})_.*/\1/')
    session_id=$(echo "$filename" | sed -E 's/transcript_[0-9]{8}_[0-9]{6}_(.*)\.txt/\1/')

    # Format timestamp for display
    date_part=$(echo "$timestamp" | cut -d'_' -f1)
    time_part=$(echo "$timestamp" | cut -d'_' -f2)
    display_date="${date_part:0:4}-${date_part:4:2}-${date_part:6:2}"
    display_time="${time_part:0:2}:${time_part:2:2}:${time_part:4:2}"

    # Get file size
    size=$(ls -lh "$file" | awk '{print $5}')

    # Get message count from file
    msg_count=$(grep -c "^--- Message" "$file" 2>/dev/null || echo "?")

    echo "📄 $filename"
    echo "   Date: $display_date $display_time"
    echo "   Session: $session_id"
    echo "   Messages: $msg_count"
    echo "   Size: $size"
    echo ""
done

echo "═══════════════════════════════════════════════════════════════"
echo "Total: $count transcript(s)"
echo ""
echo "Commands:"
echo "  View:    cat ~/.claude-toolkit/transcripts/saved/FILENAME"
echo "  Restore: ~/.claude-toolkit/transcripts/restore.sh FILENAME"
echo "  Search:  ~/.claude-toolkit/transcripts/search.sh 'term'"
echo ""
