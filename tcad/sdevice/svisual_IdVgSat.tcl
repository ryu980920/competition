#----------------------------------------------------------------------#
#set IdSat  x
#set Ioff   x
#set VtSat  x
#----------------------------------------------------------------------#
## [B1] 베이스라인 반영 - IdVgSat 추출/플로팅
## 변경점:
##   - Wfin/FH/Lgate 상수를 IdVgLin과 동일하게 맞춤 (원본엔 아예 없었음)
##   - VtSat(정전류법 Vt, 고전압 조건) 추출을 신규 추가
##     -> Workbench에서 DIBL = (VtLin - VtSat) / (1.2 - 0.05) [V/V] 로
##        VtLin(IdVgLin 결과)과 조합해 파생 파라미터로 계산 가능
##   - IdSat, Ioff(=GIDL 전류 지표) 추출은 원본 그대로 유지
## ----------------------------------------------------------------------#
load_library extract
lib::SetInfoDef 1
#----------------------------------------------------------------------#
set N     @node@
set i     @node:index@
set Vd    1.2
set Vg    1.2
set Type  AccMOS
set Wfin  0.017    ;# [신규] IdVgLin과 동일값으로 통일
set FH    0.048    ;# [신규]
set Lgate 0.020    ;# [신규] VtSat 추출(Io 공식)에 필요
set Weff  [expr (2*$FH+$Wfin)]
puts ""
set ID "$Type"
set N   ${Type}_${N}
#- Automatic alternating color assignment tied to node index
#----------------------------------------------------------------------#
set COLORS  [list green blue red orange magenta violet brown]
set NCOLORS [llength $COLORS]
set color   [lindex  $COLORS [expr $i%$NCOLORS]]
#- Plotting IdVg
#----------------------------------------------------------------------#
echo "#########################################"
echo "Plotting Id-Vg (sat) curve"
echo "#########################################"
load_file IdVgSat_@plot@ -name PLT_Sat($N)
if {[lsearch [list_plots] Plot_IdVg] == -1} {
	create_plot -1d -name Plot_IdVg
}
select_plots Plot_IdVg
set Vgs [get_variable_data "WL OuterVoltage" -dataset PLT_Sat($N)]
set Ids [get_variable_data "BL TotalCurrent" -dataset PLT_Sat($N)]
ext::AbsList -out absIds -x $Ids ;# Compute absolute value of drain currents
create_variable -name absId -dataset PLT_Sat($N) -values $absIds
create_curve -name IdVgSat($N) -dataset PLT_Sat($N) \
	-axisX "WL OuterVoltage" -axisY "absId"

set_curve_prop IdVgSat($N) -label "IdVg(Sat) ($ID BL=$Vd)" \
	-color $color -line_style solid -line_width 3

set_plot_prop -title "I<sub>bl</sub>-V<sub>wl</sub> Curve" -title_font_size 16 -show_legend
set_axis_prop -axis x -title {WL Voltage [V]} \
	-title_font_size 16 -scale_font_size 14 -type linear
set_axis_prop -axis y -title {BL Current [A]} \
	-title_font_size 16 -scale_font_size 14 -type log
set_legend_prop -label_font_size 12 -location bottom_right -label_font_att bold
#- Extraction
#----------------------------------------------------------------------#
echo "#########################################"
echo "Extracting parameters from Id-Vg (sat) curve"
echo "#########################################"
#- Defining current level for Vti extraction
#----------------------------------------------------------------------#
ext::ExtractExtremum -out Idmax  -name "IdSat"  -x $Vgs -y $absIds -type "max"
ext::ExtractIoff     -out Ioff   -name "Ioff"   -v $Vgs -i $absIds -vo 1e-5
echo "Max IdSat is [format %.3e $Idmax] A"
echo "Ioff is [format %.3e $Ioff] A"

## [신규] DIBL 계산용 - 고전압 조건에서의 정전류법 Vt
set Io    [expr 1e-7*($Weff/$Lgate)] ; # IdVgLin과 동일한 [B1] 공식
ext::ExtractVti -out VtiSat -name "VtSat" -v $Vgs -i $absIds -io $Io
echo "VtSat (constant current method, Vbl=1.2V) is [format %.3g $VtiSat] V"
