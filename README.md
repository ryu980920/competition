# GAA 나노시트 층별 차등 Vt-Implant 경진대회 프로젝트

차세대반도체 경진대회(소자/공정 부문) 출품 프로젝트. GAA 나노시트 적층 구조에서 시트 위치(top/middle/bottom)별로 발생하는 Vth·SS 편차(Inter-sheet Variation)를, 다중 에너지 이온주입 기반 층별 차등 Vt-Implant로 억제하는 것을 TCAD로 정량 검증한다.

- **팀 구성**: 3인
- **지원 분야**: ① 소자/공정
- **시뮬레이션 툴**: Synopsys Sentaurus TCAD (SProcess / SDevice / SVisual)

> **주제 전환 이력**: 이 프로젝트는 원래 "GAA-TFET(Line-Tunneling + 비대칭 도핑)"으로 시작했으나, baseline 논문 조사 중 구조·수치가 사실상 동일한 논문을 발견해 방향을 전환했다. 자세한 경위는 [`docs/devlog.md`](docs/devlog.md)의 2026-07-30 항목 참고.

## 진행 상황

| 단계 | 상태 | 비고 |
|---|---|---|
| 1차 주제 선정 (GAA-TFET) | ✅ 완료 → 전환 | baseline 논문과 구조·수치 중복 발견으로 재검토 |
| 주제 전환 (GAA + Vt-Implant) | ✅ 완료 | 층별 차등 Halo Doping 검토 → GAA엔 halo 적용 불가 확인 → 다중 에너지 blanket Vt-Implant로 최종 확정 |
| 툴 환경 확인 | ✅ 완료 | 학교 라이선스 AdvancedTransportPackage에서 관련 예제 3종 확보 |
| 예제 코드 분석 | ✅ 완료 | NSFET(3-stack), Nanowire SBTE, Nanowire NEGF 구조 스크립트 라인별 분석 (표준 MOSFET 구조라 현재 주제에 그대로 활용 가능) |
| Baseline 구조 구현 | ⬜ 예정 | Loubet 2017 / MDPI 2021 수치(Lg 25.8nm, 시트두께 6nm, 4층) 기반 |
| 균일 Vt-implant baseline 편차 정량화 | ⬜ 예정 | 시트별 Vth·SS 개별 추출, ΔVth/ΔSS 산출 |
| Analytic 프로파일 1차 검증 | ⬜ 예정 | 층별 차등 도핑의 전기적 효과 여부 확인 |
| 감도분석 | ⬜ 예정 | Energy/Dose/Anneal 중 편차 유발 요인 규명 |
| 다중 에너지 임플란트 역산 | ⬜ 예정 | 목표 프로파일을 실제 (Energy, Dose) 조합으로 구현 |
| 결과 정리·발표자료 | ⬜ 예정 | |

## 주제 선정 배경 (요약)

팀원 포트폴리오(TCAD PMOS 공정 최적화, 30/60nm NMOS Short Channel Effect 개선, QCLAS 반도체공학회 발표, LAS 공정 분석 프로젝트)를 바탕으로 소자/공정 분야 후보를 검토했다. POLARIS SIF·한국반도체학술대회(KCS)·삼성휴먼테크논문대상 수상작 11건을 분석한 결과, 1차 후보였던 "GAA + HKMG 최적화"는 이미 산업 표준 조합이라 독창성이 부족하다고 판단해 기각했다. 이후 "GAA 시트별 차등 Halo Doping"(구조 최적화)과 "GAA-TFET"(소자 동작원리 변경) 두 방향을 비교해 GAA-TFET으로 진행했으나, baseline 논문 조사 중 구조·수치가 거의 동일한 기존 논문을 발견해 원래 추천안이었던 "시트별 차등 도핑" 방향으로 복귀했다. 다만 Halo Doping은 GAA 릴리즈 후 구조에 물리적으로 적용할 수 없다는 것을 확인해, 다중 에너지 이온주입 기반 blanket Vt-Implant로 구현 방법을 최종 수정했다. 자세한 과정은 [`docs/devlog.md`](docs/devlog.md) 참고.

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
