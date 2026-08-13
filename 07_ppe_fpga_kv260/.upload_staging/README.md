# PPE Monitoring AI Hardware Accelerator

AMD/Xilinx Kria KV260에서 PPE Monitoring용 YOLOv8n의 일부 연산을 FPGA로 가속하기 위한 프로젝트입니다. 이 브랜치에는 기존 3x3 convolution RTL 실험과 model.6 HLS 소스, AXI DMA 기반 AXI4-Stream 통합 실험이 함께 정리되어 있습니다.

## 개발 환경

- Target board: Kria KV260 Vision AI Starter Kit
- Device: XCK26 (`xck26-sfvc784-2LV-c`)
- Host OS: Ubuntu 22.04
- Vivado/Vitis/Vitis HLS: 2022.2
- PL clock: 100 MHz
- 주요 데이터 형식: INT8 activation/weight, INT32 accumulator

## 저장소 구성

```text
conv_accelerator/        기존 3x3 convolution RTL 및 테스트벤치
model6_hls/              YOLOv8n model.6 관련 HLS 원본과 golden test
dma_axis_passthrough/    AXI DMA + AXI4-Stream passthrough 통합 실험
```

세부 빌드 방법과 현재 상태는 각 하위 폴더의 README를 참고하십시오.

## 현재 상태

- 기존 3x3 convolution RTL: 저장소 기존 자료 유지
- 7종 model.6 HLS 원본 및 테스트벤치: 정리
- AXI4-Stream passthrough HLS: C simulation, synthesis, RTL co-simulation 완료
- KV260 DMA passthrough Vivado 설계: Validate, synthesis, implementation, bitstream 완료
- 100 MHz timing: 충족
- 보드 Standalone DMA loopback: 미완료
  - AXI-Lite 주소 `0xA0000000`, `0xA0010000` 접근 시 A53 `EDITR timeout`
  - PS-PL isolation/reset sequence와 AXI interconnect 교체 후에도 재현됨

실패한 보드 검증 결과도 숨기지 않고 `dma_axis_passthrough/README.md`에 기록했습니다.

## 주의

- Vivado/Vitis 자동 생성 캐시와 run 디렉터리는 Git에서 제외합니다.
- 최종 bitstream은 `dma_axis_passthrough/deliverables/`에 보관합니다.
- 현재 XSA는 마지막 AXI Interconnect 변경 전에 생성된 오래된 파일이므로 포함하지 않습니다.
- YOLO 모델 weight 파일(`*.pt`)은 출처·라이선스 및 불필요한 바이너리 크기 문제로 포함하지 않습니다.

