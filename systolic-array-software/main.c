#include <stdlib.h>
#include <stdbool.h>
#include <stdio.h>
#include "xgpio.h"
#include "xil_io.h"
#include "xparameters.h"

#include <string.h>
#include "matrix.h"
#include "sa_interrupt.h"
#include "SystolicArray.h"

#include "xtime_l.h"


int main(void){

	// For measuring speed
	float matmul_time, full_time;
	XTime startMatmul, endMatmul;
	XTime fullStart, fullEnd;
	char matmul_str[50];
	char full_str[50];

	////////////////////////////////////////////////////////////

	// SETUP

	xil_printf("Hello world!\n\r");
	interrupt_init();
	if(connectFPGA()){
		printf("gpio error");
		return 1;
	}

	////////////////////////////////////////////////////////////

	// Running Kernel
	XTime_GetTime(&fullStart);


	// Writing to Memory (Matrix A)
	for(int i = 0; i < 8; i++){
		for(int j = 0; j < 8; j++) {
			mem_write(matrixA[i*8 + j],i,j);
		}
	}

	// Writing to Memory (Matrix B)
	for(int i = 0; i < 8; i++){
			for(int j = 0; j < 8; j++) {
				mem_write(matrixB[i*8 + j],i+8,j);
			}
	}

	// Loading to (Shift Registers)
	load_regs();
	while(!isInterrupted)
	isInterrupted = false;

	// Doing Matrix multiplication
	XTime_GetTime(&startMatmul);
	do_matmul();
	while(!isInterrupted)
	isInterrupted = false;

	XTime_GetTime(&endMatmul);
	matmul_time = (float)(endMatmul - startMatmul)/(COUNTS_PER_SECOND);



	// Reading and printing out results
	for(int regx = 0; regx < 8; regx++){
		for(int elem = 0; elem < 8; elem++){
			printf(" [ %2u ] ", (u32)mem_read(regx, elem));
		}
		printf("\n\r");
	}


	////////////////////////////////////////////////////////////

	// Printing Time Statistics

	XTime_GetTime(&fullEnd);
	full_time = (float)(fullEnd - fullStart)/(COUNTS_PER_SECOND);


	sprintf(matmul_str, "matmul time = %f secs\r\n", matmul_time);
	xil_printf(matmul_str);
	sprintf(full_str, "full time = %f secs\r\n", full_time);
	xil_printf(full_str);

	shutdown();


	return 0;
}
