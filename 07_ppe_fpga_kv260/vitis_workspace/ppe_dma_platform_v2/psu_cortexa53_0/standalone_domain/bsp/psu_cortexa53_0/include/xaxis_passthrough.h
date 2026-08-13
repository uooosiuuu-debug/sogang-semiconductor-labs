// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef XAXIS_PASSTHROUGH_H
#define XAXIS_PASSTHROUGH_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xaxis_passthrough_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
    u16 DeviceId;
    u64 Control_BaseAddress;
} XAxis_passthrough_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XAxis_passthrough;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XAxis_passthrough_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XAxis_passthrough_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XAxis_passthrough_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XAxis_passthrough_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
int XAxis_passthrough_Initialize(XAxis_passthrough *InstancePtr, u16 DeviceId);
XAxis_passthrough_Config* XAxis_passthrough_LookupConfig(u16 DeviceId);
int XAxis_passthrough_CfgInitialize(XAxis_passthrough *InstancePtr, XAxis_passthrough_Config *ConfigPtr);
#else
int XAxis_passthrough_Initialize(XAxis_passthrough *InstancePtr, const char* InstanceName);
int XAxis_passthrough_Release(XAxis_passthrough *InstancePtr);
#endif

void XAxis_passthrough_Start(XAxis_passthrough *InstancePtr);
u32 XAxis_passthrough_IsDone(XAxis_passthrough *InstancePtr);
u32 XAxis_passthrough_IsIdle(XAxis_passthrough *InstancePtr);
u32 XAxis_passthrough_IsReady(XAxis_passthrough *InstancePtr);
void XAxis_passthrough_EnableAutoRestart(XAxis_passthrough *InstancePtr);
void XAxis_passthrough_DisableAutoRestart(XAxis_passthrough *InstancePtr);


void XAxis_passthrough_InterruptGlobalEnable(XAxis_passthrough *InstancePtr);
void XAxis_passthrough_InterruptGlobalDisable(XAxis_passthrough *InstancePtr);
void XAxis_passthrough_InterruptEnable(XAxis_passthrough *InstancePtr, u32 Mask);
void XAxis_passthrough_InterruptDisable(XAxis_passthrough *InstancePtr, u32 Mask);
void XAxis_passthrough_InterruptClear(XAxis_passthrough *InstancePtr, u32 Mask);
u32 XAxis_passthrough_InterruptGetEnabled(XAxis_passthrough *InstancePtr);
u32 XAxis_passthrough_InterruptGetStatus(XAxis_passthrough *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
