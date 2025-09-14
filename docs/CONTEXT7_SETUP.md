# Context7 MCP Integration Setup Guide

## 🚀 Quick Start

Context7 provides real-time, up-to-date documentation for 6000+ libraries directly in your Claude Code environment.

## Installation Methods

### Method 1: One-Click Installation (Recommended for Cursor)

[![Install MCP Server](https://cursor.com/deeplink/mcp-install-dark.svg)](https://cursor.com/en/install-mcp?name=context7&config=eyJ1cmwiOiJodHRwczovL21jcC5jb250ZXh0Ny5jb20vbWNwIn0%3D)

### Method 2: Manual Configuration

#### For Cursor
Add to `~/.cursor/mcp.json`:

```json
{
  "mcpServers": {
    "context7": {
      "url": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "YOUR_API_KEY_HERE"
      }
    }
  }
}
```

#### For Claude Code / VSCode
Add to your settings or use the command palette:

```bash
npx -y @upstash/context7-mcp@latest
```

### Method 3: Local Server Installation

```bash
# Install globally
npm install -g @upstash/context7-mcp

# Or use with npx
npx @upstash/context7-mcp --transport stdio
```

## 🔑 Getting Your API Key

1. Visit [context7.com/dashboard](https://context7.com/dashboard)
2. Create a free account
3. Copy your API key
4. Replace `YOUR_API_KEY_HERE` in the configuration

## 📝 Usage Instructions

### Basic Usage
Simply add `use context7` to any prompt:

```
Create a Next.js 14 app router with authentication. use context7
```

```
Show me how to use Drizzle ORM with PostgreSQL. use context7
```

### With Claude Agents
When using specialized agents, Context7 automatically provides relevant documentation:

```
@backend-specialist create a REST API with Express and TypeORM. use context7
```

```
@frontend-specialist build a React component with Framer Motion animations. use context7
```

## 🎯 Best Practices

### 1. Token Optimization
- Context7 uses 1000-5000 tokens by default
- This fits within your 32K standard context window
- No need to escalate to 200K/1M for documentation

### 2. Library Detection
Context7 automatically detects libraries from your prompt:
- ✅ "Create a React component" → Fetches React docs
- ✅ "Setup FastAPI with SQLAlchemy" → Fetches both docs
- ✅ "Configure Tailwind CSS" → Fetches latest Tailwind docs

### 3. Version Specificity
Specify versions when needed:
```
Create a Vue 3 composition API component. use context7
```

### 4. Caching Strategy
- Documentation is cached for 1 hour
- Reduces API calls and improves response time
- Force refresh by adding `--fresh` flag

## 🤝 Integration with Claude Agents

### Automatic Integration
These agents automatically benefit from Context7:

| Agent | Use Case | Example |
|-------|----------|---------|
| `backend-specialist` | API frameworks, databases | Express, FastAPI, PostgreSQL |
| `frontend-specialist` | UI frameworks, styling | React, Vue, Tailwind |
| `ml-ai-integration` | AI/ML libraries | OpenAI, LangChain, Transformers |
| `data-engineer` | Data tools | Pandas, Spark, Airflow |
| `senior-fullstack-developer` | Full-stack frameworks | Next.js, NestJS, Prisma |

### Manual Trigger
For other agents, manually add the trigger:
```
@security-specialist review this JWT implementation. use context7
```

## 🔧 Troubleshooting

### Common Issues

1. **"Context7 not found" error**
   - Ensure MCP server is properly configured
   - Check if API key is valid
   - Restart your editor after configuration

2. **"Rate limit exceeded"**
   - Get a free API key for higher limits
   - Default: 10 requests/minute
   - With API key: 100 requests/minute

3. **"Documentation not found"**
   - Library might not be indexed yet
   - Submit it at [context7.com/add-library](https://context7.com/add-library)

## 📊 Monitoring Usage

### Check Token Usage
Context7 reports token usage in responses:
```
[Context7: Retrieved 3,847 tokens of React documentation]
```

### View API Usage
Dashboard: [context7.com/dashboard](https://context7.com/dashboard)

## 🔐 Security Considerations

1. **API Key Storage**
   - Never commit API keys to git
   - Use environment variables in production
   - Rotate keys regularly

2. **Network Security**
   - All requests use HTTPS
   - No sensitive code is sent to Context7
   - Only library names are transmitted

## 📚 Supported Libraries

### Top Categories
- **Frontend**: React, Vue, Angular, Svelte, Next.js
- **Backend**: Express, FastAPI, Django, Rails, NestJS
- **Database**: PostgreSQL, MongoDB, Redis, Prisma, Drizzle
- **AI/ML**: OpenAI, Anthropic, Hugging Face, LangChain
- **DevOps**: Docker, Kubernetes, Terraform, AWS CDK
- **Testing**: Jest, Playwright, Cypress, Vitest

Full list: [context7.com/libraries](https://context7.com/libraries)

## 🚀 Advanced Configuration

### Custom Token Limits
```json
{
  "mcpServers": {
    "context7": {
      "url": "https://mcp.context7.com/mcp",
      "headers": {
        "CONTEXT7_API_KEY": "YOUR_API_KEY",
        "CONTEXT7_MAX_TOKENS": "8000"
      }
    }
  }
}
```

### Project-Specific Configuration
Create `.cursor/mcp.json` in your project root for project-specific settings.

## 📈 Performance Impact

- **Initial request**: +100-500ms for doc fetching
- **Cached requests**: <50ms overhead
- **Token savings**: 50-80% compared to full doc loading
- **Accuracy improvement**: 90%+ reduction in outdated API usage

## 🤖 Integration with Session Memory

Context7 usage is automatically tracked by the session-memory agent:
- Documents which libraries were queried
- Stores successful documentation retrievals
- Tracks version-specific information
- Includes in handover notes for continuity

## 💡 Tips & Tricks

1. **Batch Documentation Requests**
   ```
   Setup a full-stack app with Next.js, Prisma, and NextAuth. use context7
   ```
   Context7 fetches all three documentations efficiently.

2. **Fallback Strategy**
   If Context7 is unavailable, agents automatically fall back to training data.

3. **Debugging Mode**
   Add `--debug` to see what Context7 is fetching:
   ```
   Create a React component. use context7 --debug
   ```

## 📞 Support

- **Documentation**: [github.com/upstash/context7](https://github.com/upstash/context7)
- **Issues**: [github.com/upstash/context7/issues](https://github.com/upstash/context7/issues)
- **Add Libraries**: [context7.com/add-library](https://context7.com/add-library)
- **API Status**: [status.context7.com](https://status.context7.com)

---

*Context7 integration configured for Claude Config Backup v3.1*