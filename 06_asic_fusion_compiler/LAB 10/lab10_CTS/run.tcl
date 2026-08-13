#fc_shell -gui

source -echo ./setup.tcl
set PREVIOUS_STEP compile
set CURRENT_STEP  CTS

### Copy compiled block to CTS block ####
sh cp -rf ./${DESIGN_NAME}_${PREVIOUS_STEP}.nlib ./${DESIGN_NAME}_${CURRENT_STEP}.nlib
open_block ./${DESIGN_NAME}_${CURRENT_STEP}.nlib:${DESIGN_NAME}
current_block ./${DESIGN_NAME}_${CURRENT_STEP}.nlib:${DESIGN_NAME}
link_block -rebind -force

### Verify that the placement is legal.Running clock tree synthesis on a block that does not have a legal placement might result in long runtimes and reduced QoR  ###
check_legality

### Recommended to enable hold scenarios here such that CCD skewing can consider them 
### Please activate hold scenarios for CTS ### 
get_scenarios -filter "hold && active"
report_scenarios

### Read Dsign Constraints ###
source ./scripts/cts_setup.tcl

### Sets the Max transition DRC constraint ###
set_max_transition 0.4 [all_clocks] -data_path
set_max_transition 0.08 [all_clocks] -clock_path

### To help with identifying existing clock cells ###
derive_clock_cell_references -output cts_leq_set.tcl

### Remove dont use attribute on the CTS CELL ###
set_attr [get_lib_cells $CTS_CELL_LIST] dont_use false

###############################################################################################################
report_clock_tree_options
remove_clock_tree_options -all -target_skew -target_latency
set_clock_tree_options -target_skew 0.1
set_clock_tree_options -target_latency 0.3 -corners [get_corners ss*]

### When you enable local skew optimization using the previous settings, by default,
### the tool derives skew targets that help improve the timing QoR, \
### and ignores the target skew you specify with the set_clock_tree_options -target_skew  command.
	# set_app_options -list {cts.compile.enable_local_skew true}
	# set_app_options -list {cts.optimize.enable_local_skew true}

report_clock_tree_options
#################################################################################################################
### Prefix ###
set_app_options -name cts.common.user_instance_name_prefix -value CTS_
set_app_options -name opt.common.user_instance_name_prefix -value CTS_opt_

report_clock_settings

### Use the check_clock_trees  command to verify that your master-clock sources are correctly defined
### Checks  the  clock trees of current design for possible problems with netlist, timing  constraints,  
###clock  constraints,  routing constraints,  or  other  tool  configurations that can adversely impact clock tree synthesis.
	check_clock_trees > clock_tree_check.rpt

########################### CLOCK_OPT Build_clock command#########################################################
	clock_opt -from build_clock -to build_clock
	save_block -as ${DESIGN_NAME}/clock_opt_build_clock

	
########################### CLOCK_OPT Route_clock command #########################################################
	clock_opt -from route_clock -to route_clock
	save_block -as ${DESIGN_NAME}/clock_opt_route_clock

	#Run check_routes to save updated routing DRC to the block
	check_routes -open_net false

	#To prevent cts buffer inserted between port and bound buf
	set_dont_touch [get_nets -of_objects [get_ports * -filter "name != vss || name !~ vdd "]] true

############################ CLOCK_OPT Final_opto #################################################################

	clock_opt -from final_opto -to final_opto
	save_block -as ${DESIGN_NAME}/clock_opt_final_opto

###################################################################################################################

save_block 
#### Report QOR #######
report_clock_qor
report_clock_qor -type area 
#### Analyzing Clock Timing ####
report_clock_timing -type summary


save_lib

exit




