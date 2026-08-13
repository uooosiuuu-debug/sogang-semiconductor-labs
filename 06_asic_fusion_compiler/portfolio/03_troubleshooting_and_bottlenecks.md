# 문제·병목 분석 경험

## 사례 1 — Block은 통과했지만 Top에서 Timing 악화

### 현상

Lab 09의 `fsc_top` Block은 Setup WNS `+0.34 ns`였지만, `lcos_cont` Top 통합 후 Setup WNS가
`-1984.43 ns`로 크게 악화됐습니다.

### 판단

개별 Block의 내부 논리만으로는 Top-level 성공을 보장할 수 없으며, Top Interface Delay, Clock 정의,
Constraint, Abstract 경계가 함께 정합해야 함을 확인했습니다.

### 배운 점

정상 모듈이 포함돼 있어도 시스템 통합 조건에서 문제가 발생할 수 있습니다. 장비 Trouble도 부품 단품 정상과
전체 장비 정상 사이에 통신·설정·Interface 조건이 존재한다는 관점으로 접근하겠습니다.

## 사례 2 — CTS와 Routing 이후에도 남은 Timing 위반

### 현상

CTS 후 Setup WNS `-1489.63 ns`, Routing 후 `-989.72 ns`로 일부 개선됐지만 위반은 해소되지 않았습니다.

### 분석 기준

- Clock Skew와 Latency
- PVT/Scenario와 Constraint
- Macro 경계 및 Feedthrough Path
- RC Extraction과 Crosstalk
- High-fanout Net과 DRC

### 배운 점

하나의 수치만 보고 성공 여부를 판단하지 않고 WNS, TNS, NVE, Hold, DRC를 함께 확인해야 합니다.

## 사례 3 — Routing 완료와 Sign-off의 차이

### 현상

Open Net은 `0`이었지만 DRC `1,378`건과 Setup/Hold 위반이 남았습니다. 또한 Route Check 명령의
Option 오류도 발견했습니다.

### 판단

Tool 단계가 종료됐다는 사실과 품질 기준을 충족했다는 사실은 다릅니다. 명령 성공, 연결 완료, Timing,
DRC를 별개의 판정으로 관리해야 합니다.

## CS·공정 직무 연결

- 장비가 Run을 완료해도 계측값과 품질 결과를 별도 확인
- 마지막 정상 단계와 최초 이상 단계를 비교
- 조건을 한 번에 하나씩 변경
- 부분 개선을 완전 해결로 오판하지 않음
- 미해결 항목과 재발 위험을 인계 문서에 기록
