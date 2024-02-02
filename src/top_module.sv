/*

    TODO: instead of a block of memory, 

    have multiple array for each register sequence.

    when writing, take the index, and the register number.


    // Follow SystolicArray_tb.sv PLEASE!!!

*/


module top_module(


    input CLK,
    input EN,
    // input RF_EN,                // can be removed.

    input WRITE,                    // WRITE TO INT_MEM
    // input READ,


    input LOAD,                     // Load to REGISTER FILE
    
    input [7:0]  ADDR,
    input [15:0] DATA_IN,

    output [15:0] DATA_OUT

);
    ///////////////////////////////////////////////////////////

    //                      SYSTOLIC ARRAY

    reg [4:0]   IDX = 0;
    
    reg [15:0]  DATA_0 = 0;
    reg [15:0]  DATA_1 = 0;
    reg [15:0]  DATA_2 = 0;
    reg [15:0]  DATA_3 = 0;
    reg [15:0]  DATA_4 = 0;
    reg [15:0]  DATA_5 = 0;
    reg [15:0]  DATA_6 = 0;
    reg [15:0]  DATA_7 = 0;
    reg [15:0]  DATA_8 = 0;
    reg [15:0]  DATA_9 = 0;
    reg [15:0]  DATA_10 = 0;
    reg [15:0]  DATA_11 = 0;
    reg [15:0]  DATA_12 = 0;
    reg [15:0]  DATA_13 = 0;
    reg [15:0]  DATA_14 = 0;
    reg [15:0]  DATA_15 = 0;

    
    reg [3:0]   REG_SELECT;

    /////////////////////////////////////////////////////////////
    
    //                  CONTROLLER


    reg [15:0] DATA_OUT_BUFFER = 0;

    // Internal Memory
    reg [15:0] INT_MEM [0:255];

    // Matrix 1
    reg [15:0] SEQ_0 [0:7];
    reg [15:0] SEQ_1 [0:7];
    reg [15:0] SEQ_2 [0:7];
    reg [15:0] SEQ_3 [0:7];
    reg [15:0] SEQ_4 [0:7];
    reg [15:0] SEQ_5 [0:7];
    reg [15:0] SEQ_6 [0:7];
    reg [15:0] SEQ_7 [0:7];
    
    // Matrix 2
    reg [15:0] SEQ_8 [0:7];
    reg [15:0] SEQ_9 [0:7];
    reg [15:0] SEQ_A [0:7];
    reg [15:0] SEQ_B [0:7];
    reg [15:0] SEQ_C [0:7];
    reg [15:0] SEQ_D [0:7];
    reg [15:0] SEQ_E [0:7];
    reg [15:0] SEQ_F [0:7];

    initial begin
        for (integer i = 0; i < 256; i = i + 1) begin
            INT_MEM[i[7:0]] = 16'b0;
        end
    end


    reg [31:0] IDX_COUNTER = 0;

    reg SA_EN = 0;
    reg SA_WRITE = 0;

  
  
    always@(posedge CLK) begin
        if(EN) begin

            if(LOAD) begin

                // Load to registers (constant addresses)
                if (!WRITE) begin

                    DATA_0 <= SEQ_0[IDX_COUNTER];
                    DATA_1 <= SEQ_1[IDX_COUNTER];
                    DATA_2 <= SEQ_2[IDX_COUNTER];
                    DATA_3 <= SEQ_3[IDX_COUNTER];
                    DATA_4 <= SEQ_4[IDX_COUNTER];
                    DATA_5 <= SEQ_5[IDX_COUNTER];
                    DATA_6 <= SEQ_6[IDX_COUNTER];
                    DATA_7 <= SEQ_7[IDX_COUNTER];
                    DATA_8 <= SEQ_8[IDX_COUNTER];
                    DATA_9 <= SEQ_9[IDX_COUNTER];
                    DATA_10 <= SEQ_A[IDX_COUNTER];
                    DATA_11 <= SEQ_B[IDX_COUNTER];
                    DATA_12 <= SEQ_C[IDX_COUNTER];
                    DATA_13 <= SEQ_D[IDX_COUNTER];
                    DATA_14 <= SEQ_E[IDX_COUNTER];
                    DATA_15 <= SEQ_F[IDX_COUNTER];
                    IDX_COUNTER <= IDX_COUNTER + 1;

                end

                // LOAD && WRITE == READ!
                else if(WRITE) begin
                    SA_EN <= 0;
                    SA_WRITE <= 0;

                    DATA_OUT_BUFFER <= INT_MEM[ADDR];
                end

            end

            

            // If not loading, then 
            else if(!LOAD) begin
                
                // Writing to INT_MEM
                if(WRITE) begin
                    SA_EN <= 0;
                    SA_WRITE <= 0;

                    INT_MEM[ADDR] <= DATA_IN;
                end

                
                // DO MATMUL IF NOT LOADING AND WRITING (IE IDLE!)
                else if (!WRITE) begin
                    SA_WRITE <= 0;
                    SA_EN <= 1;
                end
            end
        end

    end


    ///////////////////////////////////////////////////////////////


        
    SystolicArray sa_module(
        .CLK(CLK), .EN(SA_EN), .RF_EN(SA_EN), .WRITE(SA_WRITE), .IDX(IDX), 
        
        
        .DIN_0(DATA_0), 
        .DIN_1(DATA_1), 
        .DIN_2(DATA_2), 
        .DIN_3(DATA_3), 
        .DIN_4(DATA_4), 
        .DIN_5(DATA_5), 
        .DIN_6(DATA_6), 
        .DIN_7(DATA_7), 
        .DIN_8(DATA_8), 
        .DIN_9(DATA_9), 
        .DIN_10(DATA_10), 
        .DIN_11(DATA_11), 
        .DIN_12(DATA_12), 
        .DIN_13(DATA_13), 
        .DIN_14(DATA_14), 
        .DIN_15(DATA_15), 
        
        
        .REG_SELECT(REG_SELECT)
    );

    assign DATA_OUT = DATA_OUT_BUFFER;


endmodule