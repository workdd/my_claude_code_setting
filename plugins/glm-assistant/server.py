#!/usr/bin/env python3
"""
GLM Assistant MCP Server
토큰 절약을 위한 GLM-4.5-Air 통합 서버
"""

import os
import json
import asyncio
from typing import Any
import httpx

# MCP SDK 임포트
try:
    from mcp.server import Server
    from mcp.types import Tool, TextContent
    import mcp.server.stdio
except ImportError:
    print("MCP SDK not installed. Run: pip install mcp", file=__import__('sys').stderr)
    exit(1)

# 환경 설정
OPENROUTER_API_KEY = os.getenv("OPENROUTER_API_KEY")
OPENROUTER_BASE_URL = "https://openrouter.ai/api/v1"
GLM_MODEL = "zai-org/glm-4.5-air:free"

# MCP 서버 초기화
app = Server("glm-assistant")


async def call_glm(prompt: str, system_prompt: str = None, max_tokens: int = 4000) -> str:
    """GLM API 호출"""
    if not OPENROUTER_API_KEY:
        return "❌ OPENROUTER_API_KEY 환경변수가 설정되지 않았습니다."

    messages = []
    if system_prompt:
        messages.append({"role": "system", "content": system_prompt})
    messages.append({"role": "user", "content": prompt})

    try:
        async with httpx.AsyncClient(timeout=60.0) as client:
            response = await client.post(
            f"{OPENROUTER_BASE_URL}/chat/completions",
            headers={
                "Authorization": f"Bearer {OPENROUTER_API_KEY}",
                "HTTP-Referer": "https://claude-code.local",
                "X-Title": "Claude Code GLM Assistant"
            },
            json={
                "model": GLM_MODEL,
                "messages": messages,
                "max_tokens": max_tokens,
                "temperature": 0.7
            }
            )
            response.raise_for_status()
            result = response.json()
            return result["choices"][0]["message"]["content"]
    except Exception as e:
        return f"❌ GLM API 호출 실패: {str(e)}"


@app.list_tools()
async def list_tools() -> list[Tool]:
    """사용 가능한 도구 목록"""
    return [
        Tool(
            name="ask_glm",
            description="토큰 절약용 GLM-4.5-Air에게 일반 질문하기. 간단한 작업, 번역, 요약, 설명 등에 활용.",
            inputSchema={
                "type": "object",
                "properties": {
                    "question": {
                        "type": "string",
                        "description": "GLM에게 할 질문"
                    }
                },
                "required": ["question"]
            }
        ),
        Tool(
            name="ask_glm_code",
            description="GLM에게 코드 관련 질문하기. 코드 리뷰, 버그 분석, 간단한 리팩토링 제안 등에 활용.",
            inputSchema={
                "type": "object",
                "properties": {
                    "code": {
                        "type": "string",
                        "description": "분석할 코드"
                    },
                    "question": {
                        "type": "string",
                        "description": "코드에 대한 질문"
                    }
                },
                "required": ["code", "question"]
            }
        ),
        Tool(
            name="ask_glm_quick",
            description="GLM에게 빠른 답변 요청. 짧은 질문, Yes/No, 간단한 확인 등에 활용.",
            inputSchema={
                "type": "object",
                "properties": {
                    "question": {
                        "type": "string",
                        "description": "빠르게 답변받을 질문"
                    }
                },
                "required": ["question"]
            }
        )
    ]


@app.call_tool()
async def call_tool(name: str, arguments: Any) -> list[TextContent]:
    """도구 실행"""

    if name == "ask_glm":
        question = arguments.get("question", "")
        answer = await call_glm(question)
        return [TextContent(type="text", text=f"🤖 GLM: {answer}")]

    elif name == "ask_glm_code":
        code = arguments.get("code", "")
        question = arguments.get("question", "")

        system_prompt = """당신은 코드 리뷰와 분석 전문가입니다.
코드의 문제점, 개선 방안, 버그를 정확하게 파악하고 간결하게 설명합니다."""

        prompt = f"""다음 코드를 분석해주세요:

```
{code}
```

질문: {question}"""

        answer = await call_glm(prompt, system_prompt=system_prompt)
        return [TextContent(type="text", text=f"🤖 GLM (코드 분석): {answer}")]

    elif name == "ask_glm_quick":
        question = arguments.get("question", "")
        system_prompt = "간결하고 명확하게 핵심만 답변하세요. 2-3문장 이내로 답변합니다."
        answer = await call_glm(question, system_prompt=system_prompt, max_tokens=500)
        return [TextContent(type="text", text=f"🤖 GLM (빠른 답변): {answer}")]

    else:
        return [TextContent(type="text", text=f"❌ 알 수 없는 도구: {name}")]


async def main():
    """MCP 서버 실행"""
    async with mcp.server.stdio.stdio_server() as (read_stream, write_stream):
        await app.run(
            read_stream,
            write_stream,
            app.create_initialization_options()
        )


if __name__ == "__main__":
    asyncio.run(main())
