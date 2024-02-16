#include "xparameters.h"
#include "xgpio.h"


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

#define write(data) XGpio_DiscreteWrite(&xDIN,1, data)
#define set(aux) XGpio_DiscreteWrite(&xAux,1, aux)
#define en(x) XGpio_DiscreteWrite(&xEN, 1, x)
#define read() XGpio_DiscreteRead(&xDOUT,1)
#define clean(x)	XGpio_DiscreteWrite(&xClear, 1, x)

#define aux_bit(mode_, reg_select_, idx_) ((reg_select_ << _reg_select) | (idx_ << _idx) | (mode_))

#define shutdown() en(0)

XGpio xAux, xClear, xDIN, xDOUT, xEN;


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

int connectFPGA(){
	// AXI GPIO SETUP
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

		return 0;
}
