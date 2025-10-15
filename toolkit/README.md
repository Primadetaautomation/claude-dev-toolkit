# Claude Toolkit - Central Development Utilities

**Version 1.0** - Reusable toolkit for all your projects

This central toolkit provides battle-tested development utilities that work across ALL your projects:

- ✅ **Knowledge Base** - Extract concepts from docs, query accumulated wisdom
- ✅ **Parallel Worktrees** - Test multiple approaches simultaneously
- ✅ **Conversation Transcripts** - Auto-save before compaction, never lose context
- ✅ **Defensive Utilities** - Robust LLM response handling (Python)

## 🚀 Quick Start

### For Existing Projects

```bash
# 1. Add to your project's Makefile
echo 'include ~/.claude-toolkit/Makefile.include' >> Makefile

# 2. Start using toolkit commands
make knowledge-update
make worktree feature-name
make transcript-list
```

### For New Projects

```bash
# Copy integration template
cp ~/.claude-toolkit/templates/Makefile.template ./Makefile
cp ~/.claude-toolkit/templates/.claude-hooks.template ./.claude/hooks.json

# Configure project
cp ~/.claude-toolkit/.env.example ./.env
# Edit .env with your project settings
```

## 📚 Features

### 1. Knowledge Base

Extract concepts from your documentation and query them:

```bash
make knowledge-update          # Extract from docs/
make knowledge-query Q="auth"  # Query knowledge base
make knowledge-stats           # Show statistics
```

**Requirements:** Python 3.11+, Claude API key

### 2. Parallel Worktrees

Test multiple solutions simultaneously:

```bash
make worktree feature-jwt      # Create JWT auth experiment
make worktree feature-oauth    # Create OAuth experiment in parallel
make worktree-list             # Compare both
make worktree-rm feature-jwt   # Keep OAuth, remove JWT
```

**Requirements:** Git repository

### 3. Conversation Transcripts

Auto-saves full conversation before compaction:

```bash
make transcript-list           # List saved transcripts
make transcript-search TERM="auth"  # Search conversations
make transcript-restore        # Restore full lineage
```

**Integration:** Automatically activated via Claude Code hooks

### 4. Defensive Utilities (Python)

Robust utilities for handling LLM responses:

```python
from claude_toolkit.defensive import parse_llm_json, retry_with_feedback

# Handle messy JSON responses
data = parse_llm_json(llm_response)  # Extracts JSON from markdown, etc.

# Retry with error feedback
result = await retry_with_feedback(
    async_func=generate_synthesis,
    prompt=prompt,
    max_retries=3
)
```

**Requirements:** Python 3.11+, install via `pip install -e ~/.claude-toolkit/defensive`

## 📁 Directory Structure

```
~/.claude-toolkit/
├── knowledge/           # Knowledge base extraction & query scripts
├── worktrees/           # Git worktree management scripts
├── transcripts/         # Transcript save/restore hooks
├── defensive/           # Python defensive utilities (installable package)
├── templates/           # Integration templates for new projects
├── Makefile.include     # Shared Makefile targets
├── .env.example         # Configuration template
└── README.md            # This file
```

## 🔧 Configuration

Copy `.env.example` to your project root and customize:

```bash
# Project-specific settings
PROJECT_NAME=my-awesome-project
KNOWLEDGE_CONTENT_DIR=./docs
KNOWLEDGE_OUTPUT_DIR=./.data/knowledge

# API Keys (optional, for knowledge base)
ANTHROPIC_API_KEY=your-key-here
```

## 🎯 Integration Examples

### Minimal Integration (Makefile only)

```makefile
# Your project's Makefile
include ~/.claude-toolkit/Makefile.include

# Your existing targets...
```

### Full Integration (All features)

```bash
# 1. Makefile integration
echo 'include ~/.claude-toolkit/Makefile.include' >> Makefile

# 2. Claude Code hooks (transcripts)
mkdir -p .claude
cp ~/.claude-toolkit/templates/.claude-hooks.template .claude/hooks.json

# 3. Python utilities (if needed)
pip install -e ~/.claude-toolkit/defensive

# 4. Configuration
cp ~/.claude-toolkit/.env.example ./.env
```

## 📖 Command Reference

### Knowledge Base
- `make knowledge-update` - Extract concepts from docs
- `make knowledge-query Q="..."` - Query knowledge base
- `make knowledge-search Q="..."` - Search extracted knowledge
- `make knowledge-stats` - Show statistics

### Worktrees
- `make worktree NAME` - Create new worktree
- `make worktree-list` - List all worktrees
- `make worktree-rm NAME` - Remove worktree
- `make worktree-stash NAME` - Hide worktree (keeps data)

### Transcripts
- `make transcript-list` - List saved transcripts
- `make transcript-search TERM="..."` - Search conversations
- `make transcript-restore` - Restore full conversation

## 🛠️ Requirements

**Minimum:**
- Bash (for scripts)
- Git (for worktrees)
- Make (for commands)

**Optional:**
- Python 3.11+ (for knowledge base & defensive utilities)
- Claude Code (for transcripts)
- Anthropic API key (for knowledge extraction)

## 🔄 Updates

To update the toolkit:

```bash
cd ~/.claude-toolkit
git pull  # If you cloned from a repo
# Or manually copy updated files
```

## 📝 License

MIT - Use freely in all your projects

---

**Created from:** Microsoft Amplifier (adapted and simplified)
**Maintained by:** Your development workflow
**Last Updated:** 2025-10-15
