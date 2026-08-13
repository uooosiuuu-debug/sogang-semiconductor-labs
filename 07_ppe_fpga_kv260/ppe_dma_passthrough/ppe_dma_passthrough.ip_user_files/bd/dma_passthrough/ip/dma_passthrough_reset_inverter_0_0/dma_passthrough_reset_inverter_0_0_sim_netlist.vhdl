-- Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2022.2 (lin64) Build 3671981 Fri Oct 14 04:59:54 MDT 2022
-- Date        : Fri Jul 31 10:49:07 2026
-- Host        : sogang-500TGA-500SGA running 64-bit Ubuntu 22.04.5 LTS
-- Command     : write_vhdl -force -mode funcsim
--               /home/sogang/ppe_fpga_ho/ppe_dma_passthrough/ppe_dma_passthrough.gen/sources_1/bd/dma_passthrough/ip/dma_passthrough_reset_inverter_0_0/dma_passthrough_reset_inverter_0_0_sim_netlist.vhdl
-- Design      : dma_passthrough_reset_inverter_0_0
-- Purpose     : This VHDL netlist is a functional simulation representation of the design and should not be modified or
--               synthesized. This netlist cannot be used for SDF annotated simulation.
-- Device      : xck26-sfvc784-2LV-c
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity dma_passthrough_reset_inverter_0_0 is
  port (
    Op1 : in STD_LOGIC_VECTOR ( 0 to 0 );
    Res : out STD_LOGIC_VECTOR ( 0 to 0 )
  );
  attribute NotValidForBitStream : boolean;
  attribute NotValidForBitStream of dma_passthrough_reset_inverter_0_0 : entity is true;
  attribute CHECK_LICENSE_TYPE : string;
  attribute CHECK_LICENSE_TYPE of dma_passthrough_reset_inverter_0_0 : entity is "dma_passthrough_reset_inverter_0_0,util_vector_logic_v2_0_2_util_vector_logic,{}";
  attribute DowngradeIPIdentifiedWarnings : string;
  attribute DowngradeIPIdentifiedWarnings of dma_passthrough_reset_inverter_0_0 : entity is "yes";
  attribute X_CORE_INFO : string;
  attribute X_CORE_INFO of dma_passthrough_reset_inverter_0_0 : entity is "util_vector_logic_v2_0_2_util_vector_logic,Vivado 2022.2";
end dma_passthrough_reset_inverter_0_0;

architecture STRUCTURE of dma_passthrough_reset_inverter_0_0 is
begin
\Res[0]_INST_0\: unisim.vcomponents.LUT1
    generic map(
      INIT => X"1"
    )
        port map (
      I0 => Op1(0),
      O => Res(0)
    );
end STRUCTURE;
