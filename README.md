# Claude AI Configuration Backup

This repository contains my personal Claude AI agents and configuration files, now enhanced with Chrome DevTools MCP integration for advanced browser testing and debugging.

## 🆕 Chrome DevTools MCP Integration

This configuration now includes Chrome DevTools MCP for real-time browser control, debugging, and performance analysis. See [Chrome DevTools Integration Guide](docs/CHROME_DEVTOOLS_INTEGRATION.md) for details.

### Quick Chrome DevTools Setup:
```bash
# Automatic installation
./scripts/setup-chrome-devtools.sh

# Or via Claude CLI
claude mcp add chrome-devtools npx chrome-devtools-mcp@latest
```

## 📁 Repository Structure

```
.
├── agents/                 # Custom AI agents for specialized tasks
│   ├── senior-fullstack-developer.md
│   ├── qa-testing-engineer.md
│   ├── security-specialist.md
│   ├── solutions-architect.md
│   ├── devops-deployment-engineer.md
│   ├── playwright-test-agent.md  # Enhanced with Chrome DevTools
│   ├── master-orchestrator.md
│   └── ... (more specialized agents)
├── docs/                   # Documentation
│   └── CHROME_DEVTOOLS_INTEGRATION.md  # Chrome DevTools guide
├── scripts/                # Automation scripts
│   ├── auto-test-setup.sh          # Universal test setup
│   └── setup-chrome-devtools.sh    # Chrome DevTools installer
├── mcp-config.json        # MCP servers configuration
├── CLAUDE.md              # Global developer guidelines
├── agent-context-config.json  # Agent configuration
└── package.json           # Dependencies and scripts
```

## 🚀 Quick Setup

To restore these configurations on a new machine:

```bash
# Clone the repository
git clone https://github.com/Primadetaautomation/claude-config-backup.git claude-config

# Install Chrome DevTools MCP
cd claude-config
./scripts/setup-chrome-devtools.sh

# Copy configurations to Claude directory
cp -r agents/* ~/.claude/agents/
cp CLAUDE.md ~/.claude/
cp mcp-config.json ~/.claude/
```

## 🔧 MCP Servers Included

### Context7 Documentation Server
- Real-time documentation for 6000+ libraries
- Version-specific docs
- Token optimization

### Chrome DevTools MCP
- **Browser Automation**: Control Chrome programmatically
- **Performance Profiling**: Record and analyze traces
- **Network Monitoring**: Track all requests and responses  
- **Console Debugging**: Access browser console logs
- **Visual Testing**: Screenshots and snapshots

### Usage Examples:
```bash
# Performance testing
"Use chrome devtools to analyze the performance of our homepage"

# Debug failing tests
"Use chrome devtools to debug why the login test is failing"

# Exploratory testing
"Use chrome devtools to explore the checkout flow manually"
```

## 🔄 Backup Schedule

- **Automatic:** Daily at 2 PM via LaunchAgent
- **Manual:** Run `~/claude-backup.sh`

## 📋 Requirements

For Chrome DevTools MCP:
- Node.js 22.12.0 or higher
- Google Chrome (latest stable version)
- Claude CLI (optional, for automatic installation)

## 🛡️ Security Note

This is a private repository. Do not share access with untrusted parties as it may contain project-specific configurations.

**Chrome DevTools Security:**
- Chrome DevTools MCP can access all browser content
- Always use `--isolated` flag for sensitive testing
- Never use with production credentials

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