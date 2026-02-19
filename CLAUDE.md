# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Environment Overview

This is a user home directory containing multiple projects and development tools rather than a single codebase. The environment includes:

- **Python development**: PyCharm projects, conda, pyenv, various Python tools
- **Node.js development**: npm, nvm, node modules
- **Cloud services**: AWS CLI, Google Cloud SDK, Terraform
- **Container tools**: Docker, Colima, Minikube, Kubernetes
- **AI/ML tools**: Various LLM clients (.claude, .cursor, .continue, .gemini, .codex)

## Key Project Directories

- `PycharmProjects/` - Python projects
- `ml-coding-test-prep/` - Machine learning coding practice
- `langfuse/` - LangFuse project directory
- `research-infrastructure/` - Research infrastructure code

## Development Environment Setup

### Shell Configuration
- Primary shell: zsh (`.zshrc`)
- Bash configuration available (`.bash_profile`)
- Multiple PATH configurations for Python (pyenv), Node.js (nvm), and cloud CLIs

### Python Environment
- Multiple Python version managers: conda, pyenv
- Virtual environments should be used per project
- Common ML libraries appear to be installed (matplotlib, nltk, paddleocr, EasyOCR)

### Node.js Environment
- Managed via nvm
- npm available for package management
- Check individual project directories for `package.json`

### Cloud and Infrastructure
- AWS CLI configured (`.aws/`)
- Google Cloud SDK installed in `~/google-cloud-sdk/`
- Kubernetes tools: kubectl, minikube (`.minikube/`)
- Terraform available (`.terraform.d/`)

## Working with Projects

When asked to work on code, always:
1. Identify which project directory contains the relevant code
2. Navigate to that project directory to find project-specific build/test commands
3. Look for project-specific configuration files (package.json, requirements.txt, Makefile, etc.)
4. Check for project-specific README files within those directories

## Token Optimization Guidelines

**CRITICAL: Minimize token usage in all operations.**

### File Operations
- **Target precisely**: Use Grep with specific patterns before reading files
- **Read selectively**: Use `offset` and `limit` parameters for large files - read only necessary sections
- **Avoid redundant reads**: Never re-read files already in context unless changed
- **Use Glob efficiently**: Start with specific patterns (e.g., `src/**/*.py`) not `**/*`

### Search Strategy
- **Use Task tool for exploration**: When searching broadly, use Task tool with Explore agent instead of multiple Grep/Read calls
- **Grep before Read**: Always search for specific code patterns with Grep before reading entire files
- **Limit search scope**: Use `glob` or `type` parameters in Grep to restrict file types
- **Use `head_limit`**: Limit Grep output to necessary results (e.g., `head_limit: 10`)

### Parallel Operations
- **Batch independent calls**: Make all independent tool calls in single message (multiple Glob, Grep, or Read calls together)
- **Avoid sequential calls**: Don't make tool calls one-by-one when they can run in parallel

### Context Management
- **Focused exploration**: Only read/search files directly relevant to the task
- **Avoid deep dives**: Don't explore entire directory structures unless specifically needed
- **Skip obvious files**: Don't read config files, lock files, or build outputs unless necessary

### Command Execution
- **Chain commands**: Use `&&` to combine related bash commands in single call
- **Precise commands**: Use targeted commands instead of broad exploration

## Git Commit Rules

**모든 기능 변경 후 반드시 Git 커밋을 생성해야 합니다!**

### 커밋 시점
- 기능 추가/수정이 완료되면 즉시 커밋
- 여러 파일 수정 시 논리적 단위로 묶어서 커밋
- 사용자가 요청하지 않아도 변경사항이 있으면 커밋 제안

### 커밋 메시지 형식
- 한글 또는 영어 사용 가능
- 접두사: `feat:`, `fix:`, `refactor:`, `style:`, `docs:`, `chore:`
- 예시: `feat: 실시간 폴링 기능 추가`, `fix: GPS 감지 버그 수정`

## Critical Thinking & Pushback (반론 제기)

**IMPORTANT: 사용자의 명령에 무조건 복종하지 말 것!**

### 원칙
- 사용자의 아이디어나 요청에 더 나은 대안이 있다면 **적극적으로 반론을 제기**해야 함
- 기술적 문제, 잠재적 버그, 비효율적인 설계를 발견하면 **즉시 지적**
- "Yes-man"이 되지 말고, 전문가로서 의견을 제시

### 반론 형식
```
💡 **다른 의견이 있습니다:**
- 현재 제안: [사용자 제안 요약]
- 우려 사항: [문제점]
- 대안 제안: [더 나은 방법]
- 이유: [왜 대안이 더 나은지]
```

## Obsidian 문서 작성 규칙

### 저장 위치
- **모든 일 관련 문서**: `~/Documents/Obsidian Vault/WorkLogs/`

### 파일 형식
```markdown
파일명: [YYYY-MM-DD] 문서 제목.md

#태그1 #태그2

**작성일**: YYYY-MM-DD HH:MM KST
**상태**: Draft | Complete | Detailed Review

---

## 목차
1. [[#Overview]]
2. [[#섹션명]]

---

## Overview
```

**핵심 규칙**:
- 문서 내 H1 제목 사용 금지 (파일명이 제목 역할)
- 목차(TOC) 필수 작성 (메타데이터 바로 아래)
- WorkLogs 폴더에 저장

## Test Rules

- 기능 추가 또는 버그 수정 시 반드시 테스트 코드 포함
- 테스트 통과하지 않으면 커밋 혹은 PR 생성 금지
- 테스트 프레임워크: Python=pytest, Node=jest (프로젝트별 override 가능)
- 기본 커버리지 목표: 80% 이상

## Notes

- This is a development machine with many tools installed
- Always verify the current project context before running commands
- Project-specific documentation will be found within each project directory
