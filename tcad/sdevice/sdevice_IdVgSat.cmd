#setdep @previous@
## ============================================================
## [B1] 베이스라인 반영 - IdVgSat (BL=1.2V, 고전압/포화영역 스윕)
## 이 결과의 off-state 전류(Ioff, WL~0V)가 우리 프로젝트의 GIDL 전류 지표입니다.
## 변경점은 IdVgLin과 동일 - WL/PG 일함수 4.55->4.8eV, Mobility 모델 [B1] 기준 교체.
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
   ## [변경] IdVgLin과 동일한 이유로 교체 (원본: IALMob + HighFieldSaturation)
   ## [수정 2] HighFieldSaturation(Canali)는 "Canali.so.linux64 없음" 에러로 실패 -> 인자 제거 (Canali는 기본 내장 공식)

   EffectiveIntrinsicDensity(OldSlotboom)
   Recombination(SRH(DopingDep _TAT_ ) Band2Band(Model=Hurkx))
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


#--Ramp BitLine (BL) - 고전압(포화영역) 1.2V = Vdd
Quasistationary(
     InitialStep= 5e-2 Increment= 1.35
     MinStep= 1e-8 MaxStep= 0.1
     Goal{ Name= "BL" Voltage= _Vdd_ }
  ){ Coupled { Poisson Electron eQuantumPotential } }
  #-- Sweep WL

  Quasistationary(
    InitialStep= 1e-3 Increment= 1.25 Decrement= 1.25
    MinStep= 1e-8 MaxStep= 0.05
    Goal { Name= "WL" Voltage= @<-0.05*_Vdd_>@ }
  ){ Coupled { Poisson Electron eQuantumPotential } }


  NewCurrentFile= "IdVgSat_"
  Quasistationary(
    DoZero
    InitialStep= 1e-3 Increment= 1.25
     MinStep= 1e-8 MaxStep= 0.05
     Goal{ Name= "WL" Voltage= _Vdd_ }
  ){ Coupled { Poisson Electron eQuantumPotential }
     CurrentPlot( Time=(Range= (0 1) Intervals= 30) )
   }
}
