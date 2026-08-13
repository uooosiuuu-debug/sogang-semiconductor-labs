# Lab별 수행 내용과 증거

## Lab 03 — Compile Fusion

- Initial Map → Logic Optimization → DFT → Placement → Initial DRC → Final Optimization 실행
- QoR, Critical Path, Power, High-fanout Net, Layout 확인
- Final Setup WNS `-1.82 ns`, TNS `-3.55 ns`, NVE `2`
- 근거: [`t8_qor_FINAL.rpt`](../LAB%2003/lab03_compile/reports/t8_qor_FINAL.rpt)

## Lab 06 — UPF & Timing Setup

- Supply Network, Multi-voltage Check, PVT, Mode, Corner, Scenario 확인
- Functional/Test 조건의 Timing Report 비교
- GUI Timing Analysis Window 및 Floorplan 확인

## Lab 07 — CCD & Memory Macro Timing

- Register-to-RAM, RAM-to-Register, R2R 경로 분리
- 30개 SRAM Macro와 CCD, Macro Skew, Balance Point 분석
- 일부 Setup Path는 양수지만 FEEDTHROUGH `-4.35 ns`와 Hold 위반이 남음
- 근거: [`Final QoR`](../LAB%2007/lab07_ccd/reports/t4_s3_qor_FINAL.rpt)

## Lab 08 — ICG & Clock Gating

- Pre-existing/Tool-inserted ICG와 Ungated 항목 비교
- 계층별 Dynamic Power와 Leakage Power 분석
- Activity 및 Library 조건에 따른 추정값이므로 실측 전력과 구분

## Lab 09 — Hierarchical Synthesis

- `fsc_top` Block Compile → Abstract 생성 → `lcos_cont` Top 통합
- Block Setup WNS `+0.34 ns`, TNS `0`, Setup NVE `0`
- Top Setup WNS `-1984.43 ns`로, Block 성공과 Top Constraint 정합성이 별개임을 확인
- Abstract Report: Compression `98.19%`, DCC 제외 `98.21%`
- 근거: [`Block QoR`](../LAB%2009/lab09_Hier/reports/t1_qor_block.rpt), [`Top Abstract`](../LAB%2009/lab09_Hier/reports/t4_abstracts_top.rpt)

## Lab 10 — CTS

- Build Clock, Route Clock, Clock Tree Check 수행
- Clock별 Skew·Latency, Balance Point, NDR, RC 분석
- CTS 후 Setup WNS `-1489.63 ns`, Hold WNS `-31.06 ns`가 남음
- 근거: [`CTS QoR`](../LAB%2010/lab10_CTS/reports/t3_qor_after_cts.rpt)

## Lab 11 — Routing

- Detail Routing, Route Optimization, SI/Noise, Metal/Via 분석
- Open Net `0`, 총 Wire Length 약 `3,039,155.63 µm`
- 최종 Setup WNS `-989.72 ns`, Hold WNS `-30.95 ns`, DRC `1,378`
- Route Check 명령의 잘못된 Option 오류도 확인
- 근거: [`Final QoR`](../LAB%2011/lab11_Routing/reports/t5_qor_FINAL.rpt), [`Route Check`](../LAB%2011/lab11_Routing/reports/t5_check_routes_final.rpt)
