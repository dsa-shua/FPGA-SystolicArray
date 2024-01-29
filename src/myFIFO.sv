`timescale 1ns / 1ps

/*
    myFIFO

    This FIFO is used for input registers to the systolic array.
    Size is based on the Xilinx FIFO IP block's size.

*/

module myFIFO(DATA_IN, DATA_OUT, CLK, WRITE, ENABLE, 
            ALMOST_FULL, ALMOST_EMPTY, FULL, EMPTY);
    input   [31:0]  DATA_IN;
    output  [31:0]  DATA_OUT;
    
    input WRITE;
    input ENABLE;
    input CLK;

    output ALMOST_FULL;
    output FULL;
    output ALMOST_EMPTY;
    output EMPTY;

    reg [4:0] tail = 0;


    localparam DEPTH = 5'd16;
    localparam ALMOST_FULL_TH = 12;
    localparam ALMOST_EMPTY_TH = 4;

    // Make sure it is initialized!
    reg [31:0] PIPE [0:15] = {0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    reg [31:0] OUT_BUFF = 0;

    always@(posedge CLK) begin
        if (ENABLE && WRITE && tail < DEPTH) begin
            PIPE[tail[3:0]] <= DATA_IN;
            tail <= tail + 1;
        end
        else if (ENABLE && !WRITE && tail != 0) begin
            OUT_BUFF <= PIPE[0];
            PIPE[0] <= PIPE[1];
            PIPE[1] <= PIPE[2];
            PIPE[2] <= PIPE[3];
            PIPE[3] <= PIPE[4];
            PIPE[4] <= PIPE[5];
            PIPE[5] <= PIPE[6];
            PIPE[6] <= PIPE[7];
            PIPE[7] <= PIPE[8];
            PIPE[8] <= PIPE[9];
            PIPE[9] <= PIPE[10];
            PIPE[10] <= PIPE[11];
            PIPE[11] <= PIPE[12];
            PIPE[12] <= PIPE[13];
            PIPE[13] <= PIPE[14];
            PIPE[14] <= PIPE[15];
            tail <= tail - 1;
        end
    end
 


    // Status Pins
    assign FULL         = (tail == DEPTH)   ? 1 : 0;
    assign EMPTY        = (tail == 0)       ? 1 : 0;
    
    assign ALMOST_FULL  = (tail > ALMOST_FULL_TH)  ? 1 : 0;
    assign ALMOST_EMPTY = (tail < ALMOST_EMPTY_TH) ? 1 : 0;

    assign DATA_OUT     = OUT_BUFF;
endmodule