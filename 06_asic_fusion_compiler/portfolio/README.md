# Fusion Compiler 취업 포트폴리오

## 한 문장 요약

원격 Linux 환경에서 Fusion Compiler Physical Design Flow를 실행하고, 설계 계층과 Timing·Power·Clock·Routing
리포트를 읽어 Block 성공과 Top-level 병목을 구분한 경험입니다.

## 직무 역량 연결

| 실습 경험 | 판단 근거 | CS·공정 직무 연결 |
|---|---|---|
| 계층 및 Abstract 분석 | `report_hierarchy`, `report_abstracts` | 도면에서 모듈 경계와 영향 범위 파악 |
| Timing 위반 분석 | WNS/TNS/NVE, Critical Path | Alarm·계측값으로 마지막 정상 구간 추적 |
| Clock·Power 분석 | ICG, CTS, Skew, Latency, Power | 전원·Clock 계통과 부하 조건 이해 |
| Routing·DRC 분석 | Via, Metal, Open Net, DRC | 배선·접속·공정 조건의 전기적 영향 이해 |
| 단계별 실행 자동화 | Tcl, Batch, MobaXterm | 신규 Tool과 절차의 빠른 습득 |
| 결과 경계 설정 | Block/Top, 완료/Sign-off 구분 | 장비 정상 종료와 품질 정상의 분리 판단 |

## 문제 해결 프레임

```text
현상 확인
→ 설계 계층과 분석 단계 특정
→ Timing/Power/Clock/Routing 리포트 확보
→ Block과 Top 결과 분리
→ Tcl 옵션과 Constraint 검토
→ 수정 또는 추가 분석
→ 전후 수치와 남은 위반 기록
```

이 포트폴리오는 모든 위반을 해결했다고 주장하지 않습니다. 오히려 최종 결과에 남은 위반을 읽고,
어떤 단계와 조건을 추가로 점검해야 하는지 설명할 수 있는 능력을 보여주는 데 목적이 있습니다.
