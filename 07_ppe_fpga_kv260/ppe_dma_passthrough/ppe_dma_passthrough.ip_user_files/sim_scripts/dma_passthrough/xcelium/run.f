-makelib xcelium_lib/xilinx_vip -sv \
  "/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi4stream_vip_axi4streampc.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi_vip_axi4pc.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/xil_common_vip_pkg.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi4stream_vip_pkg.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi_vip_pkg.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi4stream_vip_if.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/axi_vip_if.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/clk_vip_if.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/xilinx_vip/hdl/rst_vip_if.sv" \
-endlib
-makelib xcelium_lib/xpm -sv \
  "/tools/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_fifo/hdl/xpm_fifo.sv" \
  "/tools/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \
-endlib
-makelib xcelium_lib/xpm \
  "/tools/Xilinx/Vivado/2022.2/data/ip/xpm/xpm_VCOMP.vhd" \
-endlib
-makelib xcelium_lib/axi_infrastructure_v1_1_0 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/ec67/hdl/axi_infrastructure_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_vip_v1_1_13 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/ffc2/hdl/axi_vip_v1_1_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/zynq_ultra_ps_e_vip_v1_0_13 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/abef/hdl/zynq_ultra_ps_e_vip_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_zynq_ultra_ps_e_0_0/sim/dma_passthrough_zynq_ultra_ps_e_0_0_vip_wrapper.v" \
-endlib
-makelib xcelium_lib/lib_pkg_v1_0_2 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/0513/hdl/lib_pkg_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_7 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/83df/simulation/fifo_generator_vlog_beh.v" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_7 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/83df/hdl/fifo_generator_v13_2_rfs.vhd" \
-endlib
-makelib xcelium_lib/fifo_generator_v13_2_7 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/83df/hdl/fifo_generator_v13_2_rfs.v" \
-endlib
-makelib xcelium_lib/lib_fifo_v1_0_16 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/6c82/hdl/lib_fifo_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_srl_fifo_v1_0_2 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/51ce/hdl/lib_srl_fifo_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/lib_cdc_v1_0_2 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/ef1e/hdl/lib_cdc_v1_0_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_datamover_v5_1_29 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/2237/hdl/axi_datamover_v5_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_sg_v4_1_15 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/751a/hdl/axi_sg_v4_1_rfs.vhd" \
-endlib
-makelib xcelium_lib/axi_dma_v7_1_28 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/70c4/hdl/axi_dma_v7_1_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_axi_dma_0_0/sim/dma_passthrough_axi_dma_0_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/92cc/hdl/verilog/axis_passthrough_control_s_axi.v" \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/92cc/hdl/verilog/axis_passthrough_flow_control_loop_pipe.v" \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/92cc/hdl/verilog/axis_passthrough_hls_deadlock_idx0_monitor.v" \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/92cc/hdl/verilog/axis_passthrough_regslice_both.v" \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/92cc/hdl/verilog/axis_passthrough.v" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_axis_passthrough_0_0/sim/dma_passthrough_axis_passthrough_0_0.v" \
-endlib
-makelib xcelium_lib/proc_sys_reset_v5_0_13 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/8842/hdl/proc_sys_reset_v5_0_vh_rfs.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_proc_sys_reset_0_0/sim/dma_passthrough_proc_sys_reset_0_0.vhd" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/sim/bd_e2ba.v" \
-endlib
-makelib xcelium_lib/xlconstant_v1_1_7 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/badb/hdl/xlconstant_v1_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_0/sim/bd_e2ba_one_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_1/sim/bd_e2ba_psr_aclk_0.vhd" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/f0b6/hdl/sc_util_v1_0_vl_rfs.sv" \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/c012/hdl/sc_switchboard_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_2/sim/bd_e2ba_arsw_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_3/sim/bd_e2ba_rsw_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_4/sim/bd_e2ba_awsw_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_5/sim/bd_e2ba_wsw_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_6/sim/bd_e2ba_bsw_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/be1f/hdl/sc_mmu_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_7/sim/bd_e2ba_s00mmu_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/4fd2/hdl/sc_transaction_regulator_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_8/sim/bd_e2ba_s00tr_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/637d/hdl/sc_si_converter_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_9/sim/bd_e2ba_s00sic_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/f38e/hdl/sc_axi2sc_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_10/sim/bd_e2ba_s00a2s_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/66be/hdl/sc_node_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_11/sim/bd_e2ba_sarn_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_12/sim/bd_e2ba_srn_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_13/sim/bd_e2ba_s01mmu_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_14/sim/bd_e2ba_s01tr_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_15/sim/bd_e2ba_s01sic_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_16/sim/bd_e2ba_s01a2s_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_17/sim/bd_e2ba_sawn_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_18/sim/bd_e2ba_swn_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_19/sim/bd_e2ba_sbn_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/9cc5/hdl/sc_sc2axi_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_20/sim/bd_e2ba_m00s2a_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_21/sim/bd_e2ba_m00arn_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_22/sim/bd_e2ba_m00rn_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_23/sim/bd_e2ba_m00awn_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_24/sim/bd_e2ba_m00wn_0.sv" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_25/sim/bd_e2ba_m00bn_0.sv" \
-endlib
-makelib xcelium_lib/smartconnect_v1_0 -sv \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/6bba/hdl/sc_exit_v1_0_vl_rfs.sv" \
-endlib
-makelib xcelium_lib/xil_defaultlib -sv \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/bd_0/ip/ip_26/sim/bd_e2ba_m00e_0.sv" \
-endlib
-makelib xcelium_lib/axi_register_slice_v2_1_27 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/f0b4/hdl/axi_register_slice_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_smartconnect_1_0/sim/dma_passthrough_smartconnect_1_0.v" \
-endlib
-makelib xcelium_lib/util_vector_logic_v2_0_2 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/3d84/hdl/util_vector_logic_v2_0_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_reset_inverter_0_0/sim/dma_passthrough_reset_inverter_0_0.v" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_reset_const_high_0/sim/dma_passthrough_reset_const_high_0.v" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_reset_const_low_0/sim/dma_passthrough_reset_const_low_0.v" \
  "../../../bd/dma_passthrough/sim/dma_passthrough.v" \
-endlib
-makelib xcelium_lib/generic_baseblocks_v2_1_0 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/b752/hdl/generic_baseblocks_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_data_fifo_v2_1_26 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/3111/hdl/axi_data_fifo_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_crossbar_v2_1_28 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/c40e/hdl/axi_crossbar_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_xbar_0/sim/dma_passthrough_xbar_0.v" \
-endlib
-makelib xcelium_lib/axi_protocol_converter_v2_1_27 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/aeb3/hdl/axi_protocol_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/axi_clock_converter_v2_1_26 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/b8be/hdl/axi_clock_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/blk_mem_gen_v8_4_5 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/25a8/simulation/blk_mem_gen_v8_4.v" \
-endlib
-makelib xcelium_lib/axi_dwidth_converter_v2_1_27 \
  "../../../../ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ipshared/4675/hdl/axi_dwidth_converter_v2_1_vl_rfs.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  "../../../bd/dma_passthrough/ip/dma_passthrough_auto_ds_0/sim/dma_passthrough_auto_ds_0.v" \
  "../../../bd/dma_passthrough/ip/dma_passthrough_auto_pc_0/sim/dma_passthrough_auto_pc_0.v" \
-endlib
-makelib xcelium_lib/xil_defaultlib \
  glbl.v
-endlib

