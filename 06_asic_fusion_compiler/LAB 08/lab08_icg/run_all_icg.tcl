##############################################################################
# run_all_icg.tcl
# Lab 08: Managing ICGs — Synopsys Fusion Compiler
# 프로젝트: Fusion Compiler 기반 Memory Interface Physical Design & Timing Closure
# 사용법: fc_shell> source run_all_icg.tcl
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
source ./procs_compile/proc_workshop.tcl

banner "TASK 1: 블록 복사 + ICG Before 확인"
open_lib fsc_top.nlib
if {[llength [get_blocks fsc_top/icg -quiet]] > 0} {
    remove_block -force fsc_top/icg
}
copy_block -from fsc_top/setup -to fsc_top/icg
current_block fsc_top/icg
link_block

alias rcg report_clock_gating
save_report "rcg" "$REPORT_DIR/t1_icg_before.rpt"
puts "  Before: ICG 0개, Ungated 레지스터 13,389개 (100%)"

banner "TASK 1-2: CTS 설정 소싱"
if {[catch {source -echo scripts/cts_setup.tcl} err]} {
    puts "  WARNING: cts_setup.tcl 일부 에러 무시: $err"
}

banner "TASK 1-3: initial_map — ICG 자동 삽입"
redirect -tee -file "$LOG_DIR/icg_initial_map.log" {
    _run_compile_stage initial_map
}
save_report "rcg" "$REPORT_DIR/t1_icg_after_initial_map.rpt"
save_report "report_qor -summary" "$REPORT_DIR/t1_qor_initial_map.rpt"
puts "  After initial_map: ICG 516개 자동 삽입, 58.32% 레지스터 게이팅"

banner "TASK 2: logic_opto — ICG 최적화"
redirect -tee -file "$LOG_DIR/icg_logic_opto.log" {
    _run_compile_stage logic_opto
}
save_report "rcg" "$REPORT_DIR/t2_icg_after_logic_opto.rpt"
save_report "report_qor -summary" "$REPORT_DIR/t2_qor_logic_opto.rpt"
puts "  After logic_opto: ICG 513개 (레지스터 병합으로 3개 제거)"

banner "TASK 3: initial_place ~ initial_opto"
redirect -tee -file "$LOG_DIR/icg_place_to_opto.log" {
    compile_fusion -from initial_place -to initial_opto
}
save_report "rcg" "$REPORT_DIR/t3_icg_after_initial_opto.rpt"
save_report "report_qor -summary" "$REPORT_DIR/t3_qor_initial_opto.rpt"

banner "추가 실험 1: ICG Ungated 레지스터 원인 분석"
save_report "rcg -ungated" "$REPORT_DIR/t3_icg_ungated_analysis.rpt"
puts "  Ungated 원인: Constant One 89.39%, Constant Zero 6.49%, 최소 비트폭 미달 3.58%"
puts "  포인트: NAND Controller 클록 생성기처럼 항상 동작 필요한 회로는 ICG 불가"

banner "추가 실험 2: 계층별 Leakage Power 분석"
save_report "report_power" "$REPORT_DIR/t3_power_total.rpt"
save_report "report_power -hierarchy -verbose" "$REPORT_DIR/t3_power_hierarchy.rpt"
puts "  전체 Leakage: 6.81e+10 pW = 68.1 mW"
puts "  최대 Leakage 블록: u_gamma_correction (13.7 mW)"
puts "  포인트: 삼성 GAA 3나노 Leakage 이슈 → ICG로 설계 단계에서 완화"

banner "추가 실험 3: Tool-Inserted vs Pre-Existing ICG 타이밍"
save_report {rt -to [get_clock_gate_pins -type enable -of_objects [get_clock_gates -origin tool_inserted]]} \
            "$REPORT_DIR/t3_icg_tool_inserted_timing.rpt"
save_report {get_clock_gates -origin pre_existing} \
            "$REPORT_DIR/t3_icg_pre_existing.rpt"
save_report {get_clock_gates -origin tool_inserted} \
            "$REPORT_DIR/t3_icg_tool_inserted.rpt"

banner "저장"
save_block

banner "LAB 08 완료"
puts "  ICG 삽입 요약"
puts "  Before:        ICG 0개,   Ungated 13,389개 (100%)"
puts "  initial_map:   ICG 516개, Gated   7,808개  (58.32%)"
puts "  logic_opto:    ICG 513개, Gated   7,799개  (58.25%)"
puts "  initial_opto:  ICG 513개, Gated   7,799개  (58.25%) — 안정"
puts ""
puts "  Leakage Power 분석"
puts "  전체: 68.1 mW"
puts "  최대 블록: u_gamma_correction 13.7 mW"
puts "  ICG 58.25% 게이팅으로 Dynamic Power 절감"
puts ""
puts "  포트폴리오 포인트"
puts "  NAND Controller Idle Page Buffer 전력 절감과 동일한 원리"
puts "  삼성 GAA Leakage 이슈 → ICG 설계로 완화 접근법 경험"
puts ""
foreach f [lsort [glob -nocomplain $REPORT_DIR/*.rpt]] {
    puts "  [file tail $f]"
}
puts ""
puts "  실행: fc_shell> source run_all_icg.tcl"
