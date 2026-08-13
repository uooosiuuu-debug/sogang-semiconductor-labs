##############################################################################
# run_all_compile.tcl
# Lab 03: Compile Flow — Synopsys Fusion Compiler
# 프로젝트: Fusion Compiler 기반 Memory Interface Physical Design & Timing Closure
# 사용법: fc_shell> source run_all_compile.tcl
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
set DESIGN_LIB  "fsc_top_compile.nlib"
set REPORT_DIR  "reports"
set LOG_DIR     "logs"

file mkdir $REPORT_DIR
file mkdir $LOG_DIR

##############################################################################
# STEP 0: 환경 설정
##############################################################################
banner "STEP 0: 환경 설정 (NDM Search Path + Setup)"

lappend search_path "/DATA/home/edu004/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/FC/LCOS_FC_LAB/ref/ndm"
lappend search_path "/DATA/home/ins008/Fusion_Compiler/LCOS_FC_LAB/ref/ndm"

if {[catch {source setup.tcl} err]} {
    puts "  WARNING: setup.tcl 일부 에러 무시하고 계속 진행: $err"
}

source ./procs_compile/proc_workshop.tcl
puts "  proc_workshop.tcl 로드 완료"

##############################################################################
# TASK 1: initial_map — 합성 시작, ICG 삽입
##############################################################################
banner "TASK 1: compile_fusion initial_map"

redirect -tee -file "$LOG_DIR/compile_initial_map.log" {
    _run_compile_stage_save initial_map
}

save_report "report_clock_gating" \
            "$REPORT_DIR/t1_clock_gating.rpt"
save_report "report_unloaded_registers" \
            "$REPORT_DIR/t1_unloaded_registers.rpt"
save_report "report_qor -summary" \
            "$REPORT_DIR/t1_qor_initial_map.rpt"

puts "  포인트: ICG 삽입 확인, 합성 초기 WNS 기록"

##############################################################################
# TASK 2: logic_opto — 논리 최적화 + 초기 배치
##############################################################################
banner "TASK 2: compile_fusion logic_opto"

redirect -tee -file "$LOG_DIR/compile_logic_opto.log" {
    _run_compile_stage_save logic_opto
}

save_report "report_qor -summary" \
            "$REPORT_DIR/t2_qor_logic_opto.rpt"
save_report "report_design" \
            "$REPORT_DIR/t2_design_logic_opto.rpt"

puts "  포인트: 논리 최적화 후 WNS 변화 및 셀 수 확인"

##############################################################################
# TASK 3: insert_dft — 스캔체인 삽입
##############################################################################
banner "TASK 3: compile_fusion insert_dft"

if {[catch {
    redirect -tee -file "$LOG_DIR/compile_insert_dft.log" {
        _run_compile_stage_save insert_dft
    }
} err]} {
    puts "  WARNING: insert_dft 에러 (환경 이슈) — 계속 진행: $err"
}

save_report "report_qor -summary" \
            "$REPORT_DIR/t3_qor_insert_dft.rpt"

puts "  포인트: DFT 스캔체인 삽입 (SPF 환경 이슈 시 스킵)"

##############################################################################
# TASK 4: initial_place — 타이밍 기반 배치
##############################################################################
banner "TASK 4: compile_fusion initial_place"

redirect -tee -file "$LOG_DIR/compile_initial_place.log" {
    _run_compile_stage_save initial_place
}

save_report "report_qor -summary" \
            "$REPORT_DIR/t4_qor_initial_place.rpt"
save_report "report_design" \
            "$REPORT_DIR/t4_design_initial_place.rpt"
save_report {all_high_transitive_fanout -nets -threshold 100} \
            "$REPORT_DIR/t4_high_fanout_nets.rpt"

puts "  포인트: 고팬아웃 넷 확인 (flash_rst_n 등)"

##############################################################################
# TASK 5: initial_drc — DRC 버퍼링 (핵심 단계)
##############################################################################
banner "TASK 5: compile_fusion initial_drc (핵심: 버퍼링으로 WNS 급감)"

redirect -tee -file "$LOG_DIR/compile_initial_drc.log" {
    _run_compile_stage_save initial_drc
}

save_report "report_qor -summary" \
            "$REPORT_DIR/t5_qor_initial_drc.rpt"
save_report "report_design" \
            "$REPORT_DIR/t5_design_initial_drc.rpt"
save_report {all_high_transitive_fanout -nets -threshold 40} \
            "$REPORT_DIR/t5_high_fanout_after_buffering.rpt"

puts "  포인트: 버퍼 삽입 후 WNS 99.9% 개선 확인"
puts "  Memory Controller 관점: 글로벌 리셋/클록 넷 버퍼링 효과"

##############################################################################
# TASK 6: initial_opto — CCD 포함 최적화
##############################################################################
banner "TASK 6: compile_fusion initial_opto (CCD 포함)"

redirect -tee -file "$LOG_DIR/compile_initial_opto.log" {
    _run_compile_stage_save initial_opto
}

save_report "report_qor -summary" \
            "$REPORT_DIR/t6_qor_initial_opto.rpt"
save_report "report_timing" \
            "$REPORT_DIR/t6_timing_initial_opto.rpt"
save_report "report_optimization_history" \
            "$REPORT_DIR/t6_optimization_history.rpt"

puts "  포인트: CCD 포함 최적화, 스캔체인 삽입 완료"

##############################################################################
# TASK 7: final_place — 최종 배치
##############################################################################
banner "TASK 7: compile_fusion final_place"

redirect -tee -file "$LOG_DIR/compile_final_place.log" {
    _run_compile_stage_save final_place
}

save_report "report_qor -summary" \
            "$REPORT_DIR/t7_qor_final_place.rpt"
save_report "report_power" \
            "$REPORT_DIR/t7_power_final_place.rpt"

puts "  포인트: 최종 배치 확정, 전력 소비 측정"

##############################################################################
# TASK 8: final_opto — 최종 최적화 (누설전력 최소화)
##############################################################################
banner "TASK 8: compile_fusion final_opto (최종)"

redirect -tee -file "$LOG_DIR/compile_final_opto.log" {
    _run_compile_stage_save final_opto
}

save_report "report_qor -summary" \
            "$REPORT_DIR/t8_qor_FINAL.rpt"
save_report "report_qor" \
            "$REPORT_DIR/t8_qor_detail_FINAL.rpt"
save_report "report_timing" \
            "$REPORT_DIR/t8_timing_FINAL.rpt"
save_report "report_timing -groups R2R" \
            "$REPORT_DIR/t8_timing_R2R_FINAL.rpt"
save_report "report_power" \
            "$REPORT_DIR/t8_power_FINAL.rpt"
save_report "report_design" \
            "$REPORT_DIR/t8_design_FINAL.rpt"
save_report "report_constraint -all_violators" \
            "$REPORT_DIR/t8_all_violators_FINAL.rpt"
save_report "report_optimization_history" \
            "$REPORT_DIR/t8_optimization_history_FINAL.rpt"

##############################################################################
# 완료 — RC 파라미터 기록 (공정 연결 포인트)
##############################################################################
banner "LAB 03 완료 — 생성된 파일 목록"

puts "  [RC 파라미터 — 공정 연결 포인트]"
puts "  r  = 1.785714 ohm/um  (Metal 배선 저항)"
puts "  c  = 0.073183 ff/um   (Metal 커패시턴스)"
puts "  via_r = 0.500000 ohm  (Via 저항)"
puts "  → Metal 두께/간격 공정 변수와 RC Delay 상관관계"
puts ""

foreach f [lsort [glob -nocomplain $REPORT_DIR/*.rpt]] {
    puts "  [file tail $f]"
}
puts ""
foreach f [lsort [glob -nocomplain $LOG_DIR/*.log]] {
    puts "  LOG: [file tail $f]"
}

puts ""
puts "  성공 확인:"
puts "  t8_qor_FINAL.rpt         -> Setup WNS 확인"
puts "  t8_all_violators_FINAL.rpt -> 위반 현황 확인"
puts "  t8_power_FINAL.rpt        -> 전력 소비 확인"
puts ""
puts "  실행: fc_shell> source run_all_compile.tcl"
