#!/usr/bin/env bash
# Create a git worktree for parallel development
# Usage: ./create.sh feature-name

set -e  # Exit on error

# Check if branch name provided
if [ -z "$1" ]; then
    echo "Error: Please provide a branch name"
    echo "Usage: $0 feature-name"
    exit 1
fi

BRANCH_NAME="$1"
REPO_ROOT=$(git rev-parse --show-toplevel)
WORKTREE_DIR="../$(basename "$REPO_ROOT")-$BRANCH_NAME"

# Check if worktree already exists
if [ -d "$WORKTREE_DIR" ]; then
    echo "Error: Worktree directory already exists: $WORKTREE_DIR"
    exit 1
fi

# Check if branch already exists
if git show-ref --verify --quiet "refs/heads/$BRANCH_NAME"; then
    echo "Error: Branch '$BRANCH_NAME' already exists"
    echo "Use 'git worktree add' directly if you want to check out existing branch"
    exit 1
fi

echo "Creating worktree for branch: $BRANCH_NAME"
echo "Location: $WORKTREE_DIR"

# Create the worktree
git worktree add "$WORKTREE_DIR" -b "$BRANCH_NAME"

echo ""
echo "✅ Worktree created successfully!"
echo ""
echo "To work in this worktree:"
echo "  cd $WORKTREE_DIR"
echo ""
echo "To list all worktrees:"
echo "  git worktree list"
echo ""
echo "To remove this worktree:"
echo "  make worktree-rm $BRANCH_NAME"
echo "  # or: git worktree remove $WORKTREE_DIR"
