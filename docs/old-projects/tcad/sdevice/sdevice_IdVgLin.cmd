#setdep @previous@
## ============================================================
## [B1] 베이스라인 반영 - IdVgLin (BL=0.05V, 저전압/선형영역 스윕)
## 원본(Synopsys SF_DRAM 예제 1번 Device) 대비 변경점:
##   - WL/PG 일함수 4.55 -> 4.8 eV ([B1] 명시값: "gate material was tungsten,
##     with the working function of 4.8 eV")
##   - Mobility 모델을 [B1]이 명시한 Philips unified + Lombardi + Canali로 교체
##     (원본은 IALMob + 일반 HighFieldSaturation)
##     *** 이 부분은 Sentaurus Device User Guide로 정확한 키워드를 한 번 더
##         확인하시는 걸 권합니다. 확신도는 높지만 100% 검증된 건 아닙니다. ***
##   - 나머지(Electrode, Solve 시퀀스)는 원본과 동일 - 우리 구조(BL/SC/WL/PG/substrate
##     컨택 이름)와 이미 맞아떨어짐
## ============================================================
#define _Vdd_  1.2
#define _TAT_ ElectricField(Lifetime=Hurkx)
Electrode{
  { Name= "SC"   	   Voltage= 0.0 }
  { Name= "BL"  	    Voltage= 0.0 }
  { Name= "WL"   	   Voltage= 0.0 workfunction= 4.8 }
  { Name= "PG"   	   Voltage= 0.0 workfunction= 4.8 }
  { Name= "substrate"       Voltage= 0.0 }
}
File{
  Grid= "@tdr@"
  Plot= "@tdrdat@"
  Parameter = "@parameter@"
  Current= "@plot@"
  Output= "@log@"
}
Physics {Fermi}
Physics (Material="Silicon") {
   eQuantumPotential(AutoOrientation density)
   Mobility (
      PhuMob
      Enormal ( Lombardi(AutoOrientation) )
      HighFieldSaturation
   )
   ## [변경] 원본: Enormal(IALMob(AutoOrientation)) + HighFieldSaturation
   ## [B1] 명시: "Philips unified mobility model" + Lombardi(계면 거칠기) + Canali(속도포화)
   ## [수정 2] HighFieldSaturation(Canali) 구문은 실행 시 "Canali.so.linux64를 찾을 수 없음" 에러 발생.
   ## Canali는 별도 로딩 플러그인이 아니라 HighFieldSaturation의 기본(내장) 공식이라 인자 없이 사용.

   EffectiveIntrinsicDensity(OldSlotboom)
   Recombination(SRH(DopingDep _TAT_ ) Band2Band(Model=Hurkx))
   ## BTBT(GIDL) 모델 - Band2Band(Model=Hurkx) - 원본 그대로 유지, [B1]과 일치

}
Plot{
*-Carrier Densities:
  eDensity hDensity
  * EffectiveIntrinsicDensity IntrinsicDensity
  * eEquilibriumDensity hEquilibriumDensity
*-Currents and current components:
  Current/Vector * eCurrent/Vector hCurrent/Vector
  * ConductionCurrent/Vector DisplacementCurrent/Vector
  * eMobility hMobility
  * eVelocity hVelocity
*-Fields, Potentials and Charge distributions
  ElectricField/Vector
  Potential
  SpaceCharge
*-Doping Profiles
  Doping

*-Band structure
  * BandGap
  * BandGapNarrowing
  * ElectronAffinity
  * ConductionBandEnergy ValenceBand
    eQuantumPotential hQuantumPotential
}
Math{
  Number_Of_Threads= 8
  Extrapolate
  Digits= 5
  Notdamped= 100
  Iterations= 20
  ExitOnFailure
  RHSMin= 1e-10
  RhsFactor= 1e20
  Method= ILS
  -CheckUndefinedModels

}
Solve{
  Coupled(Iterations= 100 LineSearchDamping= 1e-4 ){ Poisson eQuantumPotential }
  Coupled { Poisson Electron eQuantumPotential }


#--Ramp BitLine (BL) - 저전압(선형영역) 0.05V
Quasistationary(
     InitialStep= 5e-2 Increment= 1.35
     MinStep= 1e-8 MaxStep= 0.1
     Goal{ Name= "BL" Voltage= 0.05 }
  ){ Coupled { Poisson Electron eQuantumPotential } }
  #-- Sweep WL

  Quasistationary(
    InitialStep= 1e-3 Increment= 1.25 Decrement= 1.25
    MinStep= 1e-8 MaxStep= 0.05
    Goal { Name= "WL" Voltage= @<-0.05*_Vdd_>@ }
  ){ Coupled { Poisson Electron eQuantumPotential } }


  NewCurrentFile= "IdVgLin_"
  Quasistationary(
    DoZero
    InitialStep= 1e-3 Increment= 1.25
     MinStep= 1e-8 MaxStep= 0.05
     Goal{ Name= "WL" Voltage= _Vdd_ }
  ){ Coupled { Poisson Electron eQuantumPotential }
     CurrentPlot( Time=(Range= (0 1) Intervals= 40) )
   }
}
