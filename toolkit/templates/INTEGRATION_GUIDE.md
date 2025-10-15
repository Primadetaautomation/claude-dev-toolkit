# Claude Toolkit Integration Guide

Choose your integration path based on project type:

## 🆕 New Project

```bash
# 1. Copy Makefile template
cp ~/.claude-toolkit/templates/Makefile.template ./Makefile

# 2. Install transcript hook
mkdir -p .claude/hooks
cp ~/.claude-toolkit/transcripts/hook-precompact.py .claude/hooks/
chmod +x .claude/hooks/hook-precompact.py

# 3. Configure Claude Code
mkdir -p .claude
cp ~/.claude-toolkit/templates/settings.json.template .claude/settings.json

# 4. Install defensive utilities (if using Python)
pip install -e ~/.claude-toolkit/defensive

# 5. Test it works
make help-toolkit
```

## 🔧 Existing Project

### Minimal Integration (Makefile only)

```bash
# Add one line to your existing Makefile
echo 'include ~/.claude-toolkit/Makefile.include' >> Makefile

# Test it works
make help-toolkit
```

### Full Integration (All Features)

```bash
# 1. Add to Makefile
echo 'include ~/.claude-toolkit/Makefile.include' >> Makefile

# 2. Install transcript hook
mkdir -p .claude/hooks
cp ~/.claude-toolkit/transcripts/hook-precompact.py .claude/hooks/
chmod +x .claude/hooks/hook-precompact.py

# 3. Update Claude Code settings
# Add to .claude/settings.json:
{
  "hooks": {
    "PreCompact": ".claude/hooks/hook-precompact.py"
  }
}

# 4. Install defensive utilities (if using Python)
pip install -e ~/.claude-toolkit/defensive

# 5. Test it works
make help-toolkit
make transcript-list
```

## 📦 Per-Feature Installation

### Just Worktrees
```bash
# No installation needed - use directly
~/.claude-toolkit/worktrees/create.sh feature-name

# Or add to Makefile:
echo 'include ~/.claude-toolkit/Makefile.include' >> Makefile
make worktree NAME=feature-name
```

### Just Transcripts
```bash
# 1. Install hook
mkdir -p .claude/hooks
cp ~/.claude-toolkit/transcripts/hook-precompact.py .claude/hooks/
chmod +x .claude/hooks/hook-precompact.py

# 2. Configure
# Add to .claude/settings.json:
{"hooks": {"PreCompact": ".claude/hooks/hook-precompact.py"}}

# 3. Use
~/.claude-toolkit/transcripts/list.sh
```

### Just Defensive Utilities
```bash
# Install
pip install -e ~/.claude-toolkit/defensive

# Use in code
from claude_toolkit_defensive import parse_llm_json
```

### Just Knowledge Base
```bash
# Add to Makefile
echo 'include ~/.claude-toolkit/Makefile.include' >> Makefile

# Use
make knowledge-update
make knowledge-query Q="your question"
```

## 🧪 Testing Installation

### Test Defensive Utilities
```bash
python3 << 'EOF'
from claude_toolkit_defensive import parse_llm_json

response = '```json\n{"test": true}\n```'
result = parse_llm_json(response)
print(f"✅ Defensive utilities working: {result}")
EOF
```

### Test Worktrees
```bash
# In a git repository
make worktree NAME=test-feature
make worktree-list
make worktree-rm NAME=test-feature
```

### Test Transcripts
```bash
# List transcripts (will be empty initially)
make transcript-list

# Transcripts auto-save when you compact a conversation in Claude Code
```

### Test Knowledge Base
```bash
# Create test docs
mkdir -p docs
echo "# Test Doc\nThis is a test." > docs/test.md

# Extract knowledge
make knowledge-update

# Query
make knowledge-query Q="test"
```

## 🌍 Global vs Project Installation

### Global (Affects all projects)
Add hooks to `~/.claude/settings.json`:
```json
{
  "hooks": {
    "PreCompact": "~/.claude-toolkit/transcripts/hook-precompact.py"
  }
}
```

**Pros:** Works everywhere automatically
**Cons:** Can't customize per-project

### Per-Project (Recommended)
Add hooks to `.claude/settings.json` in each project:
```json
{
  "hooks": {
    "PreCompact": ".claude/hooks/hook-precompact.py"
  }
}
```

**Pros:** Full control per project
**Cons:** Need to set up each project

## 🔍 Troubleshooting

### "Command not found: make"
Install make:
- macOS: `xcode-select --install`
- Ubuntu: `sudo apt install build-essential`
- Windows: Use WSL or Git Bash

### "Permission denied" on scripts
Make scripts executable:
```bash
chmod +x ~/.claude-toolkit/worktrees/*.sh
chmod +x ~/.claude-toolkit/transcripts/*.sh
chmod +x ~/.claude-toolkit/knowledge/*.sh
```

### Transcripts not saving
1. Check hook installed: `ls -la .claude/hooks/hook-precompact.py`
2. Check hook executable: `chmod +x .claude/hooks/hook-precompact.py`
3. Check settings.json configured correctly
4. Test manually: Trigger compaction in Claude Code

### Python import errors
```bash
# Reinstall defensive utilities
pip install -e ~/.claude-toolkit/defensive --force-reinstall
```

## 📚 Next Steps

1. Read feature-specific READMEs:
   - `~/.claude-toolkit/defensive/README.md`
   - `~/.claude-toolkit/worktrees/README.md`
   - `~/.claude-toolkit/transcripts/README.md`
   - `~/.claude-toolkit/knowledge/README.md`

2. Check the main README:
   - `~/.claude-toolkit/README.md`

3. Test with a real project!
