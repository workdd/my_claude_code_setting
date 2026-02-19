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

# Install glm-assistant local plugin
echo "[install] glm-assistant plugin..."
PLUGIN_DIR="$CLAUDE_DIR/plugins/local/glm-assistant"
mkdir -p "$PLUGIN_DIR"
cp "$REPO_DIR/plugins/glm-assistant/server.py" "$PLUGIN_DIR/"
cp "$REPO_DIR/plugins/glm-assistant/requirements.txt" "$PLUGIN_DIR/"
cp "$REPO_DIR/plugins/glm-assistant/.mcp.json" "$PLUGIN_DIR/"
echo "  ✓ plugins/glm-assistant/"
echo ""
echo "  [!] glm-assistant 의존성 설치:"
echo "      pip install -r $PLUGIN_DIR/requirements.txt"
echo ""
echo "  [!] API 키 설정 필요 (~/.api-keys.env 또는 환경변수):"
echo "      export OPENROUTER_API_KEY=sk-or-..."

echo ""
echo "==> Done! Restart Claude Code to apply changes."
echo ""
echo "--- 추가 플러그인 설치 ---"
echo ""
echo "[optional] claude-mem (크로스 세션 메모리):"
echo "  Claude Code 내에서: /plugin install claude-mem@thedotmack"
echo ""
echo "[optional] peon-ping (사운드 알림):"
echo "  curl -fsSL https://raw.githubusercontent.com/mbrock/peon-ping/main/install.sh | bash"
