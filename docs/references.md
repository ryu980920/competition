# 참고 자료

프로젝트 진행 중 정리한 조사·분석 자료 목록.

> **최종 확정 주제**: GAA 나노시트 초협소 시트 간격 영역에서의 다중 에너지 이온주입 기반 층별 차등 Vt-Implant — WFM/다이폴 대비 RDF 트레이드오프 정량화 및 유효 구간 검증.
> 이 주제는 **GAA-TFET → GAA 시트별 차등 Halo Doping → 다중 에너지 Vt-Implant → (RDF 트레이드오프 발견) → WFM 비교 도입 → 초협소 간격 유효 구간 검증**의 여러 단계를 거쳐 확정됐다. 전환 과정과 사유는 [`devlog.md`](devlog.md) 참고. 이전 방향(TFET)에서 작성했던 물리 학습 자료는 방향 전환 후 저장소에서 정리했다.

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
- Han, Y. et al., ["Impact of Process Variability on Threshold Voltage in Vertically-Stacked Nanosheet TFET,"](https://link.springer.com/article/10.1007/s12633-022-02256-8) *Silicon*, 2023. — RDF·WFV·OTV를 통계적 방법(sIFM)으로 함께 분석한 논문. 우리가 RDF를 정량화할 때 참고할 방법론.

## RDF 트레이드오프 및 WFM/다이폴 비교 근거

- ["Guideline for balancing threshold voltages in gate-all-around CMOS by controlling the thickness of the work function metal under tight nanosheet spacing,"](https://iopscience.iop.org/article/10.35848/1347-4065/ae3835) 2026. — TiN/TiAlC/TiN 스택으로 10nm 미만 시트 간격에서도 Vth 균형(±0.2V) 달성. **우리 baseline 간격(10nm)에서는 WFM이 이미 해결한 문제임을 보여주는 핵심 근거** — 그래서 우리는 이보다 더 좁은 간격을 봐야 함.
- Random Dopant Fluctuation(RDF)과 채널 도핑 농도의 관계: σVth가 도핑 농도의 세제곱근~네제곱근에 비례해 증가한다는 것이 확립된 물리(위키피디아 "Random dopant fluctuation" 및 다수 IEEE TED 논문 참고). FinFET/GAA 같은 박막 멀티게이트 구조는 벌크 평면소자보다 이 증가폭이 작다는 연구도 있음.
- Multi-metal dipole doping / differential interfacial layer thickness 관련 특허 다수 (예: "Multi-metal dipole doping to offer multi-threshold voltage pairs without channel doping", US 11393725 등) — WFM/다이폴이 업계의 실제 주력 해법임을 보여주는 근거.

## 검토 후 기각한 대안 (중복 확인용 기록)

아래는 검토했으나 기존 문헌·특허와 겹침이 확인되어 채택하지 않은 주제들. 향후 유사 아이디어 재검토 시 참고.

- **GAA + NCFET(강유전체 게이트)**: GAA 나노시트 NCFET 자체가 이미 다수 Sentaurus TCAD 논문으로 존재(예: 1.5nm node MFIS NC-NSFET, Ioff 감소·Ion 40%↑). Sentaurus 수렴 문제도 실재(ResearchGate Q&A 스레드로 확인).
- **Air-gap 내부 스페이서 / Hybrid(Dual-k) 스페이서 / 진공 스페이서**: "Full air-gap spacers for gate-all-around nanosheet field effect transistors" 등 다수 특허, "Stacked GAA nanosheet with full-air-spacers"(Ceff 79.4%↓, 지연 75.71%↓, 전력 60.84%↓) 논문, "Performance Improvements in GAA NSFET Devices... Hybrid Dual-κ Spacer Strategy at 3nm Node"(NMOS 14.51%·PMOS 11.70% 개선) 논문, 그리고 IEEE 논문(inner-spacer의 기생용량 억제 vs 자기발열 트레이드오프)까지 이미 존재 — 지금까지 검토한 대안 중 겹침이 가장 심함.
- **DRAM + 듀얼 워크펑션 게이트**: IEDM 2023 "Workfunction Engineered Middle-Silicon-TiN Gate(MSTG)" 등 산업 논문이 GAA 나노시트 적층형 DRAM 액세스 트랜지스터에 이미 적용.

## 이론 학습

- (정리 예정) 다중 에너지 이온주입·Vt-implant·RDF 정량화 관련 공정 이론 자료. TFET 전환 당시 작성했던 "GAA-TFET 학습 가이드"는 현재 주제(순수 MOSFET + Vt-implant, BTBT 불필요)와 맞지 않아 저장소에서 제외함. 필요 시 새로 작성.

## 구조 코드 분석 (팀 분석 노트)

학교 Sentaurus 라이선스(AdvancedTransportPackage)의 예제 스크립트 3종을 팀이 직접 분석한 노트. **원본 코드는 학교 라이선스로만 열람 가능하며 여기에는 포함되어 있지 않습니다** — 아래 문서는 각 블록이 하는 일을 팀이 이해할 수 있도록 말로 풀어 설명한 것입니다. 이 구조 생성 코드들은 원래 표준 MOSFET 방식(소스/드레인 동일 도펀트)이라, TFET 전환용으로 분석했던 내용과 별개로 **현재 주제(GAA MOSFET + 층별 차등 Vt-implant)의 구조 baseline으로 그대로 활용 가능**하다.

- [NSFET 구조 코드 분석 및 적용 방안](reports/nsfet-code-analysis.md) — 3-stack 나노시트(코드 A) 구조 생성 스크립트 블록별 분석.
- [3개 구조 코드 비교분석](reports/three-codes-comparison.md) — 코드 A(NSFET) · B(Nanowire SBTE) · C(Nanowire NEGF) 구조·난이도·팀 활용 방안 비교.
- [코드 B·C 줄별 분석 비교](reports/code-bc-line-analysis.md) — Nanowire SBTE(B)와 NEGF(C) 블록별 비교, 좌표축 규약 차이, 팀 온보딩 순서 제안.
