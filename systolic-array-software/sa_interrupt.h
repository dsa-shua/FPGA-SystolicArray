#include "xscugic.h"
#include "xparameters.h"
#include <stdbool.h>

#define XPAR_FABRIC_EXT_IRQ_INTR 61U
#define XGPIOPS_IRQ_TYPE_EDGE_RISING 0x3

bool isInterrupted = false;

XScuGic InterruptController;
static XScuGic_Config *GicConfig;

void ExtIrq_Handler(void *InstancePtr)
{
  isInterrupted = true;
}

int SetUpInterruptSystem(XScuGic *XScuGicInstancePtr)
{
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT, (Xil_ExceptionHandler) XScuGic_InterruptHandler, XScuGicInstancePtr);
	Xil_ExceptionEnable();
	return XST_SUCCESS;
}

int interrupt_init()
{
	int Status;

	GicConfig = XScuGic_LookupConfig(XPAR_PS7_SCUGIC_0_DEVICE_ID);
	if (NULL == GicConfig) {
		return XST_FAILURE;
	}
	Status = XScuGic_CfgInitialize(&InterruptController, GicConfig, GicConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XScuGic_SetPriorityTriggerType(&InterruptController, XPAR_FABRIC_EXT_IRQ_INTR, 0xA0, XGPIOPS_IRQ_TYPE_EDGE_RISING);


	Status = SetUpInterruptSystem(&InterruptController);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	Status = XScuGic_Connect(&InterruptController, XPAR_FABRIC_EXT_IRQ_INTR, (Xil_ExceptionHandler)ExtIrq_Handler, (void *)NULL);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XScuGic_Enable(&InterruptController, XPAR_FABRIC_EXT_IRQ_INTR);


	return XST_SUCCESS;
}
