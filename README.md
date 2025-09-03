# Claude AI Configuration Backup

This repository contains my personal Claude AI agents and configuration files.

## 📁 Repository Structure

```
.claude/
├── agents/                 # Custom AI agents for specialized tasks
│   ├── senior-fullstack-developer.md
│   ├── qa-testing-engineer.md
│   ├── security-specialist.md
│   ├── solutions-architect.md
│   ├── devops-deployment-engineer.md
│   ├── playwright-test-agent.md
│   ├── master-orchestrator.md
│   └── ... (more specialized agents)
├── CLAUDE.md              # Global developer guidelines
├── agent-context-config.json  # Agent configuration
└── package.json           # Dependencies and scripts
```

## 🚀 Quick Setup

To restore these configurations on a new machine:

```bash
# Clone the repository
git clone https://github.com/Primadetaautomation/claude-config-backup.git ~/.claude

# Or if .claude exists, restore specific files
git clone https://github.com/Primadetaautomation/claude-config-backup.git ~/claude-restore
cp -r ~/claude-restore/agents/* ~/.claude/agents/
cp ~/claude-restore/CLAUDE.md ~/.claude/
```

## 🔄 Backup Schedule

- **Automatic:** Daily at 2 PM via LaunchAgent
- **Manual:** Run `~/claude-backup.sh`

## 🛡️ Security Note

This is a private repository. Do not share access with untrusted parties as it may contain project-specific configurations.

## 📝 Agent Categories

- **Development:** senior-fullstack-developer, code-reviewer
- **Testing:** qa-testing-engineer, playwright-test-agent
- **Architecture:** solutions-architect, database-architect
- **Operations:** devops-deployment-engineer, performance-engineer
- **Security:** security-specialist
- **Coordination:** master-orchestrator, context-manager
- **Design:** ux-ui-designer, technical-writer

## Last Updated

Generated on: $(date)

---

*Backup maintained for disaster recovery and system migration purposes*