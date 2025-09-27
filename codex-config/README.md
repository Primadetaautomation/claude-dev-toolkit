# Codex CLI Multi-Agent Backup

This directory mirrors the Claude agent setup but is tuned for the OpenAI Codex CLI. It contains:

- `agents/` – Codex-ready Markdown definitions (default model `gpt-5-codex`)
- `CODEX.md` – shared engineering guidelines for every agent
- `agent-context-config.json` – context sizing, budgeting, and escalation rules adapted to Codex
- `config/config.toml` – sample Codex CLI configuration with sandbox and approval defaults

## Manual restore

```bash
# 1. Copy agent definitions
mkdir -p ~/.codex/agents
cp codex-config/agents/*.md ~/.codex/agents/

# 2. Copy shared guidelines and context config
cp codex-config/CODEX.md ~/.codex/
cp codex-config/agent-context-config.json ~/.codex/

# 3. Apply Codex CLI defaults (adjust path if needed)
cp codex-config/config/config.toml ~/.codex/config.toml
```

Restart any running Codex CLI sessions so the new agent roster and defaults are picked up. Launch `codex` as usual and select the desired specialist via the agent picker or by typing `@agent-name` in the prompt.
