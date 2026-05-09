이 명령은 Harness 프레임워크의 *구현 시작* 단계다.

docs가 채워진 상태에서, 다음 phase의 step들을 설계하고 `execute.py`로 자동 실행한다.
GitHub Issue 자동 발행 + AC에 신규 테스트 검증 강제 + phase 종료 후 레슨런 prompt까지.

> **호출 직전 `.claude/WORKFLOW.md`를 1회 참조** — 워크플로우 5단계 / 출처 매핑 / 매일 깎기 보조 스킬 출처(`/impeccable`=Phil Bakaus, `/design-review`·`/qa`=gstack) 인지. 새 세션에서도 이 파일이 워크플로우 단일 마스터.

---

## 0. 가드 — docs 상태 체크

`docs/PRD.md`, `docs/ARCHITECTURE.md`, `docs/ADR.md`, `CLAUDE.md` 중 하나라도 placeholder(`{}` 다수)면 즉시 거부:

> "docs가 채워지지 않았습니다. `/harness-write` 먼저 호출해주세요."

모두 채워져 있으면 진행.

---

## 1. handoffs/ 확인

`handoffs/` 폴더에 `.md` 있으면 가장 최근 1개 반드시 읽기. 이전 세션 컨텍스트 흡수.

---

## 2. phase 선택

**`docs/PRD.md §핵심 기능` 체크리스트가 *Phase의 단일 마스터*** — `/harness-go`는 거기서 phase를 *고를 뿐*, 새로 만들지 않음. 이름·단위는 `/harness-write`가 1차 안을 박고 사용자가 컨펌한 결과를 그대로 따름.

- **자동 모드** (`/harness-go` 인자 없음): `- [ ]` (미완료) 항목 중 *가장 위*의 phase 자동 선택.
- **명시 모드** (`/harness-go {phase-name}`): 그 이름이 PRD 체크리스트에 있는지 검증.

### 2-1. phase 정의 검증 가드

선택된 phase가 다음 패턴으로 `docs/PRD.md §핵심 기능`에 박혀 있어야 통과:

```
- [ ] phase {N-name}: ...      (미완료 — 이번에 작업할 후보)
- [x] phase {N-name}: ...      (완성된 옛 phase 재실행 시)
```

매칭 실패 시 *즉시 거부 + 안내*:

> "이 phase는 `docs/PRD.md §핵심 기능`에 정의되지 않았습니다. 다음 형식으로 한 줄 추가하고 다시 호출해주세요:
> ```
> - [ ] phase {N-name}: {짧은 설명}
> ```
> Phase 정의는 *사용자의 책임* — `/harness-write`가 1차 안을 자동으로 박지만 *최종 컨펌·수정은 사용자*."

### 2-2. phase 이름 컨펌

선택된 phase 이름을 사용자에게 1회 확인:
> *"다음 phase로 `{N-name}` ({PRD에 적힌 짧은 설명}) 진행할까요?"*

---

## 3. Step 설계 — 7대 원칙

1. **Scope 최소화** — 한 step에 한 모듈/레이어. 여러 모듈 동시 수정 필요하면 step 쪼갬.
2. **자기완결성** — 각 step 파일은 독립 Claude 세션에서 실행됨. *"이전 대화에서 논의한..."* 같은 외부 참조 금지. 필요한 정보 전부 파일 안에.
3. **사전 준비 강제** — 관련 문서 경로와 이전 step 산출물 명시. 세션이 코드 읽고 맥락 파악 후 작업.
4. **시그니처 수준 지시** — 함수/클래스 인터페이스만 제시. 내부 구현은 에이전트 재량. 단 핵심 룰(멱등성, 보안, 데이터 무결성)은 명시.
5. **AC는 실행 가능 커맨드 + 신규 테스트 파일 검증 강제**
   - 새 기능 step의 AC는 *반드시* 신규 테스트 파일 존재 확인 포함
   - 예: `test -f tests/wake-verification.test.ts && npm test`
   - TDD 강제 안전망 — `CLAUDE.md` `CRITICAL: TDD` 텍스트 가드레일 + AC 검증 이중장치
6. **주의사항은 구체적으로** — *"조심해라"* 대신 *"X를 하지 마라. 이유: Y"* 형식.
7. **네이밍** — kebab-case slug. 핵심 모듈/작업을 한두 단어로 (예: `project-setup`, `api-layer`, `auth-flow`).

---

## 3-1. §3 종료 게이트 (plan-only 자동 흡수)

§3에서 step N개 설계가 끝나면 사용자에게 보여주고 **§4 파일 생성 전에 *항상* 사용자 승인 게이트**:

> *"위 step N개 설계안 OK한가요? *'진행'·'OK'·'좋다'* 명시하시면 §4(파일 생성)으로 넘어갑니다. 다시 짜고 싶은 step 있으면 알려주세요."*

이 게이트는 *항상 작동* — 사용자가 *"계획만 보여줘"·"코드 구현하지마"* 등 명시 안 해도 기본 정지. **plan-only 모드는 별도 박지 않음 — 기본 게이트가 그 역할 자동 흡수.** (키워드 매칭은 경직, 자연어 추론은 추측 영역 → 둘 다 안 박는 게 안정.)

---

## 3.5 prototypes/ 폴더 ignore

step 작성 시 `prototypes/` 디렉토리는 *읽기 자료에서 제외*. 정식 코드 오인 방지.

---

## 3.6 frontend-design 스킬은 `docs/DESIGN.md`를 reference로

step 작성 시 *UI 컴포넌트 구현*이 포함되면 step 본문에 다음을 명시:

> *"이 step에서 UI 컴포넌트를 구현할 때는 `frontend-design` 스킬을 호출하라. **단일 reference = `docs/DESIGN.md`** — 색/폰트/간격/모션 토큰을 *그대로* 사용하고 즉흥 토큰 생성 금지. PRD §디자인 방향(추상 의도)은 의도 확인용으로만 읽고, 구체 값은 DESIGN.md만 참조."*

`execute.py`가 `docs/*.md`를 와일드카드로 가드레일에 주입하므로 DESIGN.md는 자동 포함 — step 본문엔 *어느 파일이 단일 마스터인지*만 명시하면 됨.

---

## 4. 파일 생성

사용자 승인 후 생성:

### 4-1. `phases/index.json` (전체 현황)

여러 task를 관리하는 top-level 인덱스. 이미 존재하면 `phases` 배열에 새 항목 추가.

```json
{
  "phases": [
    { "dir": "0-mvp", "status": "pending" }
  ]
}
```

- `dir`: task 디렉토리명.
- `status`: `pending` / `completed` / `error` / `blocked`. `execute.py`가 자동 업데이트.
- 타임스탬프(`completed_at`, `failed_at`, `blocked_at`)는 `execute.py`가 자동 기록.

### 4-2. `phases/{N-task}/index.json` (task 상세)

```json
{
  "project": "<프로젝트명>",
  "phase": "<task-name>",
  "steps": [
    { "step": 0, "name": "project-setup", "status": "pending" },
    { "step": 1, "name": "core-types", "status": "pending" }
  ]
}
```

상태 전이:
| 전이 | 기록되는 필드 | 기록 주체 |
|---|---|---|
| → `completed` | `completed_at`, `summary` | Claude 세션(summary), `execute.py`(timestamp) |
| → `error` | `failed_at`, `error_message` | Claude 세션(message), `execute.py`(timestamp) |
| → `blocked` | `blocked_at`, `blocked_reason` | Claude 세션(reason), `execute.py`(timestamp) |

`summary`는 step 완료 시 한 줄 요약. `execute.py`가 다음 step에 누적 전달.

### 4-3. `phases/{N-task}/step{N}.md` (각 step마다)

```markdown
# Step {N}: {이름}

## 읽어야 할 파일

먼저 아래 파일들을 읽고 프로젝트 아키텍처와 설계 의도 파악:
- `/docs/ARCHITECTURE.md`
- `/docs/ADR.md`
- {이전 step에서 생성/수정된 파일}

이전 step 코드 꼼꼼히 읽고, 설계 의도 이해 후 작업.

## 작업

{구체적 구현 지시. 파일 경로, 시그니처, 로직.
인터페이스 수준만 제시. 구현체는 에이전트 재량.
핵심 룰은 명확히.}

## Acceptance Criteria

\`\`\`bash
# 신규 테스트 파일 존재 검증 강제
test -f tests/{새-테스트-파일}.test.ts && npm test
# 또는 프로젝트 스택에 맞는 검증 커맨드
\`\`\`

## 검증 절차

1. 위 AC 커맨드 실행
2. 아키텍처 체크리스트:
   - ARCHITECTURE.md 디렉토리 구조 따랐나?
   - ADR 기술 스택 벗어나지 않았나?
   - CLAUDE.md CRITICAL 룰 위반 없나?
3. `phases/{N-task}/index.json` 업데이트:
   - 성공 → `status: completed`, `summary`
   - 3회 실패 → `status: error`, `error_message`
   - 사용자 개입 필요 → `status: blocked`, `blocked_reason`

## 금지사항

- {이 step에서 하지 말 것. "X 하지 마라. 이유: Y" 형식}
- 기존 테스트 깨뜨리지 마라
```

---

## 5. GitHub Issue 자동 발행 (git remote 있을 때만)

`phases` 파일 생성 후 + `execute.py` 호출 *직전*에:

### 5-1. git remote 감지

```bash
git remote get-url origin 2>/dev/null
```

- **origin 있음** (GitHub 연결됨) → 5-2로 진행 (Issue 자동 발행)
- **origin 없음** (폴더 우선 패턴, GitHub 아직 X) → 5-3로 진행 (Issue 발행 건너뜀, phase 진행은 정상)

### 5-2. Issue 발행 (origin 있을 때)

```bash
gh issue create \
  --title "phase {N-task}: {phase-name}" \
  --body "$(jq -r '.steps[] | "- [ ] step\(.step): \(.name)"' phases/{N-task}/index.json)" \
  --label "phase:{N-task}"
```

PR 생성 시 commit message에 `Closes #N` 자동 포함 → 머지 시 자동 close.

**`gh` CLI 사전 셋업 필요 (1회만):**
```bash
gh auth login
```

### 5-3. Issue 건너뜀 (origin 없을 때)

다음 안내만 출력하고 phase 진행 (실행은 정상):

> "GitHub remote가 연결되지 않아 Issue 자동 발행을 건너뛰었습니다. 살아남은 프로젝트라면 `gh repo create {name} --private --source=. --push`로 GitHub에 연결하세요. 다음 phase부터 Issue 자동 발행이 켜집니다."

**중요:** 이 분기 때문에 *폴더 우선* 패턴 (GitHub 나중에 연결)도 사이클이 깨지지 않고 굴러간다.

---

## 6. 실행

```bash
python3 scripts/execute.py {N-task}        # 순차 실행
python3 scripts/execute.py {N-task} --push  # 실행 후 push
```

`execute.py` 자동 처리:
- `feat-{N-task}` 브랜치 생성/checkout
- 가드레일 주입: `CLAUDE.md` + `docs/*.md`를 매 step 프롬프트에 포함
- 컨텍스트 누적: 완료된 step의 `summary`를 다음 step에 전달
- 자가 교정: 실패 시 최대 3회 재시도, 이전 에러를 프롬프트에 피드백
- 2단계 커밋: 코드 변경(`feat`) + 메타데이터(`chore`) 분리
- 타임스탬프 자동

에러 복구:
- **error**: `phases/{N-task}/index.json`에서 해당 step `status`를 `pending`으로 + `error_message` 삭제 후 재실행.
- **blocked**: `blocked_reason` 해결 후 `status` `pending` + `blocked_reason` 삭제 후 재실행.

---

## 7. phase 종결 후 — 레슨런 자동 prompt

`execute.py` 정상 완료 후 사용자에게 묻기:

> "이번 phase에서 *시도했지만 안 된 것* 또는 *배운 레슨* 있나요?
>  - 있으면 `docs/ADR.md` `LESSON-NNN` 섹션에 박을 내용을 알려주세요.
>  - 없으면 *'no lessons'* 입력 → 스킵."

답변 받으면 `docs/ADR.md` 하단 `LESSON-NNN` 섹션에 append. 형식:

```markdown
### LESSON-NNN: {배운 것 제목}
**문제**: {어떤 문제가 생겼나}
**원인**: {왜 생겼나}
**해결**: {어떻게 해결, 다음엔 어떻게}
```

---

## 7-1. 매일 깎기 사이클 (퀄리티 강제 + override 가능)

LESSON 처리 후 사용자에게:

> "이번 phase의 *매일 깎기* 단계로 다음을 차례 권유합니다 — 모두 *강제 + 사용자 override 가능*, *'이번은 스킵'* 한 줄로 건너뛸 수 있어요:
>  - `/impeccable` (시각 폴리시·UX 통합 점검)
>  - `/design-review` (시각 QA — 라이브 사이트 인스펙션)
>  - `/qa` (기능 QA — 자동 버그 헌트 + 수정)"

답변에 따라 권유 스킬 호출 안내 또는 스킵.

**왜 phase 종결마다?** 솔로 비개발자(감독님)가 *까먹지 않게*. 외우는 부담이 아니라 *매 phase 자동 권유*로 깎기 누락 방지. 5단계 사이클의 *깎기 강제* 철학과 동일 정책.

---

## 8. plan mode 강제 X

이 명령도 plan mode 의식 없음.

---

## 9. 호출 형식

- `/harness-go` — 다음 phase로 자동 진행
- `/harness-go {phase-name}` — 특정 phase 명시 (재실행 등)
