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
echo "=========================================================="
echo "==> 기본 설치 완료! Claude Code를 재시작해 적용하세요."
echo "=========================================================="
echo ""
echo "--- [1] 마켓플레이스 플러그인 (Claude Code 내에서 실행) ---"
echo ""
echo "  # 크로스 세션 메모리"
echo "  /plugin marketplace add thedotmack/claude-mem"
echo "  /plugin install claude-mem@thedotmack"
echo ""
echo "  # 사용량 대시보드 상태줄 (Claude/Codex/Gemini 한도 추적)"
echo "  /plugin marketplace add uppinote20/claude-dashboard"
echo "  /plugin install claude-dashboard@claude-dashboard"
echo ""
echo "  # Anthropic 공식 마켓플레이스 (frontend-design, superpowers 등)"
echo "  /plugin marketplace add anthropics/claude-plugins-official"
echo "  /plugin install frontend-design@claude-plugins-official"
echo "  /plugin install superpowers@claude-plugins-official"
echo ""
echo "--- [2] Cloudflare 스킬군 (선택) ---"
echo ""
echo "  # wrangler / workers / durable-objects / cloudflare-one / sandbox-sdk 등"
echo "  # Cloudflare 공식 스킬 마켓플레이스를 add 후 필요한 스킬만 install"
echo "  # https://github.com/cloudflare (skills 저장소 참고)"
echo ""
echo "--- [3] 독립 도구 (셸에서 실행) ---"
echo ""
echo "  # peon-ping (사운드 알림 훅 — settings.json이 이 경로를 참조함)"
echo "  curl -fsSL https://raw.githubusercontent.com/mbrock/peon-ping/main/install.sh | bash"
echo ""
echo "  # last30days 스킬 (최근 30일 소셜/웹 리서치)"
echo "  # https://github.com/mvanhorn/last30days-skill  (npm skills CLI로 설치)"
echo ""
echo "  # agentcat (AI CLI 사용량 커넥터 — settings.json이 ~/.local/bin/agentcat 참조)"
echo "  # 설치 후 ~/.agentcat/connectors/skills/agentcat-usage 가 스킬로 링크됨"
echo ""
echo "--- [4] humanize-korean 툴킷 (별도 저장소 심볼릭 링크) ---"
echo ""
echo "  # AI 티 제거 한글 윤문 파이프라인 (스킬 3 + 서브에이전트 12)"
echo "  git clone https://github.com/epoko77-ai/im-not-ai.git ~/programming/im-not-ai"
echo "  cd ~/programming/im-not-ai && ./install.sh"
echo "  # install.sh가 ~/.claude/skills, ~/.claude/agents 로 심볼릭 링크를 생성함"
echo ""
echo "--- [5] Open Design MCP (로컬 디자인 워크스페이스, 선택) ---"
echo ""
echo "  # Open Design 앱 설치 후 자동 등록 (권장)"
echo "  open-design mcp install claude"
echo ""
echo "  # 또는 저장된 설정으로 수동 등록 (\$HOME 치환됨)"
echo "  claude mcp add-json open-design \"\$(sed \"s#\\\$HOME#\$HOME#g\" $REPO_DIR/mcp/open-design.json)\""
echo ""
echo "--- [6] AgentBar (macOS 메뉴바 사용량 트래킹, 선택) ---"
echo ""
echo "  gh release download -R scari/AgentBar -p '*.dmg' -D ~/Downloads"
echo "  open ~/Downloads/AgentBar.dmg   # AgentBar.app을 Applications 로 드래그"
echo ""
echo "[note] statusLine은 기본 ~/.claude/statusline.sh 를 씁니다."
echo "       claude-dashboard 설치 후 /claude-dashboard:setup 으로 전환 가능."
