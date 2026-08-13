# Memory Interface 응용 분석

## 직접 수행한 범위

- Fusion Compiler 기반 교육용 Physical Design
- 30개 SRAM Macro의 경계 Timing 분석
- Controller, Datapath, Clock Generator, Abstract Block의 계층 분석
- CCD, ICG, CTS, Routing, SI, DRC Report 분석

## NAND/DDR/HBM으로 확장해 해석한 범위

| 실습 개념 | 응용 관점 |
|---|---|
| SRAM Macro Timing | Page Buffer·Local Memory 경계의 Setup/Hold 이해 |
| Hierarchical Abstract | ECC·DMA·Interface 같은 기능 Block의 계층적 통합 이해 |
| ICG/Power | 유휴 Controller Block의 동적전력 절감 관점 |
| CTS/Skew/Latency | DDR PHY 및 고속 Memory Interface의 Clock 품질 관점 |
| Routing/RC/Crosstalk | 고속 Interface 배선의 Signal Integrity 관점 |
| Via/Metal DRC | 배선·접속 구조와 전기적 특성의 연관 이해 |

## 주장하지 않는 내용

- NAND Controller 또는 DDR PHY 직접 구현
- HBM Logic Die 직접 설계
- TSV Clock Network 실측
- Etch/CMP 조건 변경 실험
- 실제 Wafer 공정·수율 개선

## 올바른 표현

> Fusion Compiler에서 Memory Macro Timing과 계층적 Physical Design을 실습한 뒤, 해당 원리가 NAND
> Controller, DDR Interface, HBM Logic Die에서 어떤 문제와 연결되는지 추가로 분석했습니다.

이 표현은 직접 실습과 산업 응용 학습을 모두 보여주면서 경험 범위를 과장하지 않습니다.
