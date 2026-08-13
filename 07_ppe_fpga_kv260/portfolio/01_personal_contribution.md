# 개인 역할과 기여 범위

## 프로젝트 성격

- 5인 팀 프로젝트
- 목표: YOLOv8n PPE Monitoring 파이프라인의 일부를 KV260 FPGA로 가속
- 개인 핵심 범위: `model.6` C2f 하드웨어 통합과 Vivado/Vitis/KV260 검증

## 개인 수행 내용

1. HLS IP의 실제 인터페이스와 데이터 형상 조사
2. Vivado IP Integrator에서 C2f Block Design 구성
3. AXI4-Lite 제어, AXI4-Stream 데이터, DMA, Clock, Reset 연결 확인
4. Validate Design·Synthesis·Implementation 실패 로그 분석
5. Resource Utilization, Timing, DRC를 이용한 병목 판단
6. Bitstream/HWH/XSA 결과물 확인
7. KV260 SSH·PYNQ 환경에서 Overlay 파싱 및 로드 확인
8. 명령, 실패 원인, 수정 이력, 발표 근거 문서화

## 팀 공동 결과와 구분

다음은 팀 협업 결과이므로 개인 단독 성과로 표현하지 않습니다.

- YOLOv8n 전체 모델 학습과 데이터셋 구성
- 전체 PRE/FPGA/POST 파이프라인
- PPE 웹캠 검출 애플리케이션 전체 구현
- 다른 조원이 작성한 모든 HLS IP 원본

## 권장 자소서 표현

> 5인 팀의 PPE Monitoring 프로젝트에서 YOLOv8n model.6 C2f 블록의 FPGA 통합을 담당했습니다.
> 조원이 개발한 HLS IP의 인터페이스를 분석하고 AXI DMA 기반 Block Design을 구성했으며,
> 합성·구현 단계의 자원 및 배선 문제를 로그와 리포트로 추적해 Bitstream 생성과
> KV260 Overlay 검증 단계까지 진행했습니다.
