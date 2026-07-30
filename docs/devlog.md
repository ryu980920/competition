# 개발 로그

새 항목은 위(최신순)에 추가한다. 작성 형식은 [`devlog-template.md`](devlog-template.md) 참고.

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
