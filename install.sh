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

# Install skills
echo "[install] skills..."
mkdir -p "$CLAUDE_DIR/skills"
for skill in "$REPO_DIR/skills/"*.md; do
    name=$(basename "$skill")
    cp "$skill" "$CLAUDE_DIR/skills/$name"
    echo "  ✓ skills/$name"
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

# Install statusline script
echo "[install] statusline.sh..."
cp "$REPO_DIR/statusline.sh" "$CLAUDE_DIR/statusline.sh"
chmod +x "$CLAUDE_DIR/statusline.sh"
echo "  ✓ ~/.claude/statusline.sh"

# Install tmux config
echo "[install] tmux config..."
if [ -f "$HOME/.tmux.conf" ]; then
    cp "$HOME/.tmux.conf" "$HOME/.tmux.conf.backup.$(date +%Y%m%d_%H%M%S)"
    echo "  (backup created)"
fi
cp "$REPO_DIR/tmux/tmux.conf" "$HOME/.tmux.conf"
echo "  ✓ ~/.tmux.conf"

# Install TPM if not present
if [ ! -d "$HOME/.tmux/plugins/tpm" ]; then
    echo "  [!] TPM (Tmux Plugin Manager) 설치 중..."
    git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    echo "  ✓ TPM 설치 완료"
    echo "  [!] tmux 실행 후 prefix + I 로 플러그인 설치하세요"
else
    echo "  ✓ TPM 이미 설치됨"
fi

echo ""
echo "==> Done! Restart Claude Code to apply changes."
echo ""
echo "--- 추가 플러그인 설치 (Claude Code 내에서) ---"
echo ""
echo "[optional] claude-mem (크로스 세션 메모리):"
echo "  /plugin install claude-mem@thedotmack"
echo ""
echo "[optional] jeffallan skills (66개 전문 스킬 - 에이전트 성능 향상):"
echo "  /plugin marketplace add jeffallan/claude-skills"
echo "  /plugin install fullstack-dev-skills@jeffallan"
echo ""
echo "[optional] peon-ping (사운드 알림):"
echo "  curl -fsSL https://raw.githubusercontent.com/mbrock/peon-ping/main/install.sh | bash"
