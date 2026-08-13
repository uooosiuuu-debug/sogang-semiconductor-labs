set_host_options -max_cores 4
lappend search_path "../ref/"

set DESIGN_NAME                 "fsc_top" ;# Required; name of the design to be worked on; used as the block name for save_block or copy_block operations

set LIBRARY_SUFFIX              ".nlib" ;# Optional; suffix for the design library name ; default is unspecified  
set DESIGN_LIBRARY              "${DESIGN_NAME}${LIBRARY_SUFFIX}" ;# Optional; name of the design library; 
                                  
 
set PATH_DIR               [pwd]
 
set TECH_FILE                   "$PATH_DIR/../ref/TECH/saed32nm_1p9m_mw.tf"     ;# A technology file; TECH_FILE and TECH_LIB are mutually exclusive ways to specify technology information; 

set REFERENCE_LIBRARY           [ glob -nocomplain $PATH_DIR/../ref/ndm/*.ndm]


set TCL_LIB_CELL_DONT_USE_FILE  "./design_data/dont_use.tcl"
set RTL_SOURCE_FILES            "./listRTL.txt"; 

#source ./pre_compile_db/pre_compile.tcl


