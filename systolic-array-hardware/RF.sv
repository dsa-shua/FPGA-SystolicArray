`timescale 1ns / 1ps

// RegisterFile & Internal Controller

// Assumption:
//      The SW part already transposed the weight matrix.
//      
//      Future Work: TRANSPOSER.sv

module RF(CLK, RF_EN, WRITE, IDX, 
        DATA_IN_0,
        DATA_IN_1,
        DATA_IN_2,
        DATA_IN_3,
        DATA_IN_4,
        DATA_IN_5,
        DATA_IN_6,
        DATA_IN_7,
        DATA_IN_8,
        DATA_IN_9,
        DATA_IN_A,
        DATA_IN_B,
        DATA_IN_C,
        DATA_IN_D,
        DATA_IN_E,
        DATA_IN_F,

        // DATA_IN,

    X_OUT, W_OUT);

    input CLK;
    input RF_EN;
    
    input WRITE;                        // Are we writing to the registers?
                                        // When low, we should start MATMUL
    
    input [2:0] IDX;

    // input [15:0] DATA_IN [0:15];

    input [15:0] DATA_IN_0;
    input [15:0] DATA_IN_1;
    input [15:0] DATA_IN_2;
    input [15:0] DATA_IN_3;

    input [15:0] DATA_IN_4;
    input [15:0] DATA_IN_5;
    input [15:0] DATA_IN_6;
    input [15:0] DATA_IN_7;

    input [15:0] DATA_IN_8;
    input [15:0] DATA_IN_9;
    input [15:0] DATA_IN_A;
    input [15:0] DATA_IN_B;

    input [15:0] DATA_IN_C;
    input [15:0] DATA_IN_D;
    input [15:0] DATA_IN_E;
    input [15:0] DATA_IN_F;


    // input [3:0] REG_SELECT;             

    output [15:0] X_OUT [0:7];
    output [15:0] W_OUT [0:7];


    // Update: Automatic Shifting!
    

    // Input Matrix
    X_REG X_REG_0(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}), .DIN(DATA_IN_0), .DOUT(X_OUT[0]));

    X_REG X_REG_1(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+1), .DIN(DATA_IN_1), .DOUT(X_OUT[1]));

    X_REG X_REG_2(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+2), .DIN(DATA_IN_2), .DOUT(X_OUT[2]));

    X_REG X_REG_3(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+3), .DIN(DATA_IN_3), .DOUT(X_OUT[3]));

    X_REG X_REG_4(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+4), .DIN(DATA_IN_4), .DOUT(X_OUT[4]));

    X_REG X_REG_5(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+5), .DIN(DATA_IN_5), .DOUT(X_OUT[5]));

    X_REG X_REG_6(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+6), .DIN(DATA_IN_6), .DOUT(X_OUT[6]));

    X_REG X_REG_7(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+7), .DIN(DATA_IN_7), .DOUT(X_OUT[7]));

    

    // Weights Matrix    
    X_REG X_REG_8(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}), .DIN(DATA_IN_8), .DOUT(W_OUT[0]));

    X_REG X_REG_9(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+1), .DIN(DATA_IN_9), .DOUT(W_OUT[1]));

    X_REG X_REG_A(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+2), .DIN(DATA_IN_A), .DOUT(W_OUT[2]));

    X_REG X_REG_B(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+3), .DIN(DATA_IN_B), .DOUT(W_OUT[3]));

    X_REG X_REG_C(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+4), .DIN(DATA_IN_C), .DOUT(W_OUT[4]));

    X_REG X_REG_D(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+5), .DIN(DATA_IN_D), .DOUT(W_OUT[5]));

    X_REG X_REG_E(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+6), .DIN(DATA_IN_E), .DOUT(W_OUT[6]));

    X_REG X_REG_F(.CLK(CLK), .EN(RF_EN), .WRITE(WRITE),
        .IDX({2'b0,IDX}+7), .DIN(DATA_IN_F), .DOUT(W_OUT[7]));

    


    

endmodule