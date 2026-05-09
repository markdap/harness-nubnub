# harness-nubnub

감독님 전용 Claude Code 개발 하네스. **새 프로젝트 시작할 때마다 이 레포를 템플릿으로 복사해서 사용한다.**

---

## 이게 뭐야?

Claude Code (또는 Codex) 와 함께 *제품을 0에서 시작해서 운영까지* 만드는 워크플로우 템플릿.

**매번 같은 4단계 명령어**로:
1. 아이디어를 깊이 파고
2. 자동으로 문서화하고
3. 자동으로 코드를 짜고
4. 세션을 보존한다.

이걸 무한 반복하면 됨.

---

## 새 프로젝트 시작하는 법

진입 경로는 **3가지**. 감독님 스타일에 맞는 거 고르면 됨. 결과(템플릿 파일 풀린 폴더 + git)는 동일.

| 경로 | 시작 방식 | 한 줄 추천 |
|---|---|---|
| **A. `degit` 한 줄** | 터미널 명령 | 매번 빠르게 시작하는 실험가 |
| **B. ZIP 다운로드** | GitHub UI 클릭 | GUI 편하고 명령어 외울 부담 싫을 때 |
| **C. Use this template** | GitHub UI 클릭 | 시작부터 GitHub 확정 (외부 공개/팀) |

A·B = *폴더 우선* 패턴 (GitHub 나중에 한 줄로 연결). C = *GitHub 우선* 패턴.

---

### 경로 A — `degit` 한 줄 (터미널 친화)

A에는 두 가지 변형이 있습니다. *결과는 동일*, "어디서 명령을 치느냐 / 폴더를 누가 만드느냐"가 다름.

#### A-1. 상위 폴더에서 — 새 폴더까지 만들면서 가져오기

```bash
cd /Users/{me}/from_github
npx degit markdap/harness-nubnub todo-test
cd todo-test
git init
claude
```

결과:

```
from_github/
  └ todo-test/
      └ 템플릿 파일들
```

#### A-2. 이미 만들어둔 폴더 안에서 — 그 폴더 안에 풀기

```bash
cd {todo-test 폴더 절대경로}
npx degit markdap/harness-nubnub .
git init
claude
```

여기서 `.`은 "현재 폴더"라는 뜻.

결과:

```
todo-test/
  └ 템플릿 파일들
```

**핵심 차이:**
- **A-1:** `degit`이 `todo-test` 폴더를 *새로* 만듦 (상위 폴더에서 명령)
- **A-2:** 내가 *이미 들어가 있는* 폴더 안에 그대로 풀어넣음 (Finder 등에서 폴더 미리 만들어 둔 케이스)

→ 둘 다 끝나면 `/grill-with-docs`로 시작.

**이게 무슨 의미냐 (바이브코더 관점):**
- 터미널 한 줄로 끝. 단계 수 가장 적음.
- `degit`이 *템플릿의 `.git` 빼고* 깨끗한 복사본만 떨어뜨려 줌 → clone 후 `.git` 정리할 필요 X.
- A-1은 명령 안에서 폴더 이름을 *즉시 지정* / A-2는 *이미 만들어 둔 폴더 이름*을 그대로 사용.
- 결과적으로 *내 폴더 + 템플릿 파일 + 빈 git* 상태로 시작.

**유의사항:**
- **`git init` 빼먹지 말 것.** 안 하면 `/harness-go` → `execute.py` 자동 커밋 단계에서 깨짐.
- Node.js 필요. Claude Code 깔려있으면 이미 있음.
- **A-2는 *비어있는 폴더*에서만 안전.** 이미 다른 파일이 들어있는 폴더에 풀면 충돌 가능.

**언제 이걸 고르나:**
- **A-1**: 상위 폴더에서 *명령 한 줄로 폴더까지 만들며* 빠르게 시작
- **A-2**: Finder 등 GUI에서 *폴더부터 만들어 둔 다음* 그 안에 채우는 스타일
- 공통: GitHub은 살아남은 후 만들 생각

---

### 경로 B — ZIP 다운로드 (GUI 친화)

1. https://github.com/markdap/harness-nubnub 접속
2. 녹색 **"Code"** 버튼 → **"Download ZIP"**
3. 압축풀기 + 폴더 이름 원하는 걸로 변경
4. 터미널에서 `cd {폴더}`
5. **`git init`** ← 빼먹지 마세요
6. `claude`
7. `/grill-with-docs`부터

**이게 무슨 의미냐 (바이브코더 관점):**
- GitHub 웹사이트에서 *클릭*으로 시작 → 시각적으로 *"내가 뭘 받고 있는지"* 확인 가능. 안심감.
- 명령어 외울 부담 0.
- 결과는 경로 A와 *완전 동일*. 도착지 같고 가는 길만 다름.

**유의사항:**
- **`git init` 반드시 필요.** ZIP에는 `.git` 안 들어있음. 빼먹으면 `execute.py` 자동 커밋 깨짐.
- macOS에서 압축풀면 `harness-nubnub-main/` 형태로 폴더 *이중 중첩*될 때 있음 → 안쪽 폴더만 꺼내서 이름 바꿔주면 됨.
- 폴더명에 *공백* 들어가면 터미널 명령 할 때 짜증남. 공백 X 추천 (예: `wake-up-buddy` ✅, `wake up buddy` ❌).

**언제 이걸 고르나:**
- GUI가 편한 케이스
- "터미널 명령 정확히 입력하기 부담스럽다" 싶을 때

---

### 경로 C — Use this template (GitHub 우선)

1. https://github.com/markdap/harness-nubnub 접속
2. 우측 상단 녹색 **"Use this template"** → **"Create a new repository"**
3. Owner: 개인 계정 또는 회사 org / Repository name: 새 프로젝트명 / **Private** 선택
4. **Create repository** 클릭
5. 로컬에 clone:
   ```bash
   git clone https://github.com/{owner}/{새프로젝트명}
   cd {새프로젝트명}
   claude
   ```
6. `/grill-with-docs`부터

**이게 무슨 의미냐 (바이브코더 관점):**
- 시작 시점에 GitHub 레포가 *함께 생성*됨 → 작업물 분실 위험 0.
- 처음부터 `/harness-go`의 **Issue 자동 발행** 켜진 상태로 사이클 진입.
- 외부 공개/협업/백업이 *시작 시점에 명확*할 때 가장 자연스러움.

**유의사항:**
- 실패하는 실험 많으면 GitHub 계정/org에 시체 누적. 의도 명확할 때만.
- Owner(개인 계정 vs 회사 org)를 *시작 시점에* 결정해야 함 → 인지부담 1회.
- `git init` 안 해도 됨 (clone이 git까지 가져옴).

**언제 이걸 고르나:**
- 시작부터 *반드시 GitHub*인 게 확정 (팀 합류, 외부 공개 등)
- 과거 작업물 분실 트라우마가 있어 *백업 즉시* 필요

---

### A·B 선택 시: 살아남으면 GitHub에 올리기 (한 줄)

```bash
gh repo create my-project --private --source=. --push
```

→ 이 시점부터 `/harness-go`가 phase 만들 때마다 **Issue 자동 발행**도 켜짐. 그 전까진 발행 단계만 *건너뜀* (안내 메시지 출력 후 phase 정상 진행).

---

## ⭐ 매번 같은 4단계 사이클 (외워둘 것)

```
1. /grill-with-docs    ← 아이디어를 AI랑 깊이 파기
2. /harness-write      ← AI가 자동으로 문서 채워줌
3. /harness-go         ← AI가 자동으로 코드 짜줌
4. /handoff            ← 세션 끝낼 때 (트리거 룰)
```

이게 *전부야*. 매번 같음.

---

## 각 단계가 뭘 하는지 (자세히)

### 1️⃣ `/grill-with-docs` — 아이디어 깊이 파기

감독님이 *"아침 기상 앱 만들고 싶어"* 같은 한 줄을 던지면, AI가 끈질긴 인터뷰를 시작:

- *"사용자가 누구야? 못 일어나는 사람? 의무가 강한 직장인?"*
- *"'진짜 일어남'의 정의가 뭐야? 침대에서 나옴? 화장실 도착?"*
- *"결제는 어떻게? 토스페이먼츠?"*

이 인터뷰 도중:
- **모호한 거 있으면** → AI가 자동으로 `/prototype`을 호출. 한 페이지에 *라디칼하게 다른 UI 3~4개*를 만들어 비교하게 해줌.
- **도메인 용어** 정해지면 → `CONTEXT.md`가 자동으로 생성됨.
- **되돌리기 어려운 결정** 나오면 → ADR(결정 일지) 후보로 표시됨.

**언제 끝남?** 감독님이 *"이제 충분해"* 싶을 때. 보통 30분~1시간.

### 2️⃣ `/harness-write` — 자동 문서 채우기

그릴 끝나면 그냥 `/harness-write` 한 줄 치면 됨. **인자(추가 입력) 없음.**

AI가 자동으로:
- `docs/PRD.md` ← *무엇*을 만들지 (목표 / 사용자 / 기능 / 안 만들 것 / 디자인)
- `docs/ARCHITECTURE.md` ← *어떻게* 만들지 (스택 / 구조 / 데이터 흐름)
- `docs/ADR.md` ← *왜* 이 기술 골랐는지 + 트레이드오프
- `CLAUDE.md` ← *AI가 절대 어기면 안 되는 룰*

**감독님이 추가 입력 0회.** 그릴에서 다 끌어냈으니 다시 안 물어봄.

이미 docs가 있으면? AI가 알아서 *후속 호출*로 인식하고:
- `PRD.md` 맨 위에 새 `## v2` 섹션 추가
- 옛 `## v1` 섹션은 *superseded* 태그로 보존
- 새 섹션에 *"이 변경이 ARCH/ADR/CLAUDE에 미치는 영향"* 명시

### 3️⃣ `/harness-go` — 자동 코드 짜기

문서 채웠으면 그냥 `/harness-go` 치면 됨.

AI가 알아서:
1. **다음 phase 이름 추론** (예: *"1-social-alarm 맞나요?"*)
2. **step 6개로 쪼갠 계획** 보여줌 → 감독님 승인
3. **`python3 scripts/execute.py 1-social-alarm` 자동 실행**
4. step별로 알아서 코드 작성, 테스트, 커밋
5. 실패하면 *3번 재시도*
6. **GitHub Issue 자동 발행** (PR 머지하면 자동 close)
7. 끝나면 *"이번에 시도했지만 안 된 것 있나요?"* 물어봄 → 있으면 `docs/ADR.md`에 LESSON으로 박힘

### 4️⃣ `/handoff` — 세션 보존

세션 끝낼 때 한 번 치면 됨.

AI가 *"오늘 뭐 했고, 어디서 막혔고, 내일 뭐 해야 하는지"*를 한 페이지 문서로 만들어 `handoffs/` 폴더에 저장.

**다음 세션 켜고** *"`/handoff` 가장 최근 거 읽고 이어서"* 한 줄 치면, 어제 컨텍스트 그대로 복원됨.

**언제 부르나?** 다음 중 *하나라도* 해당하면:
- 컨텍스트 70~80% 찼다 싶을 때
- phase 끝났을 때
- 1시간 이상 자리 뜨기 전
- *"오늘 시도했는데 안 된 거"* 1건 이상 있을 때

---

## 이 사이클에서 빠져나올 때 (예외 룰)

### 🔧 5분 안에 끝나는 작은 fix

- 텍스트 변경, 색깔 바꾸기, 작은 버그
- 사이클 1·2·3 *스킵*, 그냥 직접 수정
- 새 phase 디렉토리 안 만듦

### 🚨 큰 버그 — `/diagnose` 강제

다음 중 *하나라도* 해당되면 무조건 `/diagnose` 써:
- **프로덕션 버그** (사용자가 본 거)
- **회귀 버그** (전에 고쳤는데 또 터짐)
- **5분 헤맴** (AI가 5분 추측해도 원인 못 찾음)

`/diagnose`는 AI가 *추측 모드*로 들어가서 코드 망치는 사고를 막는 안전장치. 7~8단계 정해진 절차로 *진짜 원인*을 찾아냄.

### 🧹 정기 청소 — `/improve-codebase-architecture`

**phase 2 끝났을 때** (= 0+1+2 누적), 그리고 그 후 *짝수 phase 끝마다*:

```
/improve-codebase-architecture
```

→ AI가 코드 누더기 된 부분 찾아서 청소 제안. 솔로 바이브코더의 가장 큰 함정 막기.

---

## 폴더 구조 (참고)

```
프로젝트-루트/
├── CLAUDE.md           헌법 (AI가 절대 어기면 안 되는 룰)
├── AGENTS.md           (CLAUDE.md 심볼릭 링크 — Codex 호환)
├── CONTEXT.md          도메인 용어 사전 (그릴이 lazy 갱신)
│
├── docs/
│   ├── PRD.md          무엇을 만드나
│   ├── ARCHITECTURE.md 어떻게 만드나
│   └── ADR.md          왜 이걸 골랐나 + 배운 거
│
├── phases/             작업 일정 (phase 단위)
│   ├── index.json
│   └── {N-task}/
│       ├── index.json
│       └── step{M}.md  구현 지시서
│
├── handoffs/           세션 일지 (git에 commit)
├── prototypes/         실험 코드 (검증 후 삭제)
│
├── scripts/
│   ├── execute.py      step 자동 실행 엔진
│   └── hooks/          위험 명령 가드
│
└── .claude/
    ├── commands/
    │   ├── harness-write.md   ← 명령 본문
    │   ├── harness-go.md      ← 명령 본문
    │   └── review.md
    └── agents/         서브에이전트 (필요시 만듦)
```

---

## 자주 헷갈리는 것 (FAQ)

### Q. `harness-write`랑 `harness-go` 뭐 먼저?

```
write 먼저, go 나중.
write = "문서 채우기"
go = "코드 짜기"
```

### Q. 그릴 안 하고 바로 `harness-write` 해도 돼?

가능하지만 비추. AI가 컨텍스트 부족하면 *"그릴부터 권장"* 안내가 뜸. 그릴이 자연스러우니 그냥 그릴부터.

### Q. PRD.md에 v2 섹션 추가? 아니면 새 PRD 파일?

**추가.** 한 PRD에 v1, v2, v3 섹션이 시간순 누적. *"이 제품이 어떻게 자라왔는가"*가 한 파일에 다 보임.

### Q. `handoffs/` 폴더는 git에 commit?

**응, 한다.** 다음 머신/환경에서 컨텍스트 이어가야 하므로.

### Q. 프로토타입 코드 어디?

`prototypes/{question}/` 폴더. 검증 끝나면 답만 docs에 박고 폴더 *삭제*.

### Q. GitHub 처음부터 안 만들어도 돼?

**돼.** *폴더 우선* 패턴이 디폴트. `/harness-go`가 git remote 자동 감지해서, GitHub 연결 없으면 Issue 발행만 건너뛰고 phase 진행은 정상. 살아남았다 싶으면 `gh repo create my-project --private --source=. --push` 한 줄로 연결 → 그때부터 Issue 자동 발행 켜짐.

### Q. `gh` CLI 셋업 어떻게?

```bash
gh auth login
```

**1회만.** GitHub 연결한 시점부터 `harness-go`가 알아서 Issue 발행함. 폴더 우선으로 시작하면 GitHub 연결 시점에만 필요.

### Q. 옛 `/harness` 명령은?

폐기됐어. `harness-write` + `harness-go`로 *분리됨*. 한 명령에 3가지 모드 추론하던 헷갈림 제거.

---

## 추가 셋업 (1회만)

### `/handoff` 명령 설치

`/handoff`는 *user 전역 명령*이라 이 하네스에 포함돼 있지 않음. 새 맥북·새 환경에서는 별도 설치 필요:

```
/Users/{유저}/.claude/commands/handoff.md
```

이 파일을 별도로 둬야 함. 감독님 자작 명령.

### matt-pocock 스킬 설치

`/grill-with-docs`, `/diagnose`, `/improve-codebase-architecture`, `/prototype` 등은 matt-pocock 글로벌 스킬. 한 번 설치하면 모든 프로젝트에서 사용 가능:

```bash
# https://github.com/mattpocock/skills 참고
```

---

## 폴더에 들어있는 거 한 줄씩

| 자산 | 뭐 하는 건지 |
|---|---|
| `docs/` | PRD, ARCHITECTURE, ADR 템플릿. 새 프로젝트마다 AI가 채움. |
| `CLAUDE.md` / `AGENTS.md` | 프로젝트 헌법. Claude Code, Codex 둘 다 읽음. |
| `.claude/commands/harness-write.md` | `/harness-write` 명령 본문 |
| `.claude/commands/harness-go.md` | `/harness-go` 명령 본문 |
| `.claude/commands/review.md` | `/review` 명령 (PR 전 체크) |
| `.claude/agents/` | 서브에이전트 정의 (필요할 때 만들어 쓰는 용) |
| `scripts/execute.py` | phase 자동 실행 엔진 |
| `scripts/hooks/` | 위험 명령 차단, 반복 에러 감지 |
| `phases/` | 실제 구현 step 들어가는 곳 (`/harness-go` 명령으로 생성) |
| `handoffs/` | 세션 종료 전 `/handoff`로 저장한 컨텍스트 |
| `prototypes/` | 그릴 도중 만든 throwaway 코드 (검증 후 삭제) |

---

## 한 장 요약 (감독님이 까먹어도 이거 한 장만 보면 됨)

```
새 프로젝트 (폴더 우선, 추천):
  1. npx degit markdap/harness-nubnub my-project
  2. cd my-project && git init && claude
  3. /grill-with-docs로 시작

매 큰 작업:
  1. /grill-with-docs    ← 깊이 인터뷰
  2. /harness-write      ← docs 자동 채움
  3. /harness-go         ← phase 설계 + 자동 실행 (GitHub 있으면 Issue 자동, 없으면 건너뜀)
  4. /handoff            ← 세션 끝낼 때

살아남으면 GitHub 연결:
  gh repo create my-project --private --source=. --push

작은 fix: 직접 수정 (사이클 스킵)
큰 버그: /diagnose
정기 청소 (phase 2, 4, 6...): /improve-codebase-architecture
```
