#fc_shell -gui

echo "hello world"

source -echo ./setup.tcl

#Copy read block to setup block
open_lib ./fsc_top.nlib
copy_block -from fsc_top/read -to fsc_top/setup
current_block fsc_top/setup

#Loading RC parasitic models
read_parasitic_tech -layermap ../ref/TECH/map/saed32nm_tf_itf_tluplus.map -tlup ../ref/TECH/saed32nm_1p9m_Cmin.tluplus -name {minTLU}

read_parasitic_tech -layermap ../ref/TECH/map/saed32nm_tf_itf_tluplus.map -tlup ../ref/TECH/saed32nm_1p9m_Cmax.tluplus -name {maxTLU}
report_lib -parasitic_tech fsc_top.nlib

get_site_defs
set_attribute [get_site_defs unit] symmetry Y
set_attribute [get_site_defs unit] is_default true

#Set the metal layer preferred routing directions 
set_attribute [get_layers {M1 M3 M5 M7 M9}] \
   	routing_direction horizontal
set_attribute [get_layers {M2 M4 M6 M8}] \
   	routing_direction vertical 
get_attribute [get_layers M?] routing_direction

report_ignored_layers
set_ignored_layers -max_routing_layer M7
report_ignored_layers

#UPF
load_upf design_data/fsc_manual.upf
commit_upf
check_mv_design

#FLOORPLAN
source design_data/fsc_top_FP/floorplan.tcl

#Auto Floorplan
#set_app_options -name compile.auto_floorplan.initialize -value true
#set_auto_floorplan_constraints -core_utilization 0.7 -core_offset 10 -shape R
#report_auto_floorplan_constraints

#TIE cells
get_lib_cells -filter "function_id==a0.0"
get_lib_cells -filter "function_id==Ia0.0"

set_dont_touch [get_lib_cells */TIE*] false
set_lib_cell_purpose \
        -include optimization [get_lib_cells */TIE*]

#### Multi- Corner Multi-Mode Setup

source ./design_data/mcmm_fsc_top.tcl
report_scenarios

#Ensure that there are no propagated clocks prior to synthesis
foreach_in_collection mode [all_modes] {
   current_mode $mode
   remove_propagated_clocks [all_clocks]
   remove_propagated_clocks [get_ports]
   remove_propagated_clocks [get_pins -hierarchical]
}

current_mode
current_mode func
current_corner
current_scenario

report_modes
#Generate a pvt report, to find out if there are any mismatches between the PVT values defined in each corner
report_pvt
### Creating a voltage mismatch 
set_voltage -object_list [get_supply_nets vdd] 1 -corners ss0p95v125c
report_pvt
set_voltage -object_list [get_supply_nets vdd] 0.95 -corners ss0p95v125c

save_block 
save_lib

exit




