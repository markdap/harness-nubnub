# harness-nubnub

감독님 전용 Claude Code 개발 하네스. 새 프로젝트 시작할 때마다 이 레포를 템플릿으로 복사해서 사용한다.

---

## 새 프로젝트 시작하는 법 (까먹었을 때 보기)

### 1. GitHub에서 새 레포 만들기

1. `github.com/markdap/harness-nubnub` 접속
2. 우측 상단 녹색 **"Use this template"** → **"Create a new repository"**
3. Owner: `markdap` (회사 org 권한 없으면 일단 개인계정)
4. Repository name: 새 프로젝트명 (예: `url2chart`)
5. Private 선택 → **Create repository**

### 2. 로컬에 가져오기

**Case A — 로컬 폴더가 없는 경우:**
```bash
cd ~/원하는위치
git clone https://github.com/markdap/{새프로젝트명}
```

**Case B — 로컬 폴더를 이미 만들어놓은 경우:**
```bash
cd ~/원하는위치/{새프로젝트명}
git init
git remote add origin https://github.com/markdap/{새프로젝트명}.git
git pull origin main
```

### 3. Claude Code로 폴더 열고 시작 → 아래 "권장 워크플로우" 따라가기

---

## 권장 워크플로우 (안 까먹게 베스트 프랙티스)

> Claude Code 열자마자 이 순서로 진행한다. 기획 → 구현 → 종료 한 사이클 전체.

### 1차 세션: 기획 초안

**Claude Code 열자마자:**
1. **Shift+Tab** 눌러서 plan mode 켜기 (AI가 멋대로 파일 안 만들게 막는 안전장치)
2. 입력:
   ```
   /harness {기획하고 싶은 내용 한 줄}
   ```
   예: `/harness URL 입력하면 차트로 변환해주는 웹 도구 만들고 싶어`

**그러면 AI가 이렇게 동작한다:**
1. `handoffs/` 폴더 확인 → 첫 세션이라 비어있음 → 패스
2. `docs/` 폴더 확인 → 플레이스홀더 상태 → "**PRD부터 같이 채울까요?**" 제안
3. 대화로 `docs/PRD.md` 채움 (목표 / 사용자 / 핵심 기능)
4. PRD 끝나면 → `docs/ARCHITECTURE.md` (기술 스택 / 폴더 구조 / 데이터 흐름)
5. ARCHITECTURE 끝나면 → `docs/ADR.md` (왜 이 기술을 골랐는가)
6. ADR 끝나면 → `CLAUDE.md` (위에서 결정한 규칙들 요약)
7. 다 채워지면 → AI가 plan 파일로 정리해서 승인 요청

> 보통 여기까지가 1차 세션. 머리 식히고 다음 세션에서 다시 본다.
> **종료 전 `/handoff` 치는 것 잊지 말기** (현재 상태가 `handoffs/` 폴더에 자동 저장됨).

### 2차 세션: 기획 재정비

1. Claude Code 다시 열기
2. plan mode 켜고 (Shift+Tab) 입력:
   ```
   /harness 어제 짠 기획 다시 보자
   ```

**그러면 AI가:**
1. `handoffs/`에서 어제 핸드오프 자동으로 읽고 컨텍스트 복원
2. 현재 docs 상태 파악 후 어디서부터 이어갈지 확인
3. 감독님과 대화하며 docs 수정

### 3차+ 세션: 구현 시작

**기획이 충분히 다듬어졌다고 판단되면:**
1. plan mode 꺼도 OK (Shift+Tab 다시 누르면 꺼짐)
2. 입력:
   ```
   /harness 이제 구현 시작하자
   ```

**그러면 AI가:**
1. `phases/{task-name}/` 폴더에 step별 구현 지시서(`step0.md`, `step1.md`, ...) 설계
2. 감독님 승인 요청
3. 승인 후 자동 실행:
   ```bash
   python3 scripts/execute.py {task-name}
   ```
4. step별로 구현 → 테스트 → 커밋 반복 (자동)

### 세션 종료 전 (매번)

```
/handoff
```

→ `handoffs/AI_Continuation_Document-{타임스탬프}-KST.md`로 현재 상태 저장.
→ 다음 세션에서 `/harness` 치면 자동으로 흡수해서 이어받음.

> `/handoff`는 user 전역 명령이라 하네스에 포함돼 있지 않다.
> 새 맥북·새 환경에서는 `/Users/{유저}/.claude/commands/handoff.md`에 별도 설치 필요.

---

## 이 하네스에 뭐가 들어있나

- `docs/` — PRD, ARCHITECTURE, ADR 템플릿. 새 프로젝트마다 AI와 대화하며 채운다.
- `CLAUDE.md` / `AGENTS.md` — 프로젝트 규칙. Claude Code와 Codex CLI가 둘 다 읽는다.
- `.claude/commands/` — `/harness` 슬래시 명령
- `.claude/agents/` — 서브에이전트 슬롯 (필요할 때 만들어 쓰는 용)
- `scripts/execute.py` — phase 자동 실행 엔진
- `scripts/hooks/` — 위험 명령 차단, 반복 에러 감지 hook
- `phases/` — 실제 구현 step들이 들어가는 곳 (`/harness` 명령으로 생성)
- `handoffs/` — 세션 종료 전 `/handoff`로 저장한 컨텍스트 (다음 세션에서 자동 흡수)
