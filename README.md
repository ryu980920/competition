# DRAM BCAT 코너·접합 결합 최적화 경진대회 프로젝트

차세대반도체 경진대회(소자/공정 부문) 출품 프로젝트. DRAM 셀 접근 트랜지스터인 BCAT(Buried Channel Array Transistor)의 새들핀 코너 라운딩(Fin Fillet Radius, 구조/식각 엔지니어링)과 Elevated Source/Drain 접합 도핑 저감을 하나로 묶어 최적화해, GIDL(Gate-Induced Drain Leakage)과 리텐션 특성을 개선한다. 두 기법 각각은 문헌에 존재하지만 하나로 묶어 통합 검증한 사례는 확인되지 않아, "완전한 신규"가 아니라 "이미 알려진 기법의 우리 조합·검증"으로 정직하게 포지셔닝한다.

- **팀 구성**: 3인
- **지원 분야**: ① 소자/공정
- **시뮬레이션 툴**: Synopsys Sentaurus TCAD (SProcess / SDevice / SVisual)

> **주제 전환 이력**: 이 프로젝트는 원래 "GAA-TFET(Line-Tunneling + 비대칭 도핑)"으로 시작해 "GAA 시트별 차등 Halo Doping" → "다중 에너지 Vt-Implant" → "WFM 비교/초협소 간격 검증"까지 GAA 나노시트 계열로 여러 차례 다듬었으나, RDF 정량화 가능 여부가 불확실해지고 팀 내부에서도 양산성에 대한 이견이 제기되어 **GAA 나노시트 계열 전체를 폐기**했다. 이후 수상작 분석·심사 기준·논문 중복 여부·양산 가능성 네 기준으로 소자군을 완전히 새로 검토해 **DRAM BCAT**로 최종 전환했다. 자세한 경위는 [`docs/devlog.md`](docs/devlog.md)의 2026-07-30 항목(전체) 참고.

## 진행 상황

| 단계 | 상태 | 비고 |
|---|---|---|
| 1차 주제 선정 (GAA-TFET) | ✅ 완료 → 폐기 | baseline 논문과 구조·수치 중복 발견으로 재검토 |
| GAA 나노시트 계열 반복 개선 | ✅ 완료 → 전체 폐기 | Halo Doping → 다중 에너지 Vt-Implant → WFM 비교까지 진행했으나 RDF 정량화 가능 여부 불확실 + 팀 내 양산성 이견으로 계열 전체 폐기 |
| 소자군 전면 재검토 | ✅ 완료 | 수상작 분석·심사기준·논문중복 배제·양산가능성 4기준으로 BSPDN/SiC/GaN/3D NAND/eMRAM/DRAM 등 교차검증 |
| GAA 파라미터 차등화 대안 5건 재검토 | ✅ 완료 | 비대칭/하이브리드 스페이서, 레이어별 워크펑션·게이트스택, 순차 스페이서 형성 — 전부 기존 문헌과 중복 확인돼 기각 |
| 최종 주제 확정 | ✅ 완료 | DRAM BCAT 코너 라운딩 + Elevated S/D 접합 결합 최적화 (GIDL·리텐션 개선) |
| 툴 환경 확인 | ✅ 완료 (GAA 시절 확보분) | 학교 라이선스 AdvancedTransportPackage 예제 3종 — BCAT 구조 재현 시 참고용으로 재검토 필요 |
| Baseline 구조 구현 | ⬜ 예정 | MDPI 2022 BCAT 논문 수치(Lgate 20nm, Drecess 120nm, AR 6.0, 게이트산화막 5nm, W게이트 WF 4.8eV) 기반, Sentaurus 재현 |
| 코너·접합 결합 DoE 설계 | ⬜ 예정 | Fin Fillet Radius × Elevated S/D 접합깊이·도핑농도 스윕 계획 수립 |
| 전기적 특성 추출 방법 확정 | ⬜ 예정 | SDevice에서 Vth, SS, GIDL, DIBL 추출 |
| 결합 최적화 시너지 정량화 | ⬜ 예정 | 개별 최적화 대비 결합 최적화의 추가 개선분 — 우리만의 기여 포인트 |
| 결과 정리·발표자료 | ⬜ 예정 | "완전 신규"가 아니라 "우리가 직접 검증한 조합"이라는 서사로 정직하게 구성 |

## 주제 선정 배경 (요약)

팀원 포트폴리오(TCAD PMOS 공정 최적화, 30/60nm NMOS Short Channel Effect 개선, QCLAS 반도체공학회 발표, LAS 공정 분석 프로젝트)를 바탕으로 소자/공정 분야 후보를 검토했다. POLARIS SIF·한국반도체학술대회(KCS)·삼성휴먼테크논문대상 수상작 11건을 분석한 결과, 1차 후보였던 "GAA + HKMG 최적화"는 이미 산업 표준 조합이라 독창성이 부족하다고 판단해 기각했다. 이후 GAA 나노시트 계열(TFET → Halo Doping → 다중 에너지 Vt-Implant → WFM 비교)로 여러 차례 방향을 다듬었으나, 핵심 결론 도출에 필요한 RDF 정량화가 학교 라이선스·컴퓨팅 자원으로 실제 가능한지 불확실해졌고, 팀 내부에서도 "양산 불가능할 수도 있는 주제"라는 회의적 시각이 제기되었다. 이에 기존 투입 노력과 무관하게 소자군 전체를 처음부터 재검토했다. 새 기준은 (1) 수상작 분석 기반 (2) 심사 기준(완성도·독창성·공학적 파급효과·발표) 기반 (3) 기존 단일 논문과 완전히 동일한 구조 배제 (4) 실제 양산 가능한 조건일 것, 네 가지였다. BSPDN(툴 미스매치), SiC/GaN 파워반도체(수상 전례 없음), 3D NAND(구조 복잡도), eMRAM(MTJ가 Sentaurus 표준 물리 밖) 등을 검토·기각했고, GAA 나노시트 파라미터 차등화 계열(비대칭/하이브리드 스페이서, 레이어별 워크펑션·게이트스택 등 5건)도 전부 기존 문헌과 중복 확인돼 기각했다. 최종적으로 DRAM 셀 트랜지스터(BCAT)가 SIF 2023·KCS 2025에서 이미 두 차례 수상한 카테고리이고, 이미 양산 중이며, Sentaurus 구현 baseline 논문(MDPI 2022)이 존재한다는 점에서 **BCAT의 코너 라운딩 + Elevated S/D 접합 결합 최적화**로 확정했다. 두 기법 개별로는 문헌에 존재하나 결합 검증 사례는 확인되지 않아 "완전 신규"는 아니라는 점을 정직하게 인정하고, 더 이상의 여백 찾기는 중단하고 실행 단계로 넘어가기로 했다. 자세한 과정은 [`docs/devlog.md`](docs/devlog.md) 참고.

## 저장소 구조

```
gaa-tfet-competition/
├── README.md
├── docs/
│   ├── devlog.md              # 날짜별 진행 로그
│   ├── devlog-template.md     # 새 로그 작성용 템플릿
│   └── references.md          # 참고 논문·수상작 링크
├── tcad/
│   ├── structure/              # SDE/SProcess 구조 스크립트
│   ├── sdevice/                 # 물리·바이어스 명령 파일
│   └── results/                 # Id-Vg 그래프, SVisual 캡처
├── figures/                     # 발표·보고서용 이미지
└── deliverables/                # 최종 포스터·발표자료
```

## 주의사항

- `.tdr` 등 대용량 구조/메시 파일은 `.gitignore`로 제외하고, 그래프·캡처 이미지와 코드·로그 위주로 커밋한다.
- 학교 Sentaurus 라이선스의 예제 코드(Applications_Library, AdvancedTransportPackage)를 그대로 올리지 않는다. 팀이 직접 작성·수정한 부분 위주로 커밋하고, 원본 예제는 출처만 표기한다.
