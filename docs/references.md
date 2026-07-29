# 참고 자료

프로젝트 진행 중 정리한 조사·분석 자료 목록.

## 프로젝트 개요

- [GAA-TFET 프로젝트 개념 정리](reports/GAA-TFET_프로젝트_개념정리.docx) — 팀 내부 스터디용. 주제가 나온 배경(전력 문제 → 60mV/dec 한계), 에너지 밴드부터 시작하는 기초 개념, GAA·TFET 동작 원리, Point vs Line-Tunneling, Ambipolar 문제, 우리가 개선할 것과 정량 목표, 4주 검증 계획, 용어집.
- [TFET/GAA 물리 Q&A 정리](reports/GAA-TFET_QA_스터디노트.docx) — 위 개념정리 문서를 팀원들과 검토하며 나온 질의응답을 정리한 심화 스터디 노트. 동작전압/문턱전압부터 시작해 터널링이 실제로 일어나는 위치, MOSFET과의 접합부 비교, Point/Line-Tunneling의 표면·벌크 경로, 공핍층과 도핑 농도 관계, Ambipolar 방향, GIDL 등 MOSFET의 BTBT까지 다룸.

## 주제 선정

- [차세대반도체 경진대회 수상작 분석 및 추천 주제](reports/차세대반도체_경진대회_수상작분석_추천주제.docx) — POLARIS SIF·한국반도체학술대회(KCS)·삼성휴먼테크논문대상 수상작 11건 분석, 패턴 정리, 초기 추천 주제(GAA+HKMG) 재검토 및 최종 확정 주제(GAA-TFET) 근거.
- 수상작 원본 링크
  - [POLARIS SIF 2025 수상작품 전체보기](https://polargate.disu.ac.kr/contest/SIF2025/winner?sc=y) (로그인 필요)
  - [전자산란효과(Electron scattering)를 이용한 FET 전류 제어 방식 제안](https://polargate.disu.ac.kr/contest/SIF2025/winner?applyidx=255)
  - [Multiple-energy ion implantation을 이용한 9.6nm BCAT 설계](https://polargate.disu.ac.kr/contest/SIF2025/winner?applyidx=258)
  - [FinFET Architecture 기반 TFET 구조 제안](https://polargate.disu.ac.kr/contest/SIF2025/winner?applyidx=232)
  - [POLARIS SIF 2023 수상작품 전체보기](https://polargate.disu.ac.kr/contest/SIF2023/winner?sc=y) (로그인 필요)
  - [a-IGZO 전기적 특성 측정](https://polargate.disu.ac.kr/contest/SIF2023/winner?applyidx=84)
  - [KCS 2025 논문상 전체 목록](http://kcs.cosar.or.kr/2025/awards-2025.jsp)
  - [제32회 삼성휴먼테크논문대상 수상자 인터뷰](https://news.samsungsemiconductor.com/kr/미래를-설계하는-젊은-과학도들이-모인-현장-수상자-2)

## 이론 학습

- [GAA-TFET 학습 가이드](reports/gaa-tfet-learning-guide.md) — TFET vs MOSFET, BTBT, Point/Line-Tunneling, Ambipolar 핵심 개념과 우선순위 논문 목록, Sentaurus BTBT/양자구속 문법 정리, SVisual 코드 예시.

## 구조 코드 분석 (팀 분석 노트)

학교 Sentaurus 라이선스(AdvancedTransportPackage)의 예제 스크립트 3종을 팀이 직접 분석한 노트. **원본 코드는 학교 라이선스로만 열람 가능하며 여기에는 포함되어 있지 않습니다** — 아래 문서는 각 블록이 하는 일을 팀이 이해할 수 있도록 말로 풀어 설명한 것입니다.

- [NSFET 구조 코드 분석 및 적용 방안](reports/nsfet-code-analysis.md) — 3-stack 나노시트(코드 A) 구조 생성 스크립트 블록별 분석 및 TFET 전환 방안.
- [3개 구조 코드 비교분석](reports/three-codes-comparison.md) — 코드 A(NSFET) · B(Nanowire SBTE) · C(Nanowire NEGF) 구조·난이도·팀 활용 방안 비교.
- [코드 B·C 줄별 분석 비교](reports/code-bc-line-analysis.md) — Nanowire SBTE(B)와 NEGF(C) 블록별 비교, 좌표축 규약 차이, 팀 온보딩 순서 제안.
