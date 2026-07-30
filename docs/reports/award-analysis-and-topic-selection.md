# 차세대반도체 경진대회 수상작 분석 및 소자·공정 부문 추천 주제

작성자: 유용성 (숭실대학교 신소재공학과, 차세대반도체공학과 복수전공) · 지원 분야: ① 소자/공정 · 팀 구성: 3인

> **[중요] 최종 주제와의 차이 안내**
> 이 문서는 프로젝트 초기(2026-07-28)에 작성된 주제 조사 자료다. 이 문서의 6절은 원래 **"GAA 시트별 차등 Halo Doping"**을 최종 추천 주제로 확정했었다. 이후 팀은 아래와 같은 과정을 거쳤다.
>
> 1. 이 문서의 결론과 달리, 대안으로 검토했던 **GAA-TFET(Line-Tunneling + 비대칭 도핑)** 방향으로 실제 진행을 시작함
> 2. TCAD baseline을 잡기 위해 참고문헌을 조사하던 중, 우리 구조·수치와 사실상 동일한 논문(Jain et al., *Silicon*, 2022)을 발견해 독창성 리스크를 재검토
> 3. 이 문서가 원래 추천했던 **Direction A(시트별 차등 도핑)**로 복귀하기로 결정
> 4. 다만 "Halo Doping"은 GAA 나노시트의 릴리즈(release) 후 구조에는 물리적으로 적용이 어렵다는 것을 확인해, **다중 에너지(Multi-Energy) 이온주입 기반 블랭킷 Vt-Implant**로 구현 방법을 수정
>
> 최종 확정 주제와 그 결정 과정은 [`docs/devlog.md`](../devlog.md)를 참고. 이 문서는 "왜 파라미터 조합만으로는 독창성을 인정받기 어려운가"에 대한 원래의 조사 근거 자료로서 그대로 보존한다.

---

## 1. 조사 개요

차세대반도체 경진대회(소자/공정 부문) 출품을 준비하며, 반도체 관련 대학생 경진대회의 실제 수상작 경향을 분석했다. 조사 대상은 크게 세 갈래다.

- POLARIS SIF (차세대반도체 첨단분야 혁신융합대학 경진대회) — 강원대·대구대·서울대·숭실대·조선이공대·중앙대·포항공과대 7개교 컨소시엄이 매년 개최. 작품/아이디어/에세이 3개 부문, 심사 기준은 완성도 30 · 독창성 30 · 공학적 파급효과 20 · 발표 20.
- 한국 대학생 반도체 설계 경진대회, 대한민국 반도체설계대전, IDEC 시스템반도체 설계 챌린지 — 산업통상자원부·반도체산업협회·KAIST IDEC 등이 주관하는 대형 공모전.
- 한국반도체학술대회(KCS) 학부생 포스터 세션, 삼성휴먼테크논문대상 — 학회·기업이 주관하는 논문/포스터 형태의 경진대회.

이 중 두 번째 갈래(반도체설계대전류)는 실제 수상작을 확인한 결과 PAM-4 트랜시버, ADC, RISC-V 프로세서 등 회로/시스템 설계에 극도로 편중되어 있어, 소자/공정 부문 참고 사례로는 적합하지 않았다. 따라서 아래 분석은 첫 번째와 세 번째 갈래를 중심으로 정리했다.

## 2. 수상작 목록 및 요약

### 2-1. POLARIS SIF — 소자/공정 관련 수상작

| 대회 / 연도 | 수상 / 소속 | 작품명 | 핵심 내용 |
|---|---|---|---|
| SIF 2025 | 사업단장상 / 중앙대 | 전자산란효과(Electron scattering)을 이용한 FET에서의 새로운 전류 제어 방식 제안 | 기존 게이트 전압 제어가 아닌 전자산란 현상을 이용한 새로운 전류 제어 메커니즘을 제안. 소자 동작 원리 자체를 재정의하는 유형. |
| SIF 2025 | 사업단장상 / 중앙대 | Multiple-energy ion implantation을 이용한 최적의 9.6nm BCAT 설계 | 이온 주입 에너지를 다단계로 조합해 초미세 BCAT(매립 채널 트랜지스터) 구조를 최적화. 공정 파라미터 스윕 기반 소자 최적화 유형. |
| SIF 2025 | 장려상 / 숭실대 | FinFET Architecture 기반 TFET 구조 제안 | FinFET의 3차원 채널 구조를 Tunnel-FET에 적용해 저전력 스위칭 특성을 확보하려는 시도. 차세대 트랜지스터 구조 융합형. |
| SIF 2023 | 장려상 / 소속 미상 | 4F2 DRAM 구조를 위한 수직 트랜지스터 제안 및 TCAD 시뮬레이션 | 고집적 DRAM용 수직형 트랜지스터를 TCAD로 설계·검증. 메모리 셀 구조 최적화에 TCAD를 활용한 사례. |
| SIF 2023 | 장려상 / 중앙대 | a-IGZO 전기적 특성 측정 | 비정질 산화물 반도체 박막의 전기적 특성을 실측 기반으로 분석. 재료 특성평가형 프로젝트. |

### 2-2. 한국반도체학술대회(KCS) 2025 — 학부생 포스터 · 논문상

| 대회 / 연도 | 수상 / 소속 | 작품명 | 핵심 내용 |
|---|---|---|---|
| KCS 2025 | 우수논문상 / 아주대 | Low-temperature SiO2 Contact Hole Etching Using C4F8 Plasmas | 저온 C4F8 플라즈마로 SiO2 컨택홀을 식각하는 공정 연구. |
| KCS 2025 | 학부생 포스터 / 전북대 | Profile Simulation of High Aspect Ratio Etching Process for Vertical NAND Devices | 3D NAND용 고종횡비(HAR) 식각 공정을 시뮬레이션으로 분석. |
| KCS 2025 | 학부생 포스터 / 중앙대 | 전자 산란효과를 이용한 FET의 새로운 전류 제어 방식 연구 | SIF 2025 사업단장상과 동일 연구를 학회에도 발표. |
| KCS 2025 | 학부생 포스터 / 건국대 | Electrical Isolation of Forksheet FET with Local Punch-through Stop Doping Process | 차세대 구조인 Forksheet FET에 국부 도핑으로 Punch-through를 억제. |
| KCS 2025 | 학부생 포스터 / 중앙대 | Enhancement of On-Current in RCAT Structures and Improving ΔV of DRAM with Dual-k Spacer Design | DRAM 셀 트랜지스터의 Spacer 유전율을 이중으로 설계해 구동전류와 문턱전압 산포를 동시에 개선. |

### 2-3. 삼성휴먼테크논문대상

| 대회 / 연도 | 수상 | 작품명 | 핵심 내용 |
|---|---|---|---|
| 제32회 (2025) | 수상작 | 낸드플래시 4bit/5bit 고집적화를 위한 신소재·밴드구조 설계 | 기존 공정·셀 구조를 크게 바꾸지 않고 소재와 밴드 구조 설계만으로 고집적 낸드플래시의 성능·신뢰성을 동시에 개선. |

## 3. 수상작 분석에서 도출된 패턴

- 소자/공정 부문 수상작은 크게 두 유형으로 갈린다. (A) 기존에 알려진 구조·소자를 TCAD·공정 시뮬레이션으로 정량 최적화하는 유형(BCAT, 4F2 DRAM, RCAT, HAR 식각 프로파일), (B) 새로운 소자 동작 원리나 구조를 제안하는 유형(전자산란 전류 제어, Forksheet TFET). 실측 장비 없이 시뮬레이션만으로도 다수가 수상했다.
- **A유형(공정 파라미터 최적화)도 최고상(사업단장상)을 받을 수 있다** — BCAT의 Multiple-energy ion implantation 사례가 대표적. "공정 최적화는 독창성 점수가 낮다"는 판단은 절대적이지 않다.
- 메모리(DRAM/NAND) 소자를 다룬 프로젝트가 다수 상위권에 올랐다.
- 차세대 트랜지스터 구조(FinFET, Forksheet, GAA 계열)에 기존 공정 기법(도핑, 유전체, 이온주입)을 접목하는 조합이 독창성 점수를 얻는 데 효과적이었다.
- 플라즈마 식각·박막 공정을 정량 분석한 연구는 실험·시뮬레이션 여부와 관계없이 학회 논문상 단위에서 꾸준히 인정받는다.
- 동일한 연구를 SIF와 KCS 등 서로 다른 대회에 함께 출품한 사례가 확인된다.

## 4. 팀의 보유 역량 (포트폴리오 기반)

- **TCAD PMOS Process Conversion & Optimization** — Sentaurus SProcess/SDevice로 nMOS 예제를 pMOS로 변환하고 NWell 농도·LDD Dose를 스윕해 Ioff 91% 감소, SS 개선을 달성.
- **30/60nm NMOS Short Channel Effect 개선 (5인 팀)** — SOI·Halo Doping·Metal Gate를 단독/복합 적용해 SS를 561→89.9 mV/dec까지 개선. "Metal Gate 단독으로는 한계가 있고 High-k와 결합해야 한다"는 한계를 스스로 도출.
- **QCLAS 기반 반도체 플라즈마 식각 공정 진단** — 반도체공학회 하계학술대회 구두 발표.
- **LAS 기반 반도체 공정 분석 주제 연구 (조장)** — 문헌 조사부터 팀 운영, 피드백 반영까지 프로젝트 총괄 경험.

## 5. 주제 재검토: 단순 파라미터 조합의 한계

최초에는 "GAA 나노시트 + HKMG(High-k Metal Gate) 최적화"를 1순위로 검토했다. 그러나 HKMG는 2007년 인텔 45nm부터 산업 표준으로 자리잡았고 GAA도 이미 삼성 3nm(MBCFET)로 양산 중인 구조여서, 두 기술을 그대로 결합하는 것만으로는 심사 배점 중 독창성(30점)을 확보하기 어렵다는 판단에 이르렀다.

### 5-1. 검토한 대안 비교

| 구분 | 주제 | 핵심 아이디어 | 실현 가능성 근거 |
|---|---|---|---|
| 방향 A | GAA 시트별 차등 Halo Doping | GAA 나노시트 스택 간 Vth·SS 불균일(Inter-sheet Variation) 문제에 본인이 검증한 Halo Doping 기법을 시트 위치별로 차등 적용해 억제. | IEEE TED "Threshold Voltage Variability in Nanosheet GAA Transistors" 등 문헌으로 실재성 확인. Sentaurus SProcess 표준 기능(이온주입 스윕)만으로 구현 가능. SCE 프로젝트 경험과 직결. |
| 방향 B | GAA + NCFET (강유전체 게이트) | 강유전체 게이트를 GAA에 결합해 상온 이론 한계(60mV/dec)를 돌파하는 시도. | Sentaurus에서 Landau-Khalatnikov 방정식으로 구현 가능하나, 강유전체-절연막 계면 수렴(convergence) 문제가 고질적이며 HZO 물성 파라미터를 커스텀으로 직접 구축해야 함. 대회 준비 기간 내 완주 리스크 큼. |

완성도(30점)는 결과를 실제로 끝까지 도출해야 받을 수 있는 점수다. 독창성이 높아도 미완성이면 의미가 없으므로, 실현 가능성과 문헌적 근거, 자기 데이터 연결성을 모두 갖춘 방향 A로 최종 확정했다. *(이 결론은 이후 GAA-TFET로 한 차례 방향 전환했다가, devlog에 기록된 과정을 거쳐 다시 방향 A로 복귀했다.)*

## 6. 결론

조사한 수상작들은 시뮬레이션 기반 정량 최적화와, 차세대 구조에 기존 공정 기법을 창의적으로 재응용하는 유형으로 수렴한다. 최초 검토했던 GAA+HKMG는 이미 산업 표준화된 기법의 단순 조합이라 독창성 확보가 어렵다고 판단해 기각했고, 강유전체 기반 NCFET은 독창성은 높지만 Sentaurus에서의 수렴 문제와 커스텀 물성 모델 구축 부담으로 대회 기간 내 완주 리스크가 크다고 판단했다. 방향 A(GAA 시트별 차등 도핑)는 실재하는 산업 이슈(Inter-sheet Variation)에 본인 팀이 이미 검증한 기술(도핑 엔지니어링)을 새로운 방식으로 재응용하는 것으로, 실현 가능성·문헌적 근거·자기 데이터 연결성·독창성을 모두 만족하는 최종안이다.

## 부록. 참고 링크

본 보고서에서 인용한 수상작 및 출처 링크. POLARIS SIF는 작품 상세 페이지가 로그인 후에만 열람 가능하며, KCS와 삼성휴먼테크는 개별 작품 단위 URL이 없어 목록/기사 페이지 링크로 대신했다.

**POLARIS SIF 2025**
- [수상작품 전체보기 (목록, 로그인 필요)](https://polargate.disu.ac.kr/contest/SIF2025/winner?sc=y)
- [전자산란효과(Electron scattering)을 이용한 FET에서의 새로운 전류 제어 방식 제안](https://polargate.disu.ac.kr/contest/SIF2025/winner?applyidx=255) — 사업단장상, 중앙대
- [Multiple-energy ion implantation을 이용한 최적의 9.6nm BCAT 설계](https://polargate.disu.ac.kr/contest/SIF2025/winner?applyidx=258) — 사업단장상, 중앙대
- [FinFET Architecture 기반 TFET 구조 제안](https://polargate.disu.ac.kr/contest/SIF2025/winner?applyidx=232) — 장려상, 숭실대

**POLARIS SIF 2023**
- [수상작품 전체보기 (목록, 로그인 필요)](https://polargate.disu.ac.kr/contest/SIF2023/winner?sc=y)
- [a-IGZO 전기적 특성 측정](https://polargate.disu.ac.kr/contest/SIF2023/winner?applyidx=84) — 장려상, 중앙대
- 4F2 DRAM 구조를 위한 수직 트랜지스터 제안 및 TCAD 시뮬레이션 — 장려상. 목록에서 썸네일 이미지가 비공개 처리되어 개별 URL 확인 불가, 위 목록 페이지에서 직접 열람 필요.

**한국반도체학술대회(KCS) 2025**
- [KCS 2025 논문상 전체 목록](http://kcs.cosar.or.kr/2025/awards-2025.jsp) — Low-temperature SiO2 Contact Hole Etching(아주대), HAR Etching Profile Simulation(전북대), 전자산란효과 FET 연구(중앙대), Forksheet FET 국부도핑(건국대), RCAT Dual-k Spacer(중앙대) 전부 이 페이지 안에 포함

**삼성휴먼테크논문대상**
- [제32회 삼성휴먼테크논문대상 수상자 인터뷰](https://news.samsungsemiconductor.com/kr/미래를-설계하는-젊은-과학도들이-모인-현장-수상자-2) — 낸드플래시 4bit/5bit 고집적화 신소재·밴드구조 설계 연구 소개 기사 (원문 비공개)
