#
# This file was created by Xilinx Vitis tool.
#


#
# tools
#

RM = rm -f
RMDIR = rm -rf



#
# variables
#

SDCARD_GEN = sdcard_gen
GENERATE_BIF = ::scw::generate_bif

XPFM_PATH = /home/sogang/ppe_fpga_ho/vitis_workspace/ppe_dma_platform/export/ppe_dma_platform/ppe_dma_platform.xpfm
SYS_CONFIG = ppe_dma_platform
DOMAINS = standalone_domain
BIF_PATH = /home/sogang/ppe_fpga_ho/vitis_workspace/dma_loopback_system/Debug/system.bif

BITSTREAM_PATH = /home/sogang/ppe_fpga_ho/vitis_workspace/dma_loopback/_ide/bitstream/dma_passthrough.bit
SD_FILES = --elf /home/sogang/ppe_fpga_ho/vitis_workspace/dma_loopback/Debug/dma_loopback.elf,psu_cortexa53_0

GENERATE_BIF_XSCT_CMD = ${GENERATE_BIF} -xpfm ${XPFM_PATH} -domains ${DOMAINS} -bifpath ${BIF_PATH}

#
# primary build targets
#

package:
	-@echo Generating bif file for the system project
	-@echo Executing command \'${GENERATE_BIF_XSCT_CMD}\' on XSCT
	-@echo "connect -u TCP:localhost:43713; tcf send_command $$::xsdb::curchan xsdb eval s es [list \"${GENERATE_BIF_XSCT_CMD}\"]" | xsct
	${SDCARD_GEN} --xpfm ${XPFM_PATH} --sys_config ${SYS_CONFIG} --bif ${BIF_PATH} --bitstream ${BITSTREAM_PATH} ${SD_FILES}

clean:
	$(RMDIR) ./_sds
	${RMDIR} package
	${RM} system.bif

.PHONY: all package clean

all: package


