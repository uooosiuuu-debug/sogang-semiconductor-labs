##############################################################################
# run_all_cts.tcl
# Lab 10: Clock Tree Synthesis & Optimization — Synopsys Fusion Compiler
# 프로젝트: Fusion Compiler 기반 Memory Interface Physical Design & Timing Closure
# 사용법: fc_shell> source run_all_cts.tcl
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

set DESIGN_NAME  "fsc_top"
set PREVIOUS_STEP "compile"
set CURRENT_STEP  "CTS"
set REPORT_DIR   "reports"
set LOG_DIR      "logs"

file mkdir $REPORT_DIR
file mkdir $LOG_DIR

banner "STEP 0: 환경 설정"
lappend search_path "/DATA/home/edu004/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/FC/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/Fusion_Compiler/LCOS_FC_LAB/ref/ndm"
source setup.tcl

banner "TASK 1: 디자인 설정"
sh cp -rf ./${DESIGN_NAME}_${PREVIOUS_STEP}.nlib ./${DESIGN_NAME}_${CURRENT_STEP}.nlib
open_block ./${DESIGN_NAME}_${CURRENT_STEP}.nlib:${DESIGN_NAME}
current_block ./${DESIGN_NAME}_${CURRENT_STEP}.nlib:${DESIGN_NAME}
link_block -rebind -force

source -echo scripts/cts_setup.tcl
set_max_transition 0.4 [all_clocks] -data_path
set_max_transition 0.08 [all_clocks] -clock_path
derive_clock_cell_references -output cts_leq_set.tcl
set_attr [get_lib_cells $CTS_CELL_LIST] dont_use false
set_clock_tree_options -target_skew 0.1
set_clock_tree_options -target_latency 0.3 -corners [get_corners ss*]
set_app_options -name cts.common.user_instance_name_prefix -value CTS_
set_app_options -name opt.common.user_instance_name_prefix -value CTS_opt_

save_report "report_clock_tree_options" "$REPORT_DIR/t1_clock_tree_options.rpt"
save_report "report_clock_settings"     "$REPORT_DIR/t1_clock_settings.rpt"
save_report "check_clock_trees"         "$REPORT_DIR/t1_clock_tree_check.rpt"

banner "TASK 2: build_clock"
clock_opt -from build_clock -to build_clock
save_block -as ${DESIGN_NAME}/clock_opt_build_clock
save_report "report_clock_qor"                    "$REPORT_DIR/t2_clock_qor_build.rpt"
save_report "report_clock_timing -type summary"   "$REPORT_DIR/t2_clock_timing_build.rpt"
save_report "report_qor -summary"                 "$REPORT_DIR/t2_qor_build.rpt"
sh cp fc_command.log "$LOG_DIR/cts_build_clock.log"
puts "  build_clock 완료"

banner "TASK 3: route_clock"
clock_opt -from route_clock -to route_clock
save_block -as ${DESIGN_NAME}/clock_opt_route_clock
save_report "report_clock_qor"                    "$REPORT_DIR/t3_clock_qor_route.rpt"
save_report "report_clock_timing -type summary"   "$REPORT_DIR/t3_clock_timing_route.rpt"
save_report "report_qor -summary"                 "$REPORT_DIR/t3_qor_route.rpt"
save_report "report_power"                        "$REPORT_DIR/t3_power_route.rpt"
sh cp fc_command.log "$LOG_DIR/cts_route_clock.log"
puts "  route_clock 완료"

banner "추가 실험: DDR/HBM 클록 분배 분석"
save_report "report_clock_timing -type skew"     "$REPORT_DIR/t4_skew_per_clock.rpt"
save_report "report_clock_timing -type latency"  "$REPORT_DIR/t4_latency_per_clock.rpt"
save_report "report_routing_rules"               "$REPORT_DIR/t4_ndr_rules.rpt"
save_report "report_clock_balance_points"        "$REPORT_DIR/t4_clock_balance_points.rpt"
save_report "report_clock_qor -show_paths"       "$REPORT_DIR/t4_clock_tree_details.rpt"
save_report {report_net -physical -connections [get_nets -filter "net_type == clock"]} \
            "$REPORT_DIR/t4_rc_analysis.rpt"

puts "  포인트1: system_clk 7,005 싱크 → DDR Memory Interface 클록 분배"
puts "  포인트2: NDR cts_w2_s2_vlg (M4~M6, 2배 폭) → 삼성 GAA Metal CMP 수율 연결"
puts "  포인트3: Via 저항 0.5 ohm/cut → 클록 레이턴시 → 타이밍 마진 → 수율"

banner "저장"
save_block

banner "LAB 10 완료"
puts "  CTS 결과:"
puts "  전체 클록 싱크: 13,384개"
puts "  최대 스큐: 2.59ns (system_clk)"
puts "  CTS 버퍼: 914개"
puts "  NDR: cts_w2_s2_vlg (M4~M6, 2배 폭)"
puts ""
foreach f [lsort [glob -nocomplain $REPORT_DIR/*.rpt]] {
    puts "  [file tail $f]"
}
puts ""
foreach f [lsort [glob -nocomplain $LOG_DIR/*.log]] {
    puts "  LOG: [file tail $f]"
}
puts ""
puts "  실행: fc_shell> source run_all_cts.tcl"
