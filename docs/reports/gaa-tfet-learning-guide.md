# GAA-TFET 실전 학습 가이드

이론보다 실행 — 1개월 준비용 핵심 개념·툴 스킬·문법·SVisual 코드 정리

> 대상: GAA·TFET을 처음 접하는 3인 팀 · 목표: Line-Tunneling GAA-TFET + 비대칭 도핑 Ambipolar 억제 구현

## 1. 핵심 개념 정리 + 추가 논문

### 1-1. 왜 TFET인가

일반 MOSFET은 열방출(Thermionic Emission)로 켜집니다. 게이트 전압을 아무리 세게 걸어도 캐리어가 볼츠만 분포를 따르는 한, 전류를 10배 늘리는 데 필요한 최소 전압(SS)은 상온에서 60mV/dec보다 작아질 수 없습니다. TFET은 밴드간 터널링(Band-to-Band Tunneling, BTBT)으로 켜지기 때문에 이 열역학적 한계를 물리적으로 돌파할 수 있습니다. 이게 팀이 이 주제를 고른 핵심 이유이자, 발표에서 가장 먼저 설명해야 할 내용입니다.

### 1-2. BTBT 동작 원리 — 최소 필요 지식

- TFET은 p-i-n 구조입니다 (MOSFET의 n-p-n/p-n-p와 반대). 소스(p+)-채널(진성)-드레인(n+) 순서입니다.
- 게이트 전압이 채널의 밴드를 끌어내려 소스의 가전자대(Valence Band)와 채널의 전도대(Conduction Band)가 에너지적으로 겹치면, 전자가 밴드갭을 "터널링"해서 넘어갑니다. 이때 정공은 소스 쪽에, 전자는 채널·드레인 쪽에 생성됩니다.
- 전류의 크기는 두 밴드가 겹치는 정도(터널링 접합 폭)와 터널링 접합의 면적에 달려있습니다 — 이 "면적"이 뒤에 나올 Line-Tunneling과 GAA 스택의 핵심 연결고리입니다.

### 1-3. Point-Tunneling vs Line-Tunneling

일반적인 TFET(Point-Tunneling)은 소스-채널의 수직 접합면(옆면)에서만 터널링이 일어나 접합 면적이 작습니다. Line-Tunneling은 게이트가 소스 위까지 겹치도록(Overlap) 설계해서, 게이트 아래 소스 표면 전체에서 터널링이 일어나게 만드는 방식입니다. 겹치는 길이(Lov)가 곧 터널링 면적이 되므로 On-전류를 크게 늘릴 수 있습니다. GAA는 시트마다 이 겹침 구조를 만들 수 있어 시트 수만큼 터널링 접합이 늘어난다는 게 팀 프로젝트의 핵심 주장입니다.

### 1-4. Ambipolar 누설과 비대칭 설계

TFET은 드레인 쪽에서도 원치 않는 반대 방향 터널링(Ambipolar Conduction)이 발생할 수 있습니다. 드레인 전압이 커지면 드레인-채널 접합에서도 밴드가 겹쳐 누설 전류가 흐르는 것으로, TFET의 대표적인 고질병입니다. 해법은 소스와 드레인을 비대칭으로 설계하는 것입니다 — 드레인 도핑 농도를 소스보다 낮추거나, 드레인 쪽 Spacer(게이트-드레인 언더랩)를 더 두껍게 만들어 드레인 쪽 밴드 겹침 자체를 억제합니다.

### 1-5. 우선순위 추천 논문 (읽는 순서대로)

| 순서 | 문헌 | 왜 이걸 먼저 읽는가 |
|---|---|---|
| 1 | Ionescu & Riel, "Tunnel field-effect transistors as energy-efficient electronic switches", Nature (2011) | TFET 분야에서 가장 널리 인용되는 개론 논문. 원리·장단점을 그림 위주로 설명해 처음 읽기 가장 좋음. |
| 2 | TCAD simulation of SOI TFETs and calibration of non-local BTBT model (ScienceDirect, 2012) | Sentaurus에서 BTBT 모델을 실측 데이터로 캘리브레이션하는 절차를 그대로 따라할 수 있음 (0단계 실습에 사용). |
| 3 | Performance Analysis of Vertically Stacked Nanosheet TFET with Ideal SS (ResearchGate) | GAA 멀티시트 스택이 Line-Tunneling TFET의 SS·Ion을 어떻게 개선하는지 정량 데이터 제공. |
| 4 | Syamal et al., "Effect of single HALO doped channel in tunnel FETs" (2010) | Halo 도핑을 TFET에 적용한 사례 — 팀 SCE 프로젝트의 Halo 경험과 연결해 Ambipolar 억제 아이디어를 보강할 때 참고. |

> 이론을 깊게 팔 시간이 없다면 1·2번만 정독하고, 3·4번은 필요한 수치나 그래프만 발췌해서 참고하는 것으로 충분합니다.

## 2. 툴 스킬을 익히기 위해 할 수 있는 것

### 2-1. 지름길: 나노와이어(원형)로 먼저 시작하세요

가장 중요한 실전 팁입니다. GAA 나노시트(사각형 단면)는 3D 구조를 직접 만들어야 해서 진입장벽이 높습니다. 반면 GAA 나노와이어(원형 단면)는 구조가 원통 대칭이라서, Sentaurus가 2D 반경 방향 단면(Radial Cross Section)을 축 중심으로 360도 회전시켜 자동으로 3D 원통형 소자를 만들어줍니다. 즉 2D 단면만 그리면 3D 나노와이어 GAA 소자가 완성됩니다. 팀이 이미 익숙한 2D 단면 작업 방식 그대로 GAA-TFET 첫 실습을 진행할 수 있다는 뜻입니다.

- 1주차 실습 목표: 나노와이어 구조로 MOSFET과 TFET을 각각 만들어 Id-Vg를 비교하고, TFET이 왜 SS가 더 가파른지 눈으로 확인.
- 이후 확장 목표: 같은 원리를 반복해 2~3층을 쌓거나(수직 방향 다중 배치), 최종적으로 나노시트(사각형)로 넘어가는 순서로 난이도를 서서히 올립니다.

### 2-2. 참고할 만한 공개 실습 자료

- [ETH Zürich, "Tunnel Field Effect Transistor (TFET)" 실습 과제 (PDF)](https://iis-people.ee.ethz.ch/~schenk/uebanl/english/tfet_20.pdf) — InAs 나노와이어 GAA MOSFET·TFET을 SDE 스크립트로 만들고 SVisual로 비교하는 전체 절차가 담긴 실제 대학 실습 자료. 그대로 따라 해보는 것을 강력 추천.
- [TCAD Sentaurus Tutorial (Sentaurus Device 모듈 목차)](https://ghzphy.github.io/Sentaurus_Training/sd/sd_menu.html) — Sentaurus Device의 각 기능별(메시, 물리모델, 브레이크다운 등) 튜토리얼 목차. 필요한 챕터만 골라 참고 가능.

### 2-3. 학교 라이선스에서 먼저 확인할 것

Sentaurus에는 Applications_Library라는 예제 프로젝트 모음이 기본 포함되어 있습니다. 설치 경로에서 Applications_Library 폴더를 열어 이름에 TFET, Nanosheet, GAA, Nanowire가 들어간 프로젝트가 있는지 먼저 확인하세요. 있다면 그 프로젝트를 열어 구조·Physics 섹션을 그대로 참고하는 것이, 백지에서 시작하는 것보다 훨씬 빠릅니다. 학교 조교나 담당 교수님께 "TFET 관련 Applications_Library 예제가 있는지" 여쭤보는 것도 좋은 방법입니다.

### 2-4. 실습 순서 요약

1. ETH 자료를 그대로 재현 (InAs 나노와이어 MOSFET vs TFET Id-Vg 비교)
2. 재료를 Si로 교체하고 BTBT 파라미터셋을 phonon-assisted로 변경 (3장 참고), 문헌 데이터와 대조해 캘리브레이션
3. 게이트-소스 오버랩을 추가해 Line-Tunneling 구조로 전환
4. 비대칭 도핑을 적용해 Ambipolar 억제 확인
5. 시간이 허락하면 나노시트 멀티스택으로 확장

## 3. 메쉬 설정 등 문법 자세한 정리

### 3-1. 두 가지 BTBT 모델 — 반드시 구분해서 이해해야 함

Sentaurus에는 BTBT를 계산하는 방식이 두 가지 있고, 이 둘을 헷갈리면 시간을 크게 낭비합니다.

| 모델 | 설정 방법 | 장점 | 한계 |
|---|---|---|---|
| Dynamic Nonlocal Path | Physics 섹션에 `Band2Band(Model=NonlocalPath)` 한 줄만 추가. 사용자가 메시를 직접 정의할 필요 없음(자동 경로 탐색) | 설정이 간단하고 안정적. ETH 실습 자료가 이 방식을 사용. | AC(소신호) 시뮬레이션을 지원하지 않음. Line-Tunneling처럼 복잡한 터널링 경로에서는 자동 탐색이 정확하지 않을 수 있음. |
| eBarrierTunneling + 사용자 정의 Nonlocal Mesh | Math 섹션에 NonLocal Mesh 블록을 직접 정의해야 함 (접합부에 별도 서브메시) | Line-Tunneling처럼 게이트-소스 오버랩 구조의 정확한 터널링 경로를 반영 가능 | 설정이 까다롭고, 실제로 연구자들도 자주 막히는 지점(3-3 참고) |

> 전략 제안: Point-Tunneling 베이스라인은 Dynamic Nonlocal Path로 빠르게 완성해서 "작동하는 결과"를 먼저 확보하고, Line-Tunneling은 시간이 남을 때 eBarrierTunneling 방식으로 도전하는 순서를 추천합니다. 아래 3-3에서 이유를 설명합니다.

### 3-2. Physics 섹션 코드 예시 (Dynamic Nonlocal Path, Si 기준)

아래는 ETH 실습 자료의 InAs 예제를 팀이 다룰 Si 기반 구조에 맞게 수정한 형태입니다. Si는 간접천이(indirect bandgap) 반도체라서 파라미터셋 이름이 InAs 같은 직접천이 물질과 다릅니다 — direct가 아니라 phonon-assisted를 씁니다.

```
Physics(Material = "Silicon"){
  Band2Band(Model=NonlocalPath
    ParameterSetName=( "phonon-assisted" ))
}

Physics{
  Recombination(
    SRH(DopingDependence Tunneling)
    Band2Band(Model=NonlocalPath
      ParameterSetName=("phonon-assisted"))
  )
  Fermi
  EffectiveIntrinsicDensity(OldSlotboom)
}
```

주의: 기본 파라미터 파일(`*.par`)에 BTBT 관련 파라미터가 없으면 시뮬레이션이 실패합니다. `sdevice -L <cmd파일명>` 명령으로 재료별 `.par` 파일을 먼저 생성하고, `Silicon.par` 안에 Band2Band 관련 섹션이 있는지 확인하세요 (ETH 자료 2장 참고).

### 3-3. Nonlocal Mesh 정의 (Line-Tunneling용) — 알려진 어려움

솔직하게 짚고 넘어가야 할 부분입니다. Line-Tunneling 구조에서 사용자 정의 Nonlocal Mesh를 설정하는 방법은 실제 연구자들 사이에서도 어려움을 겪는 지점입니다. ResearchGate에 "How to define non local mesh for TFETs based on line tunneling?"라는 질문이 있는데, 다른 연구자가 "저도 같은 문제로 막혀 있습니다"라고만 답했을 뿐 명확한 해결책이 공개적으로 없습니다. 즉 이 부분에서 막히는 건 팀의 실력 문제가 아니라 이 분야 자체의 알려진 난이도입니다.

기본 골격은 다음과 같습니다 (정확한 좌표·영역명은 본인 구조에 맞게 채워야 합니다):

```
Math{
  NonLocal("TunnelJunction"
    Region="channel" Interface="source/channel"
    Length=15e-9  Digits=6
  )
}
```

- `Region`: 터널링이 일어나는 쪽(채널)의 영역 이름
- `Interface`: 터널링 경로의 시작점이 되는 접합/계면 이름
- `Length`: 경로 탐색을 허용하는 최대 거리 (터널링 접합 폭보다 넉넉하게)

> 막히면: ① 학교 조교·교수님께 이 특정 이슈(Line-Tunneling Nonlocal Mesh)를 알고 계신지 먼저 여쭤보세요. ② Synopsys SolvNet(고객 지원 포털, 학교 라이선스로 접근 가능할 수 있음)에서 관련 사례를 검색하세요. ③ 최악의 경우 Point-Tunneling 결과만으로도 GAA 멀티시트의 이점(터널링 접합 수 증가)은 충분히 보여줄 수 있으니, Line-Tunneling을 백업 계획으로 남겨두세요.

### 3-4. 자주 발생하는 오류와 해결

| 오류 메시지 | 원인 | 해결 |
|---|---|---|
| No valid electron BarrierTunneling mass has been specified for region | 해당 재료의 `.par` 파일에 터널링 유효질량(mt) 값이 없음 | `sdevice.par` 또는 해당 `Material.par` 파일 끝에 `BarrierTunneling{ mt=0.xx }` 형태로 직접 추가 |
| Tunneling mass for interface coupled to a trap by BarrierTunneling is not specified | 계면(예: Si/SiO2)에도 터널링 질량이 필요한데 누락됨 | 해당 계면의 `Material1%Material2.par` 파일에 동일하게 `BarrierTunneling` 섹션 추가 |
| BTBT 전류가 비정상적으로 낮음(pA 수준) | reduced mass 등 캘리브레이션 파라미터가 기본값 그대로라 실제 물성과 안 맞음 | 1-5의 2번 논문 절차대로 문헌 실측 데이터에 맞춰 reduced mass를 피팅 |

### 3-5. 양자구속(Quantum Confinement) 모델 추가

나노시트/나노와이어는 채널 두께가 수 nm대라 양자구속 효과가 무시할 수 없습니다. Density Gradient(eQuantumPotential) 모델을 Physics와 Solve 양쪽에 추가해야 합니다.

```
Physics{
  eQuantumPotential(AutoOrientation Density Resolve)
}

Solve{
  Coupled(Iterations=100){ Poisson }
  Coupled{ Poisson Electron Hole eQuantumPotential }
  Quasistationary(
    InitialStep=1e-3 Increment=1.41
    MinStep=1e-6 MaxStep=0.02
    Goal{ Name="gate" Voltage=1.0 }
  ){ Coupled{ Poisson Electron Hole eQuantumPotential } }
}
```

> eQuantumPotential을 켜면 수렴이 느려질 수 있습니다. 전압 스텝(InitialStep)을 작게 시작해서 서서히 늘리는 방식(Increment=1.41 정도)이 안전합니다.

## 4. GAA를 SVisual로 다룰 때 코드

### 4-1. 구조 확인

```
# 구조 파일을 SVisual로 열기
svisual-<version> <프로젝트명>_msh.tdr &

# 예시 (ETH 자료 기준)
svisual-2014.09 nTFET_msh.tdr &
```

### 4-2. Band2Band Generation·전류밀도 시각화

구조를 연 뒤 왼쪽 패널에서 아래 항목을 선택해 시각화합니다.

- `eBand2BandGeneration` / `hBand2BandGeneration` — 전자·정공이 어디서 터널링으로 생성되는지 (터널링 접합 위치 확인용)
- `Abs(eCurrentDensity-V)` / `Abs(hCurrentDensity-V)` — 전류가 흐르는 경로. TFET은 MOSFET과 달리 소스 쪽에 정공 전류, 채널·드레인 쪽에 전자 전류가 나타나는 걸 확인하는 게 핵심 검증 포인트

### 4-3. 여러 bias step 연결해서 보기

```
# 여러 bias 지점에서 저장된 tdr 파일을 한 번에 열기
svisual-<version> nTFET_0000*_des.tdr &

# 창 안에서:
# 1) Ctrl+A로 전체 선택
# 2) 오른쪽 패널의 Link 아이콘 클릭
#    -> 여러 bias 지점을 하나의 컬러스케일로 비교 가능
```

### 4-4. Inspect로 SS·Id-Vg 추출

```
# I-V 데이터(.plt)를 Inspect로 열기
sentaurus inspect-<version> nMOSFET_des.plt nTFET_des.plt &

# 그래프 설정: X축 = 게이트 전압, 좌측 Y축 = 드레인전류(log scale)
# SS 계산식: SS = 1000 * (d log10(Id) / dVg)^-1   [mV/dec]
```

SS 곡선을 자동으로 뽑아주는 스크립트가 있다면 그대로 재사용하세요(예: `tfet_ss.sh` 같은 배치 파일). 없다면 Inspect에서 log(Id) 곡선을 그린 뒤 기울기의 역수를 구간별로 계산하는 방식으로 SS-Vg 곡선을 직접 만들 수 있습니다.

## 부록. 참고 링크

- [Ionescu & Riel, Tunnel FET 개론 논문 정보 (Nature, 2011)](https://www.nature.com/articles/nature10679) — 도서관/구글 스칼라에서 원문 검색
- [TCAD simulation of SOI TFETs and calibration of non-local BTBT model](https://www.sciencedirect.com/science/article/abs/pii/S0167931712003590)
- [ETH Zürich TFET 실습 PDF (SDE·SVisual 전체 절차)](https://iis-people.ee.ethz.ch/~schenk/uebanl/english/tfet_20.pdf)
- [TCAD Sentaurus Tutorial 목차 (Sentaurus Device)](https://ghzphy.github.io/Sentaurus_Training/sd/sd_menu.html)
- [How to define non local mesh for TFETs based on line tunneling? (ResearchGate)](https://www.researchgate.net/post/How-to-define-non-local-mesh-for-TFETs-based-on-line-tunneling)
- [Effect of single HALO doped channel in tunnel FETs (ResearchGate)](https://www.researchgate.net/publication/251990206_Effect_of_single_HALO_doped_channel_in_tunnel_FETs_A_2-D_modeling_study)
