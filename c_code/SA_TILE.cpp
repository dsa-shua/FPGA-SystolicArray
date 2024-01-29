#include <stdio.h>
#include <stdlib.h>
// #include "matrix.hpp"

const int DIM = 2;

// Inputs and Weights
int matA[DIM][DIM] = {{1,2},{3,4}};
int matB[DIM][DIM] = {{5,6},{7,8}};


// Reference
int matC[DIM][DIM];

void printref(void){
	for(int i = 0; i < DIM; i++){
		for(int j = 0; j < DIM; j++){
			printf("%3d ", matC[i][j]);
		}
		printf("\n");
	}
}

void simple(void){

	for(int i = 0; i < DIM; i++)
		for(int j = 0; j < DIM; j++)
			for(int k = 0; k < DIM; k++)
				matC[i][j] += matA[i][k] * matB[k][j];

}

int main(void){

    printf("Hello world!\n");

    simple();
    printref();

    printf("Bye!\n");

    return 0;
}