# 도면·계층·회로 해석 경험

## 계층 구조 분석

`report_hierarchy`를 통해 다음 기능 경계를 확인했습니다.

```text
lcos_cont (Top)
└── u_fsc_top (Abstract)
    ├── main_controller_top
    ├── datapath
    │   └── SRAM Macro
    └── clk_gen
```

이를 통해 Top 전체를 한 덩어리로 보지 않고 Controller, Datapath, Memory, Clock 영역으로 분해했습니다.

## 도면과 리포트를 읽은 순서

1. Top과 하위 Block의 기능 경계 확인
2. Clock와 데이터 경로 분리
3. Startpoint/Endpoint 및 Path Group 확인
4. SRAM Macro 경계의 입력·출력 Timing 확인
5. Clock Skew·Latency와 Data Arrival/Required Time 비교
6. Routing 이후 Metal Layer, Via, Wire Length, DRC 확인
7. Block 결과와 Top 결과 비교

## 회로 해석 관점

- 조합논리와 순차논리, Buffer/INV, ICG Cell 비중 구분
- Critical Path의 Cell·Net Delay 누적 확인
- Clock Tree와 데이터 경로의 Setup/Hold 관계 이해
- 배선 저항·정전용량과 Via 저항이 Delay에 미치는 영향 분석
- SRAM Macro를 일반 Standard Cell과 구분하여 경계 Timing 확인

## 직무 연결

장비 회로도와 Fusion Compiler Block Design은 동일하지 않지만, 복잡한 시스템을 전원·Clock·제어·데이터·접속
경로로 나누고 이상이 시작되는 구간을 좁히는 사고방식은 CS/FSE의 도면 해석과 연결할 수 있습니다.
