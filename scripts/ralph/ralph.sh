#!/bin/bash
# Ralph Wiggum - Long-running AI agent loop
# Usage: ./ralph.sh [max_iterations] [agent_cli]
#   agent_cli: 'amp' (default) or 'opencode'

set -e

MAX_ITERATIONS=${1:-10}
AGENT_CLI=${2:-auto}
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PRD_FILE="$SCRIPT_DIR/prd.json"
PROGRESS_FILE="$SCRIPT_DIR/progress.txt"
ARCHIVE_DIR="$SCRIPT_DIR/archive"
LAST_BRANCH_FILE="$SCRIPT_DIR/.last-branch"

# Detect which CLI to use if not specified or set to "auto"
if [ "$AGENT_CLI" = "auto" ] || [ -z "$AGENT_CLI" ]; then
  if command -v amp >/dev/null 2>&1; then
    AGENT_CLI="amp"
  elif command -v opencode >/dev/null 2>&1; then
    AGENT_CLI="opencode"
  else
    echo "Error: Neither 'amp' nor 'opencode' found in PATH"
    echo "Please install one of them:"
    echo "  Amp: https://ampcode.com"
    echo "  OpenCode: https://opencode.ai"
    exit 1
  fi
fi

# Verify the selected CLI is available
if ! command -v "$AGENT_CLI" >/dev/null 2>&1; then
  echo "Error: $AGENT_CLI not found in PATH"
  exit 1
fi

echo "Using agent CLI: $AGENT_CLI"

# Archive previous run if branch changed
if [ -f "$PRD_FILE" ] && [ -f "$LAST_BRANCH_FILE" ]; then
  CURRENT_BRANCH=$(jq -r '.branchName // empty' "$PRD_FILE" 2>/dev/null || echo "")
  LAST_BRANCH=$(cat "$LAST_BRANCH_FILE" 2>/dev/null || echo "")
  
  if [ -n "$CURRENT_BRANCH" ] && [ -n "$LAST_BRANCH" ] && [ "$CURRENT_BRANCH" != "$LAST_BRANCH" ]; then
    # Archive the previous run
    DATE=$(date +%Y-%m-%d)
    # Strip "ralph/" prefix from branch name for folder
    FOLDER_NAME=$(echo "$LAST_BRANCH" | sed 's|^ralph/||')
    ARCHIVE_FOLDER="$ARCHIVE_DIR/$DATE-$FOLDER_NAME"
    
    echo "Archiving previous run: $LAST_BRANCH"
    mkdir -p "$ARCHIVE_FOLDER"
    [ -f "$PRD_FILE" ] && cp "$PRD_FILE" "$ARCHIVE_FOLDER/"
    [ -f "$PROGRESS_FILE" ] && cp "$PROGRESS_FILE" "$ARCHIVE_FOLDER/"
    echo "   Archived to: $ARCHIVE_FOLDER"
    
    # Reset progress file for new run
    echo "# Ralph Progress Log" > "$PROGRESS_FILE"
    echo "Started: $(date)" >> "$PROGRESS_FILE"
    echo "---" >> "$PROGRESS_FILE"
  fi
fi

# Track current branch
if [ -f "$PRD_FILE" ]; then
  CURRENT_BRANCH=$(jq -r '.branchName // empty' "$PRD_FILE" 2>/dev/null || echo "")
  if [ -n "$CURRENT_BRANCH" ]; then
    echo "$CURRENT_BRANCH" > "$LAST_BRANCH_FILE"
  fi
fi

# Initialize progress file if it doesn't exist
if [ ! -f "$PROGRESS_FILE" ]; then
  echo "# Ralph Progress Log" > "$PROGRESS_FILE"
  echo "Started: $(date)" >> "$PROGRESS_FILE"
  echo "---" >> "$PROGRESS_FILE"
fi

echo "Starting Ralph - Max iterations: $MAX_ITERATIONS"

for i in $(seq 1 $MAX_ITERATIONS); do
  echo ""
  echo "═══════════════════════════════════════════════════════"
  echo "  Ralph Iteration $i of $MAX_ITERATIONS"
  echo "═══════════════════════════════════════════════════════"
  
  # Run the selected agent CLI with the ralph prompt
  if [ "$AGENT_CLI" = "amp" ]; then
    OUTPUT=$(cat "$SCRIPT_DIR/prompt.md" | amp --dangerously-allow-all 2>&1 | tee /dev/stderr) || true
  elif [ "$AGENT_CLI" = "opencode" ]; then
    # OpenCode command - reads prompt from stdin
    # Using model: opencode/big-pickle (default)
    # Other free models available: opencode/glm-4.7-free, opencode/minimax-m2.1-free
    # To use your own API keys, configure with: opencode auth login
    # Format can be 'default' or 'json' - using default for readable output
    PROMPT_CONTENT=$(cat "$SCRIPT_DIR/prompt.md")
    OUTPUT=$(echo "$PROMPT_CONTENT" | opencode run --model opencode/big-pickle --format default 2>&1 | tee /dev/stderr) || true
  else
    echo "Error: Unknown agent CLI: $AGENT_CLI"
    exit 1
  fi
  
  # Check for completion signal
  if echo "$OUTPUT" | grep -q "<promise>COMPLETE</promise>"; then
    echo ""
    echo "Ralph completed all tasks!"
    echo "Completed at iteration $i of $MAX_ITERATIONS"
    exit 0
  fi
  
  echo "Iteration $i complete. Continuing..."
  sleep 2
done

echo ""
echo "Ralph reached max iterations ($MAX_ITERATIONS) without completing all tasks."
echo "Check $PROGRESS_FILE for status."
exit 1
