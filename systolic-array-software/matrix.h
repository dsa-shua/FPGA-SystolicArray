// Input and Weights Matrices




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

// Transposed Matrix!!!
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


// For DEBUG: 8x8 serial matrix multiplication
int* matmul(int* matA, int* matB){
	int* temp = (int*)malloc(sizeof(int) * 64);
	for(int i = 0; i < 8; i++)
		for(int j = 0; j < 8; j++)
			for(int k = 0; k < 8; k++)
				temp[i*8 + j] += matA[i*8 + k] * matB[k*8 + j];

	return temp;
}

