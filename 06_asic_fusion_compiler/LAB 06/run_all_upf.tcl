##############################################################################
# run_all_upf.tcl
# Lab 06: Technology, UPF, Floorplan and Timing Setup — Synopsys Fusion Compiler
# 프로젝트: Fusion Compiler 기반 Memory Interface Physical Design & Timing Closure
# 사용법: fc_shell> source run_all_upf.tcl
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

set REPORT_DIR "reports"
set LOG_DIR    "logs"

file mkdir $REPORT_DIR
file mkdir $LOG_DIR

banner "STEP 0: 환경 설정"
lappend search_path "/DATA/home/edu004/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/FC/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/Fusion_Compiler/LCOS_FC_LAB/ref/ndm"
source setup.tcl

banner "TASK 1: 블록 복사 (read → setup)"
open_lib fsc_top.nlib
if {[llength [get_blocks fsc_top/setup -quiet]] > 0} {
    remove_block -force fsc_top/setup
}
copy_block -from fsc_top/read -to fsc_top/setup
current_block fsc_top/setup
link_block
puts "  현재 블록: [current_block]"

banner "TASK 2: Technology Setup"
read_parasitic_tech -layermap ../ref/TECH/map/saed32nm_tf_itf_tluplus.map \
    -tlup ../ref/TECH/saed32nm_1p9m_Cmin.tluplus -name {minTLU}
read_parasitic_tech -layermap ../ref/TECH/map/saed32nm_tf_itf_tluplus.map \
    -tlup ../ref/TECH/saed32nm_1p9m_Cmax.tluplus -name {maxTLU}

set_attribute [get_site_defs unit] symmetry Y
set_attribute [get_site_defs unit] is_default true
set_attribute [get_layers {M1 M3 M5 M7 M9}] routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8}]    routing_direction vertical
set_ignored_layers -max_routing_layer M8

save_report "report_ignored_layers" "$REPORT_DIR/t2_ignored_layers.rpt"
puts "  RC 모델, 사이트, 라우팅 레이어 설정 완료"

banner "TASK 3: UPF 로드"
load_upf design_data/lcos_manual.upf
commit_upf
save_report "check_mv_design" "$REPORT_DIR/t3_check_mv_design.rpt"
puts "  UPF 로드 완료 — VDD/VSS 단일 전력 도메인"

banner "TASK 4: Floorplan 로드"
source design_data/fsc_top_FP/floorplan.tcl
puts "  Floorplan 로드 완료 — SRAM 매크로 배치 확정"

banner "TASK 5: MCMM Timing Setup"
source design_data/mcmm_fsc_top.tcl

foreach_in_collection mode [all_modes] {
    current_mode $mode
    remove_propagated_clocks [all_clocks]
    remove_propagated_clocks [get_ports]
    remove_propagated_clocks [get_pins -hierarchical]
}
current_scenario ss0p95v125c.func

save_report "report_scenarios"  "$REPORT_DIR/t5_scenarios.rpt"
save_report "report_corners"    "$REPORT_DIR/t5_corners_pvt.rpt"
save_report "report_pvt"        "$REPORT_DIR/t5_pvt.rpt"
save_report "report_modes"      "$REPORT_DIR/t5_modes.rpt"

banner "추가 실험: 시나리오별 타이밍 비교"
current_scenario ss0p95v125c.func
save_report "report_timing" "$REPORT_DIR/t5_timing_func.rpt"
puts "  func 시나리오 타이밍 저장"

current_scenario ss0p95v125c.test
save_report "report_timing" "$REPORT_DIR/t5_timing_test.rpt"
puts "  test 시나리오 타이밍 저장"

current_scenario ss0p95v125c.func

banner "저장"
save_block
puts "  블록 저장 완료: fsc_top/setup"

banner "LAB 06 완료"
puts "  [PVT 분석 포인트]"
puts "  ss0p95v125c = Slow-Slow, 0.95V, 125C (NAND/DRAM 최악 동작 조건)"
puts "  이 조건에서 타이밍 마진 확보 = 수율 보장"
puts ""
puts "  [Supply Network]"
puts "  VDD → DEFAULT_POWER_DOMAIN → VSS (단일 전력 도메인)"
puts ""
foreach f [lsort [glob -nocomplain $REPORT_DIR/*.rpt]] {
    puts "  [file tail $f]"
}
puts ""
puts "  실행: fc_shell> source run_all_upf.tcl"
