# Testing Ralph

This guide helps you test the Ralph autonomous AI agent workflow.

## Prerequisites

1. **OpenCode CLI installed and authenticated**
   ```bash
   # Check if installed
   opencode --version
   
   # If not installed
   curl -fsSL https://opencode.ai/install | bash
   
   # Authenticate
   opencode auth login
   ```

2. **jq installed**
   ```bash
   # Check if installed
   jq --version
   
   # Install if needed (Arch Linux)
   sudo pacman -S jq
   ```

3. **Git repository initialized**
   ```bash
   cd "$PROJECT_ROOT"
   git status  # Should show a git repo
   ```

## Test Setup

Set the project root variable:
```bash
export PROJECT_ROOT="$(pwd)"  # Or set to your project path
```

The test PRD is already created at `scripts/ralph/prd.json` with 3 simple stories:
- US-001: Create test configuration file
- US-002: Add test script to package.json
- US-003: Create TEST.md documentation

## Running the Test

### Option 1: Test with OpenCode (Recommended)

```bash
cd "$PROJECT_ROOT"

# Run Ralph with OpenCode for 3 iterations
./scripts/ralph/ralph.sh 3 opencode
```

### Option 2: Auto-detect CLI

```bash
cd "$PROJECT_ROOT"

# Will auto-detect OpenCode or Amp
./scripts/ralph/ralph.sh 3
```

### Option 3: Test with Amp (if you have credits)

```bash
cd "$PROJECT_ROOT"

# Run with Amp
./scripts/ralph/ralph.sh 3 amp
```

## What to Expect

Ralph will:
1. Read `scripts/ralph/prd.json` to find the first story with `passes: false`
2. Check out or create the branch `ralph/test-feature`
3. Implement the story (e.g., create test-config.json)
4. Run quality checks (typecheck)
5. Commit changes with message: `feat: US-001 - Create test configuration file`
6. Update `scripts/ralph/prd.json` to set `passes: true` for completed story
7. Append progress to `scripts/ralph/progress.txt`
8. Repeat for next story

## Monitoring Progress

### Check which stories are done:
```bash
cat "$PROJECT_ROOT/scripts/ralph/prd.json" | jq '.userStories[] | {id, title, passes}'
```

### View progress log:
```bash
cat "$PROJECT_ROOT/scripts/ralph/progress.txt"
```

### Check git commits:
```bash
git log --oneline -10
```

### Check current branch:
```bash
git branch
```

## Expected Output

After running, you should see:
- New files created (test-config.json, TEST.md)
- package.json updated with test script
- Git commits for each completed story
- `scripts/ralph/prd.json` updated with `passes: true` for completed stories
- `scripts/ralph/progress.txt` with learnings from each iteration

## Troubleshooting

### OpenCode not found
```bash
# Install OpenCode
curl -fsSL https://opencode.ai/install | bash
source ~/.zshrc
```

### OpenCode not authenticated
```bash
opencode auth login
```

### jq not found
```bash
# Arch Linux
sudo pacman -S jq

# macOS
brew install jq
```

### Git not initialized
```bash
cd "$PROJECT_ROOT"
git init
git commit --allow-empty -m "Initial commit"
```

### Submodule not initialized
```bash
git submodule update --init --recursive
```

## Stopping Ralph

If you need to stop Ralph mid-execution:
- Press `Ctrl+C` to interrupt
- Ralph will stop at the end of the current iteration
- Progress is saved, you can resume later

## Clean Test Run

To start fresh:
```bash
# Reset PRD (all stories back to passes: false)
cat > "$PROJECT_ROOT/scripts/ralph/prd.json" << 'EOF'
{
  "project": "DemoProject",
  "branchName": "ralph/test-feature",
  "description": "Test Feature - Simple tasks to verify Ralph workflow",
  "userStories": [
    {
      "id": "US-001",
      "title": "Create test configuration file",
      "description": "As a developer, I need a test configuration file to verify the setup.",
      "acceptanceCriteria": [
        "Create test-config.json in project root",
        "Include at least 2 configuration options",
        "File is valid JSON",
        "Typecheck passes"
      ],
      "priority": 1,
      "passes": false,
      "notes": ""
    },
    {
      "id": "US-002",
      "title": "Add test script to package.json",
      "description": "As a developer, I want a test script to run basic checks.",
      "acceptanceCriteria": [
        "Add 'test' script to package.json",
        "Script runs successfully",
        "Typecheck passes"
      ],
      "priority": 2,
      "passes": false,
      "notes": ""
    },
    {
      "id": "US-003",
      "title": "Create TEST.md documentation",
      "description": "As a developer, I want documentation explaining how to test this project.",
      "acceptanceCriteria": [
        "Create TEST.md in project root",
        "Includes setup instructions",
        "Includes test commands",
        "Typecheck passes"
      ],
      "priority": 3,
      "passes": false,
      "notes": ""
    }
  ]
}
EOF

# Clear progress log
echo "# Ralph Progress Log" > "$PROJECT_ROOT/scripts/ralph/progress.txt"
echo "Started: $(date)" >> "$PROJECT_ROOT/scripts/ralph/progress.txt"
echo "---" >> "$PROJECT_ROOT/scripts/ralph/progress.txt"
```
