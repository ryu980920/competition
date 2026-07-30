# 개발 로그

새 항목은 위(최신순)에 추가한다. 작성 형식은 [`devlog-template.md`](devlog-template.md) 참고.

---

## 2026-07-30 — 주제 전환: GAA-TFET → GAA 시트별 차등 다중 에너지 Vt-Implant

### 한 일
- GAA-TFET(Line-Tunneling + 비대칭 도핑) 방향으로 baseline을 잡기 위해 참고문헌을 조사하던 중, Jain et al., "Performance Analysis of Vertically Stacked Nanosheet Tunnel Field Effect Transistor with Ideal Subthreshold Swing," *Silicon* (2022) 논문이 우리 계획 구조(3층 나노시트, Line-Tunneling형 extended source/drain, 도핑 조건)와 사실상 동일함을 발견
- "재현+확장(Lov 스윕, 적층수 3→5 확장)" 방안을 우선 검토했으나, 이는 이미 검증된 파라미터 범위를 넓히는 수준이라 독창성 확보에 근본적 한계가 있다고 재판단
- 시트별 변동성(적층 시 Ambipolar 억제 유지 여부)으로 재차 보완을 시도했으나, 이마저 Feng et al., "Impact of Process Variability on Threshold Voltage in Vertically-Stacked Nanosheet TFET," *Silicon* (2023)이 이미 다룬 문제임을 확인
- GAA 나노시트·TFET·DRAM 결합 전반이 이미 수년간 여러 연구그룹이 파라미터 단위로 논문화한 성숙 분야임을 재확인 (다수 특허·논문 교차검증). "전 세계에 겹치는 문헌이 전혀 없어야 한다"는 기준 자체가 이 분야에서는 비현실적이라고 결론
- 원래 [`award-analysis-and-topic-selection.md`](reports/award-analysis-and-topic-selection.md) 5~6절에서 최종 추천했던 **방향 A(GAA 시트별 차등 Halo Doping)**로 복귀 결정 — 완성 리스크 없음(BTBT 수렴 문제 회피), 본인 SCE 프로젝트(Halo Doping으로 SS 561→89.9mV/dec 개선) 데이터와 직결, 특정 논문 하나와 baseline이 통째로 겹치지 않음을 근거로 판단
- Baseline 구조 논문 조사 중, MDPI 2021 논문("Optimization of Structure and Electrical Characteristics for Four-Layer Vertically-Stacked GAA Si Nanosheets Devices")이 "기존 planar의 halo implant나 FinFET의 PTS doping은 GAA NW/NS 구조엔 그대로 못 쓴다"고 명시한 것을 확인 — 적층 시트가 서로의 이온주입 경로를 가리는 문제(shadowing)와, 릴리즈된 초박막(5~6nm) 시트에 이온주입 시 구조 손상 위험 때문
- 이에 따라 구현 방법을 **halo doping → 블랭킷 웨이퍼 단계(핀 패터닝·시트 릴리즈 이전)에서의 다중 에너지 이온주입 기반 층별 차등 Vt-implant**로 수정. 에너지로 깊이(층 위치)를, 도즈로 농도를 제어하며, 임플란트 스트래글로 인한 인접층 간섭을 감안해 Analytic 프로파일로 목표를 먼저 잡고 실제 임플란트 조합으로 역산하는 2단계 접근으로 계획
- 이 방법은 [수상작 분석](reports/award-analysis-and-topic-selection.md)의 BCAT 수상작(Multiple-energy ion implantation, 사업단장상)과 같은 장르로, 실제 수상 전례가 있는 접근임을 재확인
- 근본 원인(Vardhan et al. 2019의 MTV, 즉 일함수 변동)과 해결 수단(도핑)이 다른 메커니즘이라는 점을 인지 — Vth가 일함수와 채널 도핑 모두에 의존한다는 점에서, 도핑 기반 보정이 물리적으로 타당하다는 논리로 서사 보완 필요 (다음 할 일에 반영)
- 저장소 정리: TFET 전용 자료 정리 — `GAA-TFET_프로젝트_개념정리.docx`, `GAA-TFET_QA_스터디노트.docx`(팀 내부 스터디용, 저장소에는 미포함 상태였음), `gaa-tfet-learning-guide.md` 삭제(git 히스토리에는 남아있어 필요시 복구 가능). `차세대반도체_경진대회_수상작분석_추천주제.docx` → `award-analysis-and-topic-selection.md`로 마크다운 전환(GitHub에서 바로 렌더링되도록)

### 결정 사항
- 최종 주제: **GAA 나노시트 다중 에너지 이온주입 기반 층별 차등 Vt-Implant를 통한 Inter-sheet Variation 억제**
- TFET·Line-Tunneling·Ambipolar 관련 계획은 전부 폐기. 이번 프로젝트는 순수 MOSFET 구조이며 BTBT 물리 모델이 필요 없음

### 막힌 점 / 리스크
- Vth 편차의 근본 원인(MTV, 일함수)과 우리 해결 수단(도핑)이 물리적으로 다른 레버라는 점 — 도핑으로 상쇄 가능한지 시뮬레이션으로 먼저 검증 필요
- 다중 에너지 임플란트의 층별 (Energy, Dose) 조합을 스트래글까지 고려해 맞추는 것은 반복 튜닝이 필요한 작업 — 1차로 Analytic 프로파일로 전기적 효과부터 빠르게 검증 후, 2차로 실제 임플란트 조합으로 역산하는 순서로 진행

### 다음 할 일
- [ ] Loubet 2017 / MDPI 2021 baseline 수치(Lg 25.8nm, 시트두께 6nm, 4층)로 균일 Vt-implant 조건 구조 생성 및 baseline ΔVth/ΔSS 정량화
- [ ] Analytic 프로파일로 층별 차등 도핑의 전기적 효과(편차 감소) 1차 검증
- [ ] 감도분석(sensitivity sweep)으로 Energy/Dose/Anneal 중 편차 유발 요인 규명
- [ ] "일함수 변동 원인을 도핑으로 보정 가능한가"에 대한 물리적 타당성 서사 정리 (발표자료용)
- [ ] 목표 프로파일을 실제 다중 에너지 임플란트 (Energy, Dose) 조합으로 역산

### 참고
- 방향 전환 근거·baseline 논문 3종 → [`docs/references.md`](references.md)에 정리 완료

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
