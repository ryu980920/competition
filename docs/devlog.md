# 개발 로그

새 항목은 위(최신순)에 추가한다. 작성 형식은 [`devlog-template.md`](devlog-template.md) 참고.

> **주제 선정 이력 안내**: 이 프로젝트는 GAA-TFET에서 시작해 여러 차례 방향을 바꾼 끝에 **FinFET + Embedded SiGe Source/Drain 응력공학**으로 확정되었다 (직전까지는 DRAM BCAT였으나 2026-08-04에 다시 전환됨). 검토·기각한 후보 20개의 전체 목록과 사유는 [`topic-selection-history.md`](topic-selection-history.md)에 정리되어 있다. 아래 로그는 시간순 기록이므로 폐기된 경로의 항목도 그대로 남아 있다.

---

## 2026-08-06 (6) — competition/README.md 전면 재작성: STE 프레이밍 반영

### 한 일
- 대시보드 스크린샷을 보며 `Share`의 진행 상황 표를 고치던 중, `competition/README.md`가 여전히 **2026-08-05에 폐기한 결함 경계(People-Bean/Luryi-Suhir) 프레이밍**으로 쓰여 있다는 걸 발견 — 제목·소개 문단·핵심 질문·"사용할 공식" 섹션·베이스라인 설명까지 전부 STE 전환 이전 버전이었음
- "표만 고칠지, 전체를 다시 쓸지" 확인 후 전체 재작성으로 결정
- 여정 요약 표에 6번째 단계 추가 — "FinFET+SiGe 확정"과 "결함 경계→STE 전환"이 사실 서로 다른 두 번의 전환이었다는 걸 명시(기존엔 5단계에 뭉뚱그려져 있었음)
- 핵심 질문/왜 이 주제인가/문제 배경/베이스라인/사용할 공식 섹션을 전부 STE 기준으로 재작성. 라이선스 문제(스크립트 원문 비공개)도 베이스라인·작업 규칙 섹션에 명시적으로 반영
- 저장소 구조 섹션에서 `tcad/`(DRAM BCAT 시절 잔재)·`docs/references.md`(아직 결함 경계 프레이밍)·`docs/reports/`가 아직 정리 안 됐다는 걸 숨기지 않고 그대로 표시

### 결정 사항
- `competition/README.md`는 STE 프레이밍 기준으로 최신화 완료
- `references.md`/`reports/`/`tcad/`는 이번엔 손대지 않고 "아직 안 됐다"고 정직하게 표시만 해둠 — 범위를 무한정 넓히지 않기 위해

### 다음 할 일
- [ ] `docs/references.md`도 STE 프레이밍으로 갱신 (결함 경계 관련 문헌 정리 방식 재검토)
- [ ] `tcad/` 폴더의 DRAM BCAT 잔재 정리 여부 결정
- [ ] `docs/reports/` 세 문서 FinFET 전환 반영

### 참고
- `competition/README.md`

---

## 2026-08-06 (5) — 오늘 작업 전체 반영: 체크박스 정리 + 문서 동기화

### 한 일
- 메쉬 창-수렴 체크(2nm→1nm, 0.8% 차이)와 실제 메쉬 수렴성 검증(tasks.js #8)이 다른 질문이라는 걸 설명 — 전자는 "같은 메쉬에서 후처리 창 크기를 줄여도 안정적이냐", 후자는 "메쉬 자체(refinebox 설정)를 바꿔 재시뮬레이션해도 결과가 안 바뀌냐"로, 전자가 확인됐다고 후자를 완료 처리하면 안 됨을 명확히 함
- `Share`/`competition` 전체에서 오늘 한 작업 기준으로 체크·기입 가능한 항목을 전부 훑음:
  - `analysis/progress.json`: `#4`(baseline 구조 재현) 유용성 체크 — G50_F0 실제 실행 결과(verification CSV)가 존재해 구조 스크립트가 end-to-end로 동작함이 증명됨
  - `analysis/progress.json` 데이터 정합성 버그 발견·수정: `#1`/`#3`/`#4`/`#16`(공동 과제)에 주수빈 키가 누락돼 있었고, `#9`/`#10`/`#11`/`#12`/`#13`/`#17`(개별 과제)은 담당자 키 자체가 tasks.js/task_rules.yaml과 어긋나 있었음(예: FR 단독 스윕은 유용성 담당인데 남다연 키로, Ge% 스윕 #10은 주수빈 담당인데 남다연 키로 들어가 있었음). 대시보드 표시 이름 자체는 tasks.js 기준으로 그려져 화면상 오류는 없었지만, 데이터 파일 안에 엉뚱한 키가 계속 쌓이는 구조였음 — 전부 바로잡음
  - `Share/README.md`(루트): Y축 변수(FR) 설명, STE 측정 정의 박스, Run ID 명명 규칙, "확정 필요 항목" 목록, 폴더 구조 설명, 일정 요약을 전부 최신 상태로 갱신. 스크립트가 여전히 "골격/TODO"라고 적혀 있던 부분들도 정정
  - **부수적으로 발견한 오류**: 루트 README에 "Esd가 이미 파라미터화돼 있다"고 적혀 있었는데, 실제 스크립트를 보니 스윕 가능한 변수가 아니라 **고정 상수값**이었음(스윕 변수 아님) — 예전에 실제 스크립트를 못 보고 추정으로 적었던 부분이 틀렸던 것. 정정함
  - `tasks.js`의 `#1`/`#3`/`#4` purpose 텍스트를 오늘 확인된 실제 상태로 갱신

### 결정 사항
- 데이터 정합성(progress.json 담당자 키)과 문서 동기화(README/tasks.js)는 "팀 판단"이 필요한 항목이 아니라 사실관계 오류 수정이라 바로 반영함 — PR 없이 직접 커밋

### 다음 할 일
- [ ] `finfet_svisual_stress.tcl`(2026-08-06 최신판, SlFin_pt 등 포함) 팀 채널로 공유
- [ ] 나머지 24격자점 스윕 착수 (#10~17)
- [ ] `#1` FR>0 실제 Sentaurus 검증, `#5` 3인 baseline 대조
- [ ] `#8` 메쉬 수렴성 검증(진짜 재시뮬레이션 기반, 남다연)

### 참고
- `Share/analysis/progress.json`, `Share/README.md`, `Share/tasks.js`, `Share/baseline/README.md`, `Share/baseline/params.yaml`

---

## 2026-08-06 (4) — STE 체적평균 vs 계면 단일점 실측 비교 → 큰 차이 확인, 채택 결정 보류로 정정

### 한 일
- (3)번 항목에서 `finfet_svisual_stress.tcl`에 추가해둔 계면 인접 단일점 근사 코드를 실제로 SWB에서 돌려봄 — 사용자가 노드 14(SVisual, stress 추출)를 Clean Up(Files To Delete: n14_vis.*, pp14_vis.cmd 등) 후 재실행
- 첫 시도에서 헤더에 `#set SlFin_pt x` 등 신규 변수 선언이 빠져있던 걸 발견해 추가 — Sentaurus Workbench는 `#set 이름 x`로 선언된 변수만 결과표(변수 테이블)에 잡기 때문에, 이게 없으면 `puts "DOE: ..."` 값이 로그에만 남고 CSV/변수표엔 안 잡힘
- G50_F0(Strain_Impact=1) 결과: **SlFin(체적평균) = -2262 MPa vs SlFin_pt(계면 인접 근사) = -3482 MPa — 53.9% 차이**. ShFin은 +490(체적평균) vs -124(계면 근사)로 **부호까지 반전**. SwFin은 508 vs 389로 상대적으로 덜 벌어짐(23%, 부호 동일)
- 이 결과를 두고 "약간 희석되는 수준이냐, 크게 변형되는 수준이냐"는 질문에 명확히 후자라고 판단 — ShFin 부호 반전은 단순 크기 차이가 아니라 정성적으로도 다른 결론이 나올 수 있다는 뜻이라 더 신경쓰임
- 사용자 제안으로 방향 전환: 지금 하나의 방식으로 확정하지 말고, **남은 24격자점 스윕에서 체적평균·계면근사를 둘 다 뽑아 데이터를 모은 뒤, 스윕이 다 끝나면 그때 최종 STE 정의를 결정**하기로 함 — 이미 스크립트가 둘 다 뽑도록 돼 있어서 추가 작업 부담이 거의 없음

### 결정 사항
- (3)번에서 "체적평균 팀 채택 확정"이라고 기록했던 것을 **"provisional(잠정)"로 정정**. `params.yaml`의 `stress_transfer_efficiency.normalization.adopted`를 `true` → `"provisional"`로 변경, 실측 비교값(`measured_diff_G50F0`)을 그대로 기록
- 최종 STE 정의는 25격자점 스윕이 끝난 뒤, 오프셋(체적평균-계면근사 차이)이 조건마다 일정한지 아니면 Ge%/FR에 따라 달라지는지를 보고 결정하기로 함
- ⚠ 새로 발견한 조율 리스크: `finfet_svisual_stress.tcl`이 라이선스 문제로 git에서 빠져있어서(2026-08-06 (2) 참고), 스윕 담당 3인이 전부 같은 최신 버전(SlFin_pt 포함)을 쓰고 있는지 git으로 보장이 안 됨 — 누군가 예전 버전(SlFin/SwFin/ShFin만 있는)으로 스윕을 돌리면 그 사람 격자점만 비교 데이터가 빠지게 됨. 팀 채널로 파일을 직접 공유해서 싱크 맞춰야 함

### 막힌 점 / 리스크
- 계면 근사 창(2nm×2nm×1nm)이 임의로 정한 값이라 -3482라는 절대 수치 자체는 창 크기/위치에 따라 달라질 수 있음 — "체적평균과 상당히 다르다"는 방향성만 신뢰할 것
- 스크립트가 git 밖에 있어서 3인 동기화를 수동으로 챙겨야 하는 구조적 위험이 생김

### 다음 할 일
- [ ] `finfet_svisual_stress.tcl`(2026-08-06 최신판)을 팀 채널로 공유해 3인 전부 같은 버전으로 맞추기
- [ ] 나머지 24격자점 스윕 시 SlFin/SlFin_pt(및 Sw/Sh 계열) 전부 기록
- [ ] 스윕 완료 후 오프셋 일관성 확인 → STE 최종 정의 결정
- [ ] `doe.x_levels`/`y_levels` 확정 → `values_confirmed: true` (별개로 남은 항목)

### 참고
- `Share/baseline/params.yaml`(`stress_transfer_efficiency.normalization`, `measured_diff_G50F0`)
- `Share/baseline/README.md` 체크리스트
- `Share/baseline/finfet_svisual_stress.tcl` (로컬 전용)

---

## 2026-08-06 (3) — STE 정규화 방법(체적평균) 팀 채택 확정 + 계면 단일점 검증 코드 추가

### 한 일
- STE 정규화 방법(체적평균 vs 계면 인접 단일점) 논의 — 4개 선택지(체적평균 채택/단일점 새로 구현/둘 다 추출/3인 회의로 보류) 중 **"체적평균으로 우선 확정, 첫 실행으로 사후 검증"**을 선택
- 근거를 설명하다가 "국소 효과가 얼마나 희석되는지" 질문을 받음 — 정직하게 답하면 아직 아무도 체적평균과 단일점을 실제로 비교해본 적이 없어서 정확한 수치는 모른다고 답함. fin이 얇고(반폭 7.5nm) 채널이 짧아(25nm) 극단적으로 왜곡될 가능성은 낮다는 물리적 추론만 제시하고, 확실한 답은 실제 데이터로 검증하자고 제안
- 이 과정에서 **내가 이전에 "아직 아무도 Sentaurus를 실제로 안 돌려봤다"고 말한 게 틀렸다는 걸 사용자가 지적** — baseline(G50_F0)은 이미 실제로 돌아갔고, `verification_strain_impact_G50F0.csv`의 `SlFin`/`SwFin`/`ShFin` 컬럼 자체가 그 실행 결과였음. 아직 안 돌아간 건 25격자점 본 스윕(#10~17)뿐이었음 — 이 구분을 명확히 하지 않고 뭉뚱그려 말한 게 원인
- "계면 근처 단일점을 뽑으려면 뭘 해야 하냐"는 질문에 답하며 SVisual 워크플로를 설명: `.tdr` 파일에는 이미 전체 3D 응력장이 저장돼 있어서, SProcess/SDevice를 다시 돌릴 필요 없이 **같은 파일에 대해 SVisual 적분 창(window)만 작게 잡아 그 노드만 재실행**하면 됨
- `finfet_svisual_stress.tcl`에 계면 인접 단일점 근사(게이트 산화막 계면 x=0 × 채널 중앙 z=0 × fin 중심선 y=0 근방 2nm×2nm×1nm 슬래브) 추출 코드 추가 — `SlFin_pt`/`SwFin_pt`/`ShFin_pt`/`SlFin_diff_pct` 산출

### 결정 사항
- STE 정규화 = ChFin 영역 체적평균 방식을 **공식 채택** (`params.yaml` `stress_transfer_efficiency.normalization.adopted: true`)
- 계면 근처 값과의 오차는 "확정 후 검증" 방식으로 처리 — baseline(G50_F0) 재실행(SVisual 노드만) 시 `SlFin` vs `SlFin_pt` 비교, 차이가 크면 재검토

### 막힌 점 / 리스크
- 체적평균 vs 단일점의 실제 차이 폭은 아직 미확인 — 물리적 추론(얇은 fin, 짧은 채널이라 큰 왜곡은 없을 것)일 뿐 측정값 아님
- "실제로 돌아간 것"과 "아직 안 돌아간 것"을 구분 없이 말해서 혼선을 준 것 — 다음부터는 baseline 1점(완료)과 25격자점 스윕(미착수)을 명확히 구분해서 말할 것

### 다음 할 일
- [ ] baseline(G50_F0) .tdr에 대해 `finfet_svisual_stress.tcl`(갱신판)만 재실행해 `SlFin` vs `SlFin_pt` 실제 비교
- [ ] 오차가 크면 STE 정규화 방법 재검토, 작으면 그대로 유지
- [ ] `doe.x_levels`/`y_levels` 확정 → `values_confirmed: true`

### 참고
- `Share/baseline/finfet_svisual_stress.tcl` (로컬 전용, `SlFin_pt` 등 추가분)
- `Share/baseline/params.yaml`(`stress_transfer_efficiency.normalization`)
- `Share/baseline/README.md`, `Share/index.html`(`attachRecommendHtml`)

---

## 2026-08-06 (2) — 실제 Sentaurus 스크립트 4개 확보 → 라이선스 문제로 public repo 커밋은 보류, .gitignore 처리

### 한 일
- `Share/baseline/finfet_sprocess.scm`·`finfet_sdevice.cmd`를 GitHub에서 다시 열어보니, 실제로는 여전히 "TODO 골격(scaffold)" 버전이 커밋돼 있었다는 걸 발견 — 오전 세션에서 SVisual로 구조를 직접 열어 분석했던 실제 스크립트 내용은 채팅에서만 공유됐고 repo엔 한 번도 반영된 적이 없었음. 즉 팀원이 GitHub 링크만 보면 아직 아무것도 안 된 것처럼 보이는 상태였다
- 실제 스크립트 4개(SProcess 구조 생성 1개, SDevice 전기 시뮬레이션 1개, SVisual 응력 추출 1개, SVisual 전기 지표 추출 1개)를 받아 처음엔 `finfet_sprocess.scm`/`finfet_sdevice.cmd`를 실제 원본으로 교체하고 `finfet_svisual_stress.tcl`/`finfet_svisual_extract.tcl`를 신규 추가해서 그대로 커밋하려 했음
- **커밋 직전에 문제 발견**: `Share` 레포가 public이고, 이 스크립트들은 팀이 처음부터 쓴 코드가 아니라 Synopsys Sentaurus 라이선스 예제(Munkang Choi, 2013) 원본을 기반으로 한 것 — 상용 EDA 툴 라이선스 예제는 재배포 금지 조항이 흔해서, 확인 없이 public에 올리면 라이선스 위반 위험이 있다는 걸 뒤늦게 짚음
- 4개 옵션(그대로 push / 레포 private 전환 / 스크립트만 제외하고 나머지는 push / 라이선스 관리자에게 먼저 확인) 중 **"스크립트 파일만 `.gitignore`로 제외하고 나머지(params.yaml, README, devlog)는 그대로 push"**로 결정 — 파일은 로컬에 그대로 두고 각자 Sentaurus 작업엔 계속 쓰되, git에서만 빼는 절충안
- 실제 코드를 근거로 `params.yaml`의 미확정 항목을 채움:
  - `doping.sd_boron_conc_cm3` = 2.0e20 (S/D 붕소 도핑 고정값 — 이전엔 TODO였음). 채널/채널스탑 도핑 종(Phosphorus/Arsenic)도 추가했지만 농도는 격자점마다 CSV로 넘기는 매크로 변수라 CSV별로 다르다는 것도 함께 기록
  - `stress_transfer_efficiency.normalization` — 아침에 "게이트 산화막 계면 × 채널 중앙 × 핀 중심선 단일점"으로 제안했던 방법과 실제 스크립트(`finfet_svisual_stress.tcl`)가 다르다는 걸 발견. 실제로는 ChFin 영역 전체(핀 전체 높이·폭·채널길이)의 **체적평균**이었다 — 제안했던 단일점 방식은 채택되지 않았고, 코드는 이미 다른 방식으로 동작 중이었던 것. 이 사실만 그대로 문서화했고, "이 방식을 최종 STE 정의로 쓸지"는 여전히 팀 판단으로 남겨둠
  - `doe.baseline_point`(FR=0=원본과 동일 구조인지) — `finfet_sprocess.scm`의 리세스 식각 로직이 FR=0 조건에서는 아예 실행되지 않는 코드 구조라는 것을 재확인 (기존엔 SVisual 육안 확인만 있었음)
  - `meta.verified_by`를 빈칸에서 "유용성"으로 채움
- 부수적으로: NetActive 메쉬 스크린샷을 보고 메쉬 밀도가 적절해 보이는지 질문받음 — 육안상 재질/도핑 경계에 메쉬가 조밀하고 벌크 기판 쪽은 성긴 정석적 배치였지만, "충분한지"는 눈으로 확정할 문제가 아니라 정량적 수렴성 검사(tasks.js #8, 남다연 담당)로 확인해야 한다고 안내
- git 워크플로 재점검 — `.git/index.lock`이 반복적으로 걸리는 문제의 구조적 원인(OneDrive 동기화 폴더 위에서 Claude 샌드박스와 사용자 PowerShell이 동시에 `.git`을 건드림)을 짚고, 이후로는 파일 내용 수정은 Claude가, `git add`/`commit`/`push` 전부는 사용자가 PowerShell에서 직접 하는 것으로 역할을 재분리하기로 함

### 결정 사항
- **스크립트 원본 4개(`finfet_sprocess.scm`/`finfet_sdevice.cmd`/`finfet_svisual_stress.tcl`/`finfet_svisual_extract.tcl`)는 public `Share` repo에 커밋하지 않는다** — `.gitignore`에 등록, 로컬에만 보관. Synopsys 라이선스 재배포 조항 확인 전까지 유지
- 팀이 무엇을 바꿨는지(FR 변수 추가, GeMoleFraction 매크로화, pMOS 전용화 등)는 코드 없이도 `baseline/README.md`·`params.yaml`·이 devlog에 전부 텍스트로 남겨서, 스크립트가 git에 없어도 "무엇을 했는지"는 재현 가능하게 함
- STE 정규화 방법의 "제안"과 "실제 구현"이 서로 달랐다는 사실을 감추지 않고 그대로 기록 — 코드가 이미 체적평균 방식으로 동작 중이라는 것과, 이걸 최종 채택할지는 별개 문제라는 점을 명확히 구분해서 `params.yaml`에 남김
- git add/commit/push 역할 분리 (Claude=파일 수정만, 사용자=git 명령 전부)로 lock 충돌의 구조적 원인 제거 시도

### 막힌 점 / 리스크
- 라이선스 재배포 조항을 실제로 확인한 건 아니고, "위험해 보여서" 보수적으로 뺀 것 — 학교/연구실 라이선스 관리자에게 정식으로 확인하면 다시 올릴 수도 있음
- `finfet_svisual_stress.tcl`의 체적평균 방식이 STE 정의로 적절한지는 아직 검증되지 않음 — 특정 응력 집중 지점을 평균으로 희석시킬 가능성이 있어 팀 논의 필요
- FR>0 리세스 로직은 여전히 실제 Sentaurus 실행으로 검증된 적 없음 (FR=0 회귀 테스트만 완료)
- 메쉬 조밀도가 "충분한지"는 아직 정량적으로 확인 안 됨 (tasks.js #8 대기)
- `.git/index.lock` 구조적 원인은 추정이지 100% 확인된 건 아님 — 역할 분리 이후에도 재발하는지 지켜봐야 함

### 다음 할 일
- [ ] (선택) 학교/지도교수·라이선스 관리자에게 Sentaurus 예제 재배포 가능 여부 확인 — 가능하면 스크립트 다시 공개해도 됨
- [ ] STE 정규화 방법(체적평균 vs 단일점) 팀 논의 후 최종 확정
- [ ] FR>0 리세스가 의도대로 파이는지 실제 Sentaurus 실행으로 검증
- [ ] tasks.js #8 메쉬 수렴성 검사 결과 확인
- [ ] `doe.x_levels`/`y_levels` 확정 → `values_confirmed: true`

### 참고
- `Share/.gitignore` (스크립트 4개 제외 규칙)
- `Share/baseline/params.yaml`(`doping`, `stress_transfer_efficiency.normalization`, `doe.baseline_point`, `meta.verified_by`, `output.*_extraction_script`)
- `Share/baseline/README.md` 변경이력

---

## 2026-08-06 — SVisual로 baseline 구조 직접 열어 확인 + Strain_Impact 응력-이동도 결합 검증

### 한 일
- SVisual(`n1_e_fps`)로 baseline 구조를 직접 열어서 채널 길이/핀 폭/핀 높이가 각 축의 어디에 해당하는지 확인 — 처음엔 축 위젯(X/Y/Z 화살표)만 보고 판단하려다 헷갈려서, 재질/Region을 하나씩 꺼보면서 형상으로 재확인하는 방식으로 전환
- "핀이 어디서 끝나고 기판이 어디서 시작하는지"를 도핑 색(NetActive)만으로 구분하려다 착각 — 채널과 기판이 배경 도핑 농도가 비슷해서 같은 색으로 보였던 것. Oxide(STI) 재질만 단독으로 켜서 그 윗면 높이로 핀/기판 경계를 다시 확인
- SiGe 재질만 켜고 봤을 때 "채널(ChFin)도 SiGe 아니냐"는 오해가 발생 — Materials 탭(재질 단위)과 Regions 탭(스크립트가 이름 붙인 세부 영역 단위)을 혼동한 게 원인이었음. Regions 탭에서 ChFin만 단독으로 분리해서 켜보니 정상적으로 n형 Silicon(Nch 수준)인 것으로 확인, 오해 해소
- S/D 도핑도 처음엔 "표면 근처만 고농도, 몸통은 배경 수준"이라고 잘못 판단 — 이것도 ChFin(채널)이 같은 화면에 섞여 있어서 생긴 착시였고, SDepi(S/D)만 따로 분리해서 BTotal·BActive를 보니 부피 전체가 균일하게 2e20으로 정상
- `finfet_sprocess.scm` 원문을 직접 읽고 리세스(FR)·언더컷(Esd) 식각이 실제 물리 기반 식각 모델이 아니라, 이상적인 사각 형상을 그대로 치환하는 기하학적 방식으로 구현돼 있음을 확인 — 실제 식각 프로파일(경사면 등)은 반영 안 됨
- Esd를 "채널 아래로 파고드는 것"으로 착각했다가, brick 좌표를 직접 계산해서 "핀 전체 높이에 걸쳐 균일하게, 채널 길이 방향으로만 7.5nm 옆으로 파고드는 것"이고 게이트 바로 밑 25nm 채널 자체는 (Esd < Lsp0라서 0.5nm 여유를 두고) 안 건드린다는 것으로 정정
- GeTotal 스칼라를 평면 컷(cutline)으로 잘라서 Ge=0(채널) 구간의 실제 폭을 측정 — 계산값(L+2·Lsp0-2·Esd ≈ 26nm)과 실측(~20~25nm)이 비슷해서, 이전에 3D 비스듬한 뷰에서 "너무 얇아 보였던 것"은 원근 왜곡 때문이었다고 결론
- STE 정규화 방법(채널 인접 지점, GPa 환산 방식) 초안 제안: 게이트 산화막 계면 × 채널 길이 중앙 × 핀 중심선(Y=0) 지점에서, StressEL 세 성분 중 채널 방향(길이 방향) 성분 하나만 사용 — 팀 확정 대기
- Strain_Impact=1 vs 0 SWB 비교 CSV(G50_F0, Ge=0.50/FR=0)로 최종 판정: IdSat_norm +227%(1.704e-4→5.574e-4), IdLin_norm +176%, gmSat +116%, |VtiSat| −23%(0.525V→0.403V), SSSat 549.8→183.5. 방향성(Ion↑, |Vth|↓)이 eSiGe pMOS 문헌(압축응력→정공 이동도 증가, 밸런스밴드 효과로 |Vth| 감소)과 일치 — 응력→전기 결합이 실제로 작동함을 확인

### 결정 사항
- Strain_Impact 응력-이동도 결합 정상 작동 확인 → **G50_F0을 baseline으로 확정**
- `Share/baseline/params.yaml`(`verification.strain_impact_coupling`), `baseline/README.md`(체크리스트·변경이력)에 검증 결과 반영. 이번 건은 팀 판단으로 PR 절차 생략하고 main에 직접 반영(baseline/README.md의 "직접 push 금지" 원칙에서 예외 처리, 사유는 위 README.md 참고)

### 막힌 점 / 리스크
- SSSat 절대값(183~550 mV/dec)이 이상적 60mV/dec 대비 매우 높음 — 이 서브구조는 게이트 재질이 없는(`gate_material_present:false`) 순수 응력/도핑 계산용이라, 완전한 게이트 스택 구조에서 재확인 필요
- STE 정규화 방법은 아직 "제안" 단계이지 팀 확정이 아님
- `doe.x_levels`/`y_levels`(Ge%·FR 스윕 격자)는 여전히 PLACEHOLDER, `values_confirmed: false` 그대로

### 다음 할 일
- [ ] STE 정규화 방법(채널 인접 지점 좌표, GPa 환산 방식) 팀 확정
- [ ] SSSat 비정상적으로 높은 값의 원인 확인 (완전한 게이트 스택 구조에서 재검증)
- [ ] `doe.x_levels`/`y_levels` 확정 → `values_confirmed: true`
- [ ] 25개 격자점 본 스윕 시작

### 참고
- `Share/baseline/README.md` 변경이력, `Share/baseline/params.yaml`의 `verification.strain_impact_coupling`
- 근거 CSV: `Share/baseline/verification_strain_impact_G50F0.csv`

---

## 2026-08-04 — 주제 전환: DRAM BCAT DBCAT(질화막 두께)×접합 도핑 → FinFET + Embedded SiGe Source/Drain 응력공학

### 배경
- 실제 2025/2026 POLARIS SIF 수상작(아이디어·작품 부문) 6건을 팀이 직접 분석
- 그 중 **김나박구팀(2026 작품 부문)**이 이미 "BCAT + DWMG"로 우리가 하려던 것과 유사한 조합을 출품했음을 확인 — DBCAT×접합 도핑 조합의 독창성이 약해짐
- "~ 최적화가 아니라 기존 구조 + 새 공정 → 개선"이라는 팀의 핵심 요구사항을 재확인, 이 기준으로 대체 주제를 재검토

### 검토한 대안과 기각/채택 경위
1. **GAA 나노시트 dog-bone 접합 구조** — 검토했으나 "시뮬레이션하기 너무 어렵다"는 판단으로 기각
2. **NCFET/강유전체 게이트 스택** — 분석한 수상작 6건 중 3건이 이미 "특수 게이트 물질 삽입" 패턴이라 겹침 위험 판단으로 기각
3. **FinFET + Embedded SiGe Source/Drain 응력공학 (채택)** — FinFET 소스/드레인을 선택적 에피택시(SEG)로 SiGe 대체, in-situ 도핑, PMOS 채널에 압축 응력 유도. 스윕 변수: Ge 조성(%) × 리세스 깊이. 결과물은 단일 최적점이 아니라 두 변수의 트레이드오프 경계(전위결함으로 응력 이득이 무효화되는 지점) 지도

### 결정 사항
- 최종 주제: FinFET + Embedded SiGe S/D 응력공학, 스윕축 Ge%×리세스 깊이, 결과물은 결함 발생 경계(trade-off boundary) 2차원 지도
- 방법론: Sentaurus로 (Ge%, 리세스 깊이) 전 구간의 응력·이동도를 완전정합(pseudomorphic) 가정 하에 계산 → 문헌 기반 임계두께 경계선(People-Bean 1985 / Luryi-Suhir 1986)을 등고선 위에 별도로 오버레이하는 하이브리드 방식 (Sentaurus 자체는 결함을 반영하지 않는다는 것을 항상 전제)
- **팀 협업 방식을 대시보드 기반으로 전환**: 실제 작업용 저장소 [`ryu980920/Share`](https://github.com/ryu980920/Share)를 신설하고, GitHub Pages 대시보드([`https://ryu980920.github.io/Share/`](https://ryu980920.github.io/Share/))를 만들어 담당 과제·진행 체크리스트·소자 사진/메모·결과 CSV를 팀원 3인이 한 화면에서 공유·갱신할 수 있게 함. 정적 페이지라 체크박스/업로드가 그냥은 저장되지 않는 한계를, GitHub REST API를 브라우저에서 직접 호출(개인 Personal Access Token을 브라우저에만 저장)하는 방식으로 해결 — 팀원이 git 명령어를 몰라도 체크·사진 업로드가 실제로 저장소에 커밋되도록 구현함. 이 레포(`competition`)는 여정·의사결정 기록용이고, `Share`는 실행·결과 공유용으로 역할을 분리함
- 핵심 참고자료 확보: Choi et al.(Synopsys, 2012), Gendron-Hansen et al.(Synopsys, SISPAD 2015 — 가장 근접한 선행연구, 축·목표 차별점 명시 필요), Joshi et al.(2017), People-Bean(1985), Luryi-Suhir(1986), Hartmann et al.(2011 — People-Bean 근사식이 Ge 22% 이상에서 실측 대비 최대 ~2배 과소평가한다는 것을 XRD로 확인한 논문, 상세는 references.md)

### 막힌 점 / 리스크
- Gendron-Hansen(2015)·Choi(2012) 원문이 IEEE 페이월이라 아직 전체를 못 읽음 — 우리 축(Ge%×리세스 깊이, 결함경계 매핑)과 Gendron-Hansen의 축(기술노드 세대, 응력 최대화)이 다르다는 차별점을 원문으로 최종 확인해야 함
- People-Bean(1985) 원 논문의 임계두께 그래프 데이터를 페이월 때문에 못 구함 — 학교에 논문 복사 신청한 상태 (진행 중)
- US9245980B2 특허를 한때 "Luryi-Suhir식 탄성 완화"의 근거로 잘못 인용했다가, 원문을 직접 읽고 실제로는 ART(Aspect-Ratio Trapping)+열확산이라는 다른 메커니즘임을 확인해 정정함 — 우리 공정(SEG로 직접 리세스에 에피 성장)과 메커니즘이 달라 직접 근거로 못 씀. 대신 이 특허가 인용한 Kim et al.(2012, SEG 전용)이 더 정확한 대체 후보이나 원문 아직 미확인 (상세 경위는 [retrospective.md](retrospective.md))
- FinFET_14nm/22nm 예제(Synopsys Sentaurus Applications Library)가 Intel 22nm Tri-Gate / PTM 14nm에 실제로 대응하는지는 파일명 기반 추측일 뿐 미검증

### 다음 할 일
- [ ] Gendron-Hansen(2015)·Choi(2012) 원문을 학교 IEEE Xplore 계정으로 확인
- [ ] People-Bean(1985) 원 논문 그래프 데이터 확보되는 대로 근사식과 대조
- [ ] Kim et al.(2012, SEG 대체 후보) 원문 확인
- [ ] `docs/reports/project-plan.md`, `docs/reports/dram-basics.md`를 FinFET+SiGe 기준으로 재작성 (아직 DBCAT 단계 그대로임)
- [ ] 학교 라이선스에서 FinFET_14nm/22nm 예제 실제 치수 확인 (최우선)
- [x] Share 저장소·대시보드 사용법을 팀원(GitHub 미경험자)용 설명서로 정리해 배포 — `Share/docs/Share_저장소_대시보드_사용설명서.docx`

### 참고
- 오늘 검증 과정에서 실제로 잡아낸 오류(믿을 뻔했다가 정정한 사례) → [retrospective.md](retrospective.md)
- 참고 문헌 전체(확인됨/미확인 상태 표시) → [references.md](references.md)
- 기각 경위 상세(20번째 후보로 등재) → [topic-selection-history.md](topic-selection-history.md)
- 실행·팀 협업용 저장소(이 레포와 역할 분리) → https://github.com/ryu980920/Share , 대시보드 → https://ryu980920.github.io/Share/

---

## 2026-08-02 — 구조 변수 재검증: Rfillet(코너 라운딩) → DBCAT(질화막 두께)로 교체

### 배경
- 팀 학습자료(dram-basics.md)의 BTBT 설명 문단을 검토하던 중, "게이트-산화막-드레인이 만나는 코너"라는 GIDL 발생 위치와 "BCAT의 새들핀 각진 코너(Fin Fillet Radius, Rfillet)"를 같은 곳처럼 서술해온 것이 발견됨
- 베이스라인 논문([B1]) 원문을 재정독한 결과, 두 위치는 실제로 다름을 확인:
  - Rfillet은 새들핀 채널 단면(A-A', 채널을 가로지르는 방향)의 코너 — 채널 내부, 리세스 바닥 쪽. 논문은 이 변수의 효과를 "코너 전계 집중 → 소자 신뢰성(산화막 내구성)"으로 설명하며, 인용 근거도 GIDL 논문이 아니라 일반 전계 특이점·STI 코너 신뢰성 논문. 5개 구조 변수 중 영향이 가장 작음(<5%)이라고 논문이 직접 명시
  - GIDL은 표면의 게이트-드레인 겹침 코너(B-B' 방향)에서 발생. 논문이 GIDL과 명시적으로 인과 연결한 구조 변수는 **DBCAT(질화막 두께)**뿐: "질화막을 금속 게이트 위에 쌓는 목적은 게이트-드레인 겹침을 줄여 GIDL을 줄이기 위함"

### 검토한 대안과 기각/채택 경위
1. **코너 B(게이트-드레인 겹침)를 직접 라운딩** — 관련 특허 2건(US 11,610,972, US 8,012,828) 원문 확인 결과, 실제 GIDL 저감 기법은 "산화막 두께 조절"·"겹침 깊이 축소"였고 순수 곡률(라운딩) 기법은 문헌으로 확인되지 않아 기각
2. **Rfillet × 접합(S/D) 도핑, 목표를 Vth·SS로 변경** — 핀 코너(채널 내부)와 S/D 접합이 물리적으로 다른 위치라 상호작용 근거가 약하고, Rfillet 주효과 자체가 이미 작다고 논문에 명시되어 완주 리스크가 있어 기각
3. **DBCAT × 접합 도핑 (채택)** — 게이트-드레인 사이 전압이 절연막(산화막+질화막)과 반도체(드레인 공핍층)의 직렬 전압 분배로 나뉘므로, DBCAT과 접합 도핑이 이 전압 분배를 통해 상호작용할 물리적 근거가 명확함. 결합 조합의 선례는 검색상 확인되지 않음. 공정 제어 근거도 논문에 명시(금속 게이트 에치백 양)되어 있어 Rfillet보다 명확함

### 결정 사항
- 첫 번째 스윕 변수를 Rfillet → DBCAT으로 교체 확정
- DBCAT 베이스라인: 공칭 36nm, 24~48nm(±33%) 스윕 — [B1]이 실측한 범위
- SDE의 filleting/edge blending 기능은 더 이상 핵심 강점 근거가 아님. DBCAT은 표준 3D 리세스 에치백 파라미터로 구현
- 실행 순서에 체크포인트 추가: DBCAT 단독 스윕에서 주효과가 무시할 수준이면, 전체 2차원 격자 전에 재검토
- 가설이 빗나갈 경우의 대비 시나리오를 3가지로 구체화 (A. 독립, B. DBCAT 무효과, C. DBCAT 유효하나 대가 큼) — project-plan.md 5-4절 참고
- "2차원 등고선을 읽는 법" 절을 project-plan.md 4-4절에 신설. 예시 그림(독립/시너지/트레이드오프 3패턴)을 `figures/dbcat-doping-contour-example.png`로 추가

### 수정한 문서
- `README.md`, `docs/reports/project-plan.md`, `docs/reports/dram-basics.md`, `docs/references.md` — Rfillet 관련 서술 전체를 DBCAT 기준으로 재작성
- `figures/dbcat-doping-contour-example.png` — 2차원 등고선 예시 그림 추가

### 막힌 점 / 리스크
- DBCAT × 접합 도핑 결합에 대한 선례 미확인은 완전한 검증이 아니므로, baseline 구조 재현 착수 전 한 차례 더 좁혀서 검색할 것
- 질화막 에치백 시 재료별 식각률 차이로 비평탄 표면이 생길 수 있다는 공정 문헌상 주의점 확인됨 — 5-1절 구조 검증 항목에 반영

### 다음 할 일
- [ ] DBCAT × 접합 도핑 결합 선례 재검색 (좁혀서, 최종 확인)
- [ ] 팀 3인 공통 배경학습 — 개정된 [DRAM 기초 학습자료](reports/dram-basics.md) 완독
- [ ] 학교 라이선스 예제 폴더에서 DRAM/BCAT/리세스 게이트 예제 존재 여부 확인 (최우선)
- [ ] baseline 구조 재현 착수

### 참고
- 검토 근거(원문 재정독, 특허 원문 확인, 물리적 상호작용 논리) → 본 대화 로그. 별도 보고서 문서화는 필요 시 추가 예정

---

## 2026-07-31 — 저장소 전면 개편 및 프로젝트 문서화

### 한 일
- 최종 주제 확정(DRAM BCAT 코너 라운딩 × Elevated S/D 접합 결합 최적화)에 따라 저장소를 전면 개편
- **개편 방침 결정**: "새 주제 중심 전면 개편 + 전환 이력은 별도 아카이브 1개로 압축 보존". 이유는 (1) 저장소 첫인상이 현재 주제여야 함, (2) 그러나 19개 후보를 문헌 검증하고 기각한 기록 자체가 독창성 심사의 근거 자산이라 삭제하면 손실, (3) devlog는 시간순 로그이므로 과거 항목은 그대로 보존
- `docs/topic-selection-history.md` 신규 작성 — 검토·기각한 19개 후보 전체 목록(표), 6단계 전환 과정, 폐기 자료 목록, 이력에서 얻은 교훈 5가지
- `README.md` 전면 재작성 — BCAT 주제·핵심 질문·선정 근거·베이스라인 수치·진행 상황·역할 분담 중심
- `docs/references.md` 전면 재작성 — BCAT 관련 자료만 유지(베이스라인 B1, 접합 저도핑 근거 R1·R2, 인접 연구 N1~N4, 툴 레퍼런스 T1~T4, 수상작). GAA 계열 문헌은 전부 이력 문서로 이동
- `docs/reports/project-plan.md` 신규 작성 — 주제·이유·설계방향·확인사항·결론전략 6장 구성의 통합 기획서
- `docs/reports/dram-basics.md` 신규 작성 — 배경지식 0 기준 DRAM 학습자료. 9장 + 용어사전 28개 + 자가점검 12문항
- `docs/reports/award-analysis-and-topic-selection.md` 헤더 갱신 — 2~3장(수상작 목록·패턴)은 유효하나 5~6장 결론(GAA Halo Doping 추천)은 폐기됨을 명시
- GAA 전용 코드 분석 3종(`nsfet-code-analysis.md`, `three-codes-comparison.md`, `code-bc-line-analysis.md`) 삭제 — BCAT는 SDE Scheme 기반 3D 리세스 구조라 GAA 나노시트 SProcess 스크립트를 직접 재사용할 수 없음. 삭제 사실은 이력 문서에 기록(git 히스토리로 복원 가능)

### 조사 결과 (기획서에 반영)
- **BCAT 3D 구조는 SProcess가 아니라 Sentaurus Structure Editor(SDE)로 만들어야 함.** 관련 논문들의 일반적 흐름은 2D 공정을 SProcess로 돌린 뒤 3D 형상 구성·도핑 컴파일을 SDE로 수행하는 것
- **SDE가 filleting / 3D edge blending / chamfering을 공식 지원** — 우리 핵심 변수인 코너 라운딩(Fin Fillet Radius)을 표준 기능으로 직접 파라미터화 가능. 구현 리스크가 크게 낮아지는 결정적 요인
- **Synopsys 공식 BCAT 예제는 웹 검색으로 확인되지 않음** — 학교 라이선스 예제 폴더 직접 확인이 최우선 과제. 다만 베이스라인 논문이 치수를 모두 공개하므로 없어도 진행 가능
- SDevice의 BTBT 모델 계열(Schenk / Hurkx / Dynamic Nonlocal Path)이 GIDL 시뮬레이션에 사용됨. 관련 논문들은 주로 비국소 경로 모델 채택
- GIDL이 게이트-산화막-드레인 코너에 국소화된 표면 현상이며, **Row Hammer의 전자 주입 메커니즘도 같은 위치·같은 전계 조건을 공유**한다는 문헌 확인 → 공학적 파급효과 서사로 활용

### 결정 사항
- 프레이밍을 "두 파라미터 각각의 최적값 찾기"에서 **"두 변수의 상호작용 규명"**으로 재정의. 결과물의 형태 자체가 두 개의 1차원 그래프가 아니라 **하나의 2차원 등고선**이어야 함
- 결론 문장의 형태를 실험 전에 미리 확정 (기획서 6-1절)
- 가설(상호작용 존재)이 빗나가 두 변수가 독립으로 나올 경우의 대비 서사도 준비 — "각각 따로 최적화해도 무방하다"는 것 자체가 설계자에게 유용한 결론
- 저장소 문서는 전부 Markdown으로 작성, `.docx`는 커밋하지 않는다는 규칙 유지 (README 작업 규칙에 명문화)

### 막힌 점 / 리스크
- 학교 라이선스에 BCAT/리세스 게이트 예제가 있는지 미확인 — 없으면 SDE 구조 스크립트를 처음부터 작성해야 하므로 초기 일정 여유 필요
- SIF 2025 사업단장상 BCAT 수상작 원문 미확인(로그인 필요) — 우리 주제와의 차이를 명확히 해두어야 함
- 3D 시뮬레이션 1회 실행 시간을 아직 측정하지 못해 전체 DoE 규모(25~49점)의 현실성 미검증
- 코너 영역 국소 메쉬 정밀화가 필요한데, 필렛 반경 극단값에서 메쉬 생성이 실패할 가능성

### 다음 할 일
- [ ] 팀 3인 공통 배경학습 — [DRAM 기초 학습자료](reports/dram-basics.md) 완독 + 자가점검 12문항
- [ ] 베이스라인 논문(MDPI 2022) 팀 전원 정독
- [ ] **학교 라이선스 예제 폴더에서 DRAM/BCAT/리세스 게이트 예제 존재 여부 확인 (최우선)**
- [ ] SDE Scheme 스크립팅 기초 학습, 간단한 3D 리세스 구조 생성 실습
- [ ] 역할 분담 확정 (구조 / 소자·물리 / 분석·문헌)
- [ ] SIF 2025 BCAT 수상작 원문 확인
- [ ] baseline 구조 재현 착수

---

## 2026-07-30 (계속) — 주제 전면 재검토: GAA 나노시트 계열 전체 폐기 → DRAM BCAT 코너·접합 결합 최적화로 전환

### 배경
- 위 항목(GAA 초협소 시트 간격 Vt-Implant vs WFM)의 핵심 결론 도출 방법이 RDF 정량화(sIFM/Monte Carlo)에 의존하는데, 이게 학교 라이선스·컴퓨팅 자원으로 실제 가능한지 불확실하다는 문제 제기가 나옴
- RDF를 못 쓰면 WFM vs 다중 임플란트의 "net으로 유효한가"라는 핵심 질문 자체에 답할 수 없다는 방법론적 공백이 확인됨
- 동시에 팀원 중 한 명이 "양산 불가능할 수도 있는 주제"라는 점에 회의적이라는 팀 내부 이견도 제기됨
- 두 문제를 동시에 해결하려 하기보다, RDF 관련 내용 전체를 폐기하고 소자·주제를 처음부터 완전히 새로 검토하기로 결정 (기존 투입 노력은 고려하지 않음)

### 새 선정 기준
1. 수상작 분석 내용 기반 추천 (GAA/Forksheet/DRAM/NAND 등 실제 수상 카테고리 우선)
2. 경진대회 심사 기준(완성도 30·독창성 30·공학적 파급효과 20·발표 20) 기반
3. 기존 단일 논문과 구조·수치가 완전히 동일한 경우는 배제
4. 실제 양산 가능한 조건일 것 (양산 여부 자체가 논쟁거리인 주제는 배제)

### 검토한 소자군과 기각/채택 근거
- **BSPDN(후면 전력망) 백사이드 컨택 저항 비교**: 이미 양산 중(Intel 18A PowerVia)이라 양산성은 최고 수준이나, 관련 문헌이 대부분 SEMulator3D/Global TCAD Solutions 툴 기반이라 Sentaurus 구현 확실성이 낮아 순위 하향
- **SiC 트렌치 MOSFET / GaN HEMT 파워 반도체**: 이미 양산 중이고 Sentaurus 문헌도 풍부해 완주 리스크는 가장 낮았으나, 실제 수상작 11건(POLARIS SIF·KCS·삼성휴먼테크)을 재검토한 결과 파워 반도체 카테고리는 단 한 건도 전례가 없어 수상 패턴 기준에서 탈락
- **3D NAND 채널홀 Vth 편차**: Sentaurus 구현 사례 확인, 수상 전례도 있으나(KCS HAR 식각, 삼성휴먼테크 낸드 신소재) 채널홀의 3D 형상·전하트랩 물리가 얽혀 완주 리스크가 상대적으로 높음
- **eMRAM(STT-MRAM)**: 액세스 트랜지스터는 Sentaurus로 가능하나 MTJ 자체(스핀토크 자화 스위칭)가 Sentaurus 표준 반도체 물리 엔진 밖의 자성 물리라 실제 기여 범위가 축소될 위험
- **GAA 나노시트 파라미터 차등화 계열 전체(비대칭 스페이서, 하이브리드 스페이서, 레이어별 워크펑션, 레이어별 게이트스택, 순차 스페이서 형성 등 외부 제안 포함 5건)**: 개별 검색 결과 전부 기존 논문·특허와 겹침 확인(비대칭 Dual-k 스페이서, GAA 나노시트 spacer 소재 조합 2025 논문, WFM/다이폴 특허, stress/strain 논문 등). "GAA 레이어를 다르게 만든다"는 뼈대 자체가 이미 도핑·워크펑션·유전체·스페이서·스트레스 축 전부 개별 논문화되어 있음을 재확인 후 이 계열 전체를 폐기
- **Process-aware Device Design(변동성 고려 설계)**: 특정 소자를 지정하지 않은 방법론 제안인 데다, 사실상 RDF 등 변동성 정량화 문제로 다시 귀결되어 이번 기준(RDF 배제)과 충돌 → 기각
- **DRAM BCAT(Buried Channel Array Transistor)**: SIF 2023(4F2 DRAM 수직 트랜지스터), KCS 2025(RCAT Dual-k Spacer)에서 DRAM 셀 트랜지스터가 이미 두 차례 수상한 카테고리. 이미 삼성/SK하이닉스가 sub-20nm 노드로 양산 중이라 양산성 논쟁 자체가 없음. Sentaurus로 구현된 baseline 논문(MDPI 2022, Lgate 20nm·Drecess 120nm·AR 6.0·게이트산화막 5nm·텅스텐게이트 WF 4.8eV)이 존재해 구현 확실성도 높음 → 최종 채택

### 최종 주제 확정 및 원본 검색 한계 인정
- **최종 주제**: DRAM BCAT의 코너 라운딩(Fin Fillet Radius, 구조/식각 엔지니어링) + Elevated S/D 접합 도핑 저감을 결합한 GIDL·리텐션 특성 개선
- 좁혀서 재검색한 결과, 두 기법을 "하나로 묶어 통합 설계"한 논문은 확인되지 않았으나, 개별 축(코너 곡률 → 2024 quasi-atomistic 논문, 저도핑 접합 → GIDL 논문, F임플란트 → 리텐션 논문)은 2023~2025년 사이 인접 연구가 촘촘히 존재함을 확인. "전혀 겹치지 않는 완전 신규"라고는 말할 수 없음을 인정
- 이 시점에서 여백 찾기(추가 검색으로 완전 무경쟁 지점을 계속 좁히는 것)를 중단하고, "완전한 신규"가 아니라 "이미 알려진 개별 기법을 우리가 직접 조합·검증한 결과"로 정직하게 포지셔닝하고 실행 단계로 넘어가기로 결정
- RDF는 이 주제에서 완전히 배제 — Vth, SS, GIDL, DIBL 등 결정론적 전기적 지표만으로 결론을 낼 수 있어 이전 주제의 핵심 리스크(RDF 정량화 가능 여부)에서 자유로움

### 폐기 확정
- GAA 나노시트 관련 모든 계획(TFET, Halo Doping, 다중 에너지 Vt-Implant, WFM 비교, RDF 정량화, 시트별 파라미터 차등화 5안) 전부 폐기
- 위 "2026-07-30" 항목(1~2단계)은 폐기된 경로의 기록으로 그대로 보존

### 다음 할 일
- [ ] MDPI 2022 BCAT baseline 구조를 Sentaurus SProcess로 재현
- [ ] Fin Fillet Radius(코너 곡률) + Elevated S/D 접합깊이·도핑농도를 함께 스윕하는 DoE 설계
- [ ] SDevice에서 Vth, SS, GIDL, DIBL 추출 방법 확정
- [ ] 개별 최적화 대비 결합 최적화의 시너지 효과(우리만의 기여 포인트) 정량화
- [ ] README·references 최종 반영, git commit

### 참고
- 검토 근거(수상작 재분석, 소자군별 문헌 검색 결과) → 본 대화 로그. 별도 보고서 문서화는 필요 시 추가 예정

---

## 2026-07-30 — 주제 전환 및 최종 확정: GAA-TFET → GAA 초협소 시트 간격 영역의 다중 에너지 Vt-Implant (vs WFM)

### 한 일 (1단계 — TFET 폐기 및 도핑 방향 복귀)
- GAA-TFET(Line-Tunneling + 비대칭 도핑) 방향으로 baseline을 잡기 위해 참고문헌을 조사하던 중, Jain et al., "Performance Analysis of Vertically Stacked Nanosheet Tunnel Field Effect Transistor with Ideal Subthreshold Swing," *Silicon* (2022) 논문이 우리 계획 구조(3층 나노시트, Line-Tunneling형 extended source/drain, 도핑 조건)와 사실상 동일함을 발견
- "재현+확장(Lov 스윕, 적층수 3→5 확장)" 방안을 우선 검토했으나, 이는 이미 검증된 파라미터 범위를 넓히는 수준이라 독창성 확보에 근본적 한계가 있다고 재판단
- 시트별 변동성(적층 시 Ambipolar 억제 유지 여부)으로 재차 보완을 시도했으나, 이마저 Feng et al., "Impact of Process Variability on Threshold Voltage in Vertically-Stacked Nanosheet TFET," *Silicon* (2023)이 이미 다룬 문제임을 확인
- GAA 나노시트·TFET·DRAM 결합 전반이 이미 수년간 여러 연구그룹이 파라미터 단위로 논문화한 성숙 분야임을 재확인. "전 세계에 겹치는 문헌이 전혀 없어야 한다"는 기준 자체가 이 분야에서는 비현실적이라고 결론
- 원래 [`award-analysis-and-topic-selection.md`](reports/award-analysis-and-topic-selection.md) 5~6절에서 최종 추천했던 **방향 A(GAA 시트별 차등 Halo Doping)**로 복귀 결정 — 완성 리스크 없음(BTBT 수렴 문제 회피), 본인 SCE 프로젝트(Halo Doping으로 SS 561→89.9mV/dec 개선) 데이터와 직결
- Baseline 구조 논문(MDPI 2021)이 "기존 planar의 halo implant나 FinFET의 PTS doping은 GAA NW/NS 구조엔 그대로 못 쓴다"고 명시한 것을 확인(적층 시트 간 이온주입 경로 shadowing, 초박막 릴리즈 시트의 구조 손상 위험) → 구현 방법을 **halo doping → 블랭킷 웨이퍼 단계(핀 패터닝·릴리즈 이전)의 다중 에너지 이온주입 기반 층별 차등 Vt-implant**로 수정
- 이 방법이 [수상작 분석](reports/award-analysis-and-topic-selection.md)의 BCAT 수상작(Multiple-energy ion implantation, 사업단장상)과 같은 장르로 실제 수상 전례가 있음을 확인

### 한 일 (2단계 — RDF 리스크 발견 및 WFM 비교 필요성 도출)
- 외부 피드백으로 "다중 에너지 임플란트가 실제 양산 불가능"하다는 지적을 받음 — 근거: (1) 상위 시트를 관통하는 고에너지 이온에 의한 격자 손상, (2) Random Dopant Fluctuation(RDF), (3) 10nm급 층 간격 대비 임플란트 스트래글로 인한 타겟팅 한계
- 각 근거를 검증한 결과: (1) 격자손상은 저도즈·어닐로 완화 가능한 정도(치명적이진 않음), (3) 스트래글 문제는 이미 인지하고 있던 리스크, **(2) RDF는 실제로 심각** — 채널 도핑 농도를 올려 결정론적 편차(MTV)를 잡으면, 그 도핑 자체가 소자 간 확률적 Vth 편차(RDF)를 키운다는 게 확립된 물리(σVth ∝ 도핑농도의 세제곱근~네제곱근). 다만 FinFET/GAA 같은 박막 멀티게이트 구조는 벌크 평면소자보다 이 증가폭이 작다는 문헌도 확인
- RDF 문제를 피하는 업계 실제 해법이 **WFM(일함수 금속)/다이폴 엔지니어링**이라는 것을 확인 (채널 도핑 없이 층별 Vth 차등 가능) — 다만 이 방법 자체도 "Multi-metal dipole doping", "differential interfacial layer thickness" 등 다수 특허로 이미 두텁게 존재하며, 2026년 1월 논문(IOP, TiN/TiAlC/TiN 스택으로 10nm 미만 시트 간격에서도 Vth 균형 달성)까지 나와 있어 우리 baseline 간격(10nm)에서는 이미 해결된 문제임을 확인
- "도핑 시도 → 한계 발견 → WFM으로 마무리"라는 구조는 결국 헤드라인 성과가 업계 기존 해법(WFM) 재현에 그쳐 우리 기여가 사라진다는 문제를 인지 (사용자 지적) → 구조를 **"WFM 자체가 문헌상 한계에 부딪히는 초협소 시트 간격 영역"을 찾아, 그 영역에서 도핑 기반 접근이 RDF 대가를 감안하고도 net으로 유효한 대안이 됨을 검증**하는 방향으로 재구성. 즉 도핑(다중 에너지 Vt-implant)이 계속 메인이고, WFM은 문헌값 기반의 비교 기준선(baseline)으로만 사용 — 노력 배분은 도핑 파이프라인(구조+임플란트+RDF 통계) 90%, WFM 비교(SDevice 일함수 파라미터만 다르게 설정, 공정 재현 안 함) 10%로 계획
- 추가로 검토했던 대안 주제들 — Air-gap 내부 스페이서, Hybrid(Dual-k) 스페이서, 진공(vacuum) 스페이서를 통한 기생용량·자기발열 최적화 — 는 전부 기각. "Full air-gap spacers for GAA nanosheet FET" 등 다수 특허, "Stacked GAA nanosheet with full-air-spacers"(Ceff 79.4%↓ 등 구체 수치 포함) 논문, 그리고 결정적으로 IEEE 논문(Inner-spacer의 기생용량 억제 vs 자기발열 트레이드오프를 이미 다룸), "Hybrid Dual-κ Spacer Strategy"(3nm 노드) 논문까지 확인되어, 지금까지 검토한 대안 중 겹침이 가장 심함을 확인 후 기각

### 결정 사항
- **최종 주제**: GAA 나노시트 초협소 시트 간격 영역에서의 다중 에너지 이온주입 기반 층별 차등 Vt-Implant — WFM/다이폴 대비 RDF 트레이드오프 정량화 및 유효 구간 검증
- 핵심 질문: "시트 간격이 좁아질수록 WFM/다이폴(업계 표준)이 문헌상 한계(기생 커패시턴스 증가, 패터닝 공간 부족)에 부딪히는 지점에서, 다중 에너지 Vt-implant가 RDF 증가라는 대가를 감안하고도 층간 Vth/SS 편차 개선에 net으로 유효한가?"
- TFET·Line-Tunneling·Ambipolar·Air-gap/Hybrid/Vacuum 스페이서 관련 계획은 전부 폐기. 순수 MOSFET 구조, BTBT 물리 모델 불필요
- 발표 서사: 헤드라인은 항상 우리가 직접 시뮬레이션한 도핑 기반 접근의 개선 수치. RDF 트레이드오프와 WFM 비교는 "왜 이 조건에서 이 방법을 쓰는가"를 뒷받침하는 근거로 배치(결론이 아니라 과정)

### 막힌 점 / 리스크
- WFM의 정확한 한계 지점(몇 nm 이하 간격부터 문헌상 어려운지)이 아직 추정 수준 — 문헌을 더 좁혀 구체적 기준값 확정 필요
- 저도즈 조건에서 도핑 기반 접근이 실제로 net-positive인지는 시뮬레이션 전 확답 불가 — 안 나올 경우의 대비 서사도 미리 준비 필요
- 다중 에너지 임플란트의 층별 (Energy, Dose) 조합을 스트래글까지 고려해 실제 몇 층까지 분리 가능한지 미검증
- RDF 정량화 방법론(sIFM 또는 반복 Monte Carlo)을 학교 라이선스·컴퓨팅 자원으로 구현 가능한지 확인 필요
- 전체 스코프(baseline + 간격스윕 + RDF통계 + WFM대조)가 남은 준비 기간 대비 현실적인지 우선순위 재점검 필요

### 다음 할 일
- [ ] WFM/다이폴 방식의 문헌상 한계 시트 간격을 구체적으로 특정 (스윕 범위 설정용)
- [ ] Loubet 2017 / MDPI 2021 baseline 수치(Lg 25.8nm, 시트두께 6nm, 4층, 간격 10nm)로 구조 생성, 간격을 좁혀가며(예: 10→7→5→3nm) 스윕 계획 수립
- [ ] Analytic 프로파일로 층별 차등 도핑의 전기적 효과(편차 감소) 1차 검증
- [ ] 감도분석(sensitivity sweep)으로 Energy/Dose/Anneal 중 편차 유발 요인 규명
- [ ] RDF 정량화 방법론(sIFM 등) 구현 가능성 확인, σVth 계산
- [ ] 각 간격에서 WFM 비교값을 문헌 기준으로 산정 + 필요시 SDevice 일함수 파라미터만으로 가벼운 검증
- [ ] 목표 프로파일을 실제 다중 에너지 임플란트 (Energy, Dose) 조합으로 역산
- [ ] "반드시 해야 하는 것"과 "여유 있으면 하는 것" 우선순위 재정리 (팀 역량·시간 대비 스코프 조정)

### 참고
- 방향 전환 근거·baseline 논문·RDF/WFM 비교 근거 → [`docs/references.md`](references.md)에 정리 완료

---

## 2026-07-28 — 주제 선정 및 기초 조사

### 한 일
- 팀 포트폴리오(TCAD PMOS 공정 최적화, 30/60nm NMOS SCE 개선, QCLAS 학회 발표, LAS 프로젝트) 기반으로 소자/공정 분야 주제 후보 검토
- 반도체 관련 경진대회 수상작 조사: POLARIS SIF(2023·2025), 한국반도체학술대회(KCS) 2025, 삼성휴먼테크논문대상 — 총 11건 분석
- 1차 후보 "GAA + HKMG 최적화"는 이미 산업 표준 조합이라 독창성 부족 판단, 기각
- 대안 비교: GAA 시트별 차등 Halo Doping(구조 최적화) vs GAA-TFET(소자 동작원리 변경) — 공정 파라미터 조정은 과제에 가깝다는 판단하에 소자 변경 방향으로 전환
- GAA-TFET 중 Line-Tunneling 방식(게이트-소스 오버랩)이 GAA 멀티시트 구조와 시너지가 있다는 문헌 근거(NS-LTFET, 기존 대비 SSavg 19.2% 개선) 확인 후 채택
- 외부(Gemini) 제안 대안 교차 검증: DRAM VCT + Dual-k Spacer 안은 기존 수상작(SIF 2023, KCS 2025)과 유사해 기각, BDI(Bottom Dielectric Isolation)는 실재하는 기술이나 구조 최적화 카테고리라 보류, 역테이퍼링·나노와이어-나노시트 혼합구조는 문헌 근거 부족으로 보류
- Ambipolar 억제를 위한 소스/드레인 비대칭 도핑·Spacer 설계(방향 B)를 계획에 통합
- 1개월 준비 기간 기준 현실성 재점검: Line-Tunneling의 Nonlocal Mesh 설정이 실제 연구자도 어려워하는 지점임을 확인, 단계별 확장 전략(Tier 0~3: 기본 비교 → 멀티시트 복제 → Line-Tunneling → 심화 옵션) 수립
- 학교 Sentaurus 라이선스의 AdvancedTransportPackage에서 관련 예제 3종 발견: `NSFET_SdeviceSBTE_3nm`(3층 나노시트), `Nanowire_Si_QTX_SBTE_5nm`, `Nanowire_Si_QTX_NEGF_5nm`
- 세 예제의 SProcess 구조 생성 스크립트를 블록·라인 단위로 분석. 공통적으로 소스/드레인이 동일 도펀트(표준 MOSFET 방식)로 되어 있어, TFET 전환 시 p-i-n으로 분리하는 도핑 수정이 공통 필수 과제임을 확인
- Nanowire SBTE(코드 B)와 NEGF(코드 C) 두 예제를 라인별로 비교 — B는 KMC 이산도핑·명시적 전극 정의를 포함한 풀버전, C는 이를 덜어낸 입문용 경량 버전. 좌표축 규약이 서로 반대(B: x축=채널길이, C: z축=채널길이)임을 확인

### 결정 사항
- 최종 주제: **GAA 나노시트 Line-Tunneling TFET + 비대칭 도핑 기반 Ambipolar 억제**
- 실행 순서: 코드 C(단순 나노와이어, 입문) → 코드 B(나노와이어 심화, 검증) → 코드 A(NSFET 3층 스택, 핵심 주장 검증)

### 막힌 점 / 리스크
- Line-Tunneling용 Nonlocal Mesh 문법은 온라인에도 명확한 해결 사례가 적음 — 최악의 경우 Point-Tunneling 결과로 백업 가능하도록 계획에 포함
- 학교 예제의 물리 모델(SBTE/NEGF, 양자수송)은 팀이 계획한 Drift-Diffusion + Band2Band(NonlocalPath) 모델과 다름 — 구조 코드만 재사용하고 SDevice 물리 섹션은 직접 교체 필요

### 다음 할 일
- [ ] Sentaurus 실행 환경 확인 (라이선스 동시 사용 토큰 수, 서버/워크스테이션 코어 수)
- [ ] 코드 C 기반으로 MOSFET·TFET 구조를 각각 생성해 Id-Vg 비교 (Point-Tunneling baseline)
- [ ] 문헌 실측 데이터 기준 Nonlocal BTBT 모델(reduced mass) 캘리브레이션
- [ ] 도핑 select 블록을 p-i-n(소스 p+ / 드레인 n+)으로 수정

### 참고
- 수상작 분석 및 추천 주제, GAA 학습 가이드, 구조 코드 분석 문서 3종 → [`docs/references.md`](references.md)에 정리 완료
