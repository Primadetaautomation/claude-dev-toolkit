# 🧪 UNIVERSAL TEST AUTOMATION FOR CLAUDE

**Automatic Testing for Every Project**  
**Zero Configuration Required**

---

## 🚀 HOW IT WORKS

### 1️⃣ **Automatic Activation**
The test agent activates automatically when:
- You save/modify code files
- You commit code (`git commit`)
- You mention "test", "bug", or "fix"
- New project without tests is detected
- Before deployment

### 2️⃣ **Smart Detection**
```bash
# Detects your project type automatically:
- package.json → JavaScript/TypeScript
- requirements.txt → Python
- pom.xml → Java
- go.mod → Go
- Gemfile → Ruby
```

### 3️⃣ **Auto-Setup**
```bash
# One command to rule them all:
curl -sSL https://raw.githubusercontent.com/Primadetaautomation/claude-config-backup/main/scripts/auto-test-setup.sh | bash
```

---

## 📦 WHAT YOU GET

### For JavaScript/TypeScript Projects
✅ **Vitest** for unit testing  
✅ **Playwright** for E2E testing  
✅ **Supertest** for API testing  
✅ **k6** for load testing  
✅ **Coverage reports**  
✅ **Git hooks**  
✅ **GitHub Actions CI/CD**  

### For Python Projects
✅ **pytest** with fixtures  
✅ **Coverage reports**  
✅ **Mock support**  
✅ **Async testing**  
✅ **Git hooks**  
✅ **GitHub Actions CI/CD**  

---

## 🎯 USAGE

### Method 1: Tell Claude
```
"Hey Claude, set up testing for my project"
"Run tests after my changes"
"Check if my code broke anything"
```

### Method 2: Manual Setup
```bash
# Download and run the setup script
wget https://raw.githubusercontent.com/Primadetaautomation/claude-config-backup/main/scripts/auto-test-setup.sh
chmod +x auto-test-setup.sh
./auto-test-setup.sh
```

### Method 3: Add to Any Project
```bash
# In your project root:
curl -sSL https://raw.githubusercontent.com/Primadetaautomation/claude-config-backup/main/scripts/auto-test-setup.sh | bash

# Tests are now ready!
npm test  # or pytest
```

---

## 🔄 AUTOMATIC FEATURES

### Pre-Commit Hook
```bash
# Runs automatically before every commit:
- Linting
- Unit tests
- Prevents broken code from being committed
```

### Pre-Push Hook
```bash
# Runs before pushing to remote:
- Full test suite
- Coverage check
- Ensures clean code in repository
```

### GitHub Actions
```yaml
# Automatic CI/CD pipeline:
- Runs on every push/PR
- Multi-version testing (Node 18/20, Python 3.9/3.11)
- Coverage reporting
- Automatic deployment on success
```

---

## 📊 TEST COMMANDS

### JavaScript/TypeScript
```bash
npm test              # Run all tests
npm run test:unit     # Unit tests only
npm run test:e2e      # E2E tests only
npm run test:coverage # With coverage report
npm run test:watch    # Watch mode
npm run test:ci       # CI mode
```

### Python
```bash
pytest               # Run all tests
pytest tests/unit    # Unit tests only
pytest --cov         # With coverage
pytest -v            # Verbose output
pytest --markers     # List test markers
```

---

## 🎨 TEST STRUCTURE CREATED

```
your-project/
├── tests/
│   ├── unit/           # Unit tests
│   ├── integration/    # Integration tests
│   ├── e2e/           # End-to-end tests (JS)
│   ├── fixtures/      # Test data
│   └── performance/   # Load tests
├── .github/
│   └── workflows/
│       └── test.yml   # CI/CD pipeline
├── vitest.config.ts   # Vitest config (JS)
├── playwright.config.ts # Playwright config (JS)
├── pytest.ini         # Pytest config (Python)
└── .git/hooks/        # Git hooks
    ├── pre-commit     # Pre-commit tests
    └── pre-push       # Pre-push tests
```

---

## 🤖 CLAUDE INTEGRATION

### Add to Your Claude Config
```bash
# Clone the config
git clone https://github.com/Primadetaautomation/claude-config-backup.git

# Copy agent to your .claude folder
cp claude-config-backup/agents/test-automation-agent.md ~/.claude/agents/
```

### Auto-Triggers in Claude
When using Claude, tests run automatically:
- After code generation
- Before committing changes
- When you ask about bugs
- During code review

---

## 📈 BENEFITS

### ✅ Zero Configuration
- Works with ANY project
- Auto-detects language and framework
- Installs dependencies automatically

### ✅ Complete Coverage
- Unit tests
- Integration tests
- E2E tests
- Performance tests
- Security scans

### ✅ CI/CD Ready
- GitHub Actions included
- Works with Vercel, Netlify, etc.
- Automatic deployment on test success

### ✅ Best Practices
- TDD approach
- 80% coverage target
- Git hooks for quality
- Consistent structure

---

## 🛠️ CUSTOMIZATION

### Modify Test Configuration
```javascript
// vitest.config.ts
export default {
  test: {
    coverage: {
      thresholds: {
        branches: 90,  // Increase coverage requirement
        functions: 90,
        lines: 90
      }
    }
  }
}
```

### Add Custom Scripts
```json
// package.json
{
  "scripts": {
    "test:custom": "your-custom-test-command",
    "test:specific": "vitest tests/specific-file.test.ts"
  }
}
```

---

## 🚨 TROUBLESHOOTING

### Issue: Tests not running
```bash
# Check if dependencies are installed
npm list vitest  # or pip list | grep pytest

# Reinstall if needed
npm install --save-dev vitest
```

### Issue: Git hooks not working
```bash
# Make hooks executable
chmod +x .git/hooks/pre-commit
chmod +x .git/hooks/pre-push
```

### Issue: CI/CD failing
```bash
# Check GitHub Actions logs
# Ensure secrets are set (if needed)
# Verify Node/Python versions match
```

---

## 📚 RESOURCES

- [Vitest Documentation](https://vitest.dev/)
- [Playwright Documentation](https://playwright.dev/)
- [pytest Documentation](https://docs.pytest.org/)
- [GitHub Actions](https://docs.github.com/en/actions)

---

## 🤝 CONTRIBUTING

Want to add support for more languages?

1. Fork the repo
2. Add detection for your language in `auto-test-setup.sh`
3. Add setup function for your language
4. Submit a PR

---

## 📄 LICENSE

MIT - Use freely in all your projects!

---

**Made with ❤️ for developers who want testing everywhere, automatically!**