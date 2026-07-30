# 참고 자료

프로젝트 진행 중 정리한 조사·분석 자료 목록.

> **최종 확정 주제**: DRAM BCAT(Buried Channel Array Transistor)의 코너 라운딩(Fin Fillet Radius) + Elevated Source/Drain 접합 도핑 저감 결합 최적화 — GIDL·리텐션 특성 개선.
> 이 프로젝트는 **GAA-TFET → GAA 시트별 차등 Halo Doping → 다중 에너지 Vt-Implant → WFM 비교/초협소 간격 검증**까지 GAA 나노시트 계열로 여러 차례 방향을 다듬었으나, RDF 정량화 가능 여부가 불확실해지고 팀 내부에서도 양산성 이견이 제기되어 **GAA 나노시트 계열 전체를 폐기**했다. 이후 수상작 분석·심사기준·논문 중복 배제·양산 가능성 네 기준으로 소자군을 전면 재검토해 **DRAM BCAT**로 최종 전환했다. 전환 과정과 사유는 [`devlog.md`](devlog.md) 참고. GAA 관련 조사 자료(아래 "폐기된 GAA 나노시트 경로" 절)는 향후 유사 아이디어 재검토 시 참고용으로 그대로 보존한다.

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

## 베이스라인 논문 (BCAT — 현재 채택 경로)

- ["Simulation Study: The Impact of Structural Variations on the Characteristics of a Buried-Channel-Array Transistor (BCAT) in DRAM,"](https://www.mdpi.com/2072-666X/13/9/1476) *Micromachines*, 2022, 13(9), 1476. (오픈 액세스) — Sentaurus TCAD로 구현된 BCAT 구조·수치 baseline. Lgate 20nm, Drecess 120nm(AR≈6.0), 게이트 산화막 5nm, 텅스텐 게이트 일함수 4.8eV. 리세스-to-게이트길이 비, 깊이, 접합깊이, 핀 폭, **핀 필렛 반경(Fin Fillet Radius)**을 변수로 Vth/SS/Ion-off/DIBL을 분석 — 우리 코너 라운딩 변수의 baseline이자 겹침 확인 대상.
- ["The breakthrough in data retention time of DRAM using Recess-Channel-Array Transistor(RCAT) for 88nm feature size and beyond"](https://www.researchgate.net/publication/4028293_The_breakthrough_in_data_retention_time_of_DRAM_using_Recess-Channel-Array_TransistorRCAT_for_88_nm_feature_size_and_beyond) — RCAT/BCAT 계열의 원조 논문. Elevated Source/Drain(ESD) 구조가 접합부 저도핑으로 전계·누설전류·산포를 낮춰 리텐션을 개선한다는 근거. 우리 접합 저도핑 변수의 근거 논문.
- ["Saddle-fin Cell Transistors with Oxide Etch Rate Control by Using Tilted Ion Implantation (TIS-Fin) for Sub-50-nm DRAMs,"](https://www.kci.go.kr/kciportal/ci/sereArticleSearch/ciSereArtiView.kci?sereArticleSearchBean.artiId=ART001428889) *J. Korean Physical Society*, 2010. — 틸트 임플란트로 새들핀 균일도(Vth 산포 <100mV)를 개선한 선행 사례. RDF 트레이드오프는 다루지 않음.
- ["Variation-aware analysis of buried-channel-array transistors (BCATs) in scaled DRAM: insights from 3D quasi-atomistic simulations"](https://www.researchgate.net/publication/386265159_Variation-aware_analysis_of_buried-channel-array_transistors_BCATs_in_scaled_DRAM_insights_from_3D_quasi-atomistic_simulations) (2024) — 새들핀-소스/드레인 코너 곡률(rounding)이 Vth·전류·산포에 미치는 영향을 3D 원자단위 모델로 분석. **우리 "코너 라운딩" 축과 가장 가까운 인접 연구** — 완전히 겹치진 않으나 이 구석이 이미 상당히 채워져 있음을 보여주는 근거.
- ["Design Strategies for BCAT Structures: Enhancing DRAM Reliability and Mitigating Row Hammer Effect,"](https://www.mdpi.com/2079-9292/14/3/499) *Electronics*, 2025. — 2025년에도 BCAT 구조·신뢰성 최적화가 활발히 연구되고 있음을 보여주는 최신 사례.

> **정직한 겹침 인정**: 코너 라운딩(Fin Fillet Radius)과 Elevated S/D 저도핑을 "하나로 묶어 통합 설계"한 논문은 확인되지 않았으나, 두 축 각각은 위 논문들로 이미 상당히 다뤄지고 있다. "완전 무경쟁"이 아니라 "이미 알려진 두 기법의 우리 조합·검증"이라는 점을 발표 자료에서도 정직하게 밝힐 것.

## 검토 후 기각한 소자군 (2026-07-30 전면 재검토)

GAA 나노시트 계열 전체를 폐기하고 소자군을 새로 검토하며 기각한 후보들.

- **BSPDN(후면 전력망) 백사이드 컨택 저항 비교**: 이미 양산 중(Intel 18A PowerVia)이라 양산성은 최고 수준이나, 관련 문헌이 대부분 SEMulator3D/Global TCAD Solutions 툴 기반이라 Sentaurus 구현 확실성이 낮음.
- **SiC 트렌치 MOSFET / GaN HEMT 파워 반도체**: 양산성·Sentaurus 문헌 모두 우수하나, 실제 수상작 11건(POLARIS SIF·KCS·삼성휴먼테크) 재검토 결과 파워 반도체 카테고리는 전례가 전혀 없어 수상 패턴 기준에서 기각.
- **3D NAND 채널홀 Vth 편차 / 워드라인 유전체 엔지니어링 / 셀렉트게이트 다중 워크펑션**: Sentaurus 구현 사례·수상 전례 모두 있으나, 셀-투-셀 간섭 유전체 엔지니어링(2021 PMC 논문)·에어갭 워드라인 분리(imec 2024-2025)·셀렉트게이트 다중 WF(특허 2014, 학회논문 2019) 등 인접 축이 이미 두텁게 존재.
- **eMRAM(STT-MRAM)**: 액세스 트랜지스터는 Sentaurus로 가능하나 MTJ(스핀토크 자화 스위칭)가 Sentaurus 표준 반도체 물리 엔진 밖의 자성 물리라 실제 기여 범위 축소 위험.
- **CMOS 이미지센서 DTI(Deep Trench Isolation) 크로스토크 억제 / ESD 보호소자(ggNMOS)**: 둘 다 양산성·Sentaurus 적합성은 우수하나 2011년부터 최근까지 지속적으로 논문화된 성숙 분야.
- **Process-aware Device Design(변동성 고려 설계)**: 특정 소자를 지정하지 않은 방법론 제안이고, 사실상 RDF 등 변동성 정량화 문제로 재귀결되어 이번 기준(RDF 배제)과 충돌.

## 폐기된 GAA 나노시트 경로 (참고용 보존)

아래는 GAA 나노시트 계열 진행 중 조사했던 자료. 계열 전체가 폐기됐지만 향후 유사 아이디어 재검토 시 참고용으로 그대로 보존한다.

### 베이스라인 논문 (구조·수치·문제 근거)

- Loubet, N. et al., ["Stacked nanosheet gate-all-around transistor to enable scaling beyond FinFET,"](https://www.researchgate.net/publication/319035460_Stacked_nanosheet_gate-all-around_transistor_to_enable_scaling_beyond_FinFET) 2017 Symposium on VLSI Technology, pp. T230-T231.
- ["Optimization of Structure and Electrical Characteristics for Four-Layer Vertically-Stacked Horizontal Gate-All-Around Si Nanosheets Devices,"](https://www.mdpi.com/2079-4991/11/3/646) Nanomaterials 2021, 11(3), 646.
- Vardhan, P.H. et al., ["Threshold Voltage Variability in Nanosheet GAA Transistors,"](https://www.researchgate.net/publication/335194719_Threshold_Voltage_Variability_in_Nanosheet_GAA_Transistors) IEEE Trans. Electron Devices, 2019.
- Han, Y. et al., ["Impact of Process Variability on Threshold Voltage in Vertically-Stacked Nanosheet TFET,"](https://link.springer.com/article/10.1007/s12633-022-02256-8) *Silicon*, 2023.

### RDF 트레이드오프 및 WFM/다이폴 비교 근거

- ["Guideline for balancing threshold voltages in gate-all-around CMOS by controlling the thickness of the work function metal under tight nanosheet spacing,"](https://iopscience.iop.org/article/10.35848/1347-4065/ae3835) 2026.
- Random Dopant Fluctuation(RDF)과 채널 도핑 농도의 관계: σVth가 도핑 농도의 세제곱근~네제곱근에 비례해 증가 (위키피디아 "Random dopant fluctuation" 및 다수 IEEE TED 논문).
- Multi-metal dipole doping / differential interfacial layer thickness 관련 특허 다수 (예: US 11393725 등).

### 검토 후 기각한 대안 (GAA 경로 내)

- **GAA + NCFET(강유전체 게이트)**: 이미 다수 Sentaurus TCAD 논문 존재, Sentaurus 수렴 문제 실재.
- **Air-gap 내부 스페이서 / Hybrid(Dual-k) 스페이서 / 진공 스페이서**: 다수 특허·논문 존재 — 검토한 대안 중 겹침이 가장 심함.
- **DRAM + 듀얼 워크펑션 게이트**: IEDM 2023 등 산업 논문이 이미 적용.
- **GAA 파라미터 차등화 계열 5건(비대칭 Dual-k 스페이서, 하이브리드 스페이서, 레이어별 워크펑션, 순차 스페이서 형성, 레이어별 게이트스택)**: 전부 검색 결과 기존 논문·특허와 겹침 확인 후 기각 — "GAA 레이어를 다르게 만든다"는 뼈대 자체(도핑·워크펑션·유전체·스페이서·스트레스 축 전부)가 이미 개별 논문화됨.

### 구조 코드 분석 (팀 분석 노트)

학교 Sentaurus 라이선스(AdvancedTransportPackage)의 예제 스크립트 3종을 팀이 직접 분석한 노트. GAA 나노시트 구조 생성 코드라 BCAT 구조와는 직접 재사용은 어려우나, Sentaurus SProcess 문법 학습 자료로는 유효.

- [NSFET 구조 코드 분석 및 적용 방안](reports/nsfet-code-analysis.md)
- [3개 구조 코드 비교분석](reports/three-codes-comparison.md)
- [코드 B·C 줄별 분석 비교](reports/code-bc-line-analysis.md)

## 이론 학습

- (정리 예정) BCAT 구조·코너 라운딩·Elevated S/D 공정 이론 자료. 새로 작성 예정.
