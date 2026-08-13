// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
/***************************** Include Files *********************************/
#include "xaxis_passthrough.h"

/************************** Function Implementation *************************/
#ifndef __linux__
int XAxis_passthrough_CfgInitialize(XAxis_passthrough *InstancePtr, XAxis_passthrough_Config *ConfigPtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(ConfigPtr != NULL);

    InstancePtr->Control_BaseAddress = ConfigPtr->Control_BaseAddress;
    InstancePtr->IsReady = XIL_COMPONENT_IS_READY;

    return XST_SUCCESS;
}
#endif

void XAxis_passthrough_Start(XAxis_passthrough *InstancePtr) {
    u32 Data;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAxis_passthrough_ReadReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_AP_CTRL) & 0x80;
    XAxis_passthrough_WriteReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_AP_CTRL, Data | 0x01);
}

u32 XAxis_passthrough_IsDone(XAxis_passthrough *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAxis_passthrough_ReadReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_AP_CTRL);
    return (Data >> 1) & 0x1;
}

u32 XAxis_passthrough_IsIdle(XAxis_passthrough *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAxis_passthrough_ReadReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_AP_CTRL);
    return (Data >> 2) & 0x1;
}

u32 XAxis_passthrough_IsReady(XAxis_passthrough *InstancePtr) {
    u32 Data;

    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Data = XAxis_passthrough_ReadReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_AP_CTRL);
    // check ap_start to see if the pcore is ready for next input
    return !(Data & 0x1);
}

void XAxis_passthrough_EnableAutoRestart(XAxis_passthrough *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxis_passthrough_WriteReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_AP_CTRL, 0x80);
}

void XAxis_passthrough_DisableAutoRestart(XAxis_passthrough *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxis_passthrough_WriteReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_AP_CTRL, 0);
}

void XAxis_passthrough_InterruptGlobalEnable(XAxis_passthrough *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxis_passthrough_WriteReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_GIE, 1);
}

void XAxis_passthrough_InterruptGlobalDisable(XAxis_passthrough *InstancePtr) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxis_passthrough_WriteReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_GIE, 0);
}

void XAxis_passthrough_InterruptEnable(XAxis_passthrough *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XAxis_passthrough_ReadReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_IER);
    XAxis_passthrough_WriteReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_IER, Register | Mask);
}

void XAxis_passthrough_InterruptDisable(XAxis_passthrough *InstancePtr, u32 Mask) {
    u32 Register;

    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    Register =  XAxis_passthrough_ReadReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_IER);
    XAxis_passthrough_WriteReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_IER, Register & (~Mask));
}

void XAxis_passthrough_InterruptClear(XAxis_passthrough *InstancePtr, u32 Mask) {
    Xil_AssertVoid(InstancePtr != NULL);
    Xil_AssertVoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    XAxis_passthrough_WriteReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_ISR, Mask);
}

u32 XAxis_passthrough_InterruptGetEnabled(XAxis_passthrough *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XAxis_passthrough_ReadReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_IER);
}

u32 XAxis_passthrough_InterruptGetStatus(XAxis_passthrough *InstancePtr) {
    Xil_AssertNonvoid(InstancePtr != NULL);
    Xil_AssertNonvoid(InstancePtr->IsReady == XIL_COMPONENT_IS_READY);

    return XAxis_passthrough_ReadReg(InstancePtr->Control_BaseAddress, XAXIS_PASSTHROUGH_CONTROL_ADDR_ISR);
}

