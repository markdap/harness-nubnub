이 명령은 Harness 프레임워크의 *문서 채우기* 단계다.

직전 그릴(`/grill-with-docs`) 결과를 받아서 docs 4개 파일에 자동 분배 매핑한다.
사용자 추가 입력 0회를 목표.

---

## 0. 그릴 + 디자인 선행 확인

직전 대화에 `/grill-with-docs` 세션 흔적이 있는지 확인:
- `CONTEXT.md` 갱신 / `docs/adr/*` 추가 / 결정 트리 토론 흔적

**흔적 없으면**: "기획 깊이를 위해 `/grill-with-docs`를 먼저 권장합니다." 안내 후 사용자 진행 여부 묻기.

**흔적 있으면**: 그 컨텍스트를 1차 자료로 docs 채우기 시작.

### 0-1. `docs/DESIGN.md` placeholder 가드 (디자인 단계 선행)

5단계 사이클의 2단계(`/design-consultation`)가 *모든 프로젝트 강제 + 명시 override*인 정책상, 다음 점검:

- `docs/DESIGN.md`가 없거나 placeholder 상태 + 사용자의 *"이번은 스킵"* 명시 없음
  → **거부 안내**: *"디자인 단계 먼저 권장합니다. `docs/design-references/`에 raw 자료 모은 후 `/design-consultation` 호출 → 다시 `/harness-write`로 돌아오세요. 또는 *'이번은 스킵'*이라고 한 줄 답해주시면 진행합니다."* → 사용자 답 대기.
- DESIGN.md 채워져 있음 *또는* 사용자 스킵 명시
  → 진행. *DESIGN.md 채워져 있으면* PRD §디자인 방향 + ARCHITECTURE 컴포넌트 패턴 합성 시 *DESIGN.md 토큰을 reference로 참조*하라는 가드레일을 자연스럽게 주입 (값 자체 복제 X, 참조만).

---

## 0.5 합성 원칙 (matt-pocock `/to-prd`에서 흡수)

`/to-prd`의 합성 원칙을 그대로 따른다 — 별도 호출 없이 본문에 박힘:

1. **재인터뷰 X** — 직전 대화 컨텍스트(특히 그릴 결과)에서 합성. 새로 묻지 말 것.
2. **`CONTEXT.md` 도메인 용어 사용** — 임의 동의어 만들지 말 것. 글로서리에 정의된 그대로.
3. **ADR 모순 즉시 표면화** — 기존 ADR과 모순 발생 시 그 자리에서 명시. 예: *"Contradicts ADR-002 — but worth reopening because..."*.
4. **Out of Scope 비어도 빈 칸 X** — *"현재 명시된 제외 사항 없음"*이라고 적음. 비워두면 AI가 나중에 임의로 기능 추가 제안하는 트리거 됨.

---

## 1. 첫 호출 vs 후속 호출 분기

### 1-1. 첫 호출 (docs/*.md가 placeholder 상태)

4개 docs 처음부터 채움. 순서: **PRD → ARCHITECTURE → ADR → CLAUDE.md.**

### 1-2. 후속 호출 (docs가 이미 채워져 있음)

**`docs/PRD.md`** 맨 위에 새 섹션 추가:

```markdown
## v{N+1} — {feature} ({YYYY-MM-DD})

**Affects** (영향 분석 메타 — 반드시 명시):
- ARCH §데이터흐름 갱신 / 변동 없음
- supersedes ADR-NNN / 신규 ADR 추가 / 변동 없음
- CLAUDE.md 변동 없음 / CRITICAL 룰 추가

{새 섹션 본문}

---

## v{N} — {옛 제목} (*superseded by v{N+1}*)
{옛 섹션 본문 그대로 보존}
```

→ 이 *영향 분석 메타*가 없으면 PRD v2와 ARCH/ADR이 어긋날 위험. **반드시** 명시.

**`docs/ARCHITECTURE.md`**: 영향 분석 메타에 명시된 경우만 갱신.

**`docs/ADR.md`**: 새 ADR-NNN을 ADR 섹션에 append:

```markdown
### ADR-NNN: {결정 제목}
**결정**: ...
**이유**: ...
**트레이드오프**: ...
```

그릴이 만든 lazy `docs/adr/000N-*.md` 파일들 흡수:
1. 본문을 `docs/ADR.md` ADR-NNN 섹션으로 변환
2. **흡수 후 `docs/adr/000N-*.md` 원본 삭제** — 단일 마스터 = `docs/ADR.md`.

**`CLAUDE.md`**: CRITICAL 룰 변동 있을 때만 건드림.

### 1-3. `prototypes/` 폴더 처리

`prototypes/` 폴더에 throwaway 코드 있으면:
1. prototype에서 나온 *답*을 `docs/PRD.md`(구현 결정 섹션) / `docs/ADR.md` / `docs/ARCHITECTURE.md`에 흡수.
2. 흡수 후 `prototypes/{question}/` 폴더 통째 삭제 (또는 `prototypes/_archived/`로 이동).
3. NOTES만 docs에 남김.

---

## 2. 자동 분배 룰 (CLAUDE.md 헌법 따름)

### 2-1. `docs/PRD.md` (7개 섹션)

- **목표** (Problem + Solution 결합)
- **사용자** / 페르소나
- **핵심 기능** (3개 이하 권장)
- **Out of Scope (MVP 제외)** — 비어도 빈 칸 X
- **디자인 방향** — *추상 의도 1단락만* (예: *"차분한 단일 칼럼, 새벽 노랑 톤, 1초 안에 결심하게 하는 시선 흐름"*). 구체 토큰(색/폰트/간격/모션 값)은 절대 적지 말 것 — `docs/DESIGN.md`가 단일 마스터. DESIGN.md 채워져 있으면 *"DESIGN.md의 {핵심 토큰 3-4개 이름}을 따른다"* 한 줄로 참조.
- **(선택) 구현 결정** — 그릴에서 모듈/인터페이스 토론된 경우만
- **(선택) 테스트 접근** — 그릴에서 테스트 토론된 경우만

### 2-2. `docs/ARCHITECTURE.md`

기술 스택 / 디렉토리 / 데이터 흐름 / 패턴 / 상태 관리 / 컴포넌트 패턴(`docs/DESIGN.md` 토큰을 reference로 — 토큰 값 자체 복제 X, 참조만)

### 2-3. `docs/ADR.md`

`ADR-NNN` (결정 / 이유 / 트레이드오프) + `LESSON-NNN` (시도 / 결과 / 추정원인)

### 2-4. `CLAUDE.md`

"코드 짜기 직전 안 읽으면 사고나는 룰"만. 5개 섹션 한정 (기술 스택 / 아키텍처 룰 CRITICAL / 개발 프로세스 / Phase 용어 / SubAgent·원칙).

`## Agent skills` 4줄 블록도 CLAUDE.md 끝에 (matt-pocock 스킬용 config).

**중복 금지**: 같은 정보가 두 파일에 들어가면 안 됨.

**User Stories는 흡수 안 함**: matt-pocock `/to-prd`의 50개 나열은 솔로 비개발자한텐 오버킬. 핵심 기능 + Out of Scope로 충분.

---

## 3. CLAUDE.md 마지막

CLAUDE.md는 PRD/ARCH/ADR이 일정 수준 차기 전에는 건드리지 마라.
이유: 다른 파일이 비어있으면 *"어차피 다른 데 안 적었으니 일단 여기"*라는 충동으로 비대해진다.

CLAUDE.md를 채울 차례가 되면 상단 가이드 주석 블록과 예시 블록을 모두 **제거**.

---

## 4. plan mode 강제 X

이 명령은 plan mode 의식 없이 실행. 그릴이 이미 plan mode 상위호환 역할.

---

## 5. 호출 형식

`/harness-write` (인자 없음. 직전 그릴 컨텍스트 자동 사용.)

채우기 끝나면 사용자에게 안내:
> "docs 채우기 완료. `/harness-go`로 구현 시작하시겠어요?"
