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

Ralph is available as a git submodule in the `ralph/` folder. You can call it directly from there:

To run Ralph with the default 10 iterations (auto-detects Amp or OpenCode):

```bash
./ralph/ralph.sh
```

To run with a custom number of iterations:

```bash
./ralph/ralph.sh 5
```

To explicitly use OpenCode instead of Amp:

```bash
./ralph/ralph.sh 10 opencode
```

To explicitly use Amp:

```bash
./ralph/ralph.sh 10 amp
```

**Note:** Make sure you have `prd.json` and `progress.txt` in the `ralph/` folder, or create symlinks from your project root.

See `ralph/README-OPencode.md` for OpenCode-specific setup instructions.

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
# Run Ralph with default settings
./ralph/ralph.sh

# Run Ralph for 5 iterations
./ralph/ralph.sh 5

# Run Ralph with OpenCode
./ralph/ralph.sh 10 opencode

# Check project status
npm run typecheck
```

## Files

- `ralph/ralph.sh` - The main Ralph loop script (git submodule)
- `ralph/prompt.md` - Instructions for each iteration
- `ralph/prd.json` - Product requirements document with user stories (create this in ralph/ folder)
- `ralph/progress.txt` - Progress log and learnings (created automatically)

## Current PRD

The PRD (`ralph/prd.json`) should contain your user stories. Example structure:
1. Add demo configuration file
2. Create README with setup instructions
3. Add package.json with dependencies

These are intentionally simple to test the Ralph workflow.

## Checking Status

```bash
# See which stories are done
cat ralph/prd.json | jq '.userStories[] | {id, title, passes}'

# See learnings from previous iterations
cat ralph/progress.txt

# Check git history
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
