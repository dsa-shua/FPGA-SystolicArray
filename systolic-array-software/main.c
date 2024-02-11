#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>
#include "xgpio.h"
#include "xil_io.h"
#include "xparameters.h"
#include <time.h>
#include "xscugic.h"

#define AUX_ADDR	 		0x41200000
#define CLEAR_ADDR 		0x41210000
#define DATA_IN_ADDR 	0x41220000
#define DATA_OUT_ADDR 	0x41230000
#define EN_ADDR			0x41240000

#define AUX_ID			0
#define CLEAR_ID 			1
#define DIN_ID 			2
#define DOUT_ID 			3
#define EN_ID				4

#define TO_PL				0
#define TO_PS				1

// Shiftting
#define _write			0
#define _load				1
#define _idx 				2
#define _reg_select 		5


#define set_write			1
#define set_load			2
#define set_matmul		0
#define set_read			3

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//
//#define XPAR_FABRIC_EXT_IRQ_INTR 61U
//
//XScuGic InterruptController;
//static XScuGic_Config *GicConfig;
//bool INTERRUPTED = false;
//void Interrupt_Handler(void *InstancePtr) {
//	INTERRUPTED = true;
//}
//
//int interrupt_init()
//{
//	int Status;
//
//	GicConfig = XScuGic_LookupConfig(XPAR_PS7_SCUGIC_0_DEVICE_ID);
//	if (NULL == GicConfig) {
//		return XST_FAILURE;
//	}
//	Status = XScuGic_CfgInitialize(&InterruptController, GicConfig, GicConfig->CpuBaseAddress);
//	if (Status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}
//
//	Status = SetUpInterruptSystem(&InterruptController);
//	if (Status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}
//
//	Status = XScuGic_Connect(&InterruptController, XPAR_FABRIC_EXT_IRQ_INTR, (Xil_ExceptionHandler)Interrupt_Handler, (void *)NULL);
//	if (Status != XST_SUCCESS) {
//		return XST_FAILURE;
//	}
//
//	XScuGic_Enable(&InterruptController, XPAR_FABRIC_EXT_IRQ_INTR);
//
//	return XST_SUCCESS;
//}
//
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////

XGpio xAux, xClear, xDIN, xDOUT, xEN;



#define write(data) XGpio_DiscreteWrite(&xDIN,1, data)
#define set(aux) XGpio_DiscreteWrite(&xAux,1, aux)
#define en(x) XGpio_DiscreteWrite(&xEN, 1, x)
#define read() XGpio_DiscreteRead(&xDOUT,1)
#define clean(x)	XGpio_DiscreteWrite(&xClear, 1, x)

#define aux_bit(mode_, reg_select_, idx_) ((reg_select_ << _reg_select) | (idx_ << _idx) | (mode_))

#define shutdown() en(0)


for(int regx = 0; regx < 8; regx++){
	for(int elem = 0; elem < 8; elem++){
		printf(" [ %2d ] ", mem_read(regx, elem));
	}
	printf("\n");
}

void mem_write(int data, int reg_select, int idx){
	en(0);
	write(data);
	set(aux_bit(set_write, reg_select, idx));
	en(1);
}

void load_regs(){
	en(0);
	set(set_load);
	en(1);
}

void do_matmul(){
	en(0);
	set(set_matmul);
	en(1);
}

volatile u32 mem_read(int reg_select, int idx){
	en(0);
	set(aux_bit(set_read, reg_select,idx));
	en(1);
	return read();
}





u32 show_aux(int mode_, int reg_select_, int idx_){
	return ((reg_select_ << _reg_select) | (idx_ << _idx) | (mode_));
}

// 8x8 serial matrix multiplication
int* matmul(int* matA, int* matB){
	int* temp = (int*)malloc(sizeof(int) * 64);
	for(int i = 0; i < 8; i++)
		for(int j = 0; j < 8; j++)
			for(int k = 0; k < 8; k++)
				temp[i*8 + j] += matA[i*8 + k] * matB[k*8 + j];

	return temp;
}


void LED_TEST(){
	en(0);
	usleep(500000);
	set(set_read);
	usleep(500000);
	set(set_write);
	usleep(500000);
	set(set_load);
	usleep(500000);
	set(set_matmul);
}

int base_matrix[64] = {
	1,2,3,4,5,6,7,8,
	1,2,3,4,5,6,7,8,
	1,2,3,4,5,6,7,8,
	1,2,3,4,5,6,7,8,
	1,2,3,4,5,6,7,8,
	1,2,3,4,5,6,7,8,
	1,2,3,4,5,6,7,8,
	1,2,3,4,5,6,7,8
};

// Transposed Matrix!!!
int matrixA[64] = {
		0, 2, 3, 1, 0, 1, 2, 3,
		0, 2, 0, 3, 1, 1, 4, 4,
		1, 2, 4, 4, 2, 4, 3, 0,
		0, 2, 4, 2, 2, 0, 4, 2,
		2, 2, 0, 0, 4, 4, 3, 1,
		2, 4, 4, 0, 2, 0, 0, 3,
		4, 1, 4, 1, 3, 3, 3, 3,
		2, 4, 1, 4, 4, 2, 3, 4
};

int matrixB[64] = {
		4, 0, 3, 1, 0, 1, 1, 1,
		3, 3, 4, 4, 1, 0, 3, 2,
		4, 4, 1, 1, 1, 2, 0, 4,
		3, 2, 3, 1, 0, 1, 0, 4,
		0, 3, 2, 1, 2, 2, 0, 4,
		4, 1, 0, 4, 3, 2, 1, 1,
		1, 2, 1, 2, 4, 1, 1, 0,
		2, 3, 1, 1, 0, 2, 1, 4
};

int zeros[64] = {
		0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0,
		0,0,0,0,0,0,0,0
};


int main(void){

//	FILE *f = fopen("result.txt", "w");
//	if (f == NULL){
//		printf("Error opening file!\n");
//		return 1;
//	}


	if(XGpio_Initialize(&xAux, AUX_ID) != XST_SUCCESS){
		printf( "aux init fail\n");
		return 1;
	}

	if(XGpio_Initialize(&xClear, CLEAR_ID) != XST_SUCCESS){
			printf("clear init fail\n");
			return 1;
	}

	if(XGpio_Initialize(&xDIN, DIN_ID) != XST_SUCCESS){
				printf("din init fail\n");
				return 1;
	}

	if(XGpio_Initialize(&xDOUT, DOUT_ID) != XST_SUCCESS){
				printf("dout init fail\n");
				return 1;
	}

	if(XGpio_Initialize(&xEN, EN_ID) != XST_SUCCESS){
				printf("en init fail\n");
				return 1;
	}


	XGpio_SetDataDirection(&xAux, 1, TO_PL);
	XGpio_SetDataDirection(&xClear, 1, TO_PL);
	XGpio_SetDataDirection(&xDIN, 1, TO_PL);
	XGpio_SetDataDirection(&xDOUT, 1, TO_PS);
	XGpio_SetDataDirection(&xEN, 1, TO_PL);

	printf("Hello world!\n");


	///////////////////////////////////////////////////////////////////////

	// Write To Memory


//	printf("Write to memory...");
	for(int i = 0; i < 8; i++){
		for(int j = 0; j < 8; j++) {
			mem_write(matrixA[i*8 + j],i,j);
		}
	}

	// Matrix B
	for(int i = 0; i < 8; i++){
			for(int j = 0; j < 8; j++) {
				mem_write(matrixB[i*8 + j],i+8,j);
			}
	}


	load_regs();

	usleep(1); // replace with interrupt

	do_matmul();

	usleep(1); // replace with interrupt

	for(int regx = 0; regx < 8; regx++){
		for(int elem = 0; elem < 8; elem++){
			printf(" [ %2d ] ", mem_read(regx, elem));
		}
		printf("\n");
	}

	shutdown();


	return 0;
}

