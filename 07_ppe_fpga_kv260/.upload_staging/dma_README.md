# KV260 AXI DMA–AXI4-Stream Passthrough

## 목적

전체 YOLOv8n model.6를 통합하기 전에 KV260에서 다음 최소 데이터 경로를 검증하기 위한 설계입니다.

```text
DDR
  ↓
AXI DMA MM2S
  ↓
AXI4-Stream axis_passthrough
  ↓
AXI DMA S2MM
  ↓
DDR
```

`axis_passthrough`는 입력 AXI4-Stream word를 수정하지 않고 출력으로 전달합니다. 이 설계가 보드에서 검증되면 이후 HLS accelerator를 같은 데이터 경로에 배치하는 것이 목표입니다.

## Block Design

### 제어 경로

```text
Zynq UltraScale+ MPSoC M_AXI_HPM0_FPD
  → AXI Interconnect (1 SI, 2 MI)
    → AXI DMA S_AXI_LITE       @ 0xA0000000
    → axis_passthrough control @ 0xA0010000
```

초기 설계의 제어 SmartConnect는 보드 AXI-Lite timeout 진단 과정에서 AXI Interconnect로 교체했습니다.

### 데이터 경로

```text
AXI DMA M_AXI_MM2S ─┐
                    ├→ SmartConnect → PS S_AXI_HP0_FPD → DDR
AXI DMA M_AXI_S2MM ─┘
```

### Clock/reset

- `pl_clk0`: 100 MHz
- PS, DMA, Interconnect, SmartConnect, HLS IP를 단일 PL clock domain으로 구성
- `proc_sys_reset`의 `interconnect_aresetn`과 `peripheral_aresetn` 사용
- 보드 진단 과정에서 `ext_reset_in`을 constant-low로 연결한 상태
  - 이는 최종 reset 구조가 아니라 AXI timeout 원인 분리를 위한 진단 설정입니다.

## HLS passthrough 결과

- Interface: 32-bit AXI4-Stream input/output, AXI4-Lite control
- Target clock: 10 ns
- Loop achieved II: 1
- Estimated resource: LUT 84, FF 40, DSP 0, BRAM 0
- C simulation: PASS
- C synthesis: PASS
- RTL co-simulation: PASS
- VLNV: `xilinx.com:hls:axis_passthrough:1.0`

## Vivado 결과

Vivado 2022.2, XCK26, 100 MHz 기준:

| 항목 | 결과 |
|---|---:|
| Validate Design | PASS |
| Synthesis | PASS |
| Implementation/route | PASS |
| Bitstream | PASS |
| WNS | +5.904 ns |
| WHS | +0.010 ns |
| CLB LUT | 4,717 (4.03%) |
| CLB register | 7,220 (3.08%) |
| BRAM tile | 2 (1.39%) |
| DSP | 0 |

DRC error는 없었습니다. 남은 advisory는 AXI DMA 내부 BRAM `NO_CHANGE` collision advisory와 load가 없는 reset 관련 net입니다.

## 폴더 구조

```text
hls/
  src/                 passthrough HLS 원본과 AXIS type
  tb/                  C/RTL 검증 테스트벤치
  scripts/             Vitis HLS 2022.2 실행 Tcl
  reports/             csynth/cosim/csim 결과
  ip_repo/             Vivado 등록용 exported HLS IP
vivado/
  ppe_dma_passthrough.xpr
  sources_1/           현재 Block Design 및 IP 설정 source
  scripts/             BD 백업 Tcl
software/
  main.c               Standalone AXI DMA polling loopback
reports/
  vivado/              synthesis/implementation/timing/DRC/power
deliverables/
  dma_passthrough_wrapper.bit
  dma_passthrough.hwh
```

## 재생성 절차

### 1. HLS IP

Vivado/Vitis HLS 2022.2 환경에서:

```bash
cd dma_axis_passthrough/hls
vitis_hls -f scripts/run_hls.tcl
```

`run_hls.tcl`의 소스 경로는 저장소 내 상대 경로를 기준으로 확인해야 합니다.

### 2. Vivado

1. Vivado 2022.2에서 `vivado/ppe_dma_passthrough.xpr`을 엽니다.
2. IP Repository 경로를 `hls/ip_repo`로 갱신합니다.
3. `dma_passthrough.bd`를 열고 IP status를 확인합니다.
4. Validate Design을 수행합니다.
5. Generate Output Products를 수행합니다.
6. Synthesis → Implementation → Generate Bitstream 순으로 실행합니다.
7. timing, utilization, DRC report를 확인합니다.

프로젝트 내부에 원래 PC의 절대 경로가 남아 있을 수 있으므로 다른 시스템에서는 IP repository와 source path를 다시 지정해야 합니다.

### 3. Vitis Standalone test

1. 최신 bitstream을 포함한 XSA를 Vivado에서 다시 export합니다.
2. `psu_cortexa53_0`, standalone, 64-bit domain으로 platform을 생성합니다.
3. Empty Application에 `software/main.c`를 추가합니다.
4. platform과 application을 build합니다.
5. KV260 UART 115200 baud와 JTAG를 연결합니다.
6. Launch on Hardware로 bitstream, FSBL, ELF를 다운로드합니다.

## 보드 시험 결과와 미완료 문제

Standalone 애플리케이션 출력:

```text
PPE AXI DMA passthrough test
Transfer size: 1024 bytes
STEP 1: DMA config lookup
STEP 2: DMA config found at 0xA0000000
STEP 3: DMA initialize
```

`XAxiDma_CfgInitialize()` 내부의 AXI register access에서 정지합니다. XSCT 직접 검사에서도 다음 두 주소가 모두 timeout입니다.

```text
mrd 0xA0000000  # AXI DMA control
mrd 0xA0010000  # HLS control
```

관찰된 오류:

```text
Memory read error ... Cortex-A53 #0: EDITR timeout
```

확인한 항목:

- 주소 할당 정상
- HPM0 → control interconnect → DMA/HLS 연결 존재
- 100 MHz clock 연결 존재
- reset 진단 변경 후에도 재현
- SmartConnect를 AXI Interconnect로 교체 후에도 재현
- `psu_ps_pl_isolation_removal`, `psu_ps_pl_reset_config` 명시 실행 후에도 재현

따라서 bitstream 생성은 성공했지만 실제 보드 DMA loopback은 아직 PASS가 아닙니다. 다음 진단 후보는 PS configuration, PL clock/reset의 실제 하드웨어 관측, AXI protocol ILA, 최소 AXI GPIO slave 접근 시험입니다.

## 산출물 상태

- `.bit`: 마지막 AXI Interconnect 설계에서 생성된 최종 파일
- `.hwh`: 해당 Block Design output product
- `.xsa`: 마지막 변경 이후 재생성되지 않아 이번 업로드에서 제외
- Block Design 이미지: 현재 로컬 자료에서 찾을 수 없어 포함하지 않음
