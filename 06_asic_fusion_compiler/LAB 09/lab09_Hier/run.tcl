#fc_shell -gui

echo "hello world"

source -echo ./setup.tcl
#Copy the setup Design db in to compile db
sh cp -rf ./${DESIGN_NAME}.nlib ./${DESIGN_NAME}_compile.nlib
open_block ./fsc_top_compile.nlib:fsc_top
current_block fsc_top
link_block -rebind -force


#READ UPF
load_upf design_data/fsc_manual.upf
commit_upf

#Apply key setup constraints
source -echo scripts/fsc_cts_setup.tcl 
#READ FLOORPLAN
source design_data/fsc_top_FP/floorplan.tcl


alias rt {report_timing -capacitance -transition -significant_digits 3}
alias rc {report_constraints -all_violators}

#####Synthesize Block = fsc_top ###########
compile_fusion -from initial_map -to final_opto

save_block 

### Annotate power  dissipation  values  that represent the power dissipation of the content of the block. ##
set_app_options -name abstract.annotate_power -value true
### To Create an abstract ###
create_abstract -read_only
### To create frame view for each sub block ###
create_frame -block_all true

save_lib -all
close_lib -f
#exit

####################### TOP IMPLEMEBNTATION ######################################################################
###### Interating fsc_top Block with lcos_cont (Top design)######
###### Design Hierarchy LCOS_CONT -> FSC_TOP -> .... ##############################################################

set DESIGN_NAME                 "lcos_cont" 
set DESIGN_LIBRARY              "${DESIGN_NAME}${LIBRARY_SUFFIX}"

## Add fsc_top compiled Block library as reference library
lappend REFERENCE_LIBRARY ./fsc_top_compile.nlib

### Create design library ###
create_lib  $DESIGN_LIBRARY \
        -tech $TECH_FILE \
        -ref_libs $REFERENCE_LIBRARY


source -echo $RTL_SOURCE_FILES
analyze -format verilog $verilogsrc
elaborate ${DESIGN_NAME}
set_top_module ${DESIGN_NAME}
link_block 

##### Ensure correct Block lib is loaded ####
report_ref_libs
#### Read Design Constraints ####
source ./scripts/cts_setup.tcl


### READ UPF ###
load_upf design_data/lcos_manual.upf
commit_upf
check_mv_design

###### Open GUI #####
###  Observe the the IO pads and fsctop block loaded as abstract in GUI ###

### READ Floorplan ######
source $TCL_FLOORPLAN_FILE 

## Verify that you have correct abstracts
report_abstracts
commit_upf

#### Useful querying in hierarchial design ###
get_cells -hierarchical -filter is_soft_macro
get_cells -hier -filter  "is_soft_macro&&physical_hierarchy_level==1"
get_cells -hierarchical -filter "is_soft_macro&&ref_view_name==abstract"
get_flat_cells -all


#Check Man page of change_abstract
man change_abstract 

### Run checks to ensure Implementation readiness
check_hier_design -stage pre_compile

#Synthesize the Top block
compile_fusion

save_block -as lcos_cont
save_lib
exit




