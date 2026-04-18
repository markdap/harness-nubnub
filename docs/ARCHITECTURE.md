# 아키텍처

<!--
이 파일은 PRD.md에서 파생된다. PRD를 먼저 채운 뒤 여기를 채울 것.
execute.py가 자동으로 읽어 각 step 프롬프트에 맥락으로 주입한다.

AI가 코드를 만들 때 이 구조를 따른다. 구체적일수록 결과물이 의도에 맞다.
-->

## 기술 스택
<!-- 사용할 프레임워크, 언어, 주요 라이브러리. ADR.md에 선택 이유를 적는다. -->
- {프레임워크 (예: Next.js 15 App Router)}
- {언어 (예: TypeScript strict mode)}
- {스타일링 (예: Tailwind CSS v4)}
- {DB (예: Supabase PostgreSQL)}

## 디렉토리 구조
<!--
실제로 만들 폴더 구조. AI가 파일을 어디에 만들지 이걸 보고 결정한다.
프로젝트에 맞게 수정할 것. Next.js가 아닌 프로젝트는 완전히 바꿔도 된다.
-->
```
src/
├── app/               # 페이지 + API 라우트
├── components/        # UI 컴포넌트
├── types/             # TypeScript 타입 정의
├── lib/               # 유틸리티 + 헬퍼
└── services/          # 외부 API 래퍼
```

## 패턴
<!-- 사용하는 디자인 패턴. 예: "Server Components 기본, 인터랙션이 필요한 곳만 'use client'" -->
{사용하는 디자인 패턴}

## 데이터 흐름
<!-- 데이터가 어떻게 이동하는지 한 줄로. 예: "사용자 입력 → API Route → Supabase → 응답 → UI" -->
```
{데이터 흐름 예시}
```

## 상태 관리
<!-- 전역 상태를 어떻게 관리하는지. 예: "서버 상태는 Server Components, 클라이언트 상태는 useState" -->
{상태 관리 방식}
