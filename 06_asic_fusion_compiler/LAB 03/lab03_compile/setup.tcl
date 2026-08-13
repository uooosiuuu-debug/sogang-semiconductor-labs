set_host_options -max_cores 4
lappend search_path "../ref/"

set DESIGN_NAME                 "fsc_top" ;# Required; name of the design to be worked on; used as the block name for save_block or copy_block operations

set LIBRARY_SUFFIX              ".nlib" ;# Optional; suffix for the design library name ; default is unspecified  
set DESIGN_LIBRARY              "${DESIGN_NAME}${LIBRARY_SUFFIX}" ;# Optional; name of the design library; 
                                  
 
 
set TECH_FILE                   "../ref/TECH/saed32nm_1p9m_mw.tf"     ;# A technology file; TECH_FILE and TECH_LIB are mutually exclusive ways to specify technology information; 

set REFERENCE_LIBRARY           [ glob -nocomplain ../ref/ndm/*.ndm]

set TCL_LIB_CELL_DONT_USE_FILE "./scripts/dont_use.tcl"

source ./pre_compile_db/pre_compile.tcl


