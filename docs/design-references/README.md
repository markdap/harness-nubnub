# docs/design-references/

## 무슨 폴더?

**raw 디자인 자료**를 두는 자리. 캡쳐, 다른 프로젝트의 `DESIGN.md`, 시안, 무드보드 — 무엇이든.

`/design-consultation` 단계가 이 폴더의 자료를 *input*으로 흡수해 `docs/DESIGN.md`(색/폰트/간격/모션 토큰)를 합성합니다.

## 어디에 떨구나

폴더 안에 그냥. 하위 폴더로 정리해도 OK.

```
docs/design-references/
├── linear-app-screenshots/
│   └── ...
├── tossfeed-design-system.md
└── moodboard-warm-minimalism.png
```

## AI 동작 원칙 (중요)

- **AI는 raw를 절대 가공·요약·이동·삭제하지 않습니다.** 원본은 사용자 자산.
- AI의 합성 결과는 오직 `docs/DESIGN.md`로만. raw는 그대로 보존.
- 중간 가공 산출물을 만들면 다음 단계 전문 스킬(`/design-consultation`, `frontend-design`)의 자유도가 제한됨 — raw는 raw로.
- 이 원칙은 다른 raw 폴더(`docs/research-references/`, `docs/meeting-notes/` 등 *필요 시 생성*)에도 동일 적용.

## 빈 채로 시작해도 OK

자료 0개여도 `/design-consultation`은 정상 작동 — 사용자와의 인터뷰로 토큰을 결정합니다.
다만 raw가 있으면 *공통 모티브 추출*이 훨씬 정확해져요.

## 진입 시점에 이미 자료 모아놨다면?

하네스 진입 직후 바로 떨궈도 됨. 이 폴더는 템플릿 기본 자산으로 *미리* 존재 — `/design-consultation` 호출을 기다릴 필요 없음.
