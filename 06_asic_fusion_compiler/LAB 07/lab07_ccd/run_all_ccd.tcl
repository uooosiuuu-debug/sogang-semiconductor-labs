##############################################################################
# run_all_ccd.tcl
# Lab 7: CCD Optimization — Synopsys Fusion Compiler
# 사용법: fc_shell> source run_all_ccd.tcl
##############################################################################

# ── 보조 함수 ─────────────────────────────────────────────────────────────────
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

# ── 변수 설정 ─────────────────────────────────────────────────────────────────
set DESIGN_LIB   "fsc_top_compile.nlib"
set SRC_BLOCK    "compile_initial_drc"
set WORK_BLOCK   "compile_initial_opto"
set CTS_SETUP    "scripts/cts_setup.tcl"
set REPORT_DIR   "reports"
set LOG_DIR      "logs"
set RAM_ENDPOINT "u_clk_gen/u_pll_mux/pll1_ld_q3_reg/D"

file mkdir $REPORT_DIR
file mkdir $LOG_DIR

##############################################################################
# STEP 0: 환경 설정
##############################################################################
banner "STEP 0: 환경 설정"

source setup.tcl
source ./procs_compile/proc_workshop.tcl

##############################################################################
# TASK 1: 디자인 로드 및 타이밍 분석
##############################################################################
banner "TASK 1-STEP 3: 디자인 열기 및 블록 복사"


lappend search_path "/DATA/home/edu004/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/FC/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/Fusion_Compiler/LCOS_FC_LAB/ref/ndm"

open_lib $DESIGN_LIB

if {[llength [get_blocks $WORK_BLOCK -quiet]] > 0} {
    puts "  기존 블록 삭제 후 재생성"
    remove_block -force $WORK_BLOCK
}

copy_block -from $SRC_BLOCK -to $WORK_BLOCK
current_block $WORK_BLOCK
puts "  현재 블록: [current_block]"

# 클록 레이턴시 설정
set_clock_latency 1.5 -source -early [get_clocks comp_clk]
set_clock_latency 2.5 -source -late  [get_clocks comp_clk]
set_clock_latency 1.5 -source -early [get_clocks pixel_clk]
set_clock_latency 2.5 -source -late  [get_clocks pixel_clk]

# 클록 불확실도 설정
source ./scripts/uncer_script.tcl

banner "TASK 1-STEP 4: 클록 정보 확인"
save_report "report_clocks -skew" \
            "$REPORT_DIR/t1_s4_clocks_skew.rpt"

banner "TASK 1-STEP 5: RAM 셀 확인"
save_report {get_cells -filter "is_memory_cell == true" -hier} \
            "$REPORT_DIR/t1_s5_ram_cells.rpt"

banner "TASK 1-STEP 6: 타이밍 리포트 (Task 1 기준)"
save_report "report_timing -groups R2R" \
            "$REPORT_DIR/t1_s6_timing_R2R.rpt"
save_report "report_timing -to $RAM_ENDPOINT" \
            "$REPORT_DIR/t1_s6_timing_to_RAM.rpt"

banner "TASK 1-STEP 8: CCD 옵션 확인"
save_report "report_app_options compile.flow.enable_ccd" \
            "$REPORT_DIR/t1_s8_opt_enable_ccd.rpt"
save_report "report_app_options ccd.*pone" \
            "$REPORT_DIR/t1_s8_opt_postpone_prepone.rpt"
save_report "report_app_options compile.flow.*skew_mac*" \
            "$REPORT_DIR/t1_s8_opt_macro_skew.rpt"

puts "  Q1: 조합 논리 딜레이를 0에 가깝게 만드는 것은 불가능 -> CCD 필요"
puts "  Q2: max_postpone 200ps + max_prepone 300ps = 500ps 가용 -> 위반 해소 가능"
puts "  Q3: global CCD가 non-RAM 경로 우선 처리시 RAM 스큐를 덮어쓸 수 있음"
puts "  Q4: max_postpone=200ps, max_prepone=300ps"
puts "  Q5: RAM 출력 슬랙 +0.93ns -> max_postpone 최대 900ps까지 증가 가능"

##############################################################################
# TASK 2: CTS 설정 + compile_fusion
##############################################################################
banner "TASK 2-STEP 1: CTS 설정 소싱"
if {[catch {source $CTS_SETUP} err]} {
    puts "  WARNING: cts_setup.tcl 일부 에러 무시하고 계속 진행: $err"
}
save_report "report_clock_settings -type all" \
            "$REPORT_DIR/t2_s1_clock_settings.rpt"

banner "TASK 2-STEP 2: compile_fusion initial_opto 실행"
redirect -tee -file "$LOG_DIR/compile_initial_opto.log" {
    compile_fusion -from initial_opto -to initial_opto
}
puts "  완료 -> 로그: $LOG_DIR/compile_initial_opto.log"

banner "TASK 2-STEP 3: initial_opto 후 타이밍 (Task 2 기준)"
save_report "report_timing -to $RAM_ENDPOINT" \
            "$REPORT_DIR/t2_s3_timing_to_RAM_after_initial_opto.rpt"

banner "TASK 2-STEP 5~6: 전체 위반 확인"
save_report "report_constraint -all_violators -max_delay" \
            "$REPORT_DIR/t2_s5_all_violators.rpt"
save_report "report_timing -groups pll1_clk_in" \
            "$REPORT_DIR/t2_s6_timing_pll1_clk_in.rpt"

banner "TASK 2-STEP 7: Macro Useful Skew 설정"
set_skew_macros -bank_name RAM_BANK \
    -macros [get_cells -filter "is_memory_cell == true" -hier] \
    -improve_side input

set_app_options -name compile.flow.skew_macros_max_postpone -value 900ps
set_app_options -name compile.flow.skew_macros_effort       -value high

puts "  set_skew_macros: bank=RAM_BANK, improve_side=input"
puts "  skew_macros_max_postpone: 900ps"
puts "  skew_macros_effort: high"

save_report "report_app_options compile.flow.*skew_mac*" \
            "$REPORT_DIR/t2_s7_macro_skew_options.rpt"

##############################################################################
# TASK 3: CCD 분석
##############################################################################
banner "TASK 3-STEP 1: report_ccd_timing"
save_report "report_ccd_timing" \
            "$REPORT_DIR/t3_s1_ccd_timing.rpt"

banner "TASK 3-STEP 2: report_multistage_timing"
save_report "report_multistage_timing" \
            "$REPORT_DIR/t3_s2_multistage_timing.rpt"

puts "  Q6: fanout 슬랙이 양수 -> postpone으로 fanin 경로 전체 해결 가능"

##############################################################################
# TASK 4: max_postpone 증가 후 compile_fusion 완료
##############################################################################
banner "TASK 4-STEP 1: max_postpone 400ps 설정"
set_app_options -name ccd.max_postpone -value 400
puts "  ccd.max_postpone: 200ps -> 400ps"

save_report "report_app_options ccd.*pone" \
            "$REPORT_DIR/t4_s1_ccd_options_400ps.rpt"

banner "TASK 4-STEP 2: compile_fusion final_place ~ final_opto"
redirect -tee -file "$LOG_DIR/compile_final.log" {
    compile_fusion -from final_place -to final_opto
}
puts "  완료 -> 로그: $LOG_DIR/compile_final.log"

banner "TASK 4-STEP 3: 최종 타이밍 리포트"
save_report "report_timing -to $RAM_ENDPOINT" \
            "$REPORT_DIR/t4_s3_timing_to_RAM_FINAL.rpt"
save_report "report_timing -groups R2R" \
            "$REPORT_DIR/t4_s3_timing_R2R_FINAL.rpt"
save_report "report_constraint -all_violators -max_delay" \
            "$REPORT_DIR/t4_s3_all_violators_FINAL.rpt"
save_report "report_qor" \
            "$REPORT_DIR/t4_s3_qor_FINAL.rpt"
save_report "report_clock_balance_points" \
            "$REPORT_DIR/t4_s3_balance_points_FINAL.rpt"

##############################################################################
# 완료
##############################################################################
banner "LAB 7 완료 - 생성된 report 파일 목록"

foreach f [lsort [glob -nocomplain $REPORT_DIR/*.rpt]] {
    puts "  [file tail $f]"
}
puts ""
foreach f [lsort [glob -nocomplain $LOG_DIR/*.log]] {
    puts "  LOG: [file tail $f]"
}

puts ""
puts "  성공 확인:"
puts "  t4_s3_timing_to_RAM_FINAL.rpt  -> Slack >= 0 이면 성공"
puts "  t4_s3_all_violators_FINAL.rpt  -> 내용 없으면 성공"
puts "  t4_s3_qor_FINAL.rpt            -> WNS 확인"
puts ""
puts "  전달: 이 폴더 전체 zip 압축 후 전달"
puts "  실행: fc_shell> source run_all_ccd.tcl"
