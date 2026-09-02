# FinFET pMOS Embedded SiGe S/D의 응력 전달 특성 및 리세스 설계창 분석

2026 차세대반도체 경진대회 소자·공정 분야 출품 프로젝트 저장소다. FinFET pMOS의 Embedded SiGe Source/Drain에서 Ge 조성과 S/D fin recess 깊이(FR)가 채널 응력, 구동 성능, 정전제어 및 누설에 미치는 영향을 Sentaurus TCAD로 분석했다.

- 팀: 폭주기관차 — 유용성 · 남다연 · 주수빈
- 시뮬레이션: Synopsys Sentaurus TCAD (SProcess / SDevice / SVisual)
- 기본 설계실험: Ge 30·40·50·60·70% × FR 0·10·20·30·35 nm = 25개 격자점
- 최종 제출본: [`docs/reports/경진대회_보고서.pdf`](docs/reports/경진대회_보고서.pdf)
- 최종 결과 요약: [`docs/reports/project-summary.md`](docs/reports/project-summary.md)
- 팀 실행·결과 공유 저장소: [`ryu980920/Share`](https://github.com/ryu980920/Share)

> 최종 수치와 결론은 PDF 제출본을 기준으로 한다. 개발 로그와 주제선정 이력은 당시의 판단 과정을 보존한 기록이므로 현재 결론과 다른 가설이나 미확정 표현이 남아 있을 수 있다.

---

## 연구 목적

Ge 조성과 FR을 각각 5수준으로 조합한 25개 조건을 계산하고, 동일한 설계공간에서 다음 세 지도를 비교했다.

1. 채널 압축응력 절대값 지도
2. Ge 조성 기반 명목 응력으로 정규화한 STE 지도
3. `Ioff_norm` 로그 지도

이를 통해 두 설계변수가 응력 이득과 전기적 손실에 어떻게 함께 작용하는지 확인하고, Ge=50%에서 FR=15 nm와 22 nm를 추가 계산해 20 nm 부근의 설계창 경계를 세분화했다.

---

## 기준 구조와 평가 지표

| 항목 | 값 |
|---|---:|
| Gate length | 25 nm |
| Fin height | 35 nm |
| Fin width (top / bottom) | 15 / 15 nm |
| S/D–channel lateral distance, Esd | 7.5 nm |
| S/D Boron concentration | 2 × 10²⁰ cm⁻³ |
| Channel concentration | 2 × 10¹⁸ cm⁻³ |
| VDD | 0.8 V |
| Gate workfunction | 4.623 eV |
| Channel / substrate orientation | ⟨110⟩ / (100) |

채널 응력은 ChFin 영역의 채널 길이 방향 체적평균값 `SlFin`으로 추출했다. 전기 특성은 `gmSat`, `IdSat_norm`, `SSlin`, `DIBL`, `Ioff_norm`으로 나누어 평가했다.

응력 전달 비교 지표는 다음과 같이 정의했다.

`STE = |σ_channel| / (M × 0.042 × x)`

- `x`: Ge 몰분율
- `0.042`: Si–Ge 격자 부정합의 선형 근사 계수
- `M = 180 GPa`: 모든 조건에 공통 적용한 고정 기준값

STE는 실제 stressor 내부 응력 대비 절대 전달률이 아니라 Ge 조성 기반 명목 응력으로 정규화한 비교 지표다. 따라서 최종 해석에서는 같은 Ge 조건 안에서 FR에 따른 증가와 포화 경향을 비교하는 데 사용했다.

---

## 핵심 결과

### 1. 25개 격자점에서 서로 다른 세 가지 양상이 나타났다

- 절대 채널 응력 지도는 Ge 방향의 변화가 크다. FR=0에서 Ge 30→70% 증가 시 채널 압축응력 절대값은 1.346→3.210 GPa로 약 2.38배 증가했다.
- STE 지도는 다섯 Ge 조건 모두 FR 0→20 nm에서 증가한 뒤 포화한다. FR=20 nm에서 0.667–0.672, FR=30–35 nm에서 0.668–0.677이었다.
- `Ioff_norm` 지도는 등고선이 대각 방향으로 나타난다. 낮은 FR에서는 Ge 영향이 보이고, FR=30–35 nm에서는 FR 영향이 지배적이다.

즉 Ge 조성은 채널 응력의 절대량을 크게 바꾸고, 같은 Ge 조건에서 FR은 채널에 전달되는 정도를 높인다. 누설은 두 변수의 영향을 함께 받는다.

### 2. Ge 조성 증가는 응력과 구동 성능을 높이고 누설을 증가시켰다

형상이 동일한 FR=0에서 Ge 30→70%로 증가했을 때:

- 채널 압축응력 절대값: 1.346→3.210 GPa
- `gmSat`: 약 19% 증가
- `IdSat_norm`: 약 34% 증가
- `SSlin`: 80.4→76.6 mV/dec로 개선
- `DIBL`: 89.3→69.3 mV/V로 개선
- `Ioff_norm`: 약 5.6배 증가

본 설계공간에서 Ge 조성 상향의 전기적 비용은 SSlin·DIBL 악화가 아니라 누설 증가로 나타났다.

### 3. FR 이득은 약 20 nm에서 포화하고 이후 전기적 손실이 커졌다

Ge=50% 세분화 계산 결과:

| FR (nm) | STE | gmSat (S/µm) | SSlin (mV/dec) | DIBL (mV/V) | Ioff_norm |
|---:|---:|---:|---:|---:|---:|
| 15 | 0.660 | 1.143×10⁻⁴ | 82.2 | 90.7 | 5.26×10⁻¹⁰ |
| 20 | 0.667 | 1.149×10⁻⁴ | 84.7 | 97.3 | 9.68×10⁻¹⁰ |
| 22 | 0.668 | 1.131×10⁻⁴ | 87.5 | 100.0 | 1.93×10⁻⁹ |

FR=20→22 nm에서 STE는 0.667→0.668로 거의 변하지 않았지만 `gmSat`은 감소하고 `Ioff_norm`은 약 2배 증가했다. FR=20→35 nm에서는 SSlin 84.7→112.9 mV/dec, DIBL 97.3→129.3 mV/V, `Ioff_norm` 약 108배 증가가 나타났다.

이에 본 구조의 FR 설계창을 **15–20 nm**로 정했다. 이 구간에서 STE는 Ge=50% 기준 최대값의 98.5–99.6%에 도달하고 `gmSat`은 FR=20 nm에서 최대가 되며, `Ioff_norm`은 10⁻⁹ 미만으로 유지된다.

### 4. deep-recess 열화는 리세스 형상 변화와 연관된다

Ge=50%에서 `Strain_Impact=0`으로 strain의 전기적 결합을 제거해도 FR 0→35 nm에서 SSlin은 31%, DIBL은 21% 악화되고 `Ioff_norm`은 약 42배 증가했다. 따라서 deep-recess 열화는 strain의 전기적 결합만으로 발생한 것이 아니라 리세스 형상 변화에서도 비롯된다.

FR 증가와 함께 DIBL이 78.7→129.3 mV/V로 증가하고 높은 drain 전압의 OFF-state 전류도 함께 커졌다. 이를 근거로 누설 증가는 drain coupling 강화와 정전제어 약화에 연관된 현상으로 해석했다.

### 5. fin 폭 결과는 두 조건 사이의 보조 민감도 분석이다

Wfin 15 nm와 7.5 nm를 비교하면 FR=0과 20 nm에서 좁은 fin의 SSlin·DIBL이 개선되고 STE가 9–10% 증가했다. 반면 Ge=60%, FR=30–35 nm에서 7.5 nm fin의 SSlin은 162.3–222.3 mV/dec로 크게 악화됐다.

이는 확인한 두 폭 조건에서 좁은 fin의 이득이 얕은 리세스 구간에 집중되고, deep-recess에서는 FR 상한을 지키는 것이 중요함을 보여주는 사례다.

---

## 최종 결론

본 프로젝트는 25개 Ge–FR 격자점에서 채널 응력과 여섯 개 전기 지표를 추출하고, 절대 응력·STE·누설의 2차원 지도를 같은 설계공간에서 비교했다. 그 결과 절대 응력은 Ge 방향으로 크게 증가하고, STE는 모든 Ge 조건에서 FR 약 20 nm까지 증가한 뒤 포화하며, 누설은 Ge와 FR의 영향을 함께 받는다는 서로 다른 양상을 확인했다.

Ge=50%에서 FR=15 nm와 22 nm를 추가 계산해 포화 경계를 세분화한 결과, FR=15–20 nm에서 대부분의 응력 전달 이득과 최대 `gmSat`을 확보하면서 SSlin·DIBL·Ioff의 급격한 열화를 피할 수 있었다. 따라서 본 구조의 최종 결과는 **응력 최대점이 아니라 이득의 포화와 전기적 손실의 증가를 함께 고려한 FR 15–20 nm 설계창**이다.

---

## 적용 범위

- STE의 절대값은 고정 기준 `M = 180 GPa`와 정규화 정의에 의존한다. 핵심 근거는 같은 Ge 조건에서 확인한 FR 증가·포화 경향이다.
- 구조는 이상적인 coherent SiGe epitaxy를 가정한다. Ge 70% 조건의 절대 응력을 양산 공정의 직접 권장값으로 사용하지 않는다.
- 15–20 nm는 본 TCAD 구조와 입력 조건에서 도출한 설계창이다.
- 공간적 누설 경로는 특정하지 않았다. 원인 해석은 DIBL 상승과 OFF-state 전류 증가로 확인한 drain coupling 및 정전제어 변화 범위에 한정한다.
- fin 폭 결과는 Wfin 15/7.5 nm와 Ge 60/70% 조건의 민감도 사례이며 일반적인 scaling law로 확대하지 않는다.

---

## 기록 문서

- [`docs/devlog.md`](docs/devlog.md): FinFET 전환 이후 날짜별 진행 기록
- [`docs/devlog-archive-pre-finfet.md`](docs/devlog-archive-pre-finfet.md): 이전 주제의 원본 로그
- [`docs/topic-selection-history.md`](docs/topic-selection-history.md): 검토·기각한 주제와 전환 이유
- [`docs/retrospective.md`](docs/retrospective.md): 문헌·AI 검색 결과의 재검증과 정정 기록
- [`docs/references.md`](docs/references.md): 참고문헌 및 검증 상태

`competition`은 주제 선정, 판단 근거, 검증 과정과 최종 해석을 보존하며, `Share`는 팀원이 시뮬레이션 조건·수치·그림을 공유한 실행 저장소다.
