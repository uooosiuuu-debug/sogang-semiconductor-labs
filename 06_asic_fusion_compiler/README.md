# Fusion Compiler Physical Design & Timing Analysis

Synopsys Fusion Compiler를 원격 Linux 환경에서 직접 실행하며 Synthesis부터 Routing까지
Physical Design Flow를 실습하고, Timing·Power·Hierarchy·Clock·DRC 리포트를 분석한 기록입니다.

## 실습 범위

| Lab | 주제 | 핵심 산출물 |
|---|---|---|
| Lab 03 | Compile Fusion | 단계별 QoR, Timing, Power, Layout |
| Lab 06 | UPF & Timing Setup | Supply Network, PVT, Mode/Corner/Scenario |
| Lab 07 | CCD & Memory Macro Timing | SRAM 경계 Timing, Useful Skew, Balance Point |
| Lab 08 | ICG & Clock Gating | Gating 전후 구조, Dynamic/Leakage Power |
| Lab 09 | Hierarchical Synthesis | Block Compile, Abstract, Top Integration |
| Lab 10 | CTS | Clock Tree, Skew, Latency, NDR, RC |
| Lab 11 | Routing | Route Check, DRC, Via, Metal, SI, Post-route Timing |

## 취업용으로 빠르게 읽기

- [포트폴리오 개요](portfolio/README.md)
- [Lab별 수행 내용과 증거](portfolio/01_lab_flow_and_evidence.md)
- [도면·계층·회로 해석](portfolio/02_diagram_and_circuit_analysis.md)
- [문제·병목 분석 경험](portfolio/03_troubleshooting_and_bottlenecks.md)
- [빠른 학습과 도구 활용](portfolio/04_learning_agility.md)
- [Memory 응용 분석과 경계](portfolio/05_memory_application_study.md)
- [CS·공정 직무 자소서 소재](portfolio/06_job_application_cards.md)
- [검증 수치와 사용 원칙](portfolio/07_evidence_matrix.md)

## 검증 범위 안내

본 저장소는 교육용 설계에 대한 Fusion Compiler 실습입니다. NAND, DDR, HBM 항목은
Timing·Hierarchy·Clock·Routing 개념을 메모리 반도체 구조에 적용해 해석한 Application Study이며,
실제 메모리 Controller, HBM Logic Die 또는 반도체 제조공정을 직접 개발한 경험을 의미하지 않습니다.

또한 Block 단위 Setup Timing 만족과 Top-level Timing Closure는 구분합니다. 저장된 리포트에는
CTS·Routing 이후 Setup/Hold 및 DRC 위반이 남아 있으며, 이를 숨기지 않고 분석 대상으로 기록합니다.
