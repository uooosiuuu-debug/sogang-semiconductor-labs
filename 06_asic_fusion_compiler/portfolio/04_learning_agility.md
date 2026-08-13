# 빠른 학습과 도구 활용

## 학습 환경

- MobaXterm을 이용한 원격 Linux 접속
- Synopsys Fusion Compiler GUI와 Tcl Batch 실행
- Physical Design 용어와 Report 형식 학습
- Lab별 결과를 스크린샷, Tcl, Log, Report로 정리

## 학습 방식

```text
명령 실행
→ 생성된 설계 상태 확인
→ Report의 핵심 지표 추출
→ GUI에서 Physical 위치 확인
→ 이전 단계와 비교
→ 결과와 남은 위반 문서화
```

처음부터 모든 명령을 외우기보다 `왜 이 Report를 보는지`를 중심으로 학습했습니다.

예를 들어 CTS에서는 Clock Tree 생성 여부만 보지 않고 Skew, Latency, Balance Point, NDR, RC를 연결했고,
Routing에서는 Open Net, DRC, Via, Wire Length, SI, Post-route Timing을 함께 확인했습니다.

## 빠른 습득의 증거

- Compile에서 Routing까지 서로 다른 Lab Flow를 Tcl로 실행
- QoR·Timing·Power·Hierarchy·Clock·DRC Report를 직접 생성
- Block과 Top 결과가 다른 이유를 Interface/Constraint 관점으로 재해석
- 실행 결과를 Memory Interface와 장비·공정 직무 관점으로 확장

## 자소서 표현

> 새로운 Tool을 기능 목록으로 암기하지 않고 입력 조건, 처리 단계, 출력 Report의 관계로 구조화했습니다.
> 그 결과 짧은 교육 기간에 Synthesis부터 Routing까지 실행하고, 단계별 품질 지표와 남은 위반을 설명할 수
> 있게 되었습니다.
