# Knowledge Base

**Query your documentation instantly**

Extract concepts from your docs and query them. No complex setup, just simple text-based knowledge extraction.

## Quick Start

### 1. Create Documentation

```bash
# Create docs directory if it doesn't exist
mkdir -p docs

# Add markdown files
echo "# Authentication\n\n## JWT Tokens\n**Bearer tokens** are used..." > docs/auth.md
echo "# Database\n\n## Schema Design\n**Normalization** is key..." > docs/database.md
```

### 2. Extract Knowledge

```bash
make knowledge-update
```

This extracts:
- Document titles
- Section headers (concepts)
- **Bold terms** (key concepts)
- Word counts
- File metadata

### 3. Query Knowledge

```bash
# Find information
make knowledge-query Q="authentication"
make knowledge-query Q="database schema"
make knowledge-query Q="JWT"
```

### 4. View Statistics

```bash
make knowledge-stats
```

## How It Works

### Extraction Process

1. **Scans documentation** - Finds all `.md` files in `docs/`
2. **Extracts structure** - Headers become concepts
3. **Identifies key terms** - Bold text = important concepts
4. **Creates index** - JSON file with all metadata
5. **Enables querying** - Fast grep-based search

### Storage

**Location:** `~/.claude-toolkit/knowledge/extracted/`

**Index file:** `index.json`

**Format:**
```json
{
  "extracted_at": "20251015_143022",
  "source_dir": "./docs",
  "files": [
    {
      "file": "auth.md",
      "title": "Authentication",
      "word_count": 542,
      "concepts": ["JWT Tokens", "OAuth Flow", "Session Management"],
      "key_terms": ["Bearer tokens", "Refresh tokens", "PKCE"]
    }
  ]
}
```

## Commands

### Extract/Update Knowledge
```bash
make knowledge-update

# Output:
# 📚 Knowledge Extraction
# Found 12 markdown file(s) in ./docs
# Processing: auth.md
# Processing: database.md
# ...
# ✅ Extraction complete!
```

### Query Knowledge
```bash
make knowledge-query Q="authentication methods"

# Output:
# 🔍 Knowledge Query
# Query: "authentication methods"
#
# Matching Concepts:
#   📄 Authentication
#      File: auth.md
#      Concepts: JWT Tokens, OAuth Flow, Session Management
#
# Content Search:
# 📄 auth.md
# 15: We support multiple **authentication methods**:
# 16: - JWT tokens
# 17: - OAuth 2.0
```

### View Statistics
```bash
make knowledge-stats

# Output:
# 📊 Knowledge Base Statistics
# Overview:
#   Files: 12
#   Total Words: 8,432
#   Concepts: 68
#   Key Terms: 143
#
# Top Files by Size:
#   📄 API Reference (1,234 words)
#   📄 Database Design (987 words)
```

## Configuration

### Custom Documentation Directory

```bash
# In your .env or Makefile
export KNOWLEDGE_CONTENT_DIR=./documentation

# Then extract
make knowledge-update
```

### Multiple Directories

```bash
# Extract from multiple sources
KNOWLEDGE_CONTENT_DIR=./docs make knowledge-update
KNOWLEDGE_CONTENT_DIR=./specs make knowledge-update
KNOWLEDGE_CONTENT_DIR=./design make knowledge-update
```

## Use Cases

### 1. Find Decisions
```bash
# "What did we decide about caching?"
make knowledge-query Q="caching"
```

### 2. Locate Patterns
```bash
# "Where did we document error handling?"
make knowledge-query Q="error handling"
```

### 3. Remember Context
```bash
# "What authentication methods do we support?"
make knowledge-query Q="authentication"
```

### 4. Explore Documentation
```bash
# See all concepts
make knowledge-stats

# Find specific topic
make knowledge-query Q="database schema"
```

## Best Practices

### Document Structure

Use clear headers and bold terms:

```markdown
# Feature Name

## Overview

**Key concept** is important because...

## Implementation

We use **specific approach** to handle...

### Details

The **important detail** to remember...
```

### Regular Updates

```bash
# After adding/updating docs
make knowledge-update

# Keep knowledge fresh
```

### Descriptive Headers

Good headers become searchable concepts:
- ✅ "JWT Token Authentication"
- ✅ "Database Connection Pooling"
- ❌ "Implementation" (too vague)
- ❌ "Details" (not descriptive)

### Use Bold for Key Terms

```markdown
# Good
**Bearer tokens** are used for API authentication.
The **connection pool** manages database connections.

# Not as useful
Bearer tokens are used for API authentication.
The connection pool manages database connections.
```

## Comparison with Amplifier

### Amplifier's Knowledge System
- Complex Python package
- LLM-based extraction
- Graph database
- Relationship mapping
- Advanced synthesis

### Toolkit's Knowledge System
- Simple bash scripts
- Pattern-based extraction
- JSON storage
- Basic grep search
- Fast and lightweight

**Philosophy:** Start simple. You can always upgrade to Amplifier's full system later if needed.

## Limitations

- **No AI extraction** - Just pattern matching
- **No relationships** - Files are independent
- **No synthesis** - Doesn't combine concepts
- **Basic search** - grep-based, not semantic

**When to upgrade:** If you need semantic search, relationship mapping, or concept synthesis, use Amplifier's full knowledge system.

## Troubleshooting

### No files found
```bash
# Check docs directory exists
ls -la docs/

# Verify it contains markdown
find docs/ -name "*.md"
```

### Empty extraction
```bash
# Check markdown format
cat docs/your-file.md

# Ensure headers exist (# or ##)
# Ensure bold terms exist (**term**)
```

### Query returns nothing
```bash
# Check index exists
cat ~/.claude-toolkit/knowledge/extracted/index.json

# Re-extract
make knowledge-update

# Try broader query
make knowledge-query Q="auth"  # Instead of "authentication method flow"
```

## Advanced Usage

### Export for LLM Context

```bash
# Get all concepts for Claude
jq -r '[.files[].concepts[]] | unique | .[]' \
  ~/.claude-toolkit/knowledge/extracted/index.json
```

### Find Related Topics

```bash
# Topics related to "database"
make knowledge-query Q="database" | grep "📄"
```

### Track Documentation Growth

```bash
# Compare stats over time
make knowledge-stats > stats-$(date +%Y%m%d).txt
```

## Source

Simplified from [Microsoft Amplifier](https://github.com/microsoft/amplifier)
- Original: Full graph database with LLM extraction
- Toolkit: Simple pattern-based extraction
- Philosophy: Start simple, upgrade when needed
