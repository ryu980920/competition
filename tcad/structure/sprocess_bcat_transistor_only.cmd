#header
set CNode @node@
#rem #   LAYOUT
icwb filename= "DRAMCell_lyt.mac" scale= 1e-3
icwb domain= DCell
#endheader

## ============================================================
## [B1] Kim et al., Micromachines 2022, 13(9), 1476 베이스라인에 맞춘 개정판
## 원본: Synopsys SF_DRAM 예제 (31nm 노드, Chung 2006 / Lee 2008 / Schloesser 2008 계열)
## 변경 요약:
##   - BWH   0.155 -> 0.120   (Drecess = 120nm)
##   - SFE   -> Workbench 파라미터 @DBCAT@로부터 역산 (SFE=BWH-DBCAT-0.002)
##   - FH    0.05  -> 0.048   (Hfin = 48nm, [B1] 명시값)
##   - S/D 임플란트 dose -> Workbench 파라미터 @SDdoseScale@로 배율 조정
##   - GoxT  0.0035-> 0.005   (게이트 산화막 5nm)
##   - 초기 기판 도핑 1e15 -> 1e17 boron ([B1] 명시값)
##   - SFin 레지스트 트림 rate 0.002 -> 0.0057 (Lgate 32nm(as-drawn) -> 20nm)
##   - Halo 임플란트 비활성화 ([B1]에 halo 서술 없음, 순수 배경도핑+S/D만)
##   - #split @BL@, #split @SNC@ 통째로 제거 (커패시터/비트라인 BEOL 불필요 - 트랜지스터만)
##   - @WL@ 말미에 블랭킷 CMP 추가: S/D 표면의 실리콘을 노출시켜 컨택 확보
##   - DeviceMesh의 BL/SC 컨택을 Aluminum/TaN 박스 대신 실리콘 표면 point 컨택으로 교체
##   - S/D 도핑: analytic Gaussian 직접 지정을 시도했으나 문법 오류("Unknown parameter
##     type")로 실패, 검증된 3단 임플란트+RTA 방식으로 되돌림 (현재 비활성 상태로 보존)
##   - ElevatedSD 스위치(fset, 기본값 0) 신규 추가 - 1로 바꾸면 S/D 위에 에피 성장
##     단계가 추가됨 (DoE의 Elevated S/D 변수용, 지금 베이스라인 검증은 0으로 둘 것)
##
## 검증 필요 항목 (직접 눈으로 확인 전까지는 추정치입니다):
##   - Lgate 32nm 계산은 DRAMCell_lyt.mac의 WL 폴리곤 좌표를 손으로 측정한 값입니다.
##     트림 후 실제 리세스 바닥에서의 폭을 SVisual로 재서 20nm에 맞는지 확인하세요.
##   - Wfin(=17nm)은 STI 식각 각도(88, 78도)와 핀 라운딩 단계가 겹쳐 있어 손 계산이
##     어렵습니다. 한 번 돌려서 실제 폭을 재고 필요하면 STI 관련 rate를 조정하세요.
##   - Rfillet 라운딩 단계(etch 0.012/deposit 0.008)는 원본 예제의 Wfin=22nm 기준
##     값입니다. 우리 Wfin=17nm에서도 반원(Rfillet=1.0)에 가까운지 확인 안 됨.
##   - 임플란트+RTA 조합이 Djunction=48nm(1e17cm-3 지점)을 만드는지 실행 후
##     SVisual로 확인 필요. Gaussian 직접 지정은 문법 재확인 후 재시도 대상.
## ============================================================

## Geometry and Simulation Control
fset debug       1
fset fp          1.0
fset ReoxT       0.006
fset STI_Depth   0.3
fset STI_Tilt    88
fset GoxT   0.005   ;# [변경] Gate Oxide Thickness: 3.5nm -> 5nm ([B1] 명시값)
fset BWH    0.120   ;# [변경] Wordline depth = Drecess: 155nm -> 120nm ([B1] 명시값)
fset FH     0.048   ;# [변경] SaddleFin Height: 50nm -> 48nm (Hfin, [B1] 명시값)

## [신규] Workbench 스윕 변수 - project-plan.md 4장 2차원 DoE의 X축
## Workbench 프로젝트 화면에서 파라미터 이름 "DBCAT"을 추가하고,
## 실험(행)마다 0.024 / 0.030 / 0.036(공칭) / 0.042 / 0.048 값을 넣으면 됩니다.
fset DBCAT  @DBCAT@
fset SFE    [expr $BWH - $DBCAT - 0.002]   ;# DBCAT = BWH-SFE-0.002 역산
fset NiSiT  0.015   ;# NiSi thickness - BL/SNC 제거로 이 프로젝트에서는 미사용
fset PWL    0.088   ;# Word Line Pitch (레이아웃 유래, 그대로 둠)
fset LgTrim 0.0057  ;# [신규] SFin 레지스트 트림량: 편측 5.7nm (Lgate 32nm(as-drawn) -> ~20nm)

fproc WriteBND {} {
     global count
     global CNode

     struct tdr.bnd= n${CNode}_${count} !Gas
     incr count
}
fset count 1

# Domain initialization
fset sim_top    0.0
fset sim_bottom 0.8
fset sim_left   [icwb bbox left ]
fset sim_right  [icwb bbox right]
fset sim_back   [icwb bbox back ]
fset sim_front  [icwb bbox front]
fset spac_y     [expr ($sim_right-$sim_left)/4.0]
fset spac_z     [expr ($sim_front-$sim_back)/4.0]
fset WW   [expr $sim_right - $sim_left]     ;# Cell Width, um
fset WL   [expr $sim_front - $sim_back]     ;# Cell Length,um

line x loc= $sim_top                tag= top
line x loc= $sim_bottom             tag= bot
line y loc= $sim_left   tag= left   spac= $spac_y
line y loc= $sim_right  tag= right  spac= $spac_y
line z loc= $sim_back   tag= back   spac= $spac_y
line z loc= $sim_front  tag= front  spac= $spac_y

region Silicon xlo= top xhi= bot ylo= left yhi= right zlo= back zhi= front substrate
init concentration= 1e17 field= Boron wafer.orient= {0 0 1} notch.direction= {1 1 0} !DelayFullD
## [변경] 1e15 -> 1e17: [B1]이 명시한 기판/바디 배경 도핑(1e17 cm-3 boron)에 맞춤

source MaterialParams_sp.tcl

# General control
AdvancedCalibration
math numThreads= 4
math coord.ucs

# pdb settings ---------------------------------------------------------
pdbSet InfoDefault 1
pdbSet Mechanics StressHistory 0
pdbSet Mechanics EtchDepoRelax 0
pdbSet ImplantData ResistSkip 1
pdbSet ImplantData LeftBoundary Reflect
pdbSet ImplantData RightBoundary Reflect
pdbSet ImplantData BackBoundary Reflect
pdbSet ImplantData FrontBoundary Reflect

# meshing strategy ----------------------------------------------------------------------
mgoals resolution= 1.0/3.0 accuracy= 1e-4 repair.angle= 2.0
grid set.min.normal.size= 0.005 \
     set.normal.growth.ratio.3d= 4.0 \
     set.min.edge= 1e-7 \
     set.max.points= 10000000 \
     set.max.neighbor.ratio= 1e6
pdbSet Grid SnMesh max.box.angle.3d 175

refinebox name= GlobalInt \
   min= " $sim_top-0.01 $sim_left $sim_back " max= " $sim_bottom $sim_right $sim_front " \
   min.normal.size= 0.005 normal.growth.ratio= 2.0 interface.materials= {Silicon Oxide}
refinebox name= Global1 \
   min= " -0.01 $sim_left $sim_back-0.001 " max= " $sim_bottom $sim_right $sim_front " \
   xrefine= "0.05/$fp"  yrefine= "0.04/$fp" zrefine= "0.05/$fp"

## ---- Pad Oxide -----
deposit material= {Oxide} type= isotropic rate= 1.0 time= 0.04
if { $debug } { WriteBND }

## ---- Nitride Deposition -----
deposit material= {Nitride} type= isotropic rate= 1.0 time= 0.10
temp_ramp name= liner time= 5  temp= 600.0 ramprate= 0.6667
temp_ramp name= liner time= 10 temp= 800.0 hold
temp_ramp name= liner time= 5  temp= 800.0 ramprate= -0.6667
diffuse temp_ramp= liner info= 1

## (split 제거됨 - STI 단계 시작)
icwb.create.mask layer.name= "Active" name= ACTIVEn polarity= negative
photo mask= ACTIVEn thickness= 0.2
if { $debug } { WriteBND }
etch material= {Photoresist} type= isotropic rate= {0.005}  time= 1.1
if { $debug } { WriteBND }

## ---- STI Etching -----
etch material= {Nitride} type= anisotropic rate= {0.1}  time= 1.1
etch material= {Oxide}   type= anisotropic rate= {0.04} time= 1.1
if { $debug } { WriteBND }
strip Photoresist
strip nitride
etch    material= {Oxide} type= isotropic rate= {0.007} time= 1.0
deposit material= {Oxide} type= isotropic rate= {0.007} time= 1.0 selective.materials= Oxide
if { $debug } { WriteBND }
etch material= {Silicon} type= trapezoidal time= 1.0 rate= $STI_Depth angle= $STI_Tilt roundness= 3.0
if { $debug } { WriteBND }
deposit material= {Oxide2} type= isotropic rate= {0.0005} time= 1.0
etch material= {Oxide2} type= anisotropic rate= 0.001  time= 1.0
etch material= {Silicon} type= trapezoidal time= 1.0 rate= {0.22} angle= 78
if { $debug } { WriteBND }
strip Oxide2
strip Oxide
if { $debug } { WriteBND }
etch    material= {Silicon} type= isotropic rate= 0.005 time= 1.0
deposit material= {Silicon} type= isotropic rate= 0.005 time= 1.0 selective.materials= {Silicon}
if { $debug } { WriteBND }
deposit material= {Oxide} type= isotropic rate=$ReoxT  time= 1.0
deposit material= {Nitride2} type= fill coord= -0.004
etch    material= {Nitride2 Oxide} type= cmp coord= -0.003
deposit material= {Oxide}  type= anisotropic rate= {0.0045} time= 1.0
if { $debug } { WriteBND }

## (split 제거됨 - SFin 단계 시작)
## -- Saddle FIN ----
icwb.create.mask layer.name= "WL" name= BWL polarity= positive
photo mask= BWL thickness= 0.05
deposit material= Photoresist type= isotropic time= 1.0 rate= $LgTrim selective.materials= {Photoresist}
## [변경] rate 0.002 -> $LgTrim(0.0057): WL as-drawn 폭 32nm(레이아웃 실측) 기준
##        편측 5.7nm 트림 -> Lgate ~20nm 목표. 실행 후 SVisual로 재확인 권장.
if { $debug } { WriteBND }
etch material= {Silicon Oxide Nitride2} type= trapezoidal rate= {$BWH} time= 1.0 angle= 87.0
if { $debug } { WriteBND }
deposit material= {Oxide2} type= isotropic   time= 1.0 rate= 0.0002
etch   material= {Oxide2} type= anisotropic time= 1.0 rate= 0.001
if { $debug } { WriteBND }
etch material= {Nitride2 Oxide} type= trapezoidal  rate= {$FH} time= 1.2 angle= 86.0
strip Oxide2
if { $debug } { WriteBND }
etch material= {Nitride2 Oxide} type= isotropic rate= {0.007 0.007} time= 1.0
if { $debug } { WriteBND }
## ---- Control the rounding of the Saddle Fin -----
## Rfillet은 이번 프로젝트 변수가 아니므로 원본 값 그대로 둠(적당히 둥글면 충분)
etch    material= {Silicon} type= isotropic rate= 0.012 time= 1.0
if { $debug } { WriteBND }
deposit material= {Silicon} type= isotropic rate= 0.008 time= 1.0 selective.materials= {Silicon}
if { $debug } { WriteBND }
strip Photoresist
deposit material= {Oxide} type= isotropic rate= $GoxT time= 1.0
if { $debug } { WriteBND }

## (split 제거됨 - SD 단계 시작)
refinebox name= SFin1 \
 min= " 0.001 $sim_left $sim_back-0.001 " max= " 0.225 $sim_right $sim_front " \
 xrefine= " 0.0075/$fp "  yrefine= " 0.005/$fp " zrefine= " 0.005/$fp " Silicon

## ---- Halo Implant: [B1]은 halo를 서술하지 않으므로 비활성화 ----
## (필요 시 아래 4줄 주석 해제)
# implant Boron energy= 56 dose= 4.1e13 tilt= 30 rotation= 0.0
# implant Boron energy= 56 dose= 4.1e13 tilt= 30 rotation= 90.0
# implant Boron energy= 56 dose= 4.1e13 tilt= 30 rotation= 180.0
# implant Boron energy= 56 dose= 4.1e13 tilt= 30 rotation= -90.0

# SD Implant / Doping
## [변경] [B1] 원문: "counter-doped with 1e20 cm-3 arsenic. Note that the Gaussian
## doping profile was used." -> 실제 이온주입+RTA 대신 analytic Gaussian 직접 지정으로 교체.
## *** doping 명령의 정확한 문법(특히 characteristic/peak.location 정의 방식)은
##     Sentaurus Process User Guide로 꼭 재확인하세요. 지금은 초안입니다. ***
## characteristic(시그마 유사) 값 0.020은 임시값입니다. 실행 후 SVisual로 Djunction을
## 재고 48nm(=0.4*Drecess)에 안 맞으면 이 값을 늘리거나 줄여서 재조정하세요.

fset ElevatedSD 0   ;# [신규 스위치] 0=베이스라인 검증(평면 S/D, [B1] 그대로)
                    ;# 1=Elevated S/D(에피 성장 후 저도핑) - DoE 단계에서 사용
                    ;# 지금은 0으로 둔 채 베이스라인부터 검증하세요.

icwb.create.mask layer.name= "WL" name= SD polarity= negative
photo mask= SD thickness= 0.25

if { $ElevatedSD } {
  ## Elevated S/D: 노출된 S/D 실리콘 위에 에피 실리콘을 추가로 성장(선택적 증착)
  ## rate/time은 임시값 - 목표 융기 높이에 맞춰 조정 필요
  deposit material= {Silicon} type= isotropic rate= 0.010 time= 1.0 selective.materials= {Silicon}
  if { $debug } { WriteBND }
}

## [신규] Workbench 스윕 변수 - project-plan.md 4장 2차원 DoE의 Y축(도핑농도)
## Workbench 프로젝트 화면에서 파라미터 이름 "SDdoseScale"을 추가하고,
## 실험(행)마다 0.3 / 0.5 / 0.7 / 1.0(공칭) 값을 넣으면 됩니다 (베이스라인 대비 배율).
## [원복] doping Gaussian 명령이 문법 오류("Unknown parameter type")로 실패해서
## 검증된 임플란트+RTA 방식으로 되돌립니다. Gaussian 프로파일 직접 지정은
## Sentaurus Process User Guide로 정확한 문법을 확인한 뒤 다시 시도하세요.
# doping field= Arsenic type= Gaussian conc= [expr 1.0e20*@SDdoseScale@] \
#     peak.location= 0.0 characteristic= 0.020 material= Silicon
# strip Photoresist

implant Arsenic energy= 10 dose= [expr 1.0e15*@SDdoseScale@] tilt= 0 rotation= 0
implant Arsenic energy= 30 dose= [expr 1.0e15*@SDdoseScale@] tilt= 0 rotation= 0
implant Arsenic energy= 45 dose= [expr 1.0e15*@SDdoseScale@] tilt= 0 rotation= 0
struct tdr= n@node@_asImp
strip Photoresist
temp_ramp name= rta temp= 600  time= 2.0<s> ramprate= (900-600)/2.0
temp_ramp name= rta temp= 900  time= 1.0<s> ramprate= (1050-900)/1.0
temp_ramp name= rta temp= 1050 time= 0.5<s> ramprate=  0.0
temp_ramp name= rta temp= 1050 time= 5.0<s> ramprate= (800-1050)/5.0
temp_ramp name= rta temp= 800  time= 2.0<s> ramprate= (800-600)/2.0
diffuse delT= 50.0 temp_ramp= rta
# -------------------------------------------------------------------- #
SetPlxList { BTotal AsTotal }
WritePlx n@node@_anneal.plx y= [expr $WW/2.0] z= [expr $WL/2.0]
# -------------------------------------------------------------------- #

## (split 제거됨 - WL 단계 시작)
refinebox name= SFin2 \
   min= " 0.025 $sim_left $sim_back-0.001 " max= " 0.15 $sim_right $sim_front " \
   refine.fields= { NetActive } def.max.asinhdiff= 1.0 \
   refine.max.edge= " 0.05/$fp  0.05/$fp  0.05/$fp" \
   refine.min.edge= " 0.003/$fp 0.003/$fp 0.003/$fp" adaptive Silicon
deposit material= {TiN} type= isotropic rate= 0.0025 time= 1.0
deposit material= { Tungsten } type= fill coord= $BWH-$SFE-0.002
if { $debug } { WriteBND }
etch material= {TiNitride TiN} type= cmp coord= $BWH-$SFE-0.002
if { $debug } { WriteBND }
## [수정 1] 원본의 NitridePECVD/OxideCVD/OxideTEOS는 Sentaurus 표준 재질명이 아니라서
## SDevice가 TDR을 읽을 때 "material name not found in DATEX" 에러가 남. 원래 이 별칭들은
## BL/SNC(비트라인/스토리지노드) 선택적 식각을 위한 구분용이었는데, 그 단계를 통째로
## 삭제했으므로 구분할 필요가 없어져서 표준 재질명(Nitride/Oxide)으로 통일.
## [수정 2] 4단계로 나눠 같은 이름(Nitride/Oxide)을 반복 증착하니 서로 다른 증착 방식
## (isotropic/fill/anisotropic) 경계에서 얇은 슬리버가 생겨 메쉬 생성이 특정 지점에서
## 수렴하지 못하는 문제 발생(short edge 경고 반복). [B1]도 "질화막 캡"이라고만 서술하므로
## 표면(x=0)까지 한 번에 채우는 단일 증착으로 단순화 - 애매한 내부 경계 자체를 제거.
deposit material= {Nitride} type= fill coord= 0.0
if { $debug } { WriteBND }

## [신규] 블랭킷 CMP: 단일 fill이 이미 x=0(표면)까지 채워서 사실상 평탄하지만,
## 안전하게 한 번 더 깎아 S/D 위 실리콘 노출을 확실히 함. 게이트 위 DBCAT 캡은 그대로 남음.
etch material= {Oxide Nitride} type= cmp coord= 0.0
if { $debug } { WriteBND }

## ===== 원본의 #split @BL@ (비트라인 금속화), #split @SNC@ (스토리지 노드 컨택) =====
## ===== 전체 삭제. 커패시터/BEOL은 우리 프로젝트(Id-Vg/Id-Vd, GIDL 추출)에 =====
## ===== 필요 없음 - 트랜지스터 구조만으로 충분 (project-plan.md 4장 참고)     =====

## (split 제거됨 - DeviceMesh 단계 시작)
refinebox clear
line clear
fset fd 1.0
# Set very high values for adaptive meshing parameters
pdbSet Grid AdaptiveField Refine.Abs.Error     1e37
pdbSet Grid AdaptiveField Refine.Rel.Error     1e10
pdbSet Grid AdaptiveField Refine.Target.Length 100.0
pdbSet Grid SnMesh max.box.angle.3d 179
select PolySilicon z= 1.0e20 name= NetActive store
# Refinement strategy
grid Adaptive set.Delaunay.type= boxmethod \
     set.max.points= 10000000 set.max.neighbor.ratio= 1e6 \
     set.min.normal.size= 0.005/$fd set.normal.growth.ratio.3d= 4.0
refinebox name= Device \
  min= " -0.1 $sim_left $sim_back-0.001 " max= " $sim_bottom $sim_right $sim_front " \
   refine.fields= { NetActive } def.max.asinhdiff= 1.0 \
   refine.max.edge= " 0.2/$fd    0.2/$fd    0.2/$fd" \
   refine.min.edge= " 0.008/$fd  0.008/$fd  0.008/$fd" adaptive Silicon
refinebox name= DeviceSD \
   min= " 0.04 $sim_left $sim_back " max= " 0.25 $sim_right $sim_front " \
   refine.fields= { NetActive } def.max.asinhdiff= 1.0 \
   refine.max.edge= " 0.1/$fd   0.1/$fd   0.1/$fd" \
   refine.min.edge= " 0.003/$fd  0.003/$fd  0.003/$fd" adaptive Silicon

refinebox name= Device_IF \
   min= "-0.001 $sim_left $sim_back" max= "$BWH+$SFE+0.2 $sim_right $sim_front" \
   min.normal.size= 0.0025 normal.growth.ratio= 2.0 \
   interface.materials= {Silicon Oxide}

## Trap near SF-Gate Region (Row Hammer 확장용 - 지금 당장은 안 써도 무해하게 남겨둠)
mater add name= SiTr new.like= Silicon alt.matername= Silicon
polygon name= TrapC min= { 0.012 0.018 } max= { 0.05 0.08 } rectangle
polyhedron name=SFTrap polygons= TrapC min=$SFE max=0.22
insert polyhedron= SFTrap replace.materials= {Silicon} new.material= SiTr new.region= SiTr_1
# Refinement for Trap Region
refinebox name= "SiTr_IF" \
   min= " $SFE $sim_left $sim_back-0.001 " max= " 0.25 $sim_right $sim_front " \
   min.normal.size= 2.0e-3 normal.growth.ratio= 1.5 \
   interface.materials = {SiTr Oxide}
grid remesh

# square contact size on interface; contact border must be within contact interface(s) to avoid crash.
set contact_size   0.012
set contact_offset 0.012

## [변경] 원본은 Aluminum_1(BL)/TaN_1(SC) 박스 컨택 - BEOL 제거로 더 이상 존재하지 않음.
## 대신 블랭킷 CMP로 노출된 S/D 실리콘 표면에 직접 point 컨택을 잡음.
## 원본 박스의 y/z 중심 좌표(WW/1.75, 0.018 / WW/4.0, 0.1)는 그대로 재사용 -
## 그 위치가 실제 S/D 영역 위였다는 근거이므로. x만 표면(0.001, 실리콘 안쪽으로 1nm)으로 변경.
## *** 실행 후 SVisual로 이 두 점이 실제로 Silicon(도핑된 S/D) 위에 있는지 꼭 확인 ***
contact name= "BL" point x= 0.001 y= [expr $WW/1.75] z= 0.018 Silicon !replace
contact name= "SC" point x= 0.001 y= [expr $WW/4.0]  z= 0.1   Silicon !replace

contact name= "WL" point x= [expr $BWH-$SFE/2.0] y= $WW/2.0 z= $PWL/2.0 Tungsten !replace
contact name= "PG" point x= [expr $BWH-$SFE/2.0] y= $WW/1.5 z= [expr $sim_front-0.005] Tungsten !replace
contact  name= substrate Silicon bottom !replace
struct tdr= n@node@
exit
