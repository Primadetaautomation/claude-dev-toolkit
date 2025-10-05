# 📘 CLAUDE Config Backup - Intelligente Development Standards

**Versie 5.0 - Modular Intent-Based System**

Claude Code automatische context loading op basis van gewone taal - geen technische jargon nodig!

---

## 🎯 Wat is dit?

Een slimme **modulaire documentatie-structuur** die Claude Code helpt om de juiste expertise automatisch te laden op basis van wat je vraagt - **in gewone, niet-technische taal**.

---

## ✨ Wat is er nieuw in v5.0?

### **Probleem opgelost:**
- **v4.1**: CLAUDE.md was 47,286 karakters (7,286 te groot voor 40K limiet)
- **v4.1**: Gebruikte technische keywords ("API maken", "component", "authentication")

### **Oplossing:**
- **v5.0**: CLAUDE.md kern is nu slechts ~8,500 karakters (81% reductie!)
- **v5.0**: Herkent niet-technische taal ("verbinding met database", "knop toevoegen", "gebruikers inloggen")
- **v5.0**: 5 gespecialiseerde docs modules worden automatisch geladen op basis van intent

---

## 🆕 Chrome DevTools MCP Integration

This configuration now includes Chrome DevTools MCP for real-time browser control, debugging, and performance analysis.

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
├── CLAUDE.md                        # Core regels (~8.5K chars) ⭐ NIEUW v5.0
├── docs/                            # Gespecialiseerde modules ⭐ NIEUW v5.0
│   ├── backend.md                   # API, database, server
│   ├── frontend.md                  # UI, formulieren, pagina's
│   ├── security.md                  # Inloggen, privacy, GDPR
│   ├── infrastructure.md            # Deployment, hosting, Docker
│   └── testing.md                   # Testen, debuggen, kwaliteit
├── agents/                          # Custom AI agents
│   ├── senior-fullstack-developer.md
│   ├── qa-testing-engineer.md
│   ├── security-specialist.md
│   ├── solutions-architect.md
│   ├── devops-deployment-engineer.md
│   ├── playwright-test-agent.md
│   ├── master-orchestrator.md
│   └── ... (35 specialized agents total)
├── scripts/                         # Automation scripts
│   ├── auto-test-setup.sh
│   └── setup-chrome-devtools.sh
├── mcp-config.json                  # MCP servers configuration
├── agent-context-config.json        # Agent configuration
└── package.json                     # Dependencies
```

## 🚀 Quick Setup

### **Nieuw Project Starten:**

```bash
# Kopieer naar je nieuwe project directory:
cp /path/to/claude-config-backup/CLAUDE.md /path/to/new-project/
cp -r /path/to/claude-config-backup/docs /path/to/new-project/

# Dat is alles! Claude Code leest automatisch CLAUDE.md
```

### **Restore op nieuwe machine:**

```bash
# Clone het repository
git clone https://github.com/Primadetaautomation/claude-config-backup.git

# Install Chrome DevTools MCP (optioneel)
cd claude-config-backup
./scripts/setup-chrome-devtools.sh

# Copy configurations naar Claude directory
cp -r agents/* ~/.claude/agents/
cp CLAUDE.md ~/.claude/
cp -r docs ~/.claude/
cp mcp-config.json ~/.claude/
```

## 💡 Hoe werkt Intent-Based Loading?

### **Stap 1: Vraag in gewone taal**

```
❌ OUDE MANIER (technisch):
"Maak een RESTful API endpoint voor user authentication met JWT tokens"

✅ NIEUWE MANIER (gewoon Nederlands):
"Ik wil dat gebruikers kunnen inloggen met hun email en wachtwoord"
```

### **Stap 2: Claude analyseert intent**

Claude begrijpt:
- "inloggen" → security.md nodig
- "email/wachtwoord" → backend.md nodig (database)
- Automatisch laadt: `docs/security.md` + `docs/backend.md`

### **Stap 3: Claude werkt met volledige context**

Claude implementeert volledig login systeem met JWT + bcrypt!

---

## 🎯 Intent → Docs Mapping

| Jouw Vraag (gewone taal) | Automatisch Geladen | Content |
|---------------------------|---------------------|---------|
| "verbinding met database" | `docs/backend.md` | API, database, JWT, GraphQL |
| "knop op scherm tonen" | `docs/frontend.md` | React, forms, styling, routing |
| "gebruikers inloggen" | `docs/security.md` | Passwords, GDPR, encryption |
| "app online zetten" | `docs/infrastructure.md` | Vercel, Docker, CI/CD |
| "test of het werkt" | `docs/testing.md` | Jest, Playwright, debugging |

---

## 🔧 MCP Servers Included

### Context7 Documentation Server
- Real-time documentation for 6000+ libraries
- Version-specific docs
- Token optimization

### Chrome DevTools MCP
- Browser automation & performance profiling
- Network monitoring & console debugging
- Visual testing with screenshots

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