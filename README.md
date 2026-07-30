# GAA 나노시트 초협소 시트 간격 영역의 다중 에너지 Vt-Implant 경진대회 프로젝트

차세대반도체 경진대회(소자/공정 부문) 출품 프로젝트. GAA 나노시트 적층 구조에서 시트 위치(top/middle/bottom)별로 발생하는 Vth·SS 편차(Inter-sheet Variation)를 억제하는 두 방식(업계 표준 WFM/다이폴 엔지니어링 vs 다중 에너지 이온주입 기반 층별 차등 Vt-Implant)을 비교하고, WFM이 문헌상 한계에 부딪히기 시작하는 **초협소 시트 간격 영역**에서 도핑 기반 접근이 RDF(Random Dopant Fluctuation) 증가라는 대가를 감안하고도 net으로 유효한 대안인지 TCAD로 정량 검증한다.

- **팀 구성**: 3인
- **지원 분야**: ① 소자/공정
- **시뮬레이션 툴**: Synopsys Sentaurus TCAD (SProcess / SDevice / SVisual)

> **주제 전환 이력**: 이 프로젝트는 원래 "GAA-TFET(Line-Tunneling + 비대칭 도핑)"으로 시작했으나, baseline 논문 조사 중 구조·수치가 사실상 동일한 논문을 발견해 방향을 전환했다. 이후 "시트별 차등 Halo Doping" → "다중 에너지 Vt-Implant" → (RDF 트레이드오프 발견) → "WFM 비교 도입" → "초협소 간격 유효 구간 검증"까지 여러 차례 다듬었다. 자세한 경위는 [`docs/devlog.md`](docs/devlog.md)의 2026-07-30 항목 참고.

## 진행 상황

| 단계 | 상태 | 비고 |
|---|---|---|
| 1차 주제 선정 (GAA-TFET) | ✅ 완료 → 전환 | baseline 논문과 구조·수치 중복 발견으로 재검토 |
| 주제 전환 (Halo Doping → Vt-Implant) | ✅ 완료 | GAA엔 halo 적용 불가 확인 → 다중 에너지 blanket Vt-Implant로 전환 |
| RDF 리스크 검토 및 WFM 비교 도입 | ✅ 완료 | 도핑 기반 보정의 RDF 트레이드오프 확인 → WFM/다이폴을 비교 기준선으로 도입 → 초협소 간격 영역으로 서사 재구성 |
| 대안 주제 교차검증 | ✅ 완료 | NCFET, Air-gap/Hybrid/Vacuum 스페이서, DRAM+듀얼 WFM 등 검토 후 전부 기존 문헌과 중복 확인돼 기각 |
| 최종 주제 확정 | ✅ 완료 | GAA 초협소 시트 간격에서의 다중 에너지 Vt-Implant vs WFM 유효 구간 검증 |
| 툴 환경 확인 | ✅ 완료 | 학교 라이선스 AdvancedTransportPackage에서 관련 예제 3종 확보 |
| 예제 코드 분석 | ✅ 완료 | NSFET(3-stack), Nanowire SBTE, Nanowire NEGF 구조 스크립트 라인별 분석 (표준 MOSFET 구조라 현재 주제에 그대로 활용 가능) |
| WFM 한계 간격 문헌 특정 | ⬜ 예정 | 몇 nm 이하부터 WFM이 문헌상 어려운지 구체화 (스윕 범위 설정용) |
| Baseline 구조 구현 | ⬜ 예정 | Loubet 2017 / MDPI 2021 수치(Lg 25.8nm, 시트두께 6nm, 4층, 간격 10nm) 기반 |
| 시트 간격 스윕 계획 | ⬜ 예정 | 10nm → 7 → 5 → 3nm 등으로 좁혀가며 baseline 구조 재생성 |
| 균일 Vt-implant baseline 편차 정량화 | ⬜ 예정 | 시트별 Vth·SS 개별 추출, ΔVth/ΔSS 산출 |
| Analytic 프로파일 1차 검증 | ⬜ 예정 | 층별 차등 도핑의 전기적 효과 여부 확인 |
| 감도분석 | ⬜ 예정 | Energy/Dose/Anneal 중 편차 유발 요인 규명 |
| RDF 정량화 | ⬜ 예정 | sIFM 등 통계적 방법으로 σVth 산출, 도즈별 트레이드오프 확인 |
| WFM 비교값 산정 | ⬜ 예정 | 문헌 기준값 + 필요시 SDevice 일함수 파라미터만으로 가벼운 검증 |
| 다중 에너지 임플란트 역산 | ⬜ 예정 | 목표 프로파일을 실제 (Energy, Dose) 조합으로 구현 |
| 결과 정리·발표자료 | ⬜ 예정 | 헤드라인은 항상 도핑 기반 접근의 개선 수치, RDF·WFM 비교는 근거 서사로 배치 |

## 주제 선정 배경 (요약)

팀원 포트폴리오(TCAD PMOS 공정 최적화, 30/60nm NMOS Short Channel Effect 개선, QCLAS 반도체공학회 발표, LAS 공정 분석 프로젝트)를 바탕으로 소자/공정 분야 후보를 검토했다. POLARIS SIF·한국반도체학술대회(KCS)·삼성휴먼테크논문대상 수상작 11건을 분석한 결과, 1차 후보였던 "GAA + HKMG 최적화"는 이미 산업 표준 조합이라 독창성이 부족하다고 판단해 기각했다. 이후 "GAA 시트별 차등 Halo Doping"과 "GAA-TFET" 두 방향을 비교해 GAA-TFET으로 진행했으나, baseline 논문 조사 중 구조·수치가 거의 동일한 기존 논문을 발견해 원래 추천안(시트별 차등 도핑)으로 복귀했다. Halo Doping은 GAA 릴리즈 후 구조에 적용 불가해 다중 에너지 Vt-Implant로 수정했고, 이 방법이 RDF를 악화시킨다는 리스크가 제기돼 검증한 결과 실재하는 트레이드오프임을 확인했다. RDF를 피하는 업계 표준 해법(WFM/다이폴)은 이미 우리 baseline 간격(10nm)에서 해결된 문제(2026년 논문 확인)라, 그보다 더 좁은 **초협소 간격에서 도핑 기반 접근이 유효한지 검증**하는 것으로 최종 방향을 좁혔다. Air-gap/Hybrid 스페이서, NCFET, DRAM+WFM 등 다른 대안들도 교차검증했으나 전부 기존 문헌과 중복이 확인돼 기각했다. 자세한 과정은 [`docs/devlog.md`](docs/devlog.md) 참고.

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
