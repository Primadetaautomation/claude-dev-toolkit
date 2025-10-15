#!/usr/bin/env bash
# Remove a git worktree
# Usage: ./remove.sh feature-name [--force]

set -e  # Exit on error

# Check if branch name provided
if [ -z "$1" ]; then
    echo "Error: Please provide a branch name"
    echo "Usage: $0 feature-name [--force]"
    exit 1
fi

BRANCH_NAME="$1"
FORCE_FLAG=""

# Check for --force flag
if [ "$2" = "--force" ]; then
    FORCE_FLAG="--force"
    echo "⚠️  Force removal enabled - uncommitted changes will be lost"
fi

REPO_ROOT=$(git rev-parse --show-toplevel)
WORKTREE_DIR="../$(basename "$REPO_ROOT")-$BRANCH_NAME"

# Check if worktree exists
if [ ! -d "$WORKTREE_DIR" ]; then
    echo "Error: Worktree directory not found: $WORKTREE_DIR"
    echo ""
    echo "Available worktrees:"
    git worktree list
    exit 1
fi

# Check for uncommitted changes (unless force)
if [ -z "$FORCE_FLAG" ]; then
    cd "$WORKTREE_DIR"
    if ! git diff-index --quiet HEAD -- 2>/dev/null || ! git diff --quiet 2>/dev/null; then
        echo "Error: Worktree has uncommitted changes"
        echo ""
        echo "Options:"
        echo "  1. Commit your changes first"
        echo "  2. Use --force to remove anyway (changes will be lost)"
        echo ""
        echo "Usage: $0 $BRANCH_NAME --force"
        exit 1
    fi
    cd - > /dev/null
fi

echo "Removing worktree: $WORKTREE_DIR"

# Remove the worktree
if [ -n "$FORCE_FLAG" ]; then
    git worktree remove "$WORKTREE_DIR" --force
else
    git worktree remove "$WORKTREE_DIR"
fi

# Ask if user wants to delete the branch too
echo ""
read -p "Delete branch '$BRANCH_NAME' as well? [y/N]: " -n 1 -r
echo ""
if [[ $REPLY =~ ^[Yy]$ ]]; then
    git branch -D "$BRANCH_NAME"
    echo "✅ Worktree and branch removed"
else
    echo "✅ Worktree removed (branch '$BRANCH_NAME' kept)"
fi
