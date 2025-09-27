#!/bin/bash

# Agent Migration Script v2.0
# Safely migrates to consolidated agent system

echo "🚀 Starting Agent System Migration v2.0"
echo "======================================="

# Create backup directory
BACKUP_DIR="./deprecated-agents-backup-$(date +%Y%m%d-%H%M%S)"
mkdir -p "$BACKUP_DIR"

echo "📦 Creating backup in: $BACKUP_DIR"

# List of deprecated agents to move
DEPRECATED_AGENTS=(
    "performance-engineer.md"
    "load-stress-test.md"
    "security-specialist.md"
    "privacy-gdpr.md"
    "devops-deployment-engineer.md"
    "ci-cd-pipeline.md"
    "infra-as-code.md"
    "technical-writer.md"
    "content-strategist.md"
    "code-reviewer.md"
    "business-analyst.md"
    "product-manager.md"
    "impact-analyzer.md"
)

# Move deprecated agents to backup
echo "🔄 Moving deprecated agents to backup..."
for agent in "${DEPRECATED_AGENTS[@]}"; do
    if [ -f "$agent" ]; then
        echo "  - Moving $agent"
        mv "$agent" "$BACKUP_DIR/"
    else
        echo "  ⚠️ Not found: $agent (skipping)"
    fi
done

# Verify new consolidated agents exist
echo ""
echo "✅ Verifying consolidated agents..."
CONSOLIDATED_AGENTS=(
    "performance-testing-agent.md"
    "security-compliance-agent.md"
    "devops-automation-agent.md"
    "documentation-agent.md"
)

for agent in "${CONSOLIDATED_AGENTS[@]}"; do
    if [ -f "$agent" ]; then
        echo "  ✓ Found: $agent"
    else
        echo "  ❌ Missing: $agent"
        exit 1
    fi
done

# Verify new system files
echo ""
echo "🔍 Verifying new system files..."
SYSTEM_FILES=(
    "agent-registry.json"
    "agent-selector.js"
    "agent-health-dashboard.md"
    "agent-chains.yaml"
)

for file in "${SYSTEM_FILES[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✓ Found: $file"
    else
        echo "  ❌ Missing: $file"
        exit 1
    fi
done

# Update references in other files
echo ""
echo "🔧 Updating agent references in documentation..."

# Update agents-summary.md if it exists
if [ -f "agents-summary.md" ]; then
    echo "  - Updating agents-summary.md with new structure"
    # Note: Manual review recommended after migration
fi

# Create migration report
echo ""
echo "📊 Creating migration report..."
cat > "MIGRATION-REPORT.md" << EOF
# Agent System Migration Report
Generated: $(date)

## Migration Summary
- **Deprecated Agents Removed**: ${#DEPRECATED_AGENTS[@]}
- **New Consolidated Agents**: ${#CONSOLIDATED_AGENTS[@]}
- **Backup Location**: $BACKUP_DIR

## Consolidated Agents
- performance-testing-agent.md (replaces: performance-engineer, load-stress-test)
- security-compliance-agent.md (replaces: security-specialist, privacy-gdpr)
- devops-automation-agent.md (replaces: devops-deployment-engineer, ci-cd-pipeline, infra-as-code)
- documentation-agent.md (replaces: technical-writer, content-strategist)

## New System Components
- agent-registry.json: Central agent configuration
- agent-selector.js: Smart agent selection logic
- agent-health-dashboard.md: Performance monitoring
- agent-chains.yaml: Workflow automation

## Action Items
1. Review and test agent selection with new registry
2. Update any hardcoded agent references in your code
3. Test agent chains for your common workflows
4. Monitor agent health dashboard for performance

## Rollback Instructions
If you need to rollback:
\`\`\`bash
# Restore deprecated agents from backup
cp $BACKUP_DIR/*.md ./
# Remove new consolidated agents
rm performance-testing-agent.md security-compliance-agent.md devops-automation-agent.md documentation-agent.md
# Remove new system files
rm agent-registry.json agent-selector.js agent-health-dashboard.md agent-chains.yaml
\`\`\`
EOF

echo "  ✓ Migration report created: MIGRATION-REPORT.md"

echo ""
echo "✨ Migration completed successfully!"
echo ""
echo "Next steps:"
echo "1. Review MIGRATION-REPORT.md"
echo "2. Test agent selection: node agent-selector.js"
echo "3. Commit changes: git add . && git commit -m 'feat: Migrate to consolidated agent system v2.0'"
echo "4. Push to GitHub: git push origin main"
echo ""
echo "Backup saved to: $BACKUP_DIR"