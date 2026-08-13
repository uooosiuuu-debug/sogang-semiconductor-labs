# 빠른 학습과 Codex 활용

## 학습 대상

프로젝트 초기에 HLS, AXI, DMA, IP Integrator, 양자화, PYNQ/KV260 제어가 모두 익숙한 것은
아니었습니다. 개념을 한꺼번에 암기하기보다 실제 데이터 흐름과 실패 지점을 기준으로 학습했습니다.

```text
HLS IP 단위 이해
→ 인터페이스와 Tensor shape 확인
→ 최소 Block Design
→ 전체 C2f 통합
→ Synthesis/Implementation
→ Bitstream
→ KV260/PYNQ 검증
```

## Codex 활용 방식

- 긴 Vivado/Vitis 로그에서 오류 후보 분류
- HLS pragma와 IP 포트의 불일치 비교
- Tcl과 터미널 명령 초안 작성
- 수정 전후 수치 및 증거 문서화
- GitHub 자료 구조와 발표 문서 정리
- 다음 실험의 우선순위와 확인 항목 구성

## 검증 원칙

AI의 답을 결과로 간주하지 않았습니다. 제안은 다음 근거로 다시 확인했습니다.

- 실제 파일과 소스
- `component.xml`과 Block Design 포트
- HLS/Vivado/Vitis 로그
- Utilization, Timing, DRC Report
- Bitstream 파일 존재 여부
- KV260 터미널의 실제 출력

## 직무 연결

> 새로운 도구를 빠르게 학습하되, 자동화 도구의 제안을 그대로 신뢰하지 않고 장비 로그와
> 측정 결과로 재검증하는 태도를 갖추었습니다.
