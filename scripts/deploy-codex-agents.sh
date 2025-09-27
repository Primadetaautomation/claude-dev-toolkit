#!/bin/bash
set -euo pipefail

TARGET_DIR="${HOME}/.codex"
AGENT_DIR="${TARGET_DIR}/agents"

mkdir -p "${AGENT_DIR}"
cp codex-config/agents/*.md "${AGENT_DIR}/"
cp codex-config/CODEX.md "${TARGET_DIR}/CODEX.md"
cp codex-config/agent-context-config.json "${TARGET_DIR}/agent-context-config.json"
cp codex-config/config/config.toml "${TARGET_DIR}/config.toml"

echo "✅ Codex agent bundle synced to ${TARGET_DIR}"
