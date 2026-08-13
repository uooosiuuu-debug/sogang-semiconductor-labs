# Sogang Semiconductor Design Labs

서강대학교 시스템반도체 설계교육 과정에서 수행한 실습 및 프로젝트를 정리한 저장소입니다.

## Contents

- 01 SystemVerilog
- 02 Python Data Processing
- 03 ARM SoC / AMBA
- 04 FPGA Basic Design
- 05 UART / SPI / GPIO
- 06 ASIC / Fusion Compiler
- 07 PPE Monitoring FPGA Accelerator on KV260

## Main Project

### PPE Monitoring AI Hardware Accelerator

- Target Board: AMD/Xilinx Kria KV260
- Tool: Vivado / Vitis / Vitis HLS 2022.2
- Model: YOLOv8n
- Hardware Acceleration: model.6 C2f
- Interfaces: AXI4-Stream, AXI4-Lite, AXI DMA
- Runtime: PYNQ / Python
