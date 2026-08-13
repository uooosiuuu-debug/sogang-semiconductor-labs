set SCRIPT_DIR [file normalize [file dirname [info script]]]
set HLS_DIR [file normalize "$SCRIPT_DIR/.."]
set PROJECT_DIR "$HLS_DIR/build/axis_passthrough_hls"
set EXPORT_ZIP "$HLS_DIR/axis_passthrough_ip.zip"

if {[file exists $EXPORT_ZIP]} {
    error "Export ZIP already exists; refusing to overwrite: $EXPORT_ZIP"
}

open_project $PROJECT_DIR
set_top axis_passthrough
add_files "$HLS_DIR/src/axis_passthrough.cpp" \
    -cflags "-I$HLS_DIR/src"
add_files -tb "$HLS_DIR/tb/tb_axis_passthrough.cpp" \
    -cflags "-I$HLS_DIR/src"

open_solution "solution1" -flow_target vivado
set_part {xck26-sfvc784-2LV-c}
create_clock -period 10 -name default

csim_design
csynth_design
cosim_design -rtl verilog
export_design -format ip_catalog -rtl verilog -output $EXPORT_ZIP

exit
