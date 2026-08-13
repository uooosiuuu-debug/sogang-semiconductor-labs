# 트러블슈팅 사례

## 사례 1. Implementation 및 Routing 실패

### 상황

Block Design 검증과 합성 이후 Implementation에서 배선 혼잡 및 Routing 관련 문제가 발생했습니다.

### 접근

- 단순 재실행 대신 Implementation 로그, DRC, Route Status를 분리해 확인
- IP 병렬 구조, Handshake, Clock/Reset, 자원 포화를 가설로 분류
- 최소 구성에서 정상 동작한 연결을 기준으로 전체 구조를 단계적으로 복원

### 결과와 학습

- 최종 빌드 로그에서 DRC Error 0과 `write_bitstream completed successfully` 확인
- 장비 장애도 증상만 보고 조치하기보다 로그와 시스템 구조로 범위를 축소해야 함을 학습

## 사례 2. Stream 처리 정지와 DMA 대기

### 상황

시뮬레이션 또는 보드 제어 중 데이터가 일부만 처리되거나 DMA/API 호출이 반환되지 않는 현상을 경험했습니다.

### 접근

- 연산 오류와 전송 교착을 분리
- AXI Stream의 `TVALID/TREADY/TLAST`, FIFO, DATAFLOW 구조 확인
- 입력·출력 데이터 크기와 DMA Length Register 폭 비교
- Python MMIO 읽기가 멈췄을 때 커널 재시작과 SSH 상태를 분리해 점검

### 학습

정상 동작하던 시스템도 특정 데이터 길이와 Handshake 조건에서만 멈출 수 있으므로,
재현 조건과 마지막 정상 지점을 먼저 확보해야 합니다.

## 사례 3. 출력값 불일치

### 점검 항목

- CHW와 HWC 레이아웃
- INT8 signed 해석과 saturation
- Quantization scale
- BRAM 주소 증가 방식
- 입력·출력 Tensor shape
- DMA 전송 길이

### 학습

`done` 신호와 프로그램 정상 종료는 결과의 정확성을 보장하지 않습니다. Python Golden Model과
중간 출력을 같은 주소와 인덱스로 비교하는 별도의 품질 검증이 필요합니다.

## CS·공정 직무 연결

- 현상 재현과 마지막 정상 지점 확보
- Alarm·로그·도면을 이용한 원인 범위 축소
- 한 번에 한 조건만 변경
- 정상 종료와 품질 정상의 분리 확인
- 조치 후 재발 여부와 남은 위험 기록
