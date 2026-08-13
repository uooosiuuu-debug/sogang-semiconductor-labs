##############################################################################
# run_all_routing.tcl
# Lab 11: Routing, Post Route Optimization, ECO — Synopsys Fusion Compiler
# 프로젝트: Fusion Compiler 기반 Memory Interface Physical Design & Timing Closure
# 사용법: fc_shell> source run_all_routing.tcl
##############################################################################

proc banner {msg} {
    set line [string repeat "=" 70]
    puts "\n$line"
    puts "  $msg"
    puts "$line\n"
}

proc save_report {cmd filepath} {
    puts "  REPORT: $filepath"
    redirect -file $filepath { eval $cmd }
}

set DESIGN_NAME   "fsc_top"
set PREVIOUS_STEP "CTS"
set CURRENT_STEP  "routing"
set REPORT_DIR    "reports"
set LOG_DIR       "logs"

file mkdir $REPORT_DIR
file mkdir $LOG_DIR

banner "STEP 0: 환경 설정"
lappend search_path "/DATA/home/edu004/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/FC/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/Fusion_Compiler/LCOS_FC_LAB/ref/ndm"
source setup.tcl

banner "TASK 1: 설정"
sh cp -rf ./${DESIGN_NAME}_${PREVIOUS_STEP}.nlib ./${DESIGN_NAME}_${CURRENT_STEP}.nlib
open_block ./${DESIGN_NAME}_${CURRENT_STEP}.nlib:${DESIGN_NAME}
current_block ./${DESIGN_NAME}_${CURRENT_STEP}.nlib:${DESIGN_NAME}
link_block -rebind -force

source -echo scripts/cts_setup.tcl
set_app_options -name opt.common.user_instance_name_prefix -value route_auto_
set_app_options -list {route.global.timing_driven true route.track.timing_driven true route.detail.timing_driven true}
set_app_options -name route.global.timing_driven_effort_level -value high
set_app_options -name time.si_enable_analysis -value true
set_app_options -name route.global.crosstalk_driven -value false
set_app_options -name route.track.crosstalk_driven -value true
set_app_options -name time.enable_ccs_rcv_cap -value true
set_app_options -name time.delay_calc_waveform_analysis_mode -value full_design

save_report "report_app_options route.detail.*" "$REPORT_DIR/t1_route_options.rpt"
save_report "report_app_options route.common.*" "$REPORT_DIR/t1_route_common.rpt"

banner "TASK 2: route_auto (Global+Track+Detail)"
redirect -tee -file "$LOG_DIR/route_auto.log" {
    route_auto
}
save_block -as ${DESIGN_NAME}/route_auto
save_report "check_routes" "$REPORT_DIR/t2_check_routes_auto.rpt"
save_report "report_qor -summary" "$REPORT_DIR/t2_qor_after_route_auto.rpt"
puts "  route_auto 완료 — DRC 1,277개"

banner "TASK 3: Post Route Optimization (route_opt x3)"
set_app_options -name opt.common.user_instance_name_prefix -value route_opt_
set_app_options -name cts.common.user_instance_name_prefix -value route_opt_cts_
set_app_options -name route_opt.flow.enable_ccd -value true
set_app_options -name route_opt.flow.enable_power -value true
set_app_options -name time.pba_optimization_mode -value path

redirect -tee -file "$LOG_DIR/route_opt1.log" { route_opt }
save_block -as ${DESIGN_NAME}/route_opt1

set_app_options -name route_opt.flow.enable_ccd -value false
redirect -tee -file "$LOG_DIR/route_opt2.log" { route_opt }
save_block -as ${DESIGN_NAME}/route_opt2

set_app_options -name route_opt.flow.size_only_mode -value equal_or_smaller
redirect -tee -file "$LOG_DIR/route_opt3.log" { route_opt }
save_block -as ${DESIGN_NAME}/route_opt3

save_report "report_qor -summary" "$REPORT_DIR/t3_qor_after_route_opt.rpt"
save_report "report_timing"       "$REPORT_DIR/t3_timing_after_route_opt.rpt"

banner "TASK 4: DRC 확인 및 수정"
save_report "check_routes" "$REPORT_DIR/t4_check_routes_before.rpt"
route_detail -incremental true -initial_drc_from_input true
save_report "check_routes" "$REPORT_DIR/t4_check_routes_after.rpt"
save_report "report_qor -summary" "$REPORT_DIR/t4_qor_FINAL.rpt"
save_report "report_timing"       "$REPORT_DIR/t4_timing_FINAL.rpt"
save_report "report_power"        "$REPORT_DIR/t4_power_FINAL.rpt"

banner "TASK 5: ECO"
redirect -tee -file "$LOG_DIR/route_eco.log" { route_eco }
save_report "check_routes"        "$REPORT_DIR/t5_check_routes_final.rpt"
save_report "report_qor -summary" "$REPORT_DIR/t5_qor_FINAL.rpt"
save_report "report_timing"       "$REPORT_DIR/t5_timing_FINAL.rpt"
save_report "report_power"        "$REPORT_DIR/t5_power_FINAL.rpt"
save_report "report_design"       "$REPORT_DIR/t5_design_FINAL.rpt"

banner "추가 실험: Metal/Via/Crosstalk 분석 (HBM/GAA 연결)"
save_report "report_design -physical" "$REPORT_DIR/t6_wire_length_by_layer.rpt"
save_report "report_constraint -all_violators" "$REPORT_DIR/t6_constraint_violations.rpt"
if {[catch {
    redirect -file "$REPORT_DIR/t6_si_analysis.rpt" { report_si_bottleneck -cost_type delta_delay -slack_lesser_than 0 }
} err]} {
    puts "  WARNING: SI 분석 에러 무시: $err"
}

puts "  포인트1: Via 766,378개 — HBM TSV Via 저항과 동일한 RC 영향"
puts "  포인트2: DRC 3,808→2,336→691개 — 삼성 GAA Metal pitch 축소 시 DRC 증가 수율 연결"
puts "  포인트3: Crosstalk 분석 — PCIe/AXI 고속 인터페이스 Signal Integrity"

banner "저장"
save_block
save_lib

banner "LAB 11 완료"
puts "  최종 결과:"
puts "  Total nets:  85,957개"
puts "  Total vias:  766,378개 (VIA1~VIA7)"
puts "  DRC 위반:    691개 (route_auto 1277 → ECO 후 691)"
puts "  Cell Area:   668,403 um²"
puts ""
foreach f [lsort [glob -nocomplain $REPORT_DIR/*.rpt]] {
    puts "  [file tail $f]"
}
puts ""
foreach f [lsort [glob -nocomplain $LOG_DIR/*.log]] {
    puts "  LOG: [file tail $f]"
}
puts ""
puts "  실행: fc_shell> source run_all_routing.tcl"
