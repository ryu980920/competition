# 참고 자료

> **현재 주제**: FinFET + Embedded SiGe Source/Drain 응력공학 — Ge 조성(%) × 리세스 깊이(nm) Stress Transfer Efficiency(STE) 지도
>
> 이 문서는 **현재 주제에 필요한 자료만** 담는다. 이전에 검토했다가 폐기한 GAA 나노시트 계열, DRAM BCAT 계열(코너 라운딩·DBCAT×접합 도핑 둘 다)의 참고문헌은 이 문서에서 뺐다 — git 히스토리로 복원 가능하며, 폐기 경위는 [`topic-selection-history.md`](topic-selection-history.md)에 서술돼 있다.
>
> **개정 (2026-08-04)**: DBCAT(질화막 두께)×접합 도핑에서 FinFET + Embedded SiGe S/D 응력공학으로 전환하며 전면 교체. 경위는 [devlog.md](devlog.md) 참고.
>
> ⚠️ **2026-08-06 기준 미반영**: 방법론은 2026-08-05에 결함 발생 경계(trade-off boundary)에서 Stress Transfer Efficiency(STE)로 다시 전환됐으나(경위는 [devlog.md 2026-08-05 항목](devlog.md) 참고), 아래 섹션 1·2·5~8은 아직 이전 프레이밍 기준 서술이 남아있다. 섹션 3(임계두께 공식)만 이번에 STE 전환을 반영해 정리했고, 나머지 전면 갱신은 별도 작업으로 남겨둔다 — 지금 안 된 것을 된 것처럼 적지 않기 위해 그대로 표시.
>
> **표기 원칙**: 각 항목에 `[확인됨]` 또는 `[미확인 — 원문 대조 필요]`를 반드시 표시한다. 이 세션 전체의 핵심 원칙이 "확인 안 된 건 확인 안 됐다고 표시한다"였다.

## 1. 베이스라인 (팀 전원 필독)

**[B1]** Synopsys Sentaurus Applications Library — `FinFET_14nm` / `FinFET_22nm` 예제

- **역할**: 구조 출발점(논문 재현이 아니라 툴 제공 예제를 그대로 씀)
- **상태**: `[미확인 — 원문 대조 필요]` 이 예제가 Intel 22nm Tri-Gate / PTM 14nm 공정에 실제로 대응한다는 것은 **파일명 기반 추측일 뿐**이다. 학교 라이선스로 예제를 직접 열어 치수 스펙(핀 폭·핀 높이·게이트 길이)을 대조해야 한다 — **최우선 확인 과제**
- **상태**: `[미확인]` 예제가 SProcess 실제 공정 흐름인지, 공정 에뮬레이션(SDE로 형상만 근사 생성)인지도 확인 안 됨

## 2. 선행연구 — 방법론 (FinFET + eSiGe TCAD)

**[P1]** Choi, Moroz, Smith, Penzin (Synopsys), "14 nm FinFET Stress Engineering with Epitaxial SiGe Source/Drain," *ISTDM* 2012.

- **역할**: Sentaurus 제작사가 직접 쓴 FinFET+SiGe TCAD 방법론 논문 — 우리 방법론과 가장 유사, 최우선 참고
- **상태**: `[미확인 — 원문 대조 필요]` IEEE 페이월이라 초록/2차 요약만 확인. 원문은 학교 IEEE Xplore 계정으로 확인 필요

**[P2]** Gendron-Hansen, Korablev, Chakarov, Egley, Cho, Benistant (Synopsys), "TCAD analysis of FinFET stress engineering for CMOS technology scaling," *SISPAD* 2015, pp. 417-420. DOI: 10.1109/SISPAD.2015.7292349.

- **역할**: **우리 프로젝트와 가장 근접한 선행연구.** eSiGe 캐비티(리세스) 설계와 FinFET 세대별 응력의 관계를 다룸
- **차별점 (반드시 발표에서 명시)**: 이 논문의 축은 **기술 노드 세대**, 목표는 **응력 최대화**. 우리 축은 **Ge%×리세스 깊이**, 목표는 **결함 발생 경계 매핑**(응력 최댓값이 아니라 안전 영역의 최댓값을 찾는 것)
- **상태**: `[미확인 — 원문 대조 필요]` IEEE 페이월이라 초록/2차 요약만 확인. 독창성 주장의 최종 확인 단계이므로 반드시 원문 대조 필요

**[P3]** Joshi et al., "Source/drain eSiGe engineering for FinFET technology," *Semiconductor Science and Technology*, 2017.

- **역할**: eSiGe 엔지니어링 인접 연구
- **상태**: `[미확인 — 원문 대조 필요]`

## 3. 폐기된 방법론 — 임계두께 공식 (People-Bean/Luryi-Suhir 결함 경계, 2026-08-05 폐기)

> ⚠️ 아래 두 문헌([F1][F3])은 2026-08-05에 폐기된 "결함 발생 경계(trade-off boundary)" 방법론의 근거였다. baseline 실제 치수(fin 반폭 7.5nm)를 대입하니 Ge 42~100% 전 구간에서 결함이 "무제한 보호"로 계산되어 경계선 자체가 스윕 범위 안에 그려지지 않음을 확인, Stress Transfer Efficiency(STE)로 방법론을 전환했다 (경위는 [devlog.md 2026-08-05 항목](devlog.md) 참고). 지금은 실제 계산에 쓰지 않지만, 실제로 원문 대조·검증을 시도했던 기록이라 삭제하지 않고 남겨둔다. Luryi-Suhir([F2])는 폐기되지 않았다 — 아래 섹션 5로 옮겼다.

**[F1]** R. People, J. C. Bean, "Calculation of critical layer thickness versus lattice mismatch for GeₓSi₁₋ₓ/Si strained-layer heterostructures," *Applied Physics Letters*, 47(3), 322-324 (1985). DOI: 10.1063/1.96206. (1986년 Erratum 있음)

- **역할(폐기됨)**: 평면(blanket) 기준 임계두께 근사식의 출처. 실무 근사식 **Tc ≈ 1.23 × x⁻³·⁰⁸ (nm, x = Ge 몰분율)** — 결함 경계 방법론의 핵심 근거였음
- **상태**: `[미확인 — 원문 대조 필요]` 이 근사식은 **원 논문 자체의 계산식이 아니라 2차 문헌의 근사 피팅식**이다. 원 논문의 실제 Fig.(임계두께 vs Ge 조성 그래프)에서 값을 읽어 대조해야 하는데, **페이월 때문에 검색으로는 원문을 구하지 못했다** — 학교에 논문 복사 신청한 상태(진행 중). 방법론 폐기로 이 대조의 우선순위는 낮아졌으나, 원문을 실제로 본 적 없이 숫자를 지어내는 것을 피하기 위해 미확인 상태 그대로 유지

**[F3]** Hartmann et al., "Critical thickness for plastic relaxation of SiGe on Si(001) revisited," *Journal of Applied Physics*, 110, 083529 (2011).

- **역할(폐기됨)**: **People-Bean 근사식의 신뢰도를 검증한 논문.** Ge 12/22/32/42/52%에서 실제로 SiGe를 성장시키고 XRD로 실측 임계두께를 측정 — People-Bean 기반 등고선 해석 보강용이었음
- **핵심 결과**: **Ge 22% 이상 구간에서는 실측 임계두께가 People-Bean 예측치보다 약 2배 더 높게 나옴** — People-Bean 근사식이 상당히 보수적(과소평가)이라는 실측 근거. 결함 경계 방법론을 계속 썼다면 "이중으로 보수적으로 잡아도 안전한 영역"이라는 프레이밍에 썼을 결과
- **상태**: `[확인됨]` 논문 존재·핵심 결과(XRD 실측 vs People-Bean 비교)까지 확인됐고 이 확인 자체는 유효한 완료 작업. 다만 방법론 폐기로 STE 계산에는 더 이상 쓰이지 않음

## 4. 관련 특허 — 주의 사례 포함

**[X1]** US9245980B2 (Akarvardar, Fronheiser, Jacob)

- **⚠ 주의**: 이전에 이 특허를 "Luryi-Suhir식 탄성 완화"의 근거로 인용했으나, **실제로 읽어보니 메커니즘이 다르다.** 이 특허는 ART(Aspect-Ratio Trapping) + 열처리 확산 방식 — SiGe를 블랭킷 증착 후 열확산시켜 결함을 트렌치 바닥에 가두는 방식이다. 우리 공정(SEG로 직접 리세스에 에피 성장)과는 메커니즘이 달라 **"우리 방식이 blanket보다 유리하다"는 직접 근거로 쓰면 안 됨**
- **상태**: `[확인됨 — 단, 우리 근거로는 부적합]` 정정 경위는 [retrospective.md](retrospective.md) 참고
- **대체 후보**: 이 특허가 인용한 **Kim et al., "Increased critical thickness for high Ge-content strained SiGe-on-Si using selective epitaxial growth," Applied Physics Letters, 97, 262106 (2012)** [X1-alt] — SEG(우리 공정과 동일 메커니즘)를 다뤄 훨씬 정확히 맞는 대체 후보. `[미확인 — 원문 대조 필요]`

## 5. 물리 이해용 — Ge%·리세스 깊이가 응력(및 STE)에 미치는 영향

**[F2]** S. Luryi, E. Suhir, "New approach to the high quality epitaxial growth of lattice-mismatched materials," *Applied Physics Letters*, 49(3), 140-142 (1986). DOI: 10.1063/1.97204.

- **역할 (현재도 사용)**: 좁은 메사(mesa/fin) 구조일수록 탄성 edge relaxation이 커진다는 것의 출처. 경험식: **fin 폭 W < 15×Tc(People-Bean 평면값)** 이면 결함 없이 버팀. 결함 경계 방법론([F1][F3])에서는 "경계선이 어디냐"를 정하는 데 썼지만, **지금 STE 방법론에서는 이 문헌이 설명하는 현상 자체가 핵심 물리**다 — fin이 좁아서 결함이 안 생기는 것(탄성 완화)과, 그 탄성 완화가 채널에 전달되는 유효 응력을 깎아먹는 것은 같은 현상의 양면이라는 게 지금 프로젝트의 핵심 통찰 (`competition/README.md` "문제 배경" 참고)
- **상태**: `[미확인 — 원문 대조 필요]` 원 논문의 실제 해석적 표현식은 아직 확인 못함(2차 문헌 요약 기준). (DOI를 처음에 10.1063/1.97316으로 잘못 추측했다가 재검색으로 정정한 사례 — [retrospective.md](retrospective.md) 참고)

- **Ge 조성**: Vegard's law에 따라 Ge%가 높을수록 SiGe의 자연 격자 상수가 커진다. Si 기판 위에 정합 성장하면서 억지로 눌린 압축 변형이 되고, 이 변형이 채널 실리콘까지 전달돼 정공 이동도를 높인다. Ge%가 높을수록 명목 응력(변형 에너지)은 커지지만, fin이 좁을수록 탄성 완화([F2])로 실제 채널 전달분(STE)은 그만큼 늘지 않을 수 있다.
- **리세스 깊이**: 격자 차이와 무관한 순수 기하학적 변수. 깊을수록 SiGe 부피·채널 근접성이 늘어 응력 전달이 세지지만, 무한정 좋아지진 않는다 — "적당한 SiGe 오버필이 최대 응력"이라는 비단조적 결과가 40nm PMOS TCAD 문헌에서 확인됨. `[미확인 — 원문 대조 필요]` (2차 요약 기준)
- **"Orthogonal(독립)"과 "트레이드오프"는 모순 아님**: 문헌에서 "Ge%와 리세스 깊이가 orthogonal한 설계 손잡이"라는 표현은 *성능 설계 관점*(각자 다른 성능 지표를 담당, 독립적으로 조작 가능)에서 하는 말이고, *응력 전달 관점*에서는 두 값이 함께 fin 내부 변형 분포를 정하므로 상호작용이 있을 수 있다.
- **FinFET 구속 효과**: FinFET은 fin이라는 좁은 구조라 SiGe가 옆면까지 둘러싸여 자란다(공간적 구속). 이 구속 구조가 평면(blanket) 기준보다 결함 없이 버티는 능력은 키우지만([F2]), 동시에 탄성 완화 때문에 채널로 전달되는 유효 응력은 깎는다 — baseline(fin 반폭 7.5nm)에서 결함 경계가 사실상 사라진 이유이자, STE가 낮게 나올 수 있는 이유이기도 하다.

## 6. 툴 레퍼런스

**[T1]** Sentaurus Structure Editor User Guide — 3D 구조 생성, Scheme 스크립팅. `[미확인 — 학교 라이선스에서 직접 확인 필요]`

**[T2]** Sentaurus Device User Guide — Stress/Mechanical 섹션에 소성 완화(전위결함) 예측 모델이 기본 탑재돼 있는지 확인 필요. 공식 매뉴얼이 검색엔진에 안 걸려 웹 검색으로는 확인 못함. `[미확인 — 학교 라이선스에서 직접 확인 필요]` 현재는 "탑재 안 돼 있다"고 가정하고 하이브리드 방법론([F1][F2] 오버레이)을 설계함

**[T3]** [TCAD Sentaurus Tutorial (외부 공개 자료)](https://ghzphy.github.io/Sentaurus_Training/sde/sde_menu.html) — SDE 3D 구조 생성 및 파라미터화 실습용. 특히 "Three-Dimensional Structures", "Scripting and Parameterization" 항목. FinFET 리세스 구조 학습에도 그대로 유효. `[확인됨 — 외부 공개 튜토리얼, 접근 가능]`

**[T4]** 학교 라이선스 예제 라이브러리 — FinFET_14nm/FinFET_22nm 예제 실제 존재·치수 확인. `[미확인 — 최우선 확인 과제]`

## 7. 경진대회 관련

- 실제 2025/2026 POLARIS SIF 수상작(아이디어·작품 부문) 6건을 팀이 직접 분석 — 그 중 **김나박구팀(2026 작품 부문, "BCAT+DWMG")**이 직전 주제(DBCAT×접합도핑)와 유사 조합으로 출품된 것을 확인, 이것이 이번 전환의 직접 계기 (경위는 [devlog.md](devlog.md), [topic-selection-history.md 7단계](topic-selection-history.md) 참고)
- `[미확인 — 확인 필요]` **FinFET+SiGe eS/D(Ge%×리세스 깊이 결함경계 매핑) 자체가 분석한 6건의 실제 수상작과 겹치는지는 아직 명시적으로 재확인하지 않았다.** DBCAT/NCFET 기각 때처럼 이 조합도 6건 각각과 직접 대조해볼 것 — 다음 devlog 항목에서 처리

## 8. 팀 내부 문서

- [프로젝트 통합 기획서 (구 DBCAT 단계, 아카이브)](old-projects/project-plan.md) — DBCAT 단계 내용 그대로 보존. FinFET+SiGe용 신규 기획서는 아직 없음
- [DRAM 기초 학습자료 (구 DBCAT 단계, 아카이브)](old-projects/dram-basics.md) — DBCAT/DRAM 단계 내용 그대로 보존. FinFET 학습자료는 아직 없음
- [주제 선정 이력](topic-selection-history.md) — 검토·기각한 20개 후보 아카이브
- [검증 오류 회고](retrospective.md) — 이 전환 과정에서 실제로 잡아낸 검증 오류 사례
