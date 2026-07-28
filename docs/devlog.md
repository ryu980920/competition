# 개발 로그

새 항목은 위(최신순)에 추가한다. 작성 형식은 [`devlog-template.md`](devlog-template.md) 참고.

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
- 수상작 분석 및 추천 주제, GAA 학습 가이드, 구조 코드 분석 문서 (팀 공유 파일 → `docs/references.md`에 정리 예정)
