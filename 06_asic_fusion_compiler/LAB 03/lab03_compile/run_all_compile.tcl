##############################################################################
# run_all_compile.tcl
# Lab 03: Compile Flow — Synopsys Fusion Compiler
# 사용법: fc_shell> source run_all_compile.tcl
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

set DESIGN_LIB  "fsc_top_compile.nlib"
set REPORT_DIR  "reports"
set LOG_DIR     "logs"

file mkdir $REPORT_DIR
file mkdir $LOG_DIR

banner "STEP 0: 환경 설정"

lappend search_path "/DATA/home/edu004/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/FC/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/Fusion_Compiler/LCOS_FC_LAB/ref/ndm"

if {[catch {source setup.tcl} err]} {
    puts "  WARNING: setup.tcl 일부 에러 무시: $err"
}

source ./procs_compile/proc_workshop.tcl

banner "TASK 1: initial_map"
redirect -tee -file "$LOG_DIR/compile_initial_map.log" {
    _run_compile_stage_save initial_map
}
save_report "report_qor -summary" "$REPORT_DIR/t1_qor_initial_map.rpt"
save_report "report_clock_gating" "$REPORT_DIR/t1_clock_gating.rpt"

banner "TASK 2: logic_opto"
redirect -tee -file "$LOG_DIR/compile_logic_opto.log" {
    _run_compile_stage_save logic_opto
}
save_report "report_qor -summary" "$REPORT_DIR/t2_qor_logic_opto.rpt"
save_report "report_design" "$REPORT_DIR/t2_design_logic_opto.rpt"

banner "TASK 3: insert_dft"
if {[catch {
    redirect -tee -file "$LOG_DIR/compile_insert_dft.log" {
        _run_compile_stage_save insert_dft
    }
} err]} {
    puts "  WARNING: insert_dft 에러 무시: $err"
}
save_report "report_qor -summary" "$REPORT_DIR/t3_qor_insert_dft.rpt"

banner "TASK 4: initial_place"
redirect -tee -file "$LOG_DIR/compile_initial_place.log" {
    _run_compile_stage_save initial_place
}
save_report "report_qor -summary" "$REPORT_DIR/t4_qor_initial_place.rpt"
save_report {all_high_transitive_fanout -nets -threshold 100} "$REPORT_DIR/t4_high_fanout_nets.rpt"

banner "TASK 5: initial_drc"
redirect -tee -file "$LOG_DIR/compile_initial_drc.log" {
    _run_compile_stage_save initial_drc
}
save_report "report_qor -summary" "$REPORT_DIR/t5_qor_initial_drc.rpt"
save_report "report_design" "$REPORT_DIR/t5_design_initial_drc.rpt"

banner "TASK 6: initial_opto"
redirect -tee -file "$LOG_DIR/compile_initial_opto.log" {
    _run_compile_stage_save initial_opto
}
save_report "report_qor -summary" "$REPORT_DIR/t6_qor_initial_opto.rpt"
save_report "report_timing" "$REPORT_DIR/t6_timing_initial_opto.rpt"

banner "TASK 7: final_place"
redirect -tee -file "$LOG_DIR/compile_final_place.log" {
    _run_compile_stage_save final_place
}
save_report "report_qor -summary" "$REPORT_DIR/t7_qor_final_place.rpt"
save_report "report_power" "$REPORT_DIR/t7_power_final_place.rpt"

banner "TASK 8: final_opto"
redirect -tee -file "$LOG_DIR/compile_final_opto.log" {
    _run_compile_stage_save final_opto
}
save_report "report_qor -summary" "$REPORT_DIR/t8_qor_FINAL.rpt"
save_report "report_qor" "$REPORT_DIR/t8_qor_detail_FINAL.rpt"
save_report "report_timing" "$REPORT_DIR/t8_timing_FINAL.rpt"
save_report "report_power" "$REPORT_DIR/t8_power_FINAL.rpt"
save_report "report_design" "$REPORT_DIR/t8_design_FINAL.rpt"
save_report "report_constraint -all_violators" "$REPORT_DIR/t8_all_violators_FINAL.rpt"

banner "LAB 03 완료"
foreach f [lsort [glob -nocomplain $REPORT_DIR/*.rpt]] {
    puts "  [file tail $f]"
}
foreach f [lsort [glob -nocomplain $LOG_DIR/*.log]] {
    puts "  LOG: [file tail $f]"
}
puts ""
puts "  실행: fc_shell> source run_all_compile.tcl"
