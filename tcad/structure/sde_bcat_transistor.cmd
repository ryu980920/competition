;=====================================================================
; [B1] Kim et al., Micromachines 2022, 13(9), 1476 -- BCAT 새들핀 3D 구조
; Sentaurus Structure Editor(SDE) Scheme 스크립트
;
; project-plan.md 4-1절 결정("구조 생성 도구 선택 - SProcess가 아니라 SDE")에
; 따라 작성. tcad/structure/sprocess_bcat_transistor_only.cmd(SProcess 버전)는
; 오늘의 디버깅 학습 기록으로 남기고, 실제 최종 구조는 이 파일을 기준으로 함.
;
; *** 중요 경고 ***
; 학교 라이선스에 BCAT/DRAM 전용 SDE 예제가 없어(project-plan.md 4-2절 확인
; 결과), 실제 동작하는 예제를 고쳐 쓴 게 아니라 Synopsys 공식 SDE 튜토리얼
; (ghzphy.github.io/Sentaurus_Training/sde/ sde_2/3/5/6.html)에서 확인한
; 검증된 문법 패턴만 조합해 처음부터 작성한 초안입니다.
; 문법 자체는 튜토리얼 예시와 일치하지만, "이 조합으로 새들핀 형상이 의도대로
; 나오는가"는 전혀 검증되지 않았습니다. SDE는 GUI로 각 단계를 누적해서 바로
; 눈으로 확인할 수 있으니(SProcess처럼 끝까지 돌려야 결과를 보는 게 아님),
; 처음 실행할 때는 이 스크립트를 한 번에 다 돌리지 말고 섹션 단위로(1->2->3...)
; 끊어서 GUI에서 확인하며 진행하는 것을 강력히 추천합니다.
;
; ★ 표시는 [B1] 원문에 없어 제가 임의로 정한 값/근사입니다 - 팀 검토 후 조정.
;=====================================================================

(sde:clear)
(sdegeo:set-auto-region-naming OFF)

;--- [B1] 명시 치수 (docs/references.md 원문 대조 완료) ----------------
(define Lgate     0.020)   ; 물리적 게이트 길이 20nm
(define Drecess   0.120)   ; 리세스 깊이 120nm (AR = Drecess/Lgate = 6.0, [B1] 일치)
(define Wfin      0.017)   ; 새들핀 폭 17nm
(define Hfin      0.048)   ; 새들핀 높이 48nm
(define GoxT      0.005)   ; 게이트 산화막 두께 5nm
(define Djunction 0.048)   ; S/D 접합 깊이 48nm (= 0.4 * Drecess, [B1] 명시)
(define SDpeak0   1e20)    ; S/D 비소 피크 농도 1e20cm-3 (baseline, Gaussian)
(define BodyDop   1e17)    ; 기판/바디 붕소 배경 도핑 1e17cm-3
; 참고: 게이트 워크펑션(4.8eV Tungsten)은 구조 파라미터가 아니라 SDevice
; Electrode 설정값이라 여기 없음 (sdevice_IdVg*.cmd에 이미 반영됨)

;--- Workbench 스윕 변수 (project-plan.md 4-4절 2차원 DoE) -------------
(define DBCAT        @DBCAT@)        ; X축: 질화막 캡 두께, 24~48nm(공칭 36nm)
(define SDdoseScale  @SDdoseScale@)  ; Y축: S/D 도즈 배율, 0.3~1.0(공칭 1.0)
(define SDpeak (* SDpeak0 SDdoseScale))

;--- ★설계 가정 - [B1]에 없는 값, 임의 결정★ ---------------------------
(define Wcell     0.100)  ; 시뮬레이션 도메인 X폭(핀 폭 방향) - STI 여유 포함
(define Lcell     0.300)  ; 시뮬레이션 도메인 Y길이(소스-게이트-드레인 방향)
(define SubBot   -0.400)  ; 기판 바닥 Z(음수=깊이) - Drecess(0.12)보다 충분히 깊게
(define LatFactor 0.8)    ; S/D Gaussian 측면 확산 계수 - SDE 튜토리얼 예시값 그대로 사용
; ★STI 트렌치 깊이 = Hfin으로 단순화(핀이 STI 위로 솟은 높이와 동일하다고 가정)

;--- Elevated S/D 스위치 (SProcess 버전과 동일한 설계, DoE 단계용) -------
(define ElevatedSD 0)      ; 0=베이스라인([B1] 그대로 평면 S/D), 1=에피 성장+저도핑
(define EpiHeight  0.020)  ; ★임의값 - 목표 융기 높이. 지금은 0으로 두고 베이스라인 검증.

;--- 파생 변수 -----------------------------------------------------------
(define Xhalf (/ Wcell 2.0))
(define Yhalf (/ Lcell 2.0))
(define Ghalf (/ Lgate 2.0))                    ; 게이트 리세스 Y방향 반폭
(define Fhalf (/ Wfin  2.0))                    ; 핀 X방향 반폭
(define GateTop    (* -1.0 (- Drecess DBCAT)))  ; 텅스텐 상단 Z (음수, DBCAT로 결정)
(define WLbottom   (* -1.0 (- Drecess GoxT)))   ; 텅스텐 하단 Z (바닥 산화막 GoxT만큼 위)

;=====================================================================
; 1. 벌크 실리콘 기판
;=====================================================================
(sdegeo:set-default-boolean "ABA")  ; New Replaces Old
(sdegeo:create-cuboid
  (position (* -1.0 Xhalf) (* -1.0 Yhalf) 0.0)
  (position      Xhalf          Yhalf   SubBot)
  "Silicon" "R.Substrate")

;=====================================================================
; 2. STI - 새들핀 폭(Wfin) 정의
;    핀 폭 바깥(X방향 좌우)을 깊이 Hfin까지 산화막으로 교체.
;=====================================================================
(sdegeo:create-cuboid
  (position (* -1.0 Xhalf) (* -1.0 Yhalf) 0.0)
  (position (* -1.0 Fhalf)      Yhalf   (* -1.0 Hfin))
  "Oxide" "R.STI_Left")
(sdegeo:create-cuboid
  (position      Fhalf     (* -1.0 Yhalf) 0.0)
  (position      Xhalf          Yhalf   (* -1.0 Hfin))
  "Oxide" "R.STI_Right")

;=====================================================================
; 3. 새들핀 게이트 리세스 - Lgate 구간에서만 Drecess 깊이까지 게이트 스택으로 채움.
;    이 구간 밖(|Y|>Ghalf)은 1,2단계의 핀이 그대로 남아 "새들" 형상이 자동 형성됨
;    (소스/드레인 쪽 높고, 게이트 아래만 낮게 파인 모양).
;    ★근사: 실제 컨포멀 라이너 대신 박스를 겹쳐 쌓아 근사
;    (바깥=게이트 산화막, 안쪽=텅스텐 - X/Y/바닥 3면을 GoxT만큼 안쪽으로).
;=====================================================================
;--- 3-1. 게이트 산화막 (리세스 전체를 채우는 바깥 박스)
(sdegeo:create-cuboid
  (position (* -1.0 Xhalf) (* -1.0 Ghalf) 0.0)
  (position      Xhalf          Ghalf   (* -1.0 Drecess))
  "Oxide" "R.GateOx")

;--- 3-2. 텅스텐 게이트 - 산화막 두께(GoxT)만큼 X/Y/바닥에서 안쪽.
;         상단(GateTop)은 산화막이 아니라 DBCAT 캡과 맞닿음(여기는 inset 안 함).
(sdegeo:create-cuboid
  (position (+ (* -1.0 Xhalf) GoxT) (+ (* -1.0 Ghalf) GoxT) GateTop)
  (position (-      Xhalf     GoxT) (-      Ghalf     GoxT) WLbottom)
  "Tungsten" "R.WL")

;--- 3-3. DBCAT 캡 (질화막) - 텅스텐 위, 표면(Z=0)까지. 리세스 전체 폭 커버.
;         *** DBCAT을 게이트 에치백 깊이 파라미터로 직접 구현(project-plan.md 3장) ***
(sdegeo:create-cuboid
  (position (* -1.0 Xhalf) (* -1.0 Ghalf) GateTop)
  (position      Xhalf          Ghalf   0.0)
  "Nitride" "R.Cap")

;=====================================================================
; 3-4. (선택) Elevated S/D - 에피 실리콘을 표면 위로 추가 성장
;=====================================================================
(if (= ElevatedSD 1)
  (begin
    (sdegeo:create-cuboid
      (position (* -0.5 Wfin) (* -1.0 Yhalf)   0.0)
      (position (*  0.5 Wfin) (* -1.0 Ghalf) EpiHeight)
      "Silicon" "R.EpiSource")
    (sdegeo:create-cuboid
      (position (* -0.5 Wfin)      Ghalf     0.0)
      (position (*  0.5 Wfin)      Yhalf   EpiHeight)
      "Silicon" "R.EpiDrain")
  )
)

;=====================================================================
; 4. S/D 도핑 (Gaussian, [B1] "Gaussian doping profile was used" 서술 그대로 구현)
;=====================================================================
(sdedr:define-constant-profile "Const.Body" "BoronActiveConcentration" BodyDop)
(sdedr:define-constant-profile-region "PlaceCD.Body" "Const.Body" "R.Substrate")

(sdedr:define-refeval-window "BaseLine.Source" "Rectangle"
  (position (* -1.0 Xhalf) (* -1.0 Yhalf) 0.0)
  (position      Xhalf     (* -1.0 Ghalf) 0.0))
(sdedr:define-refeval-window "BaseLine.Drain" "Rectangle"
  (position (* -1.0 Xhalf)      Ghalf   0.0)
  (position      Xhalf          Yhalf   0.0))

(sdedr:define-gaussian-profile "Gauss.SD"
  "ArsenicActiveConcentration" "PeakPos" 0.0 "PeakVal" SDpeak
  "ValueAtDepth" 1e17 "Depth" Djunction "Gauss" "Factor" LatFactor)

(sdedr:define-analytical-profile-placement "PlaceAP.Source"
  "Gauss.SD" "BaseLine.Source" "Both" "NoReplace" "Eval")
(sdedr:define-analytical-profile-placement "PlaceAP.Drain"
  "Gauss.SD" "BaseLine.Drain" "Both" "NoReplace" "Eval")

;=====================================================================
; 5. 컨택 정의
;=====================================================================
; 기판 바닥면 - 도메인 바깥 경계라 find-face-id로 바로 잡힘
(sdegeo:set-contact (find-face-id (position 0.0 0.0 SubBot)) "substrate")

; 텅스텐 게이트 - 캡에 덮여 표면에 노출되지 않음. 표면 face 대신 바디 전체를
; 이상적 컨택으로 지정(SDE 튜토리얼 2.11절 방식). 텅스텐 내부의 임의 한 점으로 식별.
(define WLmidZ (/ (+ GateTop WLbottom) 2.0))
(sdegeo:set-contact (find-body-id (position 0.0 0.0 WLmidZ)) "WL")

; BL(드레인 쪽)/SC(소스 쪽) - 표면에 얇은 금속 박스를 겹쳐 새 면을 만든 뒤 제거
; (SDE 튜토리얼 6.12절 "Setting the Contacts at New Faces" 방식)
(define BLimp
  (sdegeo:create-cuboid
    (position (* -0.5 Wfin) (+ Ghalf 0.02) -0.005)
    (position (*  0.5 Wfin) (+ Ghalf 0.03)  0.005)
    "Metal" "BLimprint"))
(sdegeo:set-contact BLimp "BL" "remove")

(define SCimp
  (sdegeo:create-cuboid
    (position (* -0.5 Wfin) (- (* -1.0 Ghalf) 0.03) -0.005)
    (position (*  0.5 Wfin) (- (* -1.0 Ghalf) 0.02)  0.005)
    "Metal" "SCimprint"))
(sdegeo:set-contact SCimp "SC" "remove")

;=====================================================================
; 6. 메쉬 - project-plan.md 5-1절 경고("GIDL은 게이트-드레인 겹침부에 국소화된
;    현상이라 메쉬가 성기면 결과가 왜곡됨") 반영, 그 부위 국소 정밀화
;=====================================================================
(sdedr:define-refeval-window "RefWin.Global" "Cuboid"
  (position (* -1.0 Xhalf) (* -1.0 Yhalf) SubBot)
  (position      Xhalf          Yhalf   0.0))
(sdedr:define-refinement-size "RefDef.Global" 0.02 0.02 0.02 0.005 0.005 0.005)
(sdedr:define-refinement-placement "Place.Global" "RefDef.Global" "RefWin.Global")

; 게이트-드레인 겹침부(캡 아래, 드레인 쪽 리세스 경계) 국소 정밀화 - GIDL 발생 위치
(sdedr:define-refeval-window "RefWin.Overlap" "Cuboid"
  (position (* -1.0 Xhalf) (- Ghalf 0.01) (+ GateTop 0.01))
  (position      Xhalf     (+ Ghalf 0.01) (- GateTop 0.01)))
(sdedr:define-refinement-size "RefDef.Overlap" 0.003 0.003 0.001 0.0005 0.0005 0.0002)
(sdedr:define-refinement-placement "Place.Overlap" "RefDef.Overlap" "RefWin.Overlap")

;=====================================================================
; 7. 저장 + 메쉬 생성
;=====================================================================
(sde:save-model "n@node@_bcat")
(sde:build-mesh "" "n@node@")
