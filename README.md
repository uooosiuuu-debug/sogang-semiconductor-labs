# Sogang Semiconductor Design Labs

서강대학교 시스템반도체 설계교육에서 수행한 실습과 프로젝트를 보존하고,
낯선 시스템의 문제를 도면·로그·측정 결과로 좁혀 해결한 과정을 정리한 개인 포트폴리오입니다.

## Portfolio Focus

이 저장소는 특정 장비 사용 경험 자체보다 다음 역량을 보여주는 데 목적이 있습니다.

- 로그와 증상에 근거한 고장 범위 축소
- 블록도·인터페이스·데이터 흐름 해석
- 자원 및 처리 병목 분석
- 수정 전후 결과의 검증
- 새로운 도구와 기술의 빠른 습득
- 팀 결과와 개인 기여의 명확한 구분

## Contents

| 구분 | 내용 | 상태 |
|---|---|---|
| `01_systemverilog` | SystemVerilog 실습 | Windows 원본 순차 정리 예정 |
| `02_python` | Python 데이터 처리 | Windows 원본 순차 정리 예정 |
| `03_arm_soc` | ARM SoC / AMBA | Windows 원본 순차 정리 예정 |
| `04_fpga_basic` | FPGA 기초 설계 | Windows 원본 순차 정리 예정 |
| `05_uart_spi_gpio` | UART / SPI / GPIO | Windows 원본 순차 정리 예정 |
| `06_asic_fusion_compiler` | ASIC / Fusion Compiler | Windows 원본 순차 정리 예정 |
| [`07_ppe_fpga_kv260`](07_ppe_fpga_kv260/) | PPE Monitoring FPGA 프로젝트 | 원본 및 포트폴리오 정리 중 |

## Featured Project

### PPE Monitoring AI Hardware Accelerator

- Target: AMD/Xilinx Kria KV260
- Toolchain: Vivado / Vitis / Vitis HLS 2022.2
- Model: YOLOv8n
- Hardware target: model.6 C2f block
- Interfaces: AXI4-Stream, AXI4-Lite, AXI DMA
- Runtime: PYNQ / Python

채용 관점에서 읽기 좋은 요약은
[`07_ppe_fpga_kv260/portfolio/README.md`](07_ppe_fpga_kv260/portfolio/README.md)에서 확인할 수 있습니다.

> 이 프로젝트는 5인 팀 프로젝트입니다. 팀 전체 결과를 개인 성과로 주장하지 않으며,
> 개인적으로 수행한 FPGA 통합·디버깅·검증 과정과 학습 내용을 중심으로 기록합니다.
