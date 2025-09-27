#!/bin/bash

# Kill all vitest and test-related node processes
# This prevents process accumulation when Claude Code runs tests
echo "🧹 Cleaning up test processes..."

# Kill vitest processes
pkill -f vitest 2>/dev/null || true

# Kill node test processes
pkill -f "node.*test" 2>/dev/null || true

# Kill jest processes (if any)
pkill -f jest 2>/dev/null || true

# Kill playwright processes
pkill -f playwright 2>/dev/null || true

# Count remaining processes
VITEST_COUNT=$(ps aux | grep -i vitest | grep -v grep | wc -l)
NODE_TEST_COUNT=$(ps aux | grep "node.*test" | grep -v grep | wc -l)

if [ "$VITEST_COUNT" -eq 0 ] && [ "$NODE_TEST_COUNT" -eq 0 ]; then
    echo "✅ All test processes cleaned up successfully!"
else
    echo "⚠️  Some processes might still be running:"
    echo "   Vitest processes: $VITEST_COUNT"
    echo "   Node test processes: $NODE_TEST_COUNT"
    echo ""
    echo "Run 'killall -9 node' to force kill all node processes (careful!)"
fi