# 검증 수치와 사용 원칙

## 자소서에 사용할 수 있는 확인 수치

| 항목 | 확인값 | 해석 |
|---|---:|---|
| Lab 03 Final Setup WNS | `-1.82 ns` | Compile 후에도 소수 Setup 위반 잔존 |
| Lab 07 SRAM Macro | `30개` | Memory Macro 경계 Timing 실습 근거 |
| Lab 09 Block Setup WNS | `+0.34 ns` | Block 단위 Setup 만족 |
| Lab 09 Abstract Compression | `98.19%` | 해당 Abstract Report 기준 |
| Lab 09 DCC 제외 Compression | `98.21%` | 해당 Abstract Report 기준 |
| Lab 10 CTS Setup WNS | `-1489.63 ns` | CTS 이후 Top Timing 미충족 |
| Lab 11 Routing Setup WNS | `-989.72 ns` | 일부 개선됐으나 미충족 |
| Lab 11 Open Net | `0` | 연결 완전성과 Sign-off를 구분해야 함 |
| Lab 11 Total DRC | `1,378` | Routing 완료 후 품질 위반 잔존 |
| Lab 11 Wire Length | `3,039,155.63 µm` | Physical Routing 규모 근거 |

## 사용하면 안 되는 표현

- `전체 Timing Closure 완료`
- `DRC 0 달성`
- `HBM/NAND/DDR Controller 직접 설계`
- `실제 공정 조건을 변경해 Yield 개선`
- Tcl의 출력 문구만 근거로 한 `74.89%/98.28% 압축`

## 수치 사용 규칙

1. 숫자마다 원본 Report 경로를 연결합니다.
2. Block과 Top, Setup과 Hold를 구분합니다.
3. Tool 실행 완료와 Sign-off 완료를 구분합니다.
4. 추정 Power와 실측 Power를 구분합니다.
5. 교육용 실습과 실제 산업 제품 개발을 구분합니다.
