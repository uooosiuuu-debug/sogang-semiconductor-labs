# 
# Usage: To re-create this platform project launch xsct with below options.
# xsct /home/sogang/ppe_fpga_ho/vitis_workspace/ppe_dma_platform/platform.tcl
# 
# OR launch xsct and run below command.
# source /home/sogang/ppe_fpga_ho/vitis_workspace/ppe_dma_platform/platform.tcl
# 
# To create the platform in a different location, modify the -out option of "platform create" command.
# -out option specifies the output directory of the platform project.

platform create -name {ppe_dma_platform}\
-hw {/home/sogang/ppe_fpga_ho/ppe_dma_passthrough/dma_passthrough.xsa}\
-proc {psu_cortexa53_0} -os {standalone} -arch {64-bit} -fsbl-target {psu_cortexa53_0} -out {/home/sogang/ppe_fpga_ho/vitis_workspace}

platform write
platform generate -domains 
platform active {ppe_dma_platform}
platform generate
platform config -updatehw {/home/sogang/ppe_fpga_ho/ppe_dma_passthrough/dma_passthrough.xsa}
platform active {ppe_dma_platform}
