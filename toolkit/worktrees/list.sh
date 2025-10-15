#!/usr/bin/env bash
# List all git worktrees with enhanced formatting
# Usage: ./list.sh

echo ""
echo "Git Worktrees:"
echo "═══════════════════════════════════════"
echo ""

git worktree list --porcelain | awk '
BEGIN {
    count = 0
}
/^worktree / {
    if (count > 0) print ""
    count++
    path = substr($0, 10)
    print "📁 " path
}
/^HEAD / {
    commit = substr($0, 6, 7)
    print "   Commit: " commit
}
/^branch / {
    branch = substr($0, 24)
    print "   Branch: " branch
}
END {
    if (count == 0) {
        print "No worktrees found"
    } else {
        print ""
        print "Total: " count " worktree(s)"
    }
}
'

echo ""
echo "═══════════════════════════════════════"
echo ""
echo "Commands:"
echo "  Create:  make worktree feature-name"
echo "  Remove:  make worktree-rm feature-name"
echo ""
