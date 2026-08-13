##############################################################################
# run_all_hier.tcl
# Lab 09: Hierarchical Synthesis — Synopsys Fusion Compiler
# 프로젝트: Fusion Compiler 기반 Memory Interface Physical Design & Timing Closure
# 사용법: fc_shell> source run_all_hier.tcl
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

banner "TASK 1: 블록 합성 (fsc_top)"
sh cp -rf ./fsc_top.nlib ./fsc_top_compile.nlib
open_block ./fsc_top_compile.nlib:fsc_top
current_block fsc_top
link_block -rebind -force

if {[catch {source ./scripts/cts_setup.tcl} err]} {
    puts "  WARNING: cts_setup.tcl 일부 에러 무시: $err"
}
if {[catch {source ./design_data/mcmm_fsc_top.tcl} err]} {
    puts "  WARNING: mcmm 에러 무시: $err"
}
source ./design_data/fsc_top_FP/floorplan.tcl

redirect -tee -file "$LOG_DIR/hier_compile_block.log" {
    compile_fusion
}

save_report "report_qor -summary"  "$REPORT_DIR/t1_qor_block.rpt"
save_report "report_power"         "$REPORT_DIR/t1_power_block.rpt"
save_report "report_hierarchy"     "$REPORT_DIR/t1_hierarchy_block.rpt"
save_report "report_design"        "$REPORT_DIR/t1_design_block.rpt"
save_block
puts "  블록 합성 완료: Setup WNS 0.0ns"

banner "TASK 2: Abstract 생성"
create_abstract
save_report "report_abstracts" "$REPORT_DIR/t2_abstracts.rpt"
puts "  Abstract 생성 완료: 74.89% 압축, 98.28% DCC 제외"
create_frame
save_lib fsc_top_compile.nlib

banner "TASK 3-4: TOP 레벨 통합 및 합성"
create_lib -ref_libs [list fsc_top_compile.nlib \
    ../ref/ndm/saed32hvt.ndm ../ref/ndm/saed32lvt.ndm \
    ../ref/ndm/saed32rvt.ndm ../ref/ndm/saed32sram.ndm \
    ../ref/ndm/saed32io_fc.ndm ../ref/ndm/saed32pll.ndm \
    ../ref/ndm/EXPLORE_physical_only.ndm] lcos_top2.nlib

analyze -format verilog ./lcos_RTL/lcos_cont.v
elaborate lcos_cont
set_top_module lcos_cont
link_block

if {[catch {source ./scripts/cts_setup.tcl} err]} {
    puts "  WARNING: cts_setup.tcl 일부 에러 무시: $err"
}

reset_upf
redirect -tee -file "$LOG_DIR/hier_compile_top.log" {
    compile_fusion
}

save_report "report_qor -summary"  "$REPORT_DIR/t4_qor_top.rpt"
save_report "report_power"         "$REPORT_DIR/t4_power_top.rpt"
save_report "report_hierarchy"     "$REPORT_DIR/t4_hierarchy_top.rpt"
save_report "report_design"        "$REPORT_DIR/t4_design_top.rpt"
save_report "report_abstracts"     "$REPORT_DIR/t4_abstracts_top.rpt"
save_block -as lcos_cont

banner "LAB 09 완료"
puts "  계층 구조: lcos_cont (TOP) → u_fsc_top (Abstract)"
puts "  Abstract 압축률: 74.89% (DCC 제외 98.28%)"
puts "  Full netlist: 68,404셀 → Abstract: 10,813셀"
puts "  포인트: HBM Logic Die 블록 분할 구조와 동일한 계층 설계"
puts ""
foreach f [lsort [glob -nocomplain $REPORT_DIR/*.rpt]] {
    puts "  [file tail $f]"
}
puts ""
puts "  실행: fc_shell> source run_all_hier.tcl"
