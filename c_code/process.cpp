// TEST FOR A BIGGER SYSTOLIC ARRAY REFERENCE (no implementation)


#include "systolic.h"
#include <stdlib.h>
#include <stdio.h>

#define DIM 8

using namespace std;




int matrixA[DIM][DIM] = {
	{1,2,3,4,5,6,7,8},
    {1,2,3,4,5,6,7,8},
    {1,2,3,4,5,6,7,8},
    {1,2,3,4,5,6,7,8},
    {1,2,3,4,5,6,7,8},
    {1,2,3,4,5,6,7,8},
    {1,2,3,4,5,6,7,8},
    {1,2,3,4,5,6,7,8}
};

int matrixBt[DIM][DIM] = {
	{10,11,12,13,14,15,16,17},
    {10,11,12,13,14,15,16,17},
    {10,11,12,13,14,15,16,17},
    {10,11,12,13,14,15,16,17},
    {10,11,12,13,14,15,16,17},
    {10,11,12,13,14,15,16,17},
    {10,11,12,13,14,15,16,17},
    {10,11,12,13,14,15,16,17}
};

// int matrixB[16][16] = {
// 	{10, 13, 16},{11,14,17},{12,15,18}
// };

int reference[DIM][DIM];


void printref(void){
	for(int i = 0; i < DIM; i++){
		for(int j = 0; j < DIM; j++){
			printf("%3d ", reference[i][j]);
		}
		printf("\n");
	}
}

void simple(void){

	for(int i = 0; i < DIM; i++)
		for(int j = 0; j < DIM; j++)
			for(int k = 0; k < DIM; k++)
				reference[i][j] += matrixA[i][k] * matrixBt[k][j];

}



int main(void){

    simple();

    printref();
success:
    return 0;

fail:
    return 1;
}
