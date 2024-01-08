// #include "headers.hpp"

#include <iostream>
#include <stdlib.h>
#include "systolic.h"

struct SystolicArray* systolic  = 0;
struct REGISTERS* regfile = 0;

int matrixA[3][3] = {
	{1,2,3},
	{4,5,6},
	{7,8,9}};

int matrixBt[3][3] = {
	{10,11,12},
	{13,14,15},
	{16,17,18}
};

int matrixB[3][3] = {
	{10, 13, 16},{11,14,17},{12,15,18}
};

int reference[3][3];



void printref(void){
	for(int i = 0; i < 3; i++){
		for(int j = 0; j < 3; j++){
			printf("%d ", reference[i][j]);
		}
		printf("\n");
	}
}

void simple(void){

	for(int i = 0; i < 3; i++)
		for(int j = 0; j < 3; j++)
			for(int k = 0; k < 3; k++)
				reference[i][j] += matrixA[i][k] * matrixBt[k][j];

}



int main(void){
	std::cout << "Hello World!" << std::endl; 
	
	systolic = (struct SystolicArray*)malloc(sizeof(struct SystolicArray));
	regfile = (struct REGISTERS*)malloc(sizeof(struct REGISTERS));

	if(!systolic) {
		printf("Failed to allocate memory for systolic array!\n");
		goto fail;
	} else {
	    	printf("Success! (SA)\n");
    	}

	if(!regfile) {
		printf("Failed to allocate memory for register file!\n");
		goto fail;}
	else printf("Success (RF)\n");


    	
   	initialize(systolic, regfile);
	printArray(systolic);
	
	// Start 
	
	// ITER 0:
	printf("\nITER 0\n");
	regfile->r0->A_data = matrixA[0][0];
	regfile->c0->B_data = matrixB[0][0];
	
	printRF(regfile);
	
	printf("\nITER 1\n");
	
	propagate(systolic, regfile);
	process(systolic);

	// ITER 1:
	regfile->r0->A_data = matrixA[0][1];
	regfile->r1->A_data = matrixA[1][0];
	
	regfile->c0->B_data = matrixB[0][1];
	regfile->c1->B_data = matrixB[1][0];

	printRF(regfile);
	printArray(systolic);

	printf("\nITER 2\n");
	propagate(systolic, regfile);
	process(systolic);

	// ITER 2:
	regfile->r0->A_data = matrixA[0][2];
	regfile->r1->A_data = matrixA[1][1];
	regfile->r2->A_data = matrixA[2][0];

	regfile->c0->B_data = matrixB[0][2];
	regfile->c1->B_data = matrixB[1][1];
	regfile->c2->B_data = matrixB[2][0];

	printRF(regfile);
	printArray(systolic);
	

	// ITER 3:
	printf("\nITER 3\n");
	propagate(systolic, regfile);
	process(systolic);
	
	regfile->r0->A_data = 0;
	regfile->r1->A_data = matrixA[1][2];
	regfile->r2->A_data = matrixA[2][1];

	regfile->c0->B_data = 0;
	regfile->c1->B_data = matrixB[1][2];
	regfile->c2->B_data = matrixB[2][1];

	printRF(regfile);
	printArray(systolic);


	// ITER 4:
	printf("\nITER 4\n");
	propagate(systolic, regfile);
	process(systolic);

	regfile->r0->A_data = 0;
	regfile->r1->A_data = 0;
	regfile->r2->A_data = matrixA[2][2];

	regfile->c0->B_data = 0;
	regfile->c1->B_data = 0;
	regfile->c2->B_data = matrixB[2][2];

	printRF(regfile);
	printArray(systolic);

	// ITER 5:
	printf("\nITER 5\n");
	propagate(systolic, regfile);
	process(systolic);

	regfile->r0->A_data = 0;
	regfile->r1->A_data = 0;
	regfile->r2->A_data = 0;

	regfile->c0->B_data = 0;
	regfile->c1->B_data = 0;
	regfile->c2->B_data = 0;

	printRF(regfile);
	printArray(systolic);
	
	
	// ITER 6:
	printf("\nITER 6:\n");
	propagate(systolic,regfile);
	process(systolic);
	printRF(regfile);
	printArray(systolic);

	// ITER 7
	printf("\nITER 7:\n");
	propagate(systolic, regfile);
	process(systolic);
	printRF(regfile);
	printArray(systolic);


	// ITER 8
	printf("\nITER 8: \n");
	propagate(systolic, regfile);
	process(systolic);
	printRF(regfile);
	printArray(systolic);






	printf("DONE!\n");

	simple();
	printref();	

success:    
    	return 0;

fail:
    	return 1;
}
