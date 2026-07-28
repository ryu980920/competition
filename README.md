# GAA-TFET 경진대회 프로젝트

차세대반도체 경진대회(소자/공정 부문) 출품 프로젝트. GAA 나노시트 구조에 Line-Tunneling TFET을 적용해, 멀티시트 적층이 터널링 접합 면적과 SS(Subthreshold Swing)에 미치는 영향을 TCAD로 정량 검증한다.

- **팀 구성**: 3인
- **지원 분야**: ① 소자/공정
- **시뮬레이션 툴**: Synopsys Sentaurus TCAD (SProcess / SDevice / SVisual)

## 진행 상황

| 단계 | 상태 | 비고 |
|---|---|---|
| 주제 선정 | ✅ 완료 | GAA 나노시트 Line-Tunneling TFET + 비대칭 도핑 Ambipolar 억제 |
| 실현 가능성 검토 | ✅ 완료 | 단계별 확장 전략(Tier 0~3) 수립 |
| 툴 환경 확인 | ✅ 완료 | 학교 라이선스 AdvancedTransportPackage에서 관련 예제 3종 확보 |
| 예제 코드 분석 | ✅ 완료 | NSFET(3-stack), Nanowire SBTE, Nanowire NEGF 구조 스크립트 라인별 분석 |
| Baseline 구조 구현 | ⬜ 예정 | 코드 C(단순 나노와이어) 기반 |
| BTBT 모델 캘리브레이션 | ⬜ 예정 | 문헌 실측 데이터 기준 |
| p-i-n 도핑 전환 | ⬜ 예정 | 소스/드레인 반대 타입으로 분리 |
| Line-Tunneling 구현 | ⬜ 예정 | 게이트-소스 오버랩 + Nonlocal Mesh |
| 멀티시트 확장 | ⬜ 예정 | 코드 A(NSFET) 기반, nStack 스윕 |
| Ambipolar 억제 | ⬜ 예정 | 소스/드레인 비대칭 도핑·Spacer |
| 결과 정리·발표자료 | ⬜ 예정 | |

## 주제 선정 배경 (요약)

팀원 포트폴리오(TCAD PMOS 공정 최적화, 30/60nm NMOS Short Channel Effect 개선, QCLAS 반도체공학회 발표, LAS 공정 분석 프로젝트)를 바탕으로 소자/공정 분야 후보를 검토했다. POLARIS SIF·한국반도체학술대회(KCS)·삼성휴먼테크논문대상 수상작 11건을 분석한 결과, 1차 후보였던 "GAA + HKMG 최적화"는 이미 산업 표준 조합이라 독창성이 부족하다고 판단해 기각했다. 이후 "GAA 시트별 차등 Halo Doping"(구조 최적화)과 "GAA-TFET"(소자 동작원리 변경) 두 방향을 비교했고, 소자 자체를 바꾸는 방향이 경진대회 취지에 더 부합한다고 판단해 GAA-TFET, 그중에서도 GAA 멀티시트 구조와 구조적 시너지가 있는 Line-Tunneling 방식으로 최종 확정했다. 자세한 과정은 [`docs/devlog.md`](docs/devlog.md)의 첫 항목 참고.

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
