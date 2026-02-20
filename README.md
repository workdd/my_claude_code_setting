# My Claude Code Settings

Claude Code 환경 설정 버전 관리 레포. 새 환경에서 동일한 설정을 빠르게 적용할 수 있습니다.

## 포함된 파일

```
my_claude_code_setting/
├── agents/                        # Claude Code 서브에이전트
│   ├── frontend-designer.md       # UI/UX + 프론트엔드 전문 에이전트
│   ├── backend.md                 # 백엔드 API/서버 전문 에이전트
│   └── researcher.md              # 기술 리서치 + 문서화 전문 에이전트
├── skills/                        # Skills (agents에서 참조)
│   │
│   ├── [Anthropic Official]
│   ├── frontend-design.md         # 프로덕션급 UI 설계 가이드
│   ├── web-artifacts-builder.md   # React+Vite+Tailwind HTML 아티팩트 빌더
│   ├── canvas-design.md           # PNG/PDF 비주얼 디자인
│   ├── webapp-testing.md          # Playwright 웹앱 테스트
│   ├── mcp-builder.md             # MCP 서버 개발 가이드
│   ├── pdf.md                     # PDF 처리
│   ├── docx.md                    # Word 문서 처리
│   ├── xlsx.md                    # Excel 스프레드시트 처리
│   │
│   ├── [Jeffallan/claude-skills]
│   ├── react-expert.md            # React 전문 가이드
│   ├── nextjs-developer.md        # Next.js 개발 가이드
│   ├── typescript-pro.md          # TypeScript 전문 가이드
│   ├── playwright-expert.md       # Playwright E2E 테스트
│   ├── vue-expert.md              # Vue 3 전문 가이드
│   ├── javascript-pro.md          # JavaScript 전문 가이드
│   ├── fastapi-expert.md          # FastAPI 백엔드 가이드
│   ├── nestjs-expert.md           # NestJS 백엔드 가이드
│   ├── api-designer.md            # API 설계 가이드
│   ├── postgres-pro.md            # PostgreSQL 전문 가이드
│   ├── python-pro.md              # Python 전문 가이드
│   ├── graphql-architect.md       # GraphQL 아키텍처
│   ├── microservices-architect.md # 마이크로서비스 아키텍처
│   ├── secure-code-guardian.md    # 보안 코드 리뷰
│   ├── test-master.md             # 테스트 전략 가이드
│   ├── spec-miner.md              # 스펙 분석 가이드
│   ├── code-documenter.md         # 코드 문서화 가이드
│   ├── architecture-designer.md   # 아키텍처 설계 가이드
│   ├── the-fool.md                # The Fool 탐색/창의 가이드
│   │
│   ├── [feiskyer/claude-code-settings]
│   ├── codex-skill.md             # OpenAI Codex/GPT 코드 구현 ✅ 바로 사용
│   ├── deep-research.md           # 멀티에이전트 심층 조사 ✅ 바로 사용
│   ├── youtube-transcribe-skill.md # YouTube 자막 추출 ✅ 바로 사용
│   ├── autonomous-skill.md        # 장시간 자율 작업 실행 ⚠️ 플러그인 설치 필요
│   ├── kiro-skill.md              # 기능 개발 워크플로우 ⚠️ 플러그인 설치 필요
│   ├── nanobanana-skill.md        # AI 이미지 생성 (Gemini) ⚠️ 플러그인 설치 필요
│   └── spec-kit-skill.md          # 스펙 기반 개발 ⚠️ 플러그인 설치 필요
├── plugins/
│   └── glm-assistant/             # 로컬 MCP 플러그인 (GLM-4.5-Air 무료 모델)
│       ├── server.py              # MCP 서버 구현
│       ├── .mcp.json              # MCP 서버 설정 (API 키 환경변수 참조)
│       └── requirements.txt       # Python 의존성
├── tmux/
│   └── tmux.conf                  # tmux 설정 (Shift+Enter, prefix=C-a, TPM 등)
├── statusline.sh                  # 상태바 스크립트 (모델/git/컨텍스트/비용 표시)
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

## 에이전트 & Skills 매핑

| 에이전트 | Skills (anthropics) | Skills (jeffallan) |
|----------|--------------------|--------------------|
| `frontend-designer` | `frontend-design`, `web-artifacts-builder`, `canvas-design`, `webapp-testing` | `react-expert`, `nextjs-developer`, `typescript-pro`, `playwright-expert`, `vue-expert`, `javascript-pro` |
| `backend` | `mcp-builder` | `fastapi-expert`, `nestjs-expert`, `api-designer`, `postgres-pro`, `python-pro`, `graphql-architect`, `microservices-architect`, `secure-code-guardian`, `test-master` |
| `researcher` | `pdf`, `docx`, `xlsx` | `spec-miner`, `code-documenter`, `architecture-designer`, `the-fool` |

Skills 출처:
- [anthropics/skills](https://github.com/anthropics/skills) — `skills/` 디렉토리에 포함 (자동 설치)
- [Jeffallan/claude-skills](https://github.com/Jeffallan/claude-skills) — `skills/` 디렉토리에 포함 (자동 설치)
- [feiskyer/claude-code-settings](https://github.com/feiskyer/claude-code-settings) — SKILL.md는 포함, 일부 플러그인 별도 설치 필요 (아래 참조)

---

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

### feiskyer/claude-code-settings 스킬 (일부 수동 설치 필요)

`skills/` 디렉토리에 SKILL.md가 포함되어 있지만, 일부 스킬은 **헬퍼 스크립트 포함 전체 플러그인 설치**가 필요합니다.

#### ✅ 바로 사용 가능 (SKILL.md만으로 동작)

| 스킬 | 설명 | 사전 요구사항 |
|------|------|------|
| `codex-skill` | OpenAI Codex/GPT로 코드 자동 구현 | `codex` CLI 설치 필요: `npm install -g @openai/codex` |
| `deep-research` | 멀티에이전트 심층 조사 워크플로우 | Firecrawl/Exa MCP 있으면 더 강력 (없어도 동작) |
| `youtube-transcribe-skill` | YouTube 자막/트랜스크립트 추출 | `yt-dlp` (이미 설치됨) |

#### ⚠️ 플러그인 설치 필요 (헬퍼 스크립트 포함)

아래 스킬은 SKILL.md 외에 helper scripts/Python 파일이 있어 전체 기능을 위해 플러그인 설치가 필요합니다.

**Claude Code 내에서 실행:**
```
/plugin marketplace add feiskyer/claude-code-settings
```

그 후 개별 설치:
```
/plugin install kiro-skill@feiskyer-claude-code-settings
/plugin install autonomous-skill@feiskyer-claude-code-settings
/plugin install spec-kit-skill@feiskyer-claude-code-settings
/plugin install nanobanana-skill@feiskyer-claude-code-settings
```

| 스킬 | 설명 | 추가 요구사항 |
|------|------|------|
| `kiro-skill` | 요구사항→설계→태스크→구현 워크플로우 | 없음 |
| `autonomous-skill` | 장시간 멀티세션 자율 작업 | 없음 |
| `spec-kit-skill` | Spec-Kit 헌법 기반 스펙 주도 개발 | `specify` CLI 설치 필요 |
| `nanobanana-skill` | Google Gemini API로 이미지 생성/편집 | `GOOGLE_API_KEY` 환경변수 필요 |

**nanobanana-skill 추가 설정:**
```bash
# Google AI Studio에서 무료 API 키 발급: https://aistudio.google.com
export GOOGLE_API_KEY=your-key-here
pip install google-generativeai pillow
```

---

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

### notebooklm-mcp (NotebookLM 연동) - MCP 서버

Google NotebookLM과 AI 에이전트를 직접 연결하는 MCP 서버. 문서를 NotebookLM에 업로드하면 에이전트가 직접 질의하여 hallucination 없는 답변을 받습니다.

**설치:**
```bash
claude mcp add notebooklm npx notebooklm-mcp@latest
```

**최초 인증:**
```
"Log me in to NotebookLM"
```
Chrome 창에서 Google 계정 로그인 후 자동 인증.

**사용 방법:**
1. [notebooklm.google.com](https://notebooklm.google.com)에서 노트북 생성 후 문서 업로드
2. 공유 링크 복사 (Anyone with link)
3. Claude에게 링크 전달: `"이 NotebookLM 참고해서 작업해줘: [link]"`

**주요 특징:**
- Zero-hallucination: NotebookLM이 모르면 거부 (추측 없음)
- Citation-backed: 모든 답변에 출처 포함
- 멀티소스 종합: 50+ 문서 간 정보 연결
- 토큰 절약: 문서를 직접 읽지 않고 NotebookLM에 질의

> GitHub: [PleasePrompto/notebooklm-mcp](https://github.com/PleasePrompto/notebooklm-mcp)

---

## 선택 설치: peon-ping 사운드 알림

Claude Code 이벤트(시작, 완료, 알림)에 게임 사운드 효과를 추가하는 훅.

```bash
# peon-ping 설치 (별도 레포)
curl -fsSL https://raw.githubusercontent.com/mbrock/peon-ping/main/install.sh | bash
```

`settings.json`의 hooks가 `peon-ping`을 참조하므로, 사용하지 않으려면 hooks 섹션을 제거하세요.


## 선택 설치: AgentBar AI 사용량 트래킹

macOS 메뉴바에서 여러 AI 코딩 어시스턴트의 사용량을 통합 모니터링하는 앱.

**지원 서비스:**
- Claude Code (Anthropic OAuth API, Keychain 저장)
- OpenAI Codex (로컬 세션 로그)
- Google Gemini (로컬 로그 파일)
- GitHub Copilot (GitHub Copilot API)
- Cursor (Cursor API + 로컬 DB)
- Z.ai (Z.ai quota API)

**주요 기능:**
- 메뉴바에 서비스별 사용량 바 표시 (사용량 순 정렬)
- 상세 사용량 팝오버 (서비스별 메트릭)
- 데스크톱 알림 (에이전트 이벤트)
- 커스텀 사운드 팩 지원

**설치 방법:**
```bash
# GitHub Releases에서 최신 DMG 다운로드 및 자동 설치
gh release download -R scari/AgentBar -p "*.dmg" -D ~/Downloads
open ~/Downloads/AgentBar.dmg
# AgentBar.app을 Applications 폴더로 드래그
```

**또는 자동 설치 (install.sh 사용):**
```bash
./install.sh --agentbar
```

> API 키는 macOS Keychain을 통해 안전하게 관리됩니다.


## settings.json 주요 설정

| 설정 | 값 | 설명 |
|------|-----|------|
| `model` | `sonnet` | 기본 모델 |
| `alwaysThinkingEnabled` | `true` | 확장 사고 항상 활성화 |
| `skipDangerousModePermissionPrompt` | `true` | 위험 작업 확인 프롬프트 생략 |
| `permissions.allow` | `["Bash(pkill:*)", "Bash(git commit:*)"]` | 자동 허용 커맨드 |
| `statusLine` | `~/.claude/statusline.sh` | 하단 상태바: 모델·git·컨텍스트·비용·시간 표시 |

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