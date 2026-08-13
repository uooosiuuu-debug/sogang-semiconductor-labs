# PPE Monitoring AI Hardware Accelerator on KV260

YOLOv8n의 `model.6` C2f 블록을 FPGA 하드웨어로 통합하고 KV260에서 검증하기 위한
5인 팀 프로젝트의 개발 원본과 개인 학습 기록입니다.

## 개인 담당 범위

- 조원이 작성한 Vitis HLS IP의 인터페이스와 포트 조사
- Vivado IP Repository 등록 및 Block Design 통합
- AXI4-Stream, AXI4-Lite, AXI DMA, Clock, Reset 연결 점검
- Validate Design, Synthesis, Implementation 오류 분석
- Timing, Resource Utilization, DRC 결과 확인
- Bitstream/HWH/XSA 생성과 KV260 Overlay 단계 검증
- 로그·명령·실패 원인과 수정 이력 문서화

## 빠르게 읽기

- [취업용 포트폴리오 개요](portfolio/README.md)
- [개인 역할과 경계](portfolio/01_personal_contribution.md)
- [트러블슈팅 사례](portfolio/02_troubleshooting.md)
- [도면·인터페이스 해석](portfolio/03_diagram_and_interface_analysis.md)
- [빠른 학습과 Codex 활용](portfolio/04_learning_and_ai.md)
- [결과·근거·한계](portfolio/05_results_and_limits.md)
- [자소서 소재 카드](portfolio/06_job_application_cards.md)

## 저장 원칙

현재 폴더에는 당시 작업 환경을 보존하기 위한 Vivado/Vitis 자동 생성물도 포함돼 있습니다.
채용 담당자는 `portfolio/` 문서부터 읽는 것을 권장하며, 원본 파일은 주장과 결과를 확인하는
증거 아카이브로 사용합니다.

## 팀 프로젝트 표기

전체 YOLO 모델, 데이터, 학습, 런타임 및 최종 데모는 팀 협업 결과입니다.
이 저장소는 그중 개인이 담당한 FPGA 통합과 문제 해결 과정을 중심으로 설명합니다.
