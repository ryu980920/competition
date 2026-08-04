# 참고 자료

> **현재 주제**: FinFET + Embedded SiGe Source/Drain 응력공학 — Ge 조성(%) × 리세스 깊이(nm) 결함 발생 경계(trade-off boundary) 지도
>
> 이 문서는 **현재 주제에 필요한 자료만** 담는다. 이전에 검토했다가 폐기한 GAA 나노시트 계열, DRAM BCAT 계열(코너 라운딩·DBCAT×접합 도핑 둘 다)의 참고문헌은 이 문서에서 뺐다 — git 히스토리로 복원 가능하며, 폐기 경위는 [`topic-selection-history.md`](topic-selection-history.md)에 서술돼 있다.
>
> **개정 (2026-08-04)**: DBCAT(질화막 두께)×접합 도핑에서 FinFET + Embedded SiGe S/D 응력공학으로 전환하며 전면 교체. 경위는 [devlog.md](devlog.md) 참고.
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

## 3. 임계두께 공식 (등고선 경계선에 둘 다 적용)

**[F1]** R. People, J. C. Bean, "Calculation of critical layer thickness versus lattice mismatch for GeₓSi₁₋ₓ/Si strained-layer heterostructures," *Applied Physics Letters*, 47(3), 322-324 (1985). DOI: 10.1063/1.96206. (1986년 Erratum 있음)

- **역할**: 평면(blanket) 기준 임계두께 근사식의 출처. 실무 근사식 **Tc ≈ 1.23 × x⁻³·⁰⁸ (nm, x = Ge 몰분율)**
- **상태**: `[미확인 — 원문 대조 필요]` 이 근사식은 **원 논문 자체의 계산식이 아니라 2차 문헌의 근사 피팅식**이다. 원 논문의 실제 Fig.(임계두께 vs Ge 조성 그래프)에서 값을 읽어 대조해야 하는데, **페이월 때문에 검색으로는 원문을 구하지 못했다** — 학교에 논문 복사 신청한 상태(진행 중). 원문을 실제로 본 적 없이 숫자를 지어내는 것을 피하기 위해, 이 대조 자체를 미확인 상태로 명시해둔다

**[F2]** S. Luryi, E. Suhir, "New approach to the high quality epitaxial growth of lattice-mismatched materials," *Applied Physics Letters*, 49(3), 140-142 (1986). DOI: 10.1063/1.97204.

- **역할**: 좁은 메사(mesa/fin) 구조의 탄성 edge relaxation으로 임계두께가 늘어난다는 것의 출처. 경험식: **fin 폭 W < 15×Tc(People-Bean 평면값)** 이면 결함 없이 버팀
- **상태**: `[미확인 — 원문 대조 필요]` 이것도 2차 문헌 요약이며, 원 논문의 실제 해석적 표현식은 아직 확인 못함. (DOI를 처음에 10.1063/1.97316으로 잘못 추측했다가 재검색으로 정정한 사례 — [retrospective.md](retrospective.md) 참고)

**[F3]** Hartmann et al., "Critical thickness for plastic relaxation of SiGe on Si(001) revisited," *Journal of Applied Physics*, 110, 083529 (2011).

- **역할**: **People-Bean 근사식의 신뢰도를 검증한 논문.** Ge 12/22/32/42/52%에서 실제로 SiGe를 성장시키고 XRD로 실측 임계두께를 측정
- **핵심 결과**: **Ge 22% 이상 구간에서는 실측 임계두께가 People-Bean 예측치보다 약 2배 더 높게 나옴** — People-Bean 근사식이 상당히 보수적(과소평가)이라는 실측 근거. 등고선 해석 시 "이중으로 보수적으로 잡아도 안전한 영역"이라는 프레이밍에 직접 사용
- **상태**: `[확인됨]` 논문 존재·핵심 결과(XRD 실측 vs People-Bean 비교)까지 확인. 세부 수치(정확한 배율 곡선)는 원문 확인 시 보강 예정

## 4. 관련 특허 — 주의 사례 포함

**[X1]** US9245980B2 (Akarvardar, Fronheiser, Jacob)

- **⚠ 주의**: 이전에 이 특허를 "Luryi-Suhir식 탄성 완화"의 근거로 인용했으나, **실제로 읽어보니 메커니즘이 다르다.** 이 특허는 ART(Aspect-Ratio Trapping) + 열처리 확산 방식 — SiGe를 블랭킷 증착 후 열확산시켜 결함을 트렌치 바닥에 가두는 방식이다. 우리 공정(SEG로 직접 리세스에 에피 성장)과는 메커니즘이 달라 **"우리 방식이 blanket보다 유리하다"는 직접 근거로 쓰면 안 됨**
- **상태**: `[확인됨 — 단, 우리 근거로는 부적합]` 정정 경위는 [retrospective.md](retrospective.md) 참고
- **대체 후보**: 이 특허가 인용한 **Kim et al., "Increased critical thickness for high Ge-content strained SiGe-on-Si using selective epitaxial growth," Applied Physics Letters, 97, 262106 (2012)** [X1-alt] — SEG(우리 공정과 동일 메커니즘)를 다뤄 훨씬 정확히 맞는 대체 후보. `[미확인 — 원문 대조 필요]`

## 5. 물리 이해용 — Ge%·리세스 깊이가 응력에 미치는 영향

- **Ge 조성**: Vegard's law에 따라 Ge%가 높을수록 SiGe의 자연 격자 상수가 커진다. Si 기판 위에 정합 성장하면서 억지로 눌린 압축 변형이 되고, 이 변형이 채널 실리콘까지 전달돼 정공 이동도를 높인다. Ge%가 높을수록 변형 에너지가 커지지만, 버틸 수 있는 두께(임계두께)는 줄어든다 ([F1] 참고).
- **리세스 깊이**: 격자 차이와 무관한 순수 기하학적 변수. 깊을수록 SiGe 부피·채널 근접성이 늘어 응력 전달이 세지지만, 무한정 좋아지진 않는다 — "적당한 SiGe 오버필이 최대 응력"이라는 비단조적 결과가 40nm PMOS TCAD 문헌에서 확인됨. `[미확인 — 원문 대조 필요]` (2차 요약 기준)
- **"Orthogonal(독립)"과 "트레이드오프"는 모순 아님**: 문헌에서 "Ge%와 리세스 깊이가 orthogonal한 설계 손잡이"라는 표현은 *성능 설계 관점*(각자 다른 성능 지표를 담당, 독립적으로 조작 가능)에서 하는 말이고, *신뢰성/결함 발생 관점*에서는 두 값이 함께 변형 에너지 총량을 정하므로 트레이드오프가 맞다.
- **FinFET 구속 효과**: FinFET은 fin이라는 좁은 구조라 SiGe가 옆면까지 둘러싸여 자란다(공간적 구속). 이 구속 구조가 평면(blanket) 기준 임계두께보다 더 두껍게/높은 Ge%로도 결함 없이 버틸 수 있다는 것이 [F2]의 물리적 근거다.

## 6. 툴 레퍼런스

**[T1]** Sentaurus Structure Editor User Guide — 3D 구조 생성, Scheme 스크립팅. `[미확인 — 학교 라이선스에서 직접 확인 필요]`

**[T2]** Sentaurus Device User Guide — Stress/Mechanical 섹션에 소성 완화(전위결함) 예측 모델이 기본 탑재돼 있는지 확인 필요. 공식 매뉴얼이 검색엔진에 안 걸려 웹 검색으로는 확인 못함. `[미확인 — 학교 라이선스에서 직접 확인 필요]` 현재는 "탑재 안 돼 있다"고 가정하고 하이브리드 방법론([F1][F2] 오버레이)을 설계함

**[T3]** [TCAD Sentaurus Tutorial (외부 공개 자료)](https://ghzphy.github.io/Sentaurus_Training/sde/sde_menu.html) — SDE 3D 구조 생성 및 파라미터화 실습용. 특히 "Three-Dimensional Structures", "Scripting and Parameterization" 항목. FinFET 리세스 구조 학습에도 그대로 유효. `[확인됨 — 외부 공개 튜토리얼, 접근 가능]`

**[T4]** 학교 라이선스 예제 라이브러리 — FinFET_14nm/FinFET_22nm 예제 실제 존재·치수 확인. `[미확인 — 최우선 확인 과제]`

## 7. 경진대회 관련

- 실제 2025/2026 POLARIS SIF 수상작(아이디어·작품 부문) 6건을 팀이 직접 분석 — 그 중 **김나박구팀(2026 작품 부문, "BCAT+DWMG")**이 직전 주제(DBCAT×접합도핑)와 유사 조합으로 출품된 것을 확인, 이것이 이번 전환의 직접 계기 (경위는 [devlog.md](devlog.md), [topic-selection-history.md 7단계](topic-selection-history.md) 참고)
- `[미확인 — 확인 필요]` **FinFET+SiGe eS/D(Ge%×리세스 깊이 결함경계 매핑) 자체가 분석한 6건의 실제 수상작과 겹치는지는 아직 명시적으로 재확인하지 않았다.** DBCAT/NCFET 기각 때처럼 이 조합도 6건 각각과 직접 대조해볼 것 — 다음 devlog 항목에서 처리

## 8. 팀 내부 문서

- [프로젝트 통합 기획서](reports/project-plan.md) — `[미갱신]` 아직 DBCAT 단계 내용 그대로. FinFET+SiGe 기준 재작성 필요
- [DRAM 기초 학습자료](reports/dram-basics.md) — `[미갱신]` 아직 DBCAT/DRAM 단계 내용 그대로. FinFET 학습자료로 교체 또는 신규 작성 필요
- [주제 선정 이력](topic-selection-history.md) — 검토·기각한 20개 후보 아카이브
- [검증 오류 회고](retrospective.md) — 이 전환 과정에서 실제로 잡아낸 검증 오류 사례
