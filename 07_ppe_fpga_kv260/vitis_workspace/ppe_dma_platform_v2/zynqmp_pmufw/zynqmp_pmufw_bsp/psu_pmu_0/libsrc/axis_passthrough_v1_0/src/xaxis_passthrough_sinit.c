// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2022.2 (64-bit)
// Tool Version Limit: 2019.12
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#include "xparameters.h"
#include "xaxis_passthrough.h"

extern XAxis_passthrough_Config XAxis_passthrough_ConfigTable[];

XAxis_passthrough_Config *XAxis_passthrough_LookupConfig(u16 DeviceId) {
	XAxis_passthrough_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XAXIS_PASSTHROUGH_NUM_INSTANCES; Index++) {
		if (XAxis_passthrough_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XAxis_passthrough_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XAxis_passthrough_Initialize(XAxis_passthrough *InstancePtr, u16 DeviceId) {
	XAxis_passthrough_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XAxis_passthrough_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XAxis_passthrough_CfgInitialize(InstancePtr, ConfigPtr);
}

#endif

