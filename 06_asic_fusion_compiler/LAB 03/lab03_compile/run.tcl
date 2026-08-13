#fc_shell -gui
source -echo ./setup.tcl
source  ./procs_compile/proc_workshop.tcl
##########################################################################################
## Initial Map
##########################################################################################
_run_compile_stage_save initial_map

report_unloaded_registers
report_clock_gating

##########################################################################################
## Logic opto
##########################################################################################
_run_compile_stage_save logic_opto

##########################################################################################
## GateLevel DFT Flow
##########################################################################################
_run_compile_stage_save insert_dft

foreach mode [all_test_modes] {
                dft_drc -test_mode $mode}
                 write_test_protocol -test_mode $mode -output ./insert_dft.$mode.spf
             }

get_scan_chain_count

##########################################################################################
## Inital_place
##########################################################################################
_run_compile_stage_save initial_place

all_high_transitive_fanout -nets -threshold 100
report_design

##########################################################################################
## Iniial drc
##########################################################################################
_run_compile_stage_save initial_drc
report_design
all_high_transitive_fanout -nets -threshold 100
all_high_transitive_fanout -nets -threshold 40


##########################################################################################
## Iniial opto
##########################################################################################
_run_compile_stage_save initial_opto
#get_scan_chain_count

check_legality

report_timing
report_optimization_history

##########################################################################################
## Final place
##########################################################################################
_run_compile_stage_save final_place
check_legality 
report_qor -summary
report_power

##########################################################################################
## Final opto
##########################################################################################
_run_compile_stage_save final_opto
report_power
report_qor -summary


exit



