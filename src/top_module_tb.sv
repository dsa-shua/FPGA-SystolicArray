module top_module_tb();

    reg CLK;
    reg EN;
    reg WRITE;
    reg LOAD;
    
    wire [15:0] DATA_OUT;
    reg [15:0] DATA_IN;

    reg [2:0] IDX_SELECT;
    reg [3:0] REG_SELECT;

/*
    // TEST 1
    reg [15:0] EXTERNAL_DATA_0 [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_1 [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_2 [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_3 [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_4 [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_5 [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_6 [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_7 [0:7] = {1,2,3,4,5,6,7,8};


    // Transposed Weights Matrix
    reg [15:0] EXTERNAL_DATA_8 [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_9 [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_A [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_B [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_C [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_D [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_E [0:7] = {1,2,3,4,5,6,7,8};
    reg [15:0] EXTERNAL_DATA_F [0:7] = {1,2,3,4,5,6,7,8};
*/



////////////////////////////////////////////////////////////////////

    // TEST 2

    reg [15:0] EXTERNAL_DATA_0 [0:7] = {0, 2, 3, 1, 0, 1, 2, 3};
    reg [15:0] EXTERNAL_DATA_1 [0:7] = {0, 2, 0, 3, 1, 1, 4, 4};
    reg [15:0] EXTERNAL_DATA_2 [0:7] = {1, 2, 4, 4, 2, 4, 3, 0};
    reg [15:0] EXTERNAL_DATA_3 [0:7] = {0, 2, 4, 2, 2, 0, 4, 2};
    reg [15:0] EXTERNAL_DATA_4 [0:7] = {2, 2, 0, 0, 4, 4, 3, 1};
    reg [15:0] EXTERNAL_DATA_5 [0:7] = {2, 4, 4, 0, 2, 0, 0, 3};
    reg [15:0] EXTERNAL_DATA_6 [0:7] = {4, 1, 4, 1, 3, 3, 3, 3};
    reg [15:0] EXTERNAL_DATA_7 [0:7] = {2, 4, 1, 4, 4, 2, 3, 4};


    // Transposed Weights Matrix
    reg [15:0] EXTERNAL_DATA_8 [0:7] = {4, 0, 3, 1, 0, 1, 1, 1};
    reg [15:0] EXTERNAL_DATA_9 [0:7] = {3, 3, 4, 4, 1, 0, 3, 2};
    reg [15:0] EXTERNAL_DATA_A [0:7] = {4, 4, 1, 1, 1, 2, 0, 4};
    reg [15:0] EXTERNAL_DATA_B [0:7] = {3, 2, 3, 1, 0, 1, 0, 4};
    reg [15:0] EXTERNAL_DATA_C [0:7] = {0, 3, 2, 1, 2, 2, 0, 4};
    reg [15:0] EXTERNAL_DATA_D [0:7] = {4, 1, 0, 4, 3, 2, 1, 1};
    reg [15:0] EXTERNAL_DATA_E [0:7] = {1, 2, 1, 2, 4, 1, 1, 0};
    reg [15:0] EXTERNAL_DATA_F [0:7] = {2, 3, 1, 1, 0, 2, 1, 4};


    /*
    RESULT:
    16, 34, 26, 27, 27, 13, 12, 26 
    12, 39, 30, 24, 29, 27, 19, 31 
    27, 52, 30, 27, 30, 39, 32, 27 
    20, 48, 24, 26, 28, 22, 24, 24 
    16, 27, 32, 18, 26, 34, 29, 25 
    23, 42, 42, 38, 36, 21, 22, 32 
    38, 53, 46, 42, 36, 42, 30, 37 
    24, 59, 53, 39, 46, 51, 40, 44
        
    
    */

////////////////////////////////////////////////////////////////////


    initial begin
        $display("Hello TOP MODULE!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, top_module_tb);
        
        EN = 1; // enable

        $display("Writing (INPUTS to Memory...");
        WRITE = 1;
        LOAD = 0;

        for(integer register = 0; register < 16; register = register + 1) begin
            REG_SELECT = register[3:0];
            for(integer element = 0; element < 8; element = element + 1) begin
                IDX_SELECT = element[2:0];

                case (REG_SELECT)
                    0: DATA_IN = EXTERNAL_DATA_0[IDX_SELECT];
                    1: DATA_IN = EXTERNAL_DATA_1[IDX_SELECT];
                    2: DATA_IN = EXTERNAL_DATA_2[IDX_SELECT];
                    3: DATA_IN = EXTERNAL_DATA_3[IDX_SELECT];
                    4: DATA_IN = EXTERNAL_DATA_4[IDX_SELECT];
                    5: DATA_IN = EXTERNAL_DATA_5[IDX_SELECT];
                    6: DATA_IN = EXTERNAL_DATA_6[IDX_SELECT];
                    7: DATA_IN = EXTERNAL_DATA_7[IDX_SELECT];
                    8: DATA_IN = EXTERNAL_DATA_8[IDX_SELECT];
                    9: DATA_IN = EXTERNAL_DATA_9[IDX_SELECT];
                    10: DATA_IN = EXTERNAL_DATA_A[IDX_SELECT];
                    11: DATA_IN = EXTERNAL_DATA_B[IDX_SELECT];
                    12: DATA_IN = EXTERNAL_DATA_C[IDX_SELECT];
                    13: DATA_IN = EXTERNAL_DATA_D[IDX_SELECT];
                    14: DATA_IN = EXTERNAL_DATA_E[IDX_SELECT];
                    15: DATA_IN = EXTERNAL_DATA_F[IDX_SELECT];
                endcase

                #10 CLK = ~CLK;
                #10 CLK = ~CLK;
            end     
        end
        

        #50;
        
        $display("Long delay test...");
        for(integer i = 0; i < 50; i = i + 1) begin
            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end


        $display("Loading to REGISTER FILE...");
        WRITE = 0;
        LOAD = 1;
        
        for(integer i = 0; i < 50; i = i + 1) begin
            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        #50;

        $display("Doing MATMUL...");
        WRITE = 0;
        LOAD = 0;
        for(integer i = 0; i < 50; i = i + 1) begin
            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        #50;

        // $display("Reading Results...");
        // WRITE = 1;
        // LOAD = 1;
        // for(integer i = 0; i < 50; i = i + 1) begin
        //     #10 CLK = ~CLK;
        //     #10 CLK = ~CLK;
        // end


        $display("BYE!");
        $finish; 
    end


    top_module top_module_0(
        .CLK(CLK),
        .EN(EN),
        .WRITE(WRITE),
        
        .LOAD(LOAD),


        .IDX(IDX_SELECT),
        .REG(REG_SELECT),
        .DATA_IN(DATA_IN),


        .DATA_OUT(DATA_OUT)
    );

endmodule