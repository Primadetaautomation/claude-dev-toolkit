# Conversation Transcripts

**Never lose context after compaction**

Claude Code automatically compacts (summarizes) conversations to stay within token limits. This system auto-saves your full conversation before each compaction, so you can restore complete history anytime.

## Quick Start

### 1. Install the PreCompact Hook

**Per-project installation:**
```bash
# In your project directory
mkdir -p .claude/hooks
cp ~/.claude-toolkit/transcripts/hook-precompact.py .claude/hooks/
chmod +x .claude/hooks/hook-precompact.py
```

**Add to `.claude/settings.json`:**
```json
{
  "hooks": {
    "PreCompact": ".claude/hooks/hook-precompact.py"
  }
}
```

**Or globally (affects all projects):**
```bash
# Add to ~/.claude/settings.json
{
  "hooks": {
    "PreCompact": "~/.claude-toolkit/transcripts/hook-precompact.py"
  }
}
```

### 2. Use Transcripts

Once installed, transcripts are automatically saved before each compaction.

**List saved transcripts:**
```bash
~/.claude-toolkit/transcripts/list.sh
```

**Restore most recent:**
```bash
~/.claude-toolkit/transcripts/restore.sh
```

**Restore specific transcript:**
```bash
~/.claude-toolkit/transcripts/restore.sh transcript_20251015_143022_a1b2c3d4.txt
```

**Search across all transcripts:**
```bash
~/.claude-toolkit/transcripts/search.sh "authentication"
```

## How It Works

### Automatic Save
When Claude Code compacts your conversation:
1. PreCompact hook fires **before** compaction
2. Full conversation exported to: `~/.claude-toolkit/transcripts/saved/`
3. Compaction proceeds normally
4. You see notification: "💾 Transcript saved: filename.txt"

### Restore
When you need the full history:
1. Run restore script
2. Full conversation content loaded into current context
3. Claude now has complete history again

## Commands

### List Transcripts
```bash
~/.claude-toolkit/transcripts/list.sh

# Output:
# 📄 transcript_20251015_143022_a1b2c3d4.txt
#    Date: 2025-10-15 14:30:22
#    Session: a1b2c3d4
#    Messages: 156
#    Size: 124K
```

### Restore Transcript
```bash
# Restore most recent
~/.claude-toolkit/transcripts/restore.sh

# Restore specific
~/.claude-toolkit/transcripts/restore.sh transcript_20251015_143022_a1b2c3d4.txt

# Or use full path
~/.claude-toolkit/transcripts/restore.sh ~/.claude-toolkit/transcripts/saved/transcript_20251015_143022_a1b2c3d4.txt
```

### Search Transcripts
```bash
~/.claude-toolkit/transcripts/search.sh "authentication bug"

# Shows matching sections with 3 lines context before/after
```

## Use Cases

### After Compaction
```
You: "Wait, what did we decide about the authentication approach?"
Claude: "I don't have that in my current context..."

# Restore transcript
~/.claude-toolkit/transcripts/restore.sh

You: "Now what did we decide about authentication?"
Claude: "Based on our earlier discussion (now in context)..."
```

### Review Past Decisions
```bash
# Find when you discussed a topic
~/.claude-toolkit/transcripts/search.sh "database schema"

# Restore that conversation
~/.claude-toolkit/transcripts/restore.sh transcript_20251014_091530_xyz.txt
```

### Share Conversations
```bash
# Transcripts are plain text files
cat ~/.claude-toolkit/transcripts/saved/transcript_20251015_143022.txt > shared-conversation.txt

# Share with team, attach to issue, etc.
```

## Makefile Integration

Add to your project's `Makefile`:

```makefile
include ~/.claude-toolkit/Makefile.include

# Now you have:
# make transcript-list
# make transcript-restore
# make transcript-search TERM="..."
```

## Troubleshooting

### Transcripts not saving?
1. Check hook is installed: `ls -la .claude/hooks/hook-precompact.py`
2. Check hook is executable: `chmod +x .claude/hooks/hook-precompact.py`
3. Check settings.json has hook configured
4. Check transcript directory exists: `ls -la ~/.claude-toolkit/transcripts/saved/`

### Hook not firing?
- Hooks only fire with Claude Code 0.13.0+
- Check Claude Code logs for errors
- Test manually: `echo '{"transcript_path": "/path/to/transcript.jsonl", "session_id": "test", "trigger": "manual"}' | ./.claude/hooks/hook-precompact.py`

### Can't find transcript?
```bash
# List all transcripts
~/.claude-toolkit/transcripts/list.sh

# Check directory directly
ls -lh ~/.claude-toolkit/transcripts/saved/
```

## Storage

**Location:** `~/.claude-toolkit/transcripts/saved/`

**Filename format:** `transcript_YYYYMMDD_HHMMSS_SESSIONID.txt`

**Typical size:** 50KB - 500KB per transcript (depending on conversation length)

**Management:**
```bash
# List by size
ls -lhS ~/.claude-toolkit/transcripts/saved/

# Delete old transcripts (older than 90 days)
find ~/.claude-toolkit/transcripts/saved/ -name "transcript_*.txt" -mtime +90 -delete

# Archive to compressed file
tar -czf transcripts-archive-$(date +%Y%m).tar.gz ~/.claude-toolkit/transcripts/saved/
```

## Privacy & Security

- **Local storage only** - Transcripts stored on your machine
- **Plain text** - Easy to audit, no proprietary format
- **No telemetry** - Never sent anywhere
- **Full control** - Delete anytime

## Source

Simplified from [Microsoft Amplifier](https://github.com/microsoft/amplifier)
- Original: Complex Python with duplicate detection, lineage tracking
- Toolkit: Simple, focused on core functionality
- Philosophy: Ruthless simplicity
