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
