#!/bin/bash
# Setup script to copy Ralph files from submodule to test-ralph

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RALPH_DIR="$SCRIPT_DIR/ralph"
TARGET_DIR="$SCRIPT_DIR/scripts/ralph"

echo "Setting up Ralph in test-ralph"
echo ""

# Check if ralph submodule exists
if [ ! -d "$RALPH_DIR" ]; then
  echo "Error: ralph submodule not found at $RALPH_DIR"
  echo "Initialize it with: git submodule update --init --recursive"
  exit 1
fi

# Create target directory
echo "Creating directory: $TARGET_DIR"
mkdir -p "$TARGET_DIR"

# Copy essential files
echo "Copying Ralph files..."
cp "$RALPH_DIR/ralph.sh" "$TARGET_DIR/"
cp "$RALPH_DIR/prompt.md" "$TARGET_DIR/"
cp "$RALPH_DIR/prd.json.example" "$TARGET_DIR/"

# Copy OpenCode README if it exists
if [ -f "$RALPH_DIR/README-OPencode.md" ]; then
  cp "$RALPH_DIR/README-OPencode.md" "$TARGET_DIR/"
fi

# Make ralph.sh executable
chmod +x "$TARGET_DIR/ralph.sh"

echo "Files copied to $TARGET_DIR"
echo ""

# Check if prd.json already exists
if [ ! -f "$TARGET_DIR/prd.json" ]; then
  echo "Creating prd.json from example"
  cp "$TARGET_DIR/prd.json.example" "$TARGET_DIR/prd.json"
  echo "Created $TARGET_DIR/prd.json (edit as needed)"
else
  echo "prd.json already exists, skipping"
fi

echo ""
echo "Setup complete. You can now run:"
echo "  ./scripts/ralph/ralph.sh [iterations] [opencode|amp]"
echo ""
