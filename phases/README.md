# Phases — 전체 구현 로드맵
- Harness 프레임워크로 관리되는 n개 Phase. 각 Phase는 `phases/{dir}/` 하위에 `index.json` + `step*.md` 파일로 존재.
**실행**: `python3 scripts/execute.py {phase-name}`
**현재 상태**: `phases/index.json` 참조 (상태값: pending / completed / error / blocked)

## Phase 용어 약속 (중요)

"Phase"라는 단어가 프로젝트에서 **세 가지 레벨**에서 쓰인다. 혼동하지 않도록 다음 규칙으로 통일한다:

| 레벨 | 의미 | 디렉토리/파일명 예시 | 실행 커맨드 예시 |
|------|------|-------------------|----------------|
| **Phase 단계** (0, 1, 2...) | 큰 기능 블록 | `0-mvp/`, `1-auth/` | `execute.py 0-mvp` |
| **Phase 버전** (1.1, 1.2...) | Phase 내 세부 반복/개선 | `1.1-basic-auth/`, `1.2-oauth/` | `execute.py 1.1-basic-auth` |
| **Step** (0, 1, 2...) | Phase를 구현하는 단위 | `step0.md`, `step1.md` | execute.py가 자동 순차 실행 |

예시: Phase 1.2 내에 Step이 4개 → `phases/1.2-oauth/` 안에 `step0.md` ~ `step3.md`