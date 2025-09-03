#!/bin/bash

echo "🚀 ENTERPRISE AGENT SYSTEM v2.0"
echo "================================"
echo ""
echo "Loading CLAUDE Framework Agents..."
echo ""

# Check if agent files exist
AGENTS_DIR="$HOME/.claude/agents"
REQUIRED_AGENTS=(
    "master-orchestrator.md"
    "solutions-architect.md"
    "security-specialist.md"
    "full-stack-developer.md"
    "qa-engineer.md"
    "devops-engineer.md"
)

echo "✅ Checking agent files..."
for agent in "${REQUIRED_AGENTS[@]}"; do
    if [ -f "$AGENTS_DIR/$agent" ]; then
        echo "   ✓ $agent found"
    else
        echo "   ✗ $agent MISSING!"
    fi
done

echo ""
echo "📋 Available Agents:"
echo "  1. Master Orchestrator - Coordinates all agents"
echo "  2. Solutions Architect - System design"
echo "  3. Security Specialist - Security implementation"
echo "  4. Full-Stack Developer - Code implementation"
echo "  5. QA Engineer - Testing"
echo "  6. DevOps Engineer - Deployment"
echo ""
echo "🎯 Ready to use! Start with:"
echo '   "Use the Master Orchestrator to coordinate building my application"'
echo ""
