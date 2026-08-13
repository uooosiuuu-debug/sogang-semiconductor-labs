#fc_shell -gui

echo "hello world"

source -echo ./setup.tcl
source  ./procs_compile/proc_workshop.tcl

#Copy read block icg block
open_lib fsc_top.nlib
copy_block -from fsc_top/setup -to fsc_top/icg
current_block fsc_top/icg

alias rcg report_clock_gating
rcg 

#Find clock latency
#-skew  Reports clock latency (source and network  latency)  and  uncertainty    information   set   by   the   set_clock_latency   and set_clock_uncertainty commands, respectively.
report_clock -skew

#apply key CTS setup constraints
source -echo scripts/cts_setup.tcl 

report_clock -skew

get_lib_cells */CG* -filter valid_purposes=~*cts* 

get_clock_gates

#If design doesnot have Pre Existing ICGs, run the below commands after tool insertion of  ICG
# list of all the pins of one of the clock gates
	get_pins -of_objects <ICG name>
#Find the clock pins that are driven by one of the ICGs
	all_connected [get_nets -of_objects ..../.../GCLK]
#Find out what controls the ICGs
	all_fanin -flat -to .../../EN
#Prevent Fusion Compiler from merging the ICGs of a_ and b_rams with other ICGs 
	set_clock_gate_transformations  [get_cells "ICGA_cell ICGB_cell"] true -merge_equivalents false


##########################################################################################
## Initial Map
##########################################################################################

_run_compile_stage initial_map

#Generate another clock gating report and capture the new data
rcg
rcg -ungated 

report_transformed_registers

##########################################################################################
## Logic opto
##########################################################################################

_run_compile_stage logic_opto

#You can find out the names of the pre-existing and tool-inserted ICGs at any time by using
get_clock_gates -origin pre_existing
get_clock_gates -origin tool_inserted

#Generate a timing report for the most critical tool-inserted ICG enable pin
rt -to [get_clock_gate_pins -type enable \
   -of_objects [get_clock_gates -origin tool_inserted]]



##########################################################################################
## initial_place to initial_opto
##########################################################################################
compile_fusion -from initial_place -to initial_opto
rcg
rt -nets -from *_rep*
report_transformed_registers
alias rc report_constraints
rc -max_delay -sig 3

rt -to clock_gate*
rt
save_block

##########################################################################################
## final_place to final_opto
##########################################################################################
compile_fusion -from final_place -to final_opto

rcg

check_legality
rc -max_delay -sig 3

exit




