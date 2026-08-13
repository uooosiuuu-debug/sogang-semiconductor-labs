#fc_shell -gui
source -echo ./setup.tcl
set PREVIOUS_STEP CTS
set CURRENT_STEP  routing

### Copy CTS block to routing block####
sh cp -rf ./${DESIGN_NAME}_${PREVIOUS_STEP}.nlib ./${DESIGN_NAME}_${CURRENT_STEP}.nlib
open_block ./${DESIGN_NAME}_${CURRENT_STEP}.nlib:${DESIGN_NAME}
current_block ./${DESIGN_NAME}_${CURRENT_STEP}.nlib:${DESIGN_NAME}
link_block -rebind -force

### Read Dsign Constraints ###
source ./scripts/cts_setup.tcl

### Prefix ###
set_app_options -name opt.common.user_instance_name_prefix -value route_auto_

### Timing driven routing ###
set_app_options -list {
     route.global.timing_driven true
     route.track.timing_driven  true
     route.detail.timing_driven true  }

set_app_options -name  route.global.timing_driven_effort_level -value high


### Enable crosstalk analysis ###
set_app_options -name time.si_enable_analysis -value true
time.enable_si_timing_windows

### Recommended - Crosstalk prevention at track assignment ###
set_app_options -name route.global.crosstalk_driven -value false
set_app_options -name route.track.crosstalk_driven  -value true

### To increase accuracy and better align with PrimeTime, you should set the following application options ###
set_app_options -name time.enable_ccs_rcv_cap -value true
set_app_options -name  time.delay_calc_waveform_analysis_mode -value full_design

### check various app options ###
report_app_options route.detail.*
report_app_options route.common.*

###############################################################################################################
######################### Routing ############################################################################
###############################################################################################################
	puts "Info: Running route_auto"
	route_auto

save_block -as route_auto
################################################################################################################

# Recommended timing settings for reporting on routed designs (AWP, CCS receiver, and SI timing window)
# Setting time.delay_calc_waveform_analysis_mode to full_design and time.enable_ccs_rcv_cap to true for reporting
set_app_options -name time.delay_calc_waveform_analysis_mode -value full_design ;# tool default disabled; enables AWP
set_app_options -name time.enable_ccs_rcv_cap -value true ;# tool default false; enables CCS receiver model; required

########################################################################################################
####################### POST ROUTE OPTIMIZATION ##########################################################
##############################################################################################################
## Prefix ###
set_app_options -name opt.common.user_instance_name_prefix -value route_opt_
set_app_options -name cts.common.user_instance_name_prefix -value route_opt_cts_
##########################################################################
## hyper_route_opt
##########################################################################
### Use a three-pass route_opt approach for better QoR convergence 
	route_opt

	## OR ##
	
### Recommened to use hyper_route_opt for better convergence of QOR. Read manual of hyper_route_opt ###
	hyper_route_opt

##### Check for DRC violations ####
check_routes
##########################################################################################
## Incremental route_detail for fixing routing DRCs
##########################################################################################
route_detail
route_detail -incremental true -initial_drc_from_input true
check_routes

############### TASK ###########
#############  TASK: TRY creating a Abstract view for this block ##############

#### Report QOR #######
report_timing -capacitance -transition -path_type full
report_qor

######################## ECO #####################################
### Whenever you modify the nets in your block, you need to run engineering change order (ECO) routing to reconnect the routing ##
route_eco


save_block 
save_lib

exit




