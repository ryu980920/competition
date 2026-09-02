# FinFET pMOS Embedded SiGe S/D의 응력 전달 특성 및 리세스 설계창 분석

2026 차세대반도체 경진대회 소자·공정 분야 결과 보고서 저장소다. 폭주기관차 팀(유용성·남다연·주수빈)은 Sentaurus TCAD를 이용해 Ge 조성과 S/D fin recess 깊이(FR)가 채널 응력·구동 성능·정전제어·누설에 미치는 영향을 분석했다.

## 최종 결과물

- **[최종 제출 보고서 PDF](docs/reports/경진대회_보고서.pdf)**: 최종 수치와 결론의 기준
- **[프로젝트 결과 요약](docs/reports/project-summary.md)**: 구조·평가 지표·상세 수치와 해석
- [최종 보고서 참고문헌](docs/references.md)
- [팀 실행·결과 공유 저장소 Share](https://github.com/ryu980920/Share)

## 무엇을 확인했는가

Ge 30·40·50·60·70%와 FR 0·10·20·30·35 nm를 조합한 **25개 격자점**에서 채널 응력과 전기 특성을 추출했다. 절대 응력·STE·Ioff의 2차원 지도 및 STE–SSlin trade-off overlay를 비교한 결과, 다음 양상을 확인했다.

- Ge 조성이 증가하면 절대 채널 응력과 구동 성능이 커지며 누설도 증가한다.
- 같은 Ge 조건에서 STE는 FR 약 20 nm까지 증가한 뒤 포화한다.
- FR이 더 깊어지면 추가 응력 이득은 작지만 SSlin·DIBL·Ioff 열화는 커진다.

Ge 50%에서 FR 15·22 nm를 추가 계산한 결과, **FR 15–20 nm**는 STE가 관측 최대값의 98.5–99.6%에 도달하고 gmSat이 최대가 되는 구간이었다. 반면 FR 20→22 nm에서는 STE가 거의 늘지 않는 동안 Ioff가 약 두 배 증가했다. 이를 근거로 본 TCAD 구조의 설계창을 **15–20 nm**로 제시했다.

STE는 고정 기준 `M = 180 GPa`와 Ge 조성으로 정규화한 비교 지표다. 상세 정의와 적용 범위는 [결과 요약](docs/reports/project-summary.md)에 정리했다.

## 개발 과정과 과거 기록

- [개발 로그](docs/devlog.md): 보고서 근거 재검토·수정·최종 산출을 포함한 날짜별 기록
- [주제 선정 이력](docs/topic-selection-history.md): 검토·기각한 주제와 전환 이유
- [검증 오류 회고](docs/retrospective.md): 문헌·AI 검색 결과의 재검증 기록
- [초기 조사·진행상황 아카이브](docs/archive/README.md)
- [이전 주제의 개발 로그](docs/devlog-archive-pre-finfet.md)
- [이전 프로젝트 자료](docs/old-projects/README.md)

과거 기록에는 당시의 가설과 미확정 해석을 보존했다. **현재 결론은 최종 PDF와 결과 요약을 따른다.** `docs/reports/`에는 최종 PDF와 결과 요약만 두며, 구버전 보고서는 Git 이력에서 확인할 수 있다.
