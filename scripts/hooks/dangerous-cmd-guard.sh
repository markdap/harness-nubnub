#!/bin/bash
# PreToolUse 훅: 위험한 명령어 차단
# Claude Code가 Bash 도구 호출 전에 자동 실행된다.

if echo "$CLAUDE_TOOL_INPUT" | grep -qE 'rm\s+-rf|git\s+push\s+--force|git\s+reset\s+--hard|DROP\s+TABLE'; then
    echo 'BLOCKED: 위험한 명령어가 감지되었습니다. 정말 필요하면 감독님에게 확인을 요청하세요.' >&2
    exit 1
fi
