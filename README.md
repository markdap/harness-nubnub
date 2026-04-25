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

### 3. Claude Code로 폴더 열고 시작

```
/harness
```

치면 AI가 `docs/PRD.md`, `ARCHITECTURE.md`, `ADR.md`, `CLAUDE.md` 채우는 것부터 대화로 시작한다.

---

## 이 하네스에 뭐가 들어있나

- `docs/` — PRD, ARCHITECTURE, ADR, HANDOFF 템플릿. 새 프로젝트마다 AI와 대화하며 채운다.
- `CLAUDE.md` / `AGENTS.md` — 프로젝트 규칙. Claude Code와 Codex CLI가 둘 다 읽는다.
- `.claude/commands/` — `/harness`, `/handoff` 슬래시 명령
- `.claude/agents/` — 서브에이전트 슬롯 (필요할 때 만들어 쓰는 용)
- `scripts/execute.py` — phase 자동 실행 엔진
- `scripts/hooks/` — 위험 명령 차단, 반복 에러 감지 hook
- `phases/` — 실제 구현 step들이 들어가는 곳 (`/harness` 명령으로 생성)

---

## 세션 이어받기

세션 컨텍스트가 꽉 찰 것 같으면 종료 전에:

```
/handoff
```

→ AI가 `docs/HANDOFF.md`에 현재 상태 기록.
다음 세션 열면 AI가 이걸 먼저 읽고 이어서 작업한다.
