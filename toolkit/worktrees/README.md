# Parallel Worktrees

**Test multiple solutions simultaneously**

Git worktrees let you work on different branches in separate directories **at the same time**. Perfect for:
- Trying different approaches in parallel
- Comparing implementations side-by-side
- A/B testing solutions before committing

## Quick Start

```bash
# Create a new worktree for JWT auth experiment
make worktree feature-jwt

# Create another for OAuth experiment (in parallel!)
make worktree feature-oauth

# List all worktrees
make worktree-list

# Compare both, then remove the one you don't want
make worktree-rm feature-jwt
```

## Commands

### Create Worktree
```bash
make worktree feature-name
# Creates: ../your-project-feature-name/
```

### List Worktrees
```bash
make worktree-list
# Shows all active worktrees
```

### Remove Worktree
```bash
make worktree-rm feature-name
# Removes worktree and optionally deletes branch
```

### Force Remove (with uncommitted changes)
```bash
make worktree-rm-force feature-name
# ⚠️ Discards uncommitted changes
```

## How It Works

```
your-project/           # Main project (main branch)
├── src/
└── ...

../your-project-jwt/    # Worktree 1 (JWT approach)
├── src/
└── ...

../your-project-oauth/  # Worktree 2 (OAuth approach)
├── src/
└── ...
```

Each worktree:
- Is a full working copy
- Has its own branch
- Shares git history (space efficient)
- Can be worked on simultaneously

## Example Workflow

```bash
# 1. Try JWT authentication
make worktree feature-jwt
cd ../your-project-feature-jwt
# ... implement JWT approach ...
git add . && git commit -m "JWT implementation"

# 2. Try OAuth authentication (in parallel!)
cd ../your-project
make worktree feature-oauth
cd ../your-project-feature-oauth
# ... implement OAuth approach ...
git add . && git commit -m "OAuth implementation"

# 3. Compare both implementations
# Run tests in both, check performance, etc.

# 4. Keep the winner
cd ../your-project
make worktree-rm feature-jwt  # Remove JWT approach
git merge feature-oauth        # Merge OAuth into main

# 5. Clean up
make worktree-rm feature-oauth
```

## Tips

### Parallel Testing
```bash
# Terminal 1
cd ../your-project-approach-a
npm test

# Terminal 2
cd ../your-project-approach-b
npm test
```

### Side-by-Side Comparison
```bash
# Open both in IDE
code ../your-project-approach-a
code ../your-project-approach-b
```

### Safe Experimentation
- Main project stays clean
- Experiments are isolated
- Easy to discard failed attempts
- No branch switching chaos

## Integration

Add to your project's `Makefile`:

```makefile
# Include toolkit
include ~/.claude-toolkit/Makefile.include

# Now you have worktree commands:
# make worktree NAME
# make worktree-list
# make worktree-rm NAME
```

## Source

Simplified from [Microsoft Amplifier](https://github.com/microsoft/amplifier)
- Original: Complex Python scripts with data copying
- Toolkit: Simple bash scripts, git-native
- Philosophy: Ruthless simplicity
