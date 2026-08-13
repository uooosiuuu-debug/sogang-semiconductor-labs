# 결과, 근거, 한계

## 확인 완료

- Vivado 2022.2 환경에서 Implementation 완료
- DRC 결과 Error 0 확인
- `write_bitstream completed successfully` 확인
- `.bit`, `.hwh`, `.xsa` 결과물 생성 확인
- PYNQ에서 Model6 Overlay의 IP 목록 파싱 확인
- 별도 실행에서 `overlay.download()` 후 로드 상태 확인

관련 화면과 로그:

- [Vivado Bitstream 성공 로그](../artifacts/terminal_capture/01_vivado_model6_success.txt)
- [Vitis/XSCT 작업 기록](../artifacts/terminal_capture/02_vitis_xsct_board_run.txt)
- [KV260 작업 기록](../artifacts/terminal_capture/03_kv260_camera_overlay.txt)

## 팀 통합 결과

- YOLOv8n 기반 PPE 웹캠 검출 화면
- PRE/FPGA/POST 혼합 파이프라인
- 팀 단위 최종 데모 및 발표 자료

위 항목은 팀 협업 결과이며 개인 단독 구현으로 표현하지 않습니다.

## 추가 검증 필요

- 개인 Model6 Bitstream의 전체 Tensor 출력과 Golden Model End-to-End 수치 비교
- 해당 Model6 블록이 전체 YOLO FPS에 기여한 정도
- 최종 정확도와 FPS의 반복 측정 및 통계
- 다른 KV260 환경에서의 재현성

## 결과 해석 원칙

Bitstream 성공은 하드웨어 구현 가능성을 의미하지만 전체 AI 정확도와 목표 FPS 달성을 자동으로
보장하지 않습니다. 따라서 구현 성공, 보드 로드, 수치 정확도, 전체 성능을 서로 다른 검증 단계로
구분해 기록합니다.
