
#include <string>
#define N 9				// 9 cell
#define LEN 3   			// 3x3

// Input Registers (connected to ROW 1 and COL1), 6 registers
struct XREG{
	unsigned int A_data;
	unsigned int B_data;
};


// Register File for Inputs to Systolic Array
struct REGISTERS{
	struct XREG* r0;
	struct XREG* r1;
	struct XREG* r2;
	struct XREG* c0;
	struct XREG* c1;
	struct XREG* c2;
	std::string name;		// for debugging
};


// Simple Processing Element Systolic Array
struct PE {
	struct PE* top;
	struct PE* bot;
	struct PE* left;
	struct PE* right;
	unsigned int A_data;
	unsigned int B_data;
	unsigned int A_temp;
	unsigned int B_temp;
	unsigned int ACC; 		// temporary calculation
};


// 3x3 Systolic Array
struct SystolicArray{
	struct PE* c0;		// top edge + left edge
	struct PE* c1;		// top edge
	struct PE* c2;		// top edge
	struct PE* c3;		// left edge
	struct PE* c4;
	struct PE* c5;
	struct PE* c6;		// left edge
	struct PE* c7;
	struct PE* c8;
	std::string name;		// for debugging
};

// Do MAC (specific)
void MAC(struct PE* C){
	C->ACC += (C->A_data * C->B_data);
}


// Do matrix matrix multiplication
void process(struct SystolicArray* SA){
	
	MAC(SA->c0);
	MAC(SA->c1);
	MAC(SA->c2);
	MAC(SA->c3);
	MAC(SA->c4);
	MAC(SA->c5);
	MAC(SA->c6);
	MAC(SA->c7);
	MAC(SA->c8);

}


// TODO: Have propagate done  
// Propagate Data from Left to Right, Top to Bot (All at once)
void propagate(struct SystolicArray* SA, struct REGISTERS* RF){
	// Separate cells next to registers

	SA->c0->A_temp = RF->r0->A_data;
	SA->c0->B_temp = RF->c0->B_data;

	SA->c1->A_temp = SA->c0->A_data;
	SA->c1->B_temp = RF->c1->B_data;

	SA->c2->A_temp = SA->c1->A_data;
	SA->c2->B_temp = RF->c2->B_data;

	//...
	SA->c3->A_temp = RF->r1->A_data;
	SA->c3->B_temp = SA->c0->B_data;
	
	SA->c4->A_temp = SA->c3->A_data;
	SA->c4->B_temp = SA->c1->B_data;

	SA->c5->A_temp = SA->c4->A_data;
	SA->c5->B_temp = SA->c2->B_data;

	//...
	SA->c6->A_temp = RF->r2->A_data;
	SA->c6->B_temp = SA->c3->B_data;
	
	SA->c7->A_temp = SA->c6->A_data;
	SA->c7->B_temp = SA->c4->B_data;

	SA->c8->A_temp = SA->c7->A_data;
	SA->c8->B_temp = SA->c5->B_data;


	// Commit From Temp
	SA->c0->A_data = SA->c0->A_temp;
	SA->c0->B_data = SA->c0->B_temp;

	SA->c1->A_data = SA->c1->A_temp;
	SA->c1->B_data = SA->c1->B_temp;
	
	SA->c2->A_data = SA->c2->A_temp;
	SA->c2->B_data = SA->c2->B_temp;


	//...
	SA->c3->A_data = SA->c3->A_temp;
	SA->c3->B_data = SA->c3->B_temp;
	
	SA->c4->A_data = SA->c4->A_temp;
	SA->c4->B_data = SA->c4->B_temp;

	SA->c5->A_data = SA->c5->A_temp;
	SA->c5->B_data = SA->c5->B_temp;

	//...
	SA->c6->A_data = SA->c6->A_temp;
	SA->c6->B_data = SA->c6->B_temp;

	SA->c7->A_data = SA->c7->A_temp;
	SA->c7->B_data = SA->c7->B_temp;

	SA->c8->A_data = SA->c8->A_temp;
	SA->c8->B_data = SA->c8->B_temp;
}

void printArray(struct SystolicArray* SA){
	printf("Systolic Array [ACC | A | B]:\n");
	printf("	c0 >> [ %d | %d | %d ]\n", SA->c0->ACC, SA->c0->A_data, SA->c0->B_data);
	printf("	c1 >> [ %d | %d | %d ]\n", SA->c1->ACC, SA->c1->A_data, SA->c1->B_data);
	printf("	c2 >> [ %d | %d | %d ]\n", SA->c2->ACC, SA->c2->A_data, SA->c2->B_data);
	printf("	c3 >> [ %d | %d | %d ]\n", SA->c3->ACC, SA->c3->A_data, SA->c3->B_data);
	printf("	c4 >> [ %d | %d | %d ]\n", SA->c4->ACC, SA->c4->A_data, SA->c4->B_data);
	printf("	c5 >> [ %d | %d | %d ]\n", SA->c5->ACC, SA->c5->A_data, SA->c5->B_data);
	printf("	c6 >> [ %d | %d | %d ]\n", SA->c6->ACC, SA->c6->A_data, SA->c6->B_data);
	printf("	c7 >> [ %d | %d | %d ]\n", SA->c7->ACC, SA->c7->A_data, SA->c7->B_data);
	printf("	c8 >> [ %d | %d | %d ]\n", SA->c8->ACC, SA->c8->A_data, SA->c8->B_data);
}

void printRF(struct REGISTERS* rf){
	printf("RegisterFile: [A_data, B_data]\n");

	printf("	[r0]: [ %d | %d ]\n", rf->r0->A_data, rf->r0->B_data);
	printf("	[r1]: [ %d | %d ]\n", rf->r1->A_data, rf->r1->B_data);
	printf("	[r2]: [ %d | %d ]\n", rf->r2->A_data, rf->r2->B_data);
	printf("	[c0]: [ %d | %d ]\n", rf->c0->A_data, rf->c0->B_data);
	printf("	[c1]: [ %d | %d ]\n", rf->c1->A_data, rf->c1->B_data);
	printf("	[c2]: [ %d | %d ]\n", rf->c2->A_data, rf->c2->B_data);
}

void initialize(struct SystolicArray* SA, struct REGISTERS* RF){
	// Naive Allocation
	SA->c0 = (struct PE*)malloc(sizeof(struct PE));
	SA->c1 = (struct PE*)malloc(sizeof(struct PE));
	SA->c2 = (struct PE*)malloc(sizeof(struct PE));
	SA->c3 = (struct PE*)malloc(sizeof(struct PE));
	SA->c4 = (struct PE*)malloc(sizeof(struct PE));
	SA->c5 = (struct PE*)malloc(sizeof(struct PE));
	SA->c6 = (struct PE*)malloc(sizeof(struct PE));
	SA->c7 = (struct PE*)malloc(sizeof(struct PE));
	SA->c8 = (struct PE*)malloc(sizeof(struct PE));

	RF->r0 = (struct XREG*)malloc(sizeof(struct XREG));
	RF->r1 = (struct XREG*)malloc(sizeof(struct XREG));
	RF->r2 = (struct XREG*)malloc(sizeof(struct XREG));
	RF->c0 = (struct XREG*)malloc(sizeof(struct XREG));
	RF->c1 = (struct XREG*)malloc(sizeof(struct XREG));
	RF->c2 = (struct XREG*)malloc(sizeof(struct XREG));


	// Connect the PE Cells
	SA->c0->top 	= NULL;
	SA->c0->bot 	= SA->c3;
	SA->c0->left 	= NULL;
	SA->c0->right 	= SA->c1;

	SA->c1->top	= NULL;
	SA->c1->bot	= SA->c4;
	SA->c1->left 	= SA->c0;
	SA->c1->right	= SA->c2;

	SA->c2->top	= NULL;
	SA->c2->bot 	= SA->c5;
	SA->c2->left 	= SA->c1;
	SA->c2->right	= NULL;

	SA->c3->top	= SA->c1;
	SA->c3->bot	= SA->c6;
	SA->c3->left	= NULL;
	SA->c3->right	= SA->c4;

	SA->c4->top	= SA->c1;
	SA->c4->bot	= SA->c7;
	SA->c4->left	= SA->c3;
	SA->c4->right	= SA->c5;

	SA->c5->top	= SA->c2;
	SA->c5->bot	= SA->c8;
	SA->c5->left	= SA->c4;
	SA->c5->right	= NULL;

	SA->c6->top	= SA->c3;
	SA->c6->bot	= NULL;
	SA->c6->left	= NULL;
	SA->c6->right	= SA->c7;

	SA->c7->top	= SA->c4;
	SA->c7->bot	= NULL;
	SA->c7->left	= SA->c6;
	SA->c7->right	= SA->c8;

	SA->c8->top	= SA->c5;
	SA->c8->bot	= NULL;
	SA->c8->left	= SA->c7;
	SA->c8->right	= NULL;


	// Initialize Values
	SA->c0->A_data = 0;
	SA->c1->A_data = 0;
	SA->c2->A_data = 0;
	SA->c3->A_data = 0;
	SA->c4->A_data = 0;
	SA->c5->A_data = 0;
	SA->c6->A_data = 0;
	SA->c7->A_data = 0;
	SA->c8->A_data = 0;
	
	SA->c0->B_data = 0;
	SA->c1->B_data = 0;
	SA->c2->B_data = 0;
	SA->c3->B_data = 0;
	SA->c4->B_data = 0;
	SA->c5->B_data = 0;
	SA->c6->B_data = 0;
	SA->c7->B_data = 0;
	SA->c8->B_data = 0;

	SA->c0->ACC = 0;
	SA->c1->ACC = 0;
	SA->c2->ACC = 0;
	SA->c3->ACC = 0;
	SA->c4->ACC = 0;
	SA->c5->ACC = 0;
	SA->c6->ACC = 0;
	SA->c7->ACC = 0;
	SA->c8->ACC = 0;



	RF->r0->A_data = 0;
	RF->r1->A_data = 0;
	RF->r2->A_data = 0;
	RF->c0->B_data = 0;
	RF->c1->B_data = 0;
	RF->c2->B_data = 0;	
}
