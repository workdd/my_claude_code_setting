#!/bin/bash
# Claude Code Settings Installer
# Usage: ./install.sh

set -e

REPO_DIR="$(cd "$(dirname "$0")" && pwd)"
CLAUDE_DIR="$HOME/.claude"

echo "==> Claude Code Settings Installer"
echo "    Repo: $REPO_DIR"
echo "    Target: $CLAUDE_DIR"
echo ""

# Backup existing settings if present
if [ -f "$CLAUDE_DIR/settings.json" ]; then
    BACKUP="$CLAUDE_DIR/settings.json.backup.$(date +%Y%m%d_%H%M%S)"
    echo "[backup] settings.json → $BACKUP"
    cp "$CLAUDE_DIR/settings.json" "$BACKUP"
fi

# Create necessary directories
mkdir -p "$CLAUDE_DIR/agents"

# Install agents
echo "[install] agents..."
for agent in "$REPO_DIR/agents/"*.md; do
    name=$(basename "$agent")
    cp "$agent" "$CLAUDE_DIR/agents/$name"
    echo "  ✓ agents/$name"
done

# Install settings.json
echo "[install] settings.json..."
cp "$REPO_DIR/settings.json" "$CLAUDE_DIR/settings.json"
echo "  ✓ settings.json"

# Install CLAUDE.md (global instructions)
if [ -f "$REPO_DIR/CLAUDE.md" ]; then
    echo "[install] CLAUDE.md → $HOME/CLAUDE.md..."
    cp "$REPO_DIR/CLAUDE.md" "$HOME/CLAUDE.md"
    echo "  ✓ CLAUDE.md"
fi

echo ""
echo "==> Done! Restart Claude Code to apply changes."
echo ""
echo "Optional: Install peon-ping sound notifications"
echo "  curl -fsSL https://raw.githubusercontent.com/mbrock/peon-ping/main/install.sh | bash"
