# 참고 자료

프로젝트 진행 중 정리한 조사·분석 자료 목록.

> 이 프로젝트는 **GAA-TFET → GAA 시트별 차등 Halo Doping → GAA 시트별 차등 다중 에너지 Vt-Implant** 순으로 방향을 두 차례 수정했다. 전환 과정과 사유는 [`devlog.md`](devlog.md) 참고. 이전 방향(TFET)에서 작성했던 물리 학습 자료는 방향 전환 후 저장소에서 정리했다.

## 주제 선정

- [수상작 분석 및 추천 주제](reports/award-analysis-and-topic-selection.md) — POLARIS SIF·한국반도체학술대회(KCS)·삼성휴먼테크논문대상 수상작 11건 분석, 패턴 정리, 최초 후보(GAA+HKMG) 기각 근거, 방향 A(시트별 차등 도핑) 대 방향 B(NCFET) 비교. **현재 최종 주제(다중 에너지 Vt-Implant)의 원형이 되는 문서.**
- 수상작 원본 링크
  - [POLARIS SIF 2025 수상작품 전체보기](https://polargate.disu.ac.kr/contest/SIF2025/winner?sc=y) (로그인 필요)
  - [전자산란효과(Electron scattering)를 이용한 FET 전류 제어 방식 제안](https://polargate.disu.ac.kr/contest/SIF2025/winner?applyidx=255) — 사업단장상
  - [Multiple-energy ion implantation을 이용한 9.6nm BCAT 설계](https://polargate.disu.ac.kr/contest/SIF2025/winner?applyidx=258) — 사업단장상. 우리가 최종 채택한 "다중 에너지 임플란트" 접근과 같은 장르의 수상 사례.
  - [FinFET Architecture 기반 TFET 구조 제안](https://polargate.disu.ac.kr/contest/SIF2025/winner?applyidx=232)
  - [POLARIS SIF 2023 수상작품 전체보기](https://polargate.disu.ac.kr/contest/SIF2023/winner?sc=y) (로그인 필요)
  - [a-IGZO 전기적 특성 측정](https://polargate.disu.ac.kr/contest/SIF2023/winner?applyidx=84)
  - [KCS 2025 논문상 전체 목록](http://kcs.cosar.or.kr/2025/awards-2025.jsp)
  - [제32회 삼성휴먼테크논문대상 수상자 인터뷰](https://news.samsungsemiconductor.com/kr/미래를-설계하는-젊은-과학도들이-모인-현장-수상자-2)

## 베이스라인 논문 (구조·수치·문제 근거)

- Loubet, N. et al., ["Stacked nanosheet gate-all-around transistor to enable scaling beyond FinFET,"](https://www.researchgate.net/publication/319035460_Stacked_nanosheet_gate-all-around_transistor_to_enable_scaling_beyond_FinFET) 2017 Symposium on VLSI Technology, pp. T230-T231. — 적층 GAA 나노시트 구조의 원조 논문. 전체 아키텍처 근거.
- ["Optimization of Structure and Electrical Characteristics for Four-Layer Vertically-Stacked Horizontal Gate-All-Around Si Nanosheets Devices,"](https://www.mdpi.com/2079-4991/11/3/646) Nanomaterials 2021, 11(3), 646. (오픈 액세스) — 4층 구조 실측+TCAD 논문. Lg 25.8nm, 시트두께 6nm, 4층, GP 도핑 조건, 목표 성능(Ion/Ioff 3.15×10⁵, SS 71.2/78.7 mV/dec, DIBL 9/22 mV/V) 등 baseline 수치 출처. Halo doping이 GAA에는 그대로 적용되지 않는다는 것을 명시한 논문이기도 함.
- Vardhan, P.H. et al., ["Threshold Voltage Variability in Nanosheet GAA Transistors,"](https://www.researchgate.net/publication/335194719_Threshold_Voltage_Variability_in_Nanosheet_GAA_Transistors) IEEE Trans. Electron Devices, 2019. — Metal Thickness Variation(MTV)으로 인한 층간 Vth 편차 문제의 근거 논문. 우리가 해결하려는 "문제"의 출처.

## 이론 학습

- (정리 예정) 다중 에너지 이온주입·Vt-implant 관련 공정 이론 자료. TFET 전환 당시 작성했던 "GAA-TFET 학습 가이드"는 현재 주제(순수 MOSFET + Vt-implant, BTBT 불필요)와 맞지 않아 저장소에서 제외함. 필요 시 새로 작성.

## 구조 코드 분석 (팀 분석 노트)

학교 Sentaurus 라이선스(AdvancedTransportPackage)의 예제 스크립트 3종을 팀이 직접 분석한 노트. **원본 코드는 학교 라이선스로만 열람 가능하며 여기에는 포함되어 있지 않습니다** — 아래 문서는 각 블록이 하는 일을 팀이 이해할 수 있도록 말로 풀어 설명한 것입니다. 이 구조 생성 코드들은 원래 표준 MOSFET 방식(소스/드레인 동일 도펀트)이라, TFET 전환용으로 분석했던 내용과 별개로 **현재 주제(GAA MOSFET + 층별 차등 Vt-implant)의 구조 baseline으로 그대로 활용 가능**하다.

- [NSFET 구조 코드 분석 및 적용 방안](reports/nsfet-code-analysis.md) — 3-stack 나노시트(코드 A) 구조 생성 스크립트 블록별 분석.
- [3개 구조 코드 비교분석](reports/three-codes-comparison.md) — 코드 A(NSFET) · B(Nanowire SBTE) · C(Nanowire NEGF) 구조·난이도·팀 활용 방안 비교.
- [코드 B·C 줄별 분석 비교](reports/code-bc-line-analysis.md) — Nanowire SBTE(B)와 NEGF(C) 블록별 비교, 좌표축 규약 차이, 팀 온보딩 순서 제안.
