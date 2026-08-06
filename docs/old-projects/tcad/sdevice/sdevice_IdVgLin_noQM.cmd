#setdep @previous@
## ============================================================
## [B1] 베이스라인 반영 - IdVgLin, 양자보정(eQuantumPotential) 제외 버전
## [B1] 본문 전체를 검색해도 "quantum" 관련 모델 언급이 전혀 없어, [B1]을 최대한
## 보수적으로 따르는 버전입니다. sdevice_IdVgLin.cmd(양자보정 포함판)와 같이
## 돌려서 Vth/SS 차이가 큰지 작은지 비교해보세요.
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
   ## [변경] eQuantumPotential 줄 제거 - [B1]이 언급하지 않은 모델
   Mobility (
      PhuMob
      Enormal ( Lombardi(AutoOrientation) )
      HighFieldSaturation
   )
   ## [수정] HighFieldSaturation(Canali)는 "Canali.so.linux64 없음" 에러로 실패 -> 인자 제거 (Canali는 기본 내장 공식)

   EffectiveIntrinsicDensity(OldSlotboom)
   Recombination(SRH(DopingDep _TAT_ ) Band2Band(Model=Hurkx))
   ## BTBT(GIDL) 모델은 eQuantumPotential과 완전히 별개 - 여기 그대로 유지

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
  ## [변경] eQuantumPotential 관련 Coupled 항 전부 제거 (고전적 drift-diffusion만)
  Coupled { Poisson Electron }


#--Ramp BitLine (BL) - 저전압(선형영역) 0.05V
Quasistationary(
     InitialStep= 5e-2 Increment= 1.35
     MinStep= 1e-8 MaxStep= 0.1
     Goal{ Name= "BL" Voltage= 0.05 }
  ){ Coupled { Poisson Electron } }
  #-- Sweep WL

  Quasistationary(
    InitialStep= 1e-3 Increment= 1.25 Decrement= 1.25
    MinStep= 1e-8 MaxStep= 0.05
    Goal { Name= "WL" Voltage= @<-0.05*_Vdd_>@ }
  ){ Coupled { Poisson Electron } }


  NewCurrentFile= "IdVgLin_"
  Quasistationary(
    DoZero
    InitialStep= 1e-3 Increment= 1.25
     MinStep= 1e-8 MaxStep= 0.05
     Goal{ Name= "WL" Voltage= _Vdd_ }
  ){ Coupled { Poisson Electron }
     CurrentPlot( Time=(Range= (0 1) Intervals= 40) )
   }
}
