# Demo Project

This is a demo project for testing the Ralph autonomous AI agent workflow.

## Setup

1. Ensure you have Node.js installed (required for dependencies)
2. Install project dependencies:
   ```bash
   npm install
   ```
3. Ensure you have one of these AI agent CLIs installed and authenticated:
   - **[Amp CLI](https://ampcode.com)** (default, requires paid credits for non-interactive mode)
   - **[OpenCode CLI](https://opencode.ai)** (alternative, uses your API keys)
4. Ensure `jq` is installed (`brew install jq` on macOS, or your package manager)
5. Initialize a git repository if not already done:
   ```bash
   git init
   git commit --allow-empty -m "Initial commit"
   ```

## Running Ralph

Set the project root variable (optional, defaults to current directory):
```bash
export PROJECT_ROOT="$(pwd)"  # Or set to your project path
```

Ralph is available in the `scripts/ralph/` folder. To run Ralph with the default 10 iterations (auto-detects Amp or OpenCode):

```bash
cd "$PROJECT_ROOT"
./scripts/ralph/ralph.sh
```

To run with a custom number of iterations:

```bash
cd "$PROJECT_ROOT"
./scripts/ralph/ralph.sh 5
```

To explicitly use OpenCode instead of Amp:

```bash
cd "$PROJECT_ROOT"
./scripts/ralph/ralph.sh 10 opencode
```

To explicitly use Amp:

```bash
cd "$PROJECT_ROOT"
./scripts/ralph/ralph.sh 10 amp
```

**Note:** Make sure you have `prd.json` and `progress.txt` in the `scripts/ralph/` folder.

See `scripts/ralph/README-OPencode.md` for OpenCode-specific setup instructions.

## Usage Examples

### Development Workflow
```bash
# Install dependencies
npm install

# Run type checking
npm run typecheck

# Start the application
npm start
```

### Ralph Workflow Examples
```bash
# Set project root (if not already set)
export PROJECT_ROOT="$(pwd)"

# Run Ralph with default settings
cd "$PROJECT_ROOT"
./scripts/ralph/ralph.sh

# Run Ralph for 5 iterations
cd "$PROJECT_ROOT"
./scripts/ralph/ralph.sh 5

# Run Ralph with OpenCode
cd "$PROJECT_ROOT"
./scripts/ralph/ralph.sh 10 opencode

# Check project status
npm run typecheck
```

## Files

- `scripts/ralph/ralph.sh` - The main Ralph loop script
- `scripts/ralph/prompt.md` - Instructions for each iteration
- `scripts/ralph/prd.json` - Product requirements document with user stories (create this in scripts/ralph/ folder)
- `scripts/ralph/progress.txt` - Progress log and learnings (created automatically)
- `ralph/` - Git submodule (source for Ralph scripts, copied to scripts/ralph/ by setup script)

## Current PRD

The PRD (`scripts/ralph/prd.json`) should contain your user stories. Example structure:
1. Add demo configuration file
2. Create README with setup instructions
3. Add package.json with dependencies

These are intentionally simple to test the Ralph workflow.

## Checking Status

```bash
# Set project root if not already set
export PROJECT_ROOT="${PROJECT_ROOT:-$(pwd)}"

# See which stories are done
cat "$PROJECT_ROOT/scripts/ralph/prd.json" | jq '.userStories[] | {id, title, passes}'

# See learnings from previous iterations
cat "$PROJECT_ROOT/scripts/ralph/progress.txt"

# Check git history
cd "$PROJECT_ROOT"
git log --oneline -10
```

## Using the Ralph Submodule

The `ralph/` folder is a git submodule pointing to [https://github.com/martinvalentine/ralph.git](https://github.com/martinvalentine/ralph.git). To update it:

```bash
git submodule update --remote ralph
```

To initialize the submodule (if cloning this repo):
```bash
git submodule update --init --recursive
```
