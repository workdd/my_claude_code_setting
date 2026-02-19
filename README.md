# My Claude Code Settings

Claude Code 환경 설정 버전 관리 레포. 새 환경에서 동일한 설정을 빠르게 적용할 수 있습니다.

## 포함된 파일

```
my_claude_code_setting/
├── agents/                        # Claude Code 서브에이전트
│   ├── frontend-designer.md       # UI/UX + 프론트엔드 전문 에이전트
│   ├── backend.md                 # 백엔드 API/서버 전문 에이전트
│   └── researcher.md              # 기술 리서치 + 문서화 전문 에이전트
├── plugins/
│   └── glm-assistant/             # 로컬 MCP 플러그인 (GLM-4.5-Air 무료 모델)
│       ├── server.py              # MCP 서버 구현
│       ├── .mcp.json              # MCP 서버 설정 (API 키 환경변수 참조)
│       └── requirements.txt       # Python 의존성
├── tmux/
│   └── tmux.conf                  # tmux 설정 (Shift+Enter, prefix=C-a, TPM 등)
├── settings.json                  # Claude Code 전역 설정 (hooks, permissions, plugins)
├── CLAUDE.md                      # 전역 Claude 지침 (홈 디렉토리에 배치)
├── install.sh                     # 자동 설치 스크립트
└── .gitignore
```

## 빠른 설치

```bash
git clone https://github.com/workdd/my_claude_code_setting.git
cd my_claude_code_setting
chmod +x install.sh
./install.sh
```

설치 후 Claude Code를 재시작하면 적용됩니다.

## 수동 설치

```bash
# 에이전트 설치
mkdir -p ~/.claude/agents
cp agents/*.md ~/.claude/agents/

# 설정 파일 설치
cp settings.json ~/.claude/settings.json

# 전역 지침 설치 (홈 디렉토리에 배치)
cp CLAUDE.md ~/CLAUDE.md
```

## 에이전트 설명

### `frontend-designer`
UI/UX 디자인 및 프론트엔드 개발 전문 에이전트.

- React / Next.js / Vue 3 컴포넌트 설계 및 구현
- Tailwind CSS / CSS Modules 스타일링
- 접근성 (WCAG 2.1 AA), 반응형 레이아웃
- 디자인 시스템 구축, 애니메이션/마이크로인터랙션
- 성능 최적화 (Lazy loading, LCP/CLS 개선)

### `backend`
백엔드 API 설계 및 서버 개발 전문 에이전트.

- REST API / GraphQL 설계 (OpenAPI 3.0)
- Python (FastAPI/Django), Node.js (NestJS/Express), Go
- PostgreSQL, Redis, MongoDB 스키마 설계 및 최적화
- JWT/OAuth 인증, RBAC 권한 관리
- Docker / Kubernetes / CI/CD 인프라

### `researcher`
기술 리서치 및 Obsidian 문서화 전문 에이전트.

- 논문 분석 (arXiv, NeurIPS, ICML 등)
- 라이브러리/프레임워크 비교 분석
- ADR (Architecture Decision Record) 작성
- Obsidian 형식 기술 문서 자동 생성
- 기술 트렌드 및 경쟁사 분석

## 플러그인 설치

### claude-mem (크로스 세션 메모리) - 마켓플레이스

Claude Code 세션 간 기억을 유지하는 플러그인. `settings.json`의 `enabledPlugins`에 이미 포함. 별도 설치 필요.

```bash
# Claude Code 내에서 실행
/plugin install claude-mem@thedotmack
```

### glm-assistant (무료 GLM 모델) - 로컬 MCP 플러그인

토큰 절약용 GLM-4.5-Air 무료 모델 연동 플러그인. `install.sh` 실행 시 자동 설치됨.

**수동 설치:**
```bash
mkdir -p ~/.claude/plugins/local/glm-assistant
cp plugins/glm-assistant/* ~/.claude/plugins/local/glm-assistant/
pip install -r plugins/glm-assistant/requirements.txt

# API 키 설정 (https://openrouter.ai 에서 무료 발급)
export OPENROUTER_API_KEY=sk-or-...
```

**제공 도구 (MCP):**
- `ask_glm` - 일반 질문 (번역, 요약, 설명)
- `ask_glm_code` - 코드 리뷰, 버그 분석
- `ask_glm_quick` - 빠른 단답 (2-3문장 이내)

> `zai-org/glm-4.5-air:free` 모델을 OpenRouter를 통해 무료로 사용합니다.

---

## 선택 설치: peon-ping 사운드 알림

Claude Code 이벤트(시작, 완료, 알림)에 게임 사운드 효과를 추가하는 훅.

```bash
# peon-ping 설치 (별도 레포)
curl -fsSL https://raw.githubusercontent.com/mbrock/peon-ping/main/install.sh | bash
```

`settings.json`의 hooks가 `peon-ping`을 참조하므로, 사용하지 않으려면 hooks 섹션을 제거하세요.

## settings.json 주요 설정

| 설정 | 값 | 설명 |
|------|-----|------|
| `model` | `sonnet` | 기본 모델 |
| `alwaysThinkingEnabled` | `true` | 확장 사고 항상 활성화 |
| `skipDangerousModePermissionPrompt` | `true` | 위험 작업 확인 프롬프트 생략 |
| `permissions.allow` | `["Bash(pkill:*)", "Bash(git commit:*)"]` | 자동 허용 커맨드 |

> ⚠️ `skipDangerousModePermissionPrompt: true`는 개인 환경용 설정입니다. 공유 환경에서는 `false`로 변경 권장.

## tmux 설정

`tmux/tmux.conf` → `~/.tmux.conf` 에 설치됩니다 (`install.sh` 자동 처리).

### 주요 설정

| 기능 | 설정 |
|------|------|
| 프리픽스 | `Ctrl+A` (기본 `Ctrl+B` 대신) |
| Shift+Enter | CSI-u 프로토콜로 Ghostty/xterm 지원 |
| 창 분할 | `prefix + \|` 좌우, `prefix + -` 상하 |
| 창 이동 | `prefix + h/j/k/l` (Vim 스타일) |
| 4분할 이동 | `prefix + u/i/J/K` (고정 위치) |
| 마우스 | 활성화 (`set -g mouse on`) |
| 히스토리 | 10,000줄 |
| 테마 | base16-tmux breadog |

### TPM 플러그인 목록

- `tmux-plugins/tmux-sensible` - 합리적인 기본값
- `mattdavis90/base16-tmux` - breadog 테마

### 신규 환경 설치 후

```bash
# tmux 실행 후 TPM으로 플러그인 설치
tmux
# prefix + I (대문자)
```

---

## API 키 관리

API 키는 **절대 이 레포에 포함하지 마세요.**

```bash
# 권장: ~/.api-keys.env 에 보관 후 .zshrc에서 로드
# ~/.api-keys.env
OPENROUTER_API_KEY=sk-or-...
ANTHROPIC_API_KEY=sk-ant-...

# ~/.zshrc
source ~/.api-keys.env
```

## 업데이트

새 환경에서 최신 설정 동기화:

```bash
cd my_claude_code_setting
git pull
./install.sh
```

로컬 변경사항을 레포에 반영:

```bash
cd my_claude_code_setting

# 에이전트 수정 후 동기화
cp ~/.claude/agents/*.md agents/
cp ~/.claude/settings.json settings.json

git add -A
git commit -m "feat: 에이전트 업데이트"
git push
```