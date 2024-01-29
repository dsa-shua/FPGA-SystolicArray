/*
    matrix.hpp

    This header is used for printing, and calculating GEMM.

*/


#include <stdlib.h>
#include <stdio.h>

void printref(int** A, int DIM){
	for(int i = 0; i < DIM; i++){
		for(int j = 0; j < DIM; j++){
			printf("%3d ", A[i][j]);
		}
		printf("\n");
	}
}

void simple(int** A, int** B, int** C, int DIM){
	for(int i = 0; i < DIM; i++)
		for(int j = 0; j < DIM; j++)
			for(int k = 0; k < DIM; k++)
				C[i][j] += A[i][k] * B[k][j];
}