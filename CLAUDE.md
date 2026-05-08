<!--
이 파일은 AI가 코딩할 때 가장 먼저 읽는 "헌법"이다.
프로젝트가 무엇인지 설명하는 글이 아니다. 코드 짜기 전 무조건 따라야 할 규칙만 담는다.

새 프로젝트를 시작할 때 {} 플레이스홀더를 채울 것.
**채우는 순서는 PRD → ARCHITECTURE → ADR → CLAUDE.md (마지막).** 다른 파일이 비어있으면 거기부터 채운 뒤 돌아오라.

★ CLAUDE.md에 들어갈 것 (= 아래 5개 섹션이 전부):
  - 기술 스택 (어떤 프레임워크·언어·라이브러리)
  - 아키텍처 규칙 (CRITICAL = 어겼을 때 시스템이 깨짐)
  - 개발 프로세스 (TDD, 커밋 메시지 형식 등)
  - 로드맵 Phase 용어 약속 (디렉토리 네이밍)
  - SubAgent / 원칙

★ CLAUDE.md에 절대 들어가면 안 되는 것 (각각 다른 파일로):
  - 사용자·타겟 고객 정의 → docs/PRD.md
  - 기능 enumeration · MVP 포함/제외 → docs/PRD.md
  - v2 로드맵 → docs/PRD.md 또는 phases/ 후속 디렉토리
  - phase 진행 순서·timeline → phases/ 디렉토리 구조 자체로 자명
  - 결정 근거·트레이드오프 (왜 이 기술인가) → docs/ADR.md
  - 도메인·아키텍처 세부 (데이터 흐름, 폴더 구조 등) → docs/ARCHITECTURE.md

판단 기준 한 줄: "AI가 코드 짜기 직전에 이걸 안 읽으면 사고가 나는가?"
  → YES면 CLAUDE.md. NO면 다른 파일.

Harness 워크플로우 (4단계 사이클):
  1. /grill-with-docs   ← 아이디어 깊이 인터뷰
  2. /harness-write     ← 그릴 결과 → docs 4개 자동 분배 매핑
  3. /harness-go        ← phase 설계 + execute.py 자동 실행 + GitHub Issue 발행
  4. /handoff           ← 세션 끝낼 때 (트리거 룰)
Codex 등 다른 AI CLI에서도 /harness-write, /harness-go라고 하면 .claude/commands/*.md를 읽고 동일하게 동작.
plan mode (Shift+Tab)는 강제 X — 그릴이 plan mode 상위호환.

★ 채우기가 끝나면 이 주석 블록 전체와 아래 예시 블록 전체를 **반드시 제거**하라.
-->

<!--
============================================
참고용 예시 (가상의 todo 앱). 분량 감각용. 채우기 끝나면 이 블록도 제거.
============================================

# 프로젝트: simple-todo

## 기술 스택
- Next.js 15 (App Router)
- TypeScript strict mode
- Tailwind CSS v4
- Supabase (Auth + PostgreSQL)

## 아키텍처 규칙
- CRITICAL: 모든 DB 접근은 server action 또는 route handler에서만. 클라이언트 컴포넌트에서 supabase client 직접 호출 금지.
- CRITICAL: API 키·DB 비밀번호는 환경변수로만. 코드에 하드코딩 금지. .env.local은 .gitignore.
- 컴포넌트는 components/, 타입은 types/ 분리.
- 서버 컴포넌트가 기본. 'use client'는 인터랙션 필요한 컴포넌트에만.

## 개발 프로세스
- CRITICAL: TDD. 새 기능은 Vitest 테스트 먼저, 통과하는 구현을 그 다음.
- 커밋 메시지: conventional commits (feat:, fix:, docs:, refactor:).
- "qa 끝났다"고 판단하면 레슨런을 docs/ADR.md에 기록.

## 로드맵 Phase 용어 약속
- Phase 단계: 큰 기능 블록. 디렉토리 → `0-mvp`, `1-auth`
- Phase 버전: Phase 내 세부. 디렉토리 → `1.1-email-auth`
- Step: Phase 구현 단위. 파일 → `step0.md`, `step1.md`

## SubAgent / 원칙
- 필요 시 `.claude/agents/_template.md` 복사해서 만든다.
- 감독님이 비개발자이므로, 기술 용어는 풀어서 설명한다.

============================================
예시 끝 (이 블록 전체 제거 필수)
============================================
-->

# 프로젝트: {프로젝트명}

## 기술 스택
<!-- 예: Next.js 15, TypeScript strict mode, Tailwind CSS -->
- {프레임워크 (예: Next.js 15)}
- {언어 (예: TypeScript strict mode)}
- {스타일링 (예: Tailwind CSS)}

## 아키텍처 규칙
<!--
CRITICAL 키워드는 AI가 최우선 신호로 인식한다. 반드시 지켜야 할 것에만 쓸 것.
예: "CRITICAL: 모든 API 로직은 app/api/ 라우트 핸들러에서만 처리"
     "CRITICAL: API 키는 환경변수로만. 코드에 하드코딩 절대 금지"
-->
- CRITICAL: {절대 지켜야 할 규칙 1 (예: 모든 API 로직은 app/api/ 라우트 핸들러에서만 처리)}
- CRITICAL: {절대 지켜야 할 규칙 2 (예: 클라이언트 컴포넌트에서 직접 외부 API를 호출하지 말 것)}
- {일반 규칙 (예: 컴포넌트는 components/ 폴더에, 타입은 types/ 폴더에 분리)}

## 개발 프로세스
- CRITICAL: 새 기능 구현 시 반드시 테스트를 먼저 작성하고, 테스트가 통과하는 구현을 작성할 것 (TDD)
- 커밋 메시지는 conventional commits 형식을 따를 것 (feat:, fix:, docs:, refactor:)
- 변경된 내용 또는 레슨런이 있었던 내용 구현 후 감독님이 qa까지 끝났다고 판단하면 `docs/ADR.md`에 내용을 기록한다. 다음 세션에서 이를 참고한다.

## 로드맵 Phase 용어 약속
<!--
execute.py는 phases/ 디렉토리명을 그대로 Phase 이름으로 사용한다.
아래 규칙대로 디렉토리명을 짓는다.
-->
- **Phase 단계** (0, 1, 2...): 큰 기능 블록. 디렉토리명 → `0-mvp`, `1-auth`, `2-dashboard`
- **Phase 버전** (1.1, 1.2...): Phase 내 세부 반복. 디렉토리명 → `1.1-basic-auth`, `1.2-oauth`
- **Step** (0, 1, 2...): 각 Phase를 구현하는 단위. 파일명 → `step0.md`, `step1.md`
- 실행: `python3 scripts/execute.py 1.1-basic-auth`

## SubAgent
<!--
서브에이전트가 필요하면 .claude/agents/ 에 만든다.
.claude/agents/_template.md 를 복사해서 시작할 것.
서브에이전트는 메인 에이전트의 지시에 따라 동작한다.
-->
- 메인 오케스트레이터 CLAUDE.md 외에 서브에이전트가 필요할 경우 `.claude/agents`에 작성한다. 서브에이전트는 메인 에이전트의 지시에 따라 동작한다.

## 원칙
- 감독님이 비개발자이므로, 기술적인 용어는 사용자의 관점에서 쉽게 풀어서 설명한다.

## Agent skills (matt-pocock 스킬용)
- Tracker: GitHub Issues (`gh` CLI). `/harness-go`가 phase 발행 자동.
- Labels: matt-pocock 5-role 디폴트 (needs-triage / needs-info / ready-for-agent / ready-for-human / wontfix)
- ADR location: **docs/ADR.md** (single file with ADR-NNN sections, NOT docs/adr/*)
- LESSON: docs/ADR.md의 LESSON-NNN 섹션
- matt-pocock 스킬(`/grill-with-docs`, `/improve-codebase-architecture`, `/diagnose`)은 위 layout 따름.
- `/grill-with-docs`의 lazy `docs/adr/000N-*.md` 생성은 임시 — `/harness-write`가 흡수 후 삭제.
