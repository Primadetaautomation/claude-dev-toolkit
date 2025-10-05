# 📂 Claude Config Repository Structure

## ✅ Essentiële Bestanden & Directories

### 📋 Root Files
- **CLAUDE.md** - v4.1 met intelligente context management
- **README.md** - Repository documentatie
- **README_CONTEXT7.md** - Context7 MCP setup guide
- **package.json** - Node.js dependencies
- **mcp.json** - MCP server configuratie
- **settings.local.json** - Lokale settings (gitignored)
- **agent-context-config.json** - Agent context configuratie

### 📁 Core Directories

#### `/agents/` (35 actieve agents)
Alle Claude Code agent definities:
- accessibility-specialist.md
- backend-specialist.md
- context_manager_agent.md
- context7-documentation.md
- data-engineer.md
- database-architect.md
- devops-automation-agent.md
- documentation-agent.md
- frontend-specialist.md
- lint-code-quality.md
- master-orchestrator.md
- ml-ai-integration.md
- monitoring-observability.md
- n8n-workflow-creator.md
- performance-testing-agent.md
- playwright-test-agent.md
- qa-testing-engineer.md
- security-compliance-agent.md
- senior-fullstack-developer.md
- session-memory-agent.md
- solutions-architect.md
- test-automation-agent.md
- threat-modeling.md
- ux-ui-designer.md
- + management files (agent-health-dashboard.md, agents-summary.md, etc.)

#### `/scripts/`
Utility scripts:
- auto-test-setup.sh
- deploy-codex-agents.sh
- kill-vitest.sh
- setup-chrome-devtools.sh

#### `/agent-tools/`
Agent helper tools:
- impact-analyzer.js
- preflight-check.js
- simulation-mode.js
- playwright-mcp/ (Playwright MCP integration)

#### `/docs/`
Documentatie:
- CHROME_DEVTOOLS_INTEGRATION.md
- CONTEXT7_SETUP.md
- vitest-process-management.md

#### `/.claude-memory/`
Session continuity:
- session-current.md
- session-history.md
- project-state.md
- handover-notes.md

#### `/plugins/`
Plugin configuratie en repos

#### `/.husky/`
Git hooks voor quality checks

### 🚫 Gitignored (Lokale Files)
```
# Temporary/cache directories
shell-snapshots/
todos/
statsig/
test-scenarios/
projects/
local/
file-history/
history.jsonl
agent-tools/playwright-mcp/

# Local settings
settings.local.json

# macOS files
.DS_Store
```

## 📊 Repository Statistieken
- **35** Actieve agents
- **4** Utility scripts
- **3** Agent tools
- **25,985** Regels verwijderd uit deprecated files
- **0** Duplicate configuraties

## 🔄 Recent Updates
1. **v4.1** - Intelligente context management (32K-1M auto-select)
2. Verwijderd: deprecated agents backup
3. Verwijderd: codex-config duplicates
4. Cleanup: .DS_Store files, unused config files
5. Updated: .gitignore voor lokale bestanden

## 🎯 Repository Doel
Centrale configuratie voor Claude Code agents en development standards.
Gebruikt door alle projecten via:
- Direct copy naar project root
- Global config in ~/.claude/
- GitHub sync voor backup en versioning
