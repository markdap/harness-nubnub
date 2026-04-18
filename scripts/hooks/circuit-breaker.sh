#!/bin/bash
# Circuit Breaker: 60초 안에 같은 에러가 5번 반복되면 경고
# 사용법: bash scripts/hooks/circuit-breaker.sh [에러-키]
# 예시:  bash scripts/hooks/circuit-breaker.sh "build-fail"

CIRCUIT_KEY="${1:-default}"
SAFE_KEY="${CIRCUIT_KEY//[^a-zA-Z0-9]/_}"
ERROR_LOG="/tmp/harness_cb_${SAFE_KEY}.log"
CURRENT_TIME=$(date +%s)
CUTOFF_TIME=$((CURRENT_TIME - 60))
THRESHOLD=5

# 현재 에러 기록
echo "$CURRENT_TIME" >> "$ERROR_LOG"

# 60초 내 에러 수 계산
RECENT_COUNT=$(awk -v cutoff="$CUTOFF_TIME" '$1 > cutoff' "$ERROR_LOG" 2>/dev/null | wc -l | tr -d ' ')

# 오래된 로그 정리
awk -v cutoff="$CUTOFF_TIME" '$1 > cutoff' "$ERROR_LOG" 2>/dev/null > "${ERROR_LOG}.tmp" && mv "${ERROR_LOG}.tmp" "$ERROR_LOG"

if [ "$RECENT_COUNT" -ge "$THRESHOLD" ]; then
    echo "⚠️  Circuit Breaker 발동: 60초 안에 ${RECENT_COUNT}번 실패했습니다. 접근 방식을 바꿔보세요." >&2
    exit 1
fi
