# 하네스 워크플로우 출처 매핑

이 파일은 **영구 자산**이다. 새 프로젝트로 템플릿 진입해도 `.claude/` 폴더가 그대로 따라가므로 같이 따라간다. README와 CLAUDE.md *상단 주석*은 새 프로젝트 진입 시 갈아입혀지거나 제거되므로, **이 파일이 워크플로우의 단일 마스터**.

> **AI 발견 경로:** `/harness-write`, `/harness-go` 호출 시 명령 본문 §0 위에서 이 파일을 1회 참조하라고 명시되어 있음. 따라서 슬래시 명령 호출 → 자동 발견.

---

## 5단계 사이클 (외워둘 것)

```
1. /grill-with-docs       ← 아이디어 깊이 인터뷰 (진척률 N/M 자동)
2. /design-consultation   ← DESIGN.md 합성 (raw는 docs/design-references/, 이번 스킵 가능)
3. /harness-write         ← 그릴+디자인 결과 → docs 자동 분배 (DESIGN.md를 input으로)
4. /harness-go            ← phase 설계 + execute.py 자동 실행 (DESIGN.md를 reference로)
5. /handoff               ← 세션 끝낼 때 (트리거 룰)
```

이게 *전부*. 단계는 *깎기 강제*용 — 외우는 부담이 아니라 퀄리티 가드레일.

---

## 책임 분담 — 누가 / 뭘 / 산출물 (한 장 표)

| 작업 | 누가 | 산출물 |
|---|---|---|
| **Phase 정의** | 사용자 (1차 안은 `/harness-write` 자동) | `docs/PRD.md §핵심 기능`에 `- [ ] phase {N-name}: ...` 한 줄 |
| Phase 채우기 | `/harness-write` | PRD/ARCH/ADR/CLAUDE.md 본문 |
| Step 분할 | `/harness-go §3` | step 설계안 (사용자 승인 대상) |
| Step 지시서 작성 | `/harness-go §4` | `phases/{N-task}/step{M}.md` (글, 코드 X) |
| **실제 코드 작성** | **`execute.py` (= 별도 Claude 세션들)** | `feat-{N}` 브랜치의 코드/테스트/커밋 |

→ 헷갈림 종결: *"phase는 누가?"* = 사용자가 PRD에 박음(자동 1차 안). *"step은 누가?"* = `/harness-go`가 즉석 분할. *"`/harness-go`가 코드 짜?"* = 아니오, 지시서만 쓰고 `execute.py`가 진짜 코드 작성.

## §3 종료 게이트 룰 (plan-only 자동 흡수)

`/harness-go §3` Step 설계가 끝나면 *항상* 사용자 승인 대기. **plan-only 모드는 별도 박지 않음 — 기본 게이트가 흡수.** 사용자가 *"진행/OK/좋다"* 명시 전엔 §4(파일 생성)으로 안 넘어감. 키워드 매칭은 경직, 자연어 추론은 추측 영역 → 둘 다 안 박는 게 안정.

---

## 단계별 역할 중첩 (참고)

각 단계는 *1:N 역할 중첩*. 1:1 비유(TPM·PO·CTO 등)는 부정확하니 *중첩 매트릭스*로 인지:

- `/grill-with-docs` — 도메인 PM + 일부 UX 인터뷰 + 분석가
- `/design-consultation` — UI 디자이너 + 부분 UX (layout / motion / a11y)
- `/harness-write` — TPM + PO + 기술 라이터
- `/harness-go` — CTO + 엔지니어링 매니저 + DevOps
- `/handoff` — 서기 + PM

**UX 사전 설계 갭:** 본격 UX 흐름·정보 구조 사전 설계 단계는 *5단계에 명시 X*. 1·2번에 *부분 분산*. 본격 UX 사전 설계가 필요한 프로젝트(예: 복잡한 인터랙션·온보딩 흐름·다층 페이지 위계)면 1·2번 사이에 `/shape` (gstack)을 옵션으로 호출.

> 이 매트릭스는 *시작 시점 한 번* 보고 어느 단계가 무엇을 다루는지 직관 잡는 용도. *부정확 비유*에 갇히지 않게 *중첩 사실*만 박음. dry-run에서 진짜 갭이 터지면 그때 LESSON-NNN으로 별도 박음.

---

## 출처 매핑 — Layer 1 (5단계 핵심)

| # | 스킬 | 출처 | 설치 / 위치 |
|---|---|---|---|
| 1 | `/grill-with-docs` | **matt-pocock** | 글로벌 스킬 — `~/.claude/skills/grill-with-docs/` (https://github.com/mattpocock/skills) |
| 2 | `/design-consultation` | **gstack** (Garry Tan) | gstack 패키지 — `~/.claude/skills/design-consultation/`. **영구 의존성** |
| 3 | `/harness-write` | 자작 | 이 레포 내장 — `.claude/commands/harness-write.md` |
| 4 | `/harness-go` | 자작 | 이 레포 내장 — `.claude/commands/harness-go.md` |
| 5 | `/handoff` | 자작 (user 전역) | `~/.claude/commands/handoff.md` |

---

## 출처 매핑 — Layer 2 (사이클에서 분기되는 보조 스킬)

### 매일 깎기 (`/harness-go §7-1`에서 자동 권유)

| 스킬 | 출처 | 메모 |
|---|---|---|
| `/impeccable` | **Phil Bakaus** (https://github.com/pbakaus/impeccable) | Apache 2.0. Anthropic frontend-design 기반. description에 `(gstack)` 표시 없음 = 별도 패키지 |
| `/design-review` | **gstack** | 시각 QA — 라이브 사이트 인스펙션 + 자동 수정 |
| `/qa` | **gstack** | 기능 QA — 자동 버그 헌트 + 수정 |

### 예외 룰 (5단계 밖)

| 스킬 | 출처 | 메모 |
|---|---|---|
| `/diagnose` | **matt-pocock** | 큰 버그·회귀 강제 분기 |
| `/improve-codebase-architecture` | **matt-pocock** | 정기 청소 (짝수 phase 종결마다) |
| `/prototype` | **matt-pocock** | 그릴이 모호 발견 시 자동 분기 |

---

## 출처 식별 신호 (스킬 description 끝)

스킬 출처를 빠르게 알아내는 방법:

- description 끝에 `(gstack)` 표시 → **gstack 패키지**
- 표시 없음 + `ADR-FORMAT.md` / `CONTEXT-FORMAT.md` 등 매트포콕 패턴 자료 동봉 → **matt-pocock**
- 표시 없음 + license 줄에 `Anthropic frontend-design` 언급 → **별도 패키지** (예: `/impeccable` = Phil Bakaus)
- `.claude/commands/` 위치 → **자작**

미래 헷갈림 방지: 새 스킬을 워크플로우에 끼워 넣기 전 `~/.claude/skills/{skill}/SKILL.md` frontmatter의 `description` / `license` 줄을 한 번 확인하라.

---

## 영구 의존성 알림

5단계 사이클이 작동하려면 다음 두 외부 패키지가 *반드시* 설치되어 있어야 함:

1. **matt-pocock 글로벌 스킬** — `/grill-with-docs` (5단계 1번). 없으면 사이클 시작 불가.
2. **gstack** — `/design-consultation` (5단계 2번). 하네스 자체엔 디자인 단계가 없어 *차용*. 없으면 5단계 2번이 작동하지 않음.

매일 깎기·예외 룰 스킬은 *선택* — 없으면 그 단계만 건너뜀.

상세 설치 명령은 my-harness 템플릿 README §"추가 셋업 (1회만)" 참조 (단 새 프로젝트 진입 후엔 README가 갈아입혀지므로, 새 머신·새 환경 셋업은 *템플릿 레포의 README*를 별도 참조하라).
