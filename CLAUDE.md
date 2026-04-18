# 프로젝트: {프로젝트명}

<!--
이 파일은 AI가 코딩할 때 가장 먼저 읽는 "헌법"이다.
새 프로젝트를 시작할 때 {} 플레이스홀더를 채울 것.

Harness 워크플로우: `/harness` 명령을 입력하면 AI가 이 파일과 docs/를 읽고
phases/ 설계 → execute.py 자동 실행까지 처리한다.
Codex 등 다른 AI CLI를 사용할 때도 "/harness"라고 하면 .claude/commands/harness.md를 읽고 동일하게 동작한다.
-->

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
