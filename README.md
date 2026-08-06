# FinFET pMOS eSiGe Source/Drain 응력공학 — Stress Transfer Efficiency

차세대반도체 경진대회(POLARIS SIF) 소자/공정 부문 출품 프로젝트.

FinFET pMOS의 **Embedded SiGe Source/Drain**(선택적 에피택시, in-situ 붕소 도핑) 공정에서, **Ge 조성(%) × 리세스 깊이(FR, nm)** 2차원 격자를 스윕해 **채널에 실제로 전달되는 응력이 이론값(Vegard's law 기반 명목 응력) 대비 얼마나 되는지 — Stress Transfer Efficiency(STE, 응력 전달 효율)** — 지도를 만든다.

> ⚠️ 이 주제는 2026-08-04에 확정된 뒤, **하루 만에 방법론이 한 번 더 바뀌었다**(아래 여정 요약 5→6). 처음엔 "결함 발생 경계"를 찾으려 했지만 이 fin 치수에서는 그 프레이밍 자체가 판별력을 잃어 폐기했다 — 자세한 경위는 바로 아래.

## 여정 요약

이 프로젝트는 아래 여섯 단계를 거쳐 지금 형태에 도달했다. 각 전환의 상세 경위는 [devlog.md](docs/devlog.md)(시간순 로그)와 [topic-selection-history.md](docs/topic-selection-history.md)(검토·기각한 20개 후보 전체 아카이브)에 남아 있다. 이 요약은 "결과만 보면 처음부터 정답이었던 것"처럼 보이지 않도록, 실제로 거친 시행착오를 숨기지 않고 남기기 위한 것이다.

| # | 기간 | 주제 | 핵심 전환 사유 |
|---|---|---|---|
| 1 | 07-28 ~ 07-30 | GAA-TFET (Line-Tunneling + 비대칭 도핑) | Jain et al., *Silicon* (2022) 논문이 계획 구조·수치와 사실상 동일함을 발견 — 독창성 확보 불가 |
| 2 | 07-30 | GAA 초협소 시트간격 다중에너지 Vt-Implant vs WFM | 핵심 결론이 RDF 정량화(sIFM/Monte Carlo)에 의존하는데 학교 자원으로 구현 가능한지 불확실 + 팀 내 양산성 이견 → GAA 계열 전면 폐기 |
| 3 | 07-30 ~ 08-02 | DRAM BCAT 코너 라운딩(Rfillet) × Elevated S/D 접합 도핑 | 베이스라인 논문 재정독 결과 Rfillet(채널 내부 코너)이 GIDL 실제 발생 위치(표면 게이트-드레인 겹침)와 다른 곳임을 발견 → DBCAT으로 교체 |
| 4 | 08-02 ~ 08-04 | DRAM BCAT DBCAT(질화막 두께) × 접합 도핑 | 2026 POLARIS SIF 실제 수상작(김나박구팀, 작품 부문)이 이미 "BCAT+DWMG" 유사 조합으로 출품된 것을 확인 → 독창성 약화 |
| 5 | 08-04 ~ 08-05 | FinFET + Embedded SiGe S/D — **결함 발생 경계(trade-off boundary) 지도** | Ge%×리세스 깊이 축으로 전환. People-Bean(1985)/Luryi-Suhir(1986) 이론으로 "어느 Ge%부터 전위결함이 생기는가"를 문헌 경계선으로 등고선에 오버레이하는 하이브리드 방법론을 세움 |
| 6 | 08-05 ~ | **FinFET pMOS eSiGe S/D — Stress Transfer Efficiency (현재)** | baseline 실제 치수(fin 반폭 7.5nm)를 대입하니 결함 경계가 Ge 42~100% 전 구간에서 "무제한 보호"(결함 없음)로 계산됨 — fin이 너무 좁아 결함이 생길 조건 자체가 스윕 범위 안에 없다는 뜻. "결함 안전성"이 아니라 **"응력 전달 효율"**을 보는 것으로 전환 |

- **팀 구성**: 3인
- **지원 분야**: ① 소자/공정
- **시뮬레이션 툴**: Synopsys Sentaurus TCAD (Structure Editor / SProcess / SDevice / SVisual)
- **제출 마감**: 미확인 — POLARIS SIF 2026 공식 일정 확인 필요 (이전에 적혀 있던 "2026년 1월 15일"은 현재 날짜 기준 이미 지난 시점이라 오기로 판단, 삭제함)

## 핵심 질문

> Ge 조성(%) × 리세스 깊이(FR, nm) 2차원 격자를 스윕했을 때, 채널에 **실제로 전달되는 응력**이 Vegard's law 기반 **명목 응력** 대비 얼마나 되는가 — Stress Transfer Efficiency(STE) 지도

"~ 최적화"가 아니라 **"이미 산업 표준인 eSiGe S/D 공정 위에, 아직 파라미터화되지 않은 리세스 깊이(FR) 축을 새로 추가해 Ge%×FR 2차원 지도를 그리는 것"**이다. 결과물은 단일 최적점이나 "1차원 그래프 두 개"가 아니라, 두 변수를 격자로 함께 스윕한 **하나의 2차원 Stress Transfer Efficiency 지도**다.

## 왜 이 주제인가

| 기준 | 근거 |
|---|---|
| **양산성** | FinFET은 2026년 8월 현재도 GAA와 병행 생산 중이며 물량 기준 최대 노드(TSMC N3)다. Apple M4, AMD MI350 등 최신 제품이 여전히 FinFET 기반 |
| **완주 가능성** | Synopsys Sentaurus 표준 예제 `FinFET_14nm`(Munkang Choi, Synopsys, 2013)를 실제로 열어 확인 — Ge%도 S/D-채널 근접 파라미터도 이미 완전히 파라미터화돼 있고 응력 텐서 출력도 이미 스크립트에 있어 구현 난이도가 낮다. 2026-08-06 기준 baseline 1점(G50_F0)은 실제 실행·검증까지 성공 |
| **독창성** | "Stress Transfer Efficiency"라는 용어 자체가 Choi 2012에 이미 등장한다는 것도 확인했지만, **팀 판단으로 문헌 선점 여부(독창성 저촉 가능성)는 더 확인하지 않기로 함** — 리스크로 남겨둠. 독창성의 실체는 이미 파라미터화된 Ge% 축에, 스크립트에 없던 리세스 깊이(FR) 축을 새로 추가해 2차원 지도를 그리는 것 |
| **전환 사유(5→6단계)** | 결함 경계 프레이밍이 baseline 치수(fin 반폭 7.5nm)에서 판별력을 잃어(Ge 42~100% 전 구간 "무제한 보호") 하루 만에 STE로 재전환 |

> **정직한 겹침 인정**: "TCAD+FinFET+eSiGe" 조합 자체는 2012년(Choi et al., Synopsys)부터 다뤄진 성숙한 방법론이고, "Stress Transfer Efficiency"라는 용어도 그 논문에 이미 있다. 우리 기여는 새 방법론이나 용어의 발명이 아니라 **Ge%×리세스 깊이(FR)라는, 아직 파라미터화되지 않았던 축을 추가해 응력 전달 효율을 2차원으로 매핑**한 것이다.

## 문제 배경 (요약)

- **Ge 조성**: Vegard's law(f(x)=0.042×x, x=Ge 몰분율)에 따라 Ge%가 높을수록 SiGe의 명목 격자 부정합이 커지고, 그만큼 이론상 응력도 커진다. 하지만 fin이 좁을수록 탄성 완화(elastic relaxation)가 커져서, 이론값만큼 응력이 채널까지 전달되지 않는다.
- **리세스 깊이(FR)**: 스크립트에 원래 없던 완전히 새로운 변수 — fin 바닥 아래 방향으로 SiGe가 얼마나 더 파고드는지. 2026-08-06 구현 완료(FR=0 회귀 테스트 통과, FR>0은 실제 실행 검증 중).
- **핵심 통찰**: fin이 좁아서 결함이 안 생기는 것(탄성 완화)과, 그 탄성 완화가 채널에 전달되는 유효 응력을 깎아먹는 것은 같은 현상의 양면이다. Choi 2012 논문 자신의 데이터(근접효과: nested 조건 −1289MPa vs isolated 조건 +53MPa)가 이 방향을 뒷받침한다.
- **STE 정의**: 채널 인접(★2026-08-06 확인: 실제로는 단일 좌표가 아니라 채널 fin 영역 전체의 체적평균, provisional — 아래 참고) 응력을 Vegard's law 명목 응력으로 나눈 비율.

## 베이스라인

**Synopsys Sentaurus 표준 예제 `FinFET_14nm`**(Munkang Choi, Synopsys, 2013 — 학술 논문이 아니라 Sentaurus 표준 예제 스크립트).

실제로 예제를 열어 확인한 값(2026-08-05~06): Gate length 25nm · Fin height 35nm · Fin bottom width 15nm(반폭 7.5nm) · Fin pitch 48nm · GeMoleFraction 공칭 0.50 · 이 서브구조엔 게이트 재질 없음(순수 응력 계산용). 상세 수치는 `Share` 저장소의 `baseline/params.yaml`이 유일한 출처다.

> 이 예제가 Intel 22nm Tri-Gate / PTM 14nm 공정에 실제로 대응한다는 것은 여전히 **파일명 기반 추측이며 미검증**이다 — 예제 자체의 치수·파라미터화 방식은 직접 열어 확인했지만, 특정 실제 공정 세대와의 대응 관계까지 검증한 것은 아니다.
>
> ⚠️ **라이선스 문제로 실제 스크립트 원본은 어느 저장소에도 커밋하지 않는다** (2026-08-06 팀 결정). Synopsys 라이선스 예제를 기반으로 한 실제 코드라 재배포 조항을 확인하기 전까지 위험을 감수하지 않기로 함. 각자 학교 Sentaurus 설치본의 Applications Library에서 직접 열면 원본을 볼 수 있고, 팀이 무엇을 바꿨는지는 `Share/baseline/README.md`와 `params.yaml`에 코드 없이 서술로만 기록돼 있다.

## STE 계산 방법

- **Vegard's law (명목 응력)**: f(x) = 0.042 × x (x = Ge 몰분율 0~1)
- **정규화 방법 — provisional (2026-08-06)**: 실제 구현은 단일 좌표점이 아니라 **채널 fin 영역 전체(핀 전체 높이·폭·채널길이)의 체적평균**이다. 게이트 계면 인접 단일점 근사값과 G50_F0에서 실측 비교한 결과 **53.9% 차이 + 한 성분은 부호까지 반전**되는 걸 확인 — 무시 못 할 차이라 지금 하나로 확정하지 않았다. 남은 24격자점 스윕에서 두 지표를 모두 뽑아 모은 뒤 최종 정의를 결정하기로 함
- 계산 스크립트도 위 라이선스 사유로 코드 원문은 비공개 — 방법 자체는 `Share/baseline/params.yaml`의 `stress_transfer_efficiency` 섹션에 서술로 기록

## 진행 상황

| 단계 | 상태 | 비고 |
|---|---|---|
| 주제 선정 및 소자군 전면 검토 | ✅ 완료 | 20개 후보 검토·기각 → FinFET+SiGe 확정 ([이력](docs/topic-selection-history.md)) |
| 방법론 — 결함 경계(People-Bean/Luryi-Suhir) | ⚠️ 폐기됨 (2026-08-05) | baseline 치수에서 판별력을 잃어 폐기. Stress Transfer Efficiency로 전환 |
| 학교 라이선스 예제 확인 (FinFET_14nm 실제 치수) | ✅ 완료 (2026-08-05) | Gate 25nm/Fin height 35nm/Fin bottom 15nm 등 실측 확인. 라이선스 재배포 조항 미확인이라 실제 스크립트 원본은 어느 저장소에도 커밋하지 않기로 함(2026-08-06) |
| baseline 구조 재현 (SDE) | 🟡 진행 중 | 실제 스크립트 확보 + G50_F0(Ge 50%, FR 0) 1회 실행·검증 성공(유용성). 나머지 2인 확인 및 FR>0 케이스 검증은 아직 |
| 공칭 격자점 실행 및 3인 대조 | ⬜ 예정 | W1(8/09) 마감 게이트 |
| 개별 추가 과제 + 1차원 단독 스윕 | 🟡 착수 가능 | Ge%/FR 스윕 값 확정됨(2026-08-06, [30,40,50,60,70]×[0,10,20,30,35]) — 3인 대조 이후 시작 |
| 2차원 DoE 실행 | ⬜ 예정 | |
| STE(Stress Transfer Efficiency) 지도 작성 | ⬜ 예정 | 정규화 방법(체적평균 vs 계면 인접 단일점)이 provisional — 스윕 데이터 확보 후 최종 결정 |
| 결과 정리·발표자료 | ⬜ 예정 | |

## 저장소 구조

```
competition/
├── README.md                          # 현재 문서 — 프로젝트 개요 + 여정 요약
├── docs/
│   ├── devlog.md                      # 날짜별 진행 로그 (시간순, 폐기된 경로도 그대로 보존)
│   ├── devlog-template.md             # 새 로그 작성용 템플릿
│   ├── references.md                  # 참고 논문·자료 링크 — ⚠ 아직 결함 경계 프레이밍 기준으로 쓰여 있음, STE 전환 반영 필요
│   ├── topic-selection-history.md     # 주제 선정 이력 (검토·기각한 20개 후보 아카이브)
│   ├── retrospective.md               # 이번 세션에서 실제로 잡아낸 검증 오류 사례집
│   ├── FinFET_진행상황_우선순위_20260806.md  # 진행상황·우선순위 스냅샷(2026-08-06)
│   └── reports/
│       ├── project-plan.md            # ⚠ DBCAT 단계 기준 — FinFET 전환 반영 아직 안 됨
│       ├── dram-basics.md             # ⚠ DBCAT 단계 기준 — FinFET 전환 반영 아직 안 됨
│       └── award-analysis-and-topic-selection.md   # 수상작 분석 (2~3장은 여전히 유효)
├── tcad/                               # ⚠ DRAM BCAT 시절 파일(sde_bcat_transistor.cmd 등) — 현재 FinFET 주제와 무관, 정리 필요
│   ├── structure/
│   ├── sdevice/
│   └── results/
├── figures/                            # 발표·보고서용 이미지
└── deliverables/                       # 최종 포스터·발표자료
```

> 실행·결과 공유는 별도 저장소 [`ryu980920/Share`](https://github.com/ryu980920/Share)에서 한다 — 이 `competition` 저장소는 여정·의사결정 기록용, `Share`는 실행·결과 공유용으로 역할이 분리돼 있다(2026-08-04 devlog 참고).
>
> `docs/reports/`와 `tcad/`는 아직 DBCAT 단계 잔재 그대로다. 오늘까지 README/devlog/topic-selection-history/retrospective/이 진행상황 문서는 갱신했지만, `references.md`·`reports/`·`tcad/` 정리는 다음 작업으로 남겨둠 (이 사실도 정직하게 기록해두는 것 — 실제로 무엇을 언제 했는지가 이 레포의 존재 이유다).

## 팀 역할 분담

작업 종류(구조/물리/분석)가 아니라 **격자 좌표(Ge% 열) 기준**으로 나눈다 — 한 사람이 막혀도 나머지가 대기하지 않고, 전원이 TCAD 실행부터 결과 해석까지 전체 사이클을 경험하게 하기 위함 (2026-08-03 devlog 항목 "역할 분담을 작업 종류에서 격자 좌표로 변경" 참고).

- 2차원 격자를 **Ge% 기준 세로 3등분**해서 낮은/중간/높은 열을 각 1인이 담당
- 중간 열 담당자는 공칭(baseline) 조건을 포함하므로, 인접한 양쪽 열과 모두 교차검증
- 이와 별개로 각자 개별 추가 조사 과제(모델 검증·메쉬 수렴성·라이선스 확인 등)를 1개씩 맡는다

## 작업 규칙

- **문서는 전부 Markdown으로 작성한다.** GitHub에서 링크를 클릭하면 바로 읽히도록 하기 위함이며, `.docx`는 저장소에 커밋하지 않는다.
- `.tdr` 등 대용량 구조/메시 파일은 `.gitignore`로 제외하고, 그래프·캡처 이미지와 코드·로그 위주로 커밋한다.
- **학교 Sentaurus 라이선스의 예제 코드를 그대로 올리지 않는다.** 팀이 직접 작성·수정한 부분이라도, 라이선스 예제를 기반으로 한 실제 스크립트 원문은 재배포 조항 확인 전까지 커밋하지 않는다(2026-08-06 재확인·강화). 무엇을 바꿨는지는 코드 없이 서술로 기록한다.
- 진행 상황은 [`docs/devlog.md`](docs/devlog.md)에 날짜별로 기록한다.
- **이 레포는 심사용 제출물이 아니라 개인 기록용이다.** "깔끔해 보이는가"가 아니라 "나중에 다시 열었을 때 전체 스토리와 디테일을 복원할 수 있는가"가 기준 — 시행착오·오판·정정 과정을 압축하거나 숨기지 않는다.
