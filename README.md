# 📘 CLAUDE Config Backup - Intelligent Development Standards

**🇬🇧 English** | [🇳🇱 Nederlands](#-nederlandse-versie)

**Version 5.0 - Modular Intent-Based System**

Automatic context loading for Claude Code based on natural language - no technical jargon needed!

---

## 🎯 What is this?

A smart **modular documentation structure** that helps Claude Code automatically load the right expertise based on what you ask - **in plain, non-technical language**.

---

<a id="-nederlandse-versie"></a>
# 📘 CLAUDE Config Backup - Intelligente Development Standards

**[🇬🇧 English](#-claude-config-backup---intelligent-development-standards)** | **🇳🇱 Nederlands**

**Versie 5.0 - Modular Intent-Based System**

Claude Code automatische context loading op basis van gewone taal - geen technische jargon nodig!

---

## 🎯 Wat is dit?

Een slimme **modulaire documentatie-structuur** die Claude Code helpt om de juiste expertise automatisch te laden op basis van wat je vraagt - **in gewone, niet-technische taal**.

---

## ✨ What's new in v5.0?

### **Problem Solved:**
- **v4.1**: CLAUDE.md was 47,286 characters (7,286 over the 40K limit)
- **v4.1**: Used technical keywords ("create API", "component", "authentication")

### **Solution:**
- **v5.0**: CLAUDE.md core is now only ~8,500 characters (81% reduction!)
- **v5.0**: Recognizes non-technical language ("connect to database", "add button", "users login")
- **v5.0**: 5 specialized doc modules are automatically loaded based on intent

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

## 🎯 Claude Toolkit - NEW!

**Added:** 2025-10-15

Complete development toolkit extracted from Microsoft Amplifier with 4 powerful features:

1. **Defensive Utilities** (Python) - Robust LLM integration (parse messy JSON, retry with feedback)
2. **Parallel Worktrees** - Test multiple approaches simultaneously
3. **Conversation Transcripts** - Auto-save before compaction, never lose context
4. **Knowledge Base** - Extract and query your documentation

**Location:** `toolkit/`

### Quick Toolkit Setup:
```bash
# Install to your system
cp -r toolkit ~/.claude-toolkit

# Integrate into any project
cd ~/your-project
echo 'include ~/.claude-toolkit/Makefile.include' >> Makefile
make help-toolkit

# Install defensive utilities (Python)
pip install -e ~/.claude-toolkit/defensive
```

**Full Documentation:** See `toolkit/README.md`

---

## 🎯 Claude Toolkit - NIEUW!

**Added:** 2025-10-15

Complete development toolkit extracted from Microsoft Amplifier with 4 powerful features:

1. **Defensive Utilities** (Python) - Robust LLM integration (parse messy JSON, retry with feedback)
2. **Parallel Worktrees** - Test multiple approaches simultaneously
3. **Conversation Transcripts** - Auto-save before compaction, never lose context
4. **Knowledge Base** - Extract and query your documentation

**Location:** `toolkit/`

### Quick Toolkit Setup:
```bash
# Install to your system
cp -r toolkit ~/.claude-toolkit

# Integrate into any project
cd ~/your-project
echo 'include ~/.claude-toolkit/Makefile.include' >> Makefile
make help-toolkit

# Install defensive utilities (Python)
pip install -e ~/.claude-toolkit/defensive
```

**Full Documentation:** See `toolkit/README.md`

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

---

## 🆕 Chrome DevTools MCP Integratie

Deze configuratie bevat nu Chrome DevTools MCP voor real-time browser controle, debugging en performance analyse.

### Chrome DevTools Installatie:
```bash
# Automatische installatie
./scripts/setup-chrome-devtools.sh

# Of via Claude CLI
claude mcp add chrome-devtools npx chrome-devtools-mcp@latest
```

---

## 📁 Repository Structure

```
.
├── CLAUDE.md                        # Core rules (~8.5K chars) ⭐ v5.0
├── docs/                            # Specialized modules ⭐ v5.0
│   ├── backend.md                   # API, database, server
│   ├── frontend.md                  # UI, forms, pages
│   ├── security.md                  # Login, privacy, GDPR
│   ├── infrastructure.md            # Deployment, hosting, Docker
│   └── testing.md                   # Testing, debugging, quality
├── toolkit/                         # Development Toolkit ⭐ NEW 2025-10-15
│   ├── defensive/                   # Python LLM utilities
│   ├── worktrees/                   # Parallel development
│   ├── transcripts/                 # Auto-save conversations
│   ├── knowledge/                   # Doc extraction & query
│   ├── templates/                   # Integration templates
│   ├── Makefile.include             # Easy integration
│   └── README.md                    # Complete documentation
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

---

## 📁 Repository Structuur

```
.
├── CLAUDE.md                        # Core regels (~8.5K chars) ⭐ v5.0
├── docs/                            # Gespecialiseerde modules ⭐ v5.0
│   ├── backend.md                   # API, database, server
│   ├── frontend.md                  # UI, formulieren, pagina's
│   ├── security.md                  # Inloggen, privacy, GDPR
│   ├── infrastructure.md            # Deployment, hosting, Docker
│   └── testing.md                   # Testen, debuggen, kwaliteit
├── toolkit/                         # Development Toolkit ⭐ NIEUW 2025-10-15
│   ├── defensive/                   # Python LLM utilities
│   ├── worktrees/                   # Parallel development
│   ├── transcripts/                 # Auto-save conversations
│   ├── knowledge/                   # Doc extraction & query
│   ├── templates/                   # Integration templates
│   ├── Makefile.include             # Easy integration
│   └── README.md                    # Complete documentation
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

---

## 🚀 Quick Setup

### **Starting a New Project:**

```bash
# Copy to your new project directory:
cp /path/to/claude-config-backup/CLAUDE.md /path/to/new-project/
cp -r /path/to/claude-config-backup/docs /path/to/new-project/

# That's it! Claude Code automatically reads CLAUDE.md
```

### **Restore on a New Machine:**

```bash
# Clone the repository
git clone https://github.com/Primadetaautomation/claude-config-backup.git

# Install Chrome DevTools MCP (optional)
cd claude-config-backup
./scripts/setup-chrome-devtools.sh

# Copy configurations to Claude directory
cp -r agents/* ~/.claude/agents/
cp CLAUDE.md ~/.claude/
cp -r docs ~/.claude/
cp mcp-config.json ~/.claude/
```

---

## 🚀 Snel Starten

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

---

## 💡 How Does Intent-Based Loading Work?

### **Step 1: Ask in plain language**

```
❌ OLD WAY (technical):
"Create a RESTful API endpoint for user authentication with JWT tokens"

✅ NEW WAY (plain English):
"I want users to be able to login with their email and password"
```

### **Step 2: Claude analyzes intent**

Claude understands:
- "login" → needs security.md
- "email/password" → needs backend.md (database)
- Automatically loads: `docs/security.md` + `docs/backend.md`

### **Step 3: Claude works with full context**

Claude implements complete login system with JWT + bcrypt!

---

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

| Your Question (plain language) | Automatically Loaded | Content |
|--------------------------------|----------------------|---------|
| "connect to database" | `docs/backend.md` | API, database, JWT, GraphQL |
| "show button on screen" | `docs/frontend.md` | React, forms, styling, routing |
| "users login" | `docs/security.md` | Passwords, GDPR, encryption |
| "put app online" | `docs/infrastructure.md` | Vercel, Docker, CI/CD |
| "test if it works" | `docs/testing.md` | Jest, Playwright, debugging |

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

---

## 🔧 MCP Servers Inbegrepen

### Context7 Documentation Server
- Real-time documentatie voor 6000+ libraries
- Versie-specifieke docs
- Token optimalisatie

### Chrome DevTools MCP
- Browser automatisering & performance profiling
- Network monitoring & console debugging
- Visueel testen met screenshots

---

## 🔄 Backup Schedule / Schema

- **Automatic/Automatisch:** Daily at 2 PM via LaunchAgent / Dagelijks om 14:00 via LaunchAgent
- **Manual/Handmatig:** Run `~/claude-backup.sh`

---

## 📋 Requirements / Vereisten

**For Chrome DevTools MCP / Voor Chrome DevTools MCP:**
- Node.js 22.12.0 or higher / of hoger
- Google Chrome (latest stable version / laatste stabiele versie)
- Claude CLI (optional / optioneel, for automatic installation / voor automatische installatie)

---

## 🛡️ Security Note / Beveiligingsnotitie

**🇬🇧 English:**
This repository is now public to help other developers. It contains no credentials or sensitive information.

**Chrome DevTools Security:**
- Chrome DevTools MCP can access all browser content
- Always use `--isolated` flag for sensitive testing
- Never use with production credentials

**🇳🇱 Nederlands:**
Deze repository is nu publiek om andere developers te helpen. Het bevat geen credentials of gevoelige informatie.

**Chrome DevTools Beveiliging:**
- Chrome DevTools MCP kan alle browser content benaderen
- Gebruik altijd `--isolated` flag voor gevoelige tests
- Gebruik nooit met productie credentials

---

## 📝 Agent Categories / Categorieën

**🇬🇧 English:**
- **Development:** senior-fullstack-developer, code-reviewer
- **Testing:** qa-testing-engineer, playwright-test-agent
- **Architecture:** solutions-architect, database-architect
- **Operations:** devops-deployment-engineer, performance-engineer
- **Security:** security-specialist
- **Coordination:** master-orchestrator, context-manager
- **Design:** ux-ui-designer, technical-writer

**🇳🇱 Nederlands:**
- **Ontwikkeling:** senior-fullstack-developer, code-reviewer
- **Testen:** qa-testing-engineer, playwright-test-agent
- **Architectuur:** solutions-architect, database-architect
- **Operations:** devops-deployment-engineer, performance-engineer
- **Beveiliging:** security-specialist
- **Coördinatie:** master-orchestrator, context-manager
- **Design:** ux-ui-designer, technical-writer

---

## Last Updated / Laatst Bijgewerkt

**🇬🇧 English:** Repository maintained for disaster recovery and system migration purposes
**🇳🇱 Nederlands:** Repository onderhouden voor disaster recovery en systeem migratie doeleinden

Generated on / Gegenereerd op: 2025-10-15

---

*🇬🇧 Backup maintained for disaster recovery and system migration purposes*
*🇳🇱 Backup onderhouden voor disaster recovery en systeem migratie doeleinden*