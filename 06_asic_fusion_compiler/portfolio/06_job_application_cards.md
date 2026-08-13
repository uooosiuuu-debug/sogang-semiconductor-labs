# CS·공정 직무 자소서 소재 카드

## 카드 A — 어려운 문제를 분석한 경험

**상황**: Block 단위 Setup WNS는 `+0.34 ns`였지만 Top 통합 후 큰 Timing 위반이 발생했습니다.

**행동**: Block과 Top 리포트를 분리하고, 계층·Clock·Interface·Constraint 항목을 기준으로 원인 범위를
재구성했습니다. 이후 CTS와 Routing 결과에서 WNS, TNS, Hold, DRC를 함께 추적했습니다.

**결과**: 개별 모듈 정상과 시스템 통합 정상은 별도 검증이 필요하다는 점을 수치로 확인했습니다.

**직무 연결**: 정상 부품을 교체하는 방식보다 Module 간 연결, 설정, 통신 조건까지 포함해 장비 장애 범위를
좁히겠습니다.

## 카드 B — 도면과 회로를 해석한 경험

**상황**: 수만 개 Cell과 SRAM Macro가 포함된 설계를 이해해야 했습니다.

**행동**: Top을 Controller, Datapath, Memory, Clock으로 나누고 Startpoint/Endpoint, Clock Tree,
Macro 경계, Metal/Via 경로를 순서대로 분석했습니다.

**결과**: 복잡한 설계를 기능 계층과 신호 흐름으로 설명하고, 문제가 발생한 경로를 Report와 Layout에서
교차 확인할 수 있게 됐습니다.

**직무 연결**: 장비 도면도 전원·제어·통신·센서·Actuator 경로로 나누어 해석하겠습니다.

## 카드 C — 완전 해결되지 않은 과제를 다룬 경험

**상황**: Routing은 완료되고 Open Net은 0이었지만 DRC와 Timing 위반이 남았습니다.

**행동**: 완료 여부와 품질 기준을 구분하고, 남은 DRC·Setup/Hold·명령 Option 오류를 기록했습니다.

**결과**: 부분 성공을 과장하지 않고 다음 조치가 필요한 조건을 명확히 인계할 수 있었습니다.

**직무 연결**: 장비 복구 후에도 계측값, 공정 결과, 재발 위험을 확인하겠습니다.

## 카드 D — 빠른 습득

**상황**: 짧은 교육 기간에 Fusion Compiler와 Physical Design Flow를 처음부터 학습해야 했습니다.

**행동**: Tcl 명령과 Report를 단계별로 연결하고 GUI Layout에서 결과를 재확인했습니다.

**결과**: Compile, UPF, CCD, ICG, Hierarchy, CTS, Routing을 실행하고 각 단계의 핵심 지표를 설명할 수
있게 됐습니다.

**직무 연결**: 신규 장비도 매뉴얼·도면·로그·계측값을 하나의 Flow로 구조화해 빠르게 익히겠습니다.
