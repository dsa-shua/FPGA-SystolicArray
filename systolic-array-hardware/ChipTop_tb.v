`timescale 1ns / 1ps

module ChipTop_tb();
    reg RST = 0;
    reg CLK = 0;
    reg EN;
    reg WRITE;
    reg LOAD;
    
    wire [15:0] DATA_OUT;
    reg [15:0] DATA_IN;

    reg [2:0] IDX_SELECT;
    reg [3:0] REG_SELECT;

    wire interrupt_pin;
    wire read_led, write_led, load_led, matmul_led;


    reg [31:0] clk_counter = 0;
    localparam MAX_LOAD_CYCLES = 9;
    localparam MAX_MM_CYCLES = 24;
    
    always@(posedge CLK) begin
        clk_counter <= clk_counter + 1;
    end
    

    
    always #1 CLK = ~CLK;

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


//    // Transposed Weights Matrix
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
        #3 EN = 1; // enable

        $display("Writing INPUTS to Memory...");
        EN = 0;
        WRITE = 1;
        LOAD = 0;
        #2;
        
        
        for(integer register = 0; register < 16; register = register + 1) begin
            
            REG_SELECT = register[3:0];
            for(integer element = 0; element < 8; element = element + 1) begin
                EN = 0; #3;
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
                  EN = 1; #3;
                  #2;
                  
            end     
        end
        
//        #2;
        
        $display("Loading to REGISTER FILE...");
        EN = 0;
        WRITE = 0;
        LOAD = 1;
        #2
        EN = 1;
        
        while(!interrupt_pin) begin
            #2;
        end

//        #5;

        $display("Doing MATMUL...");
        EN = 0;
        WRITE = 0;
        LOAD = 0;
        #2;
        EN = 1;
        
        while(!interrupt_pin) begin
            #2;
        end
        

//        #5;

         $display("Reading Results...");
         EN = 0;
         WRITE = 1;
         LOAD = 1;
         #2;
         EN = 1;
         
         
        for(integer register = 0; register < 8; register = register + 1) begin
            REG_SELECT = register[3:0];
            for(integer element = 0; element < 8; element = element + 1) begin
                EN = 0; #3;
                IDX_SELECT = element[2:0];
                EN = 1; #3;
                #2;                
            end     
        end
        
        
        #5;
        RST = 1;
        #5;
        RST = 0;
        
        EXTERNAL_DATA_0 [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_1 [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_2 [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_3 [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_4 [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_5 [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_6 [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_7 [0:7] = {1,2,3,4,5,6,7,8};
    
    
        EXTERNAL_DATA_8 [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_9 [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_A [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_B [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_C [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_D [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_E [0:7] = {1,2,3,4,5,6,7,8};
        EXTERNAL_DATA_F [0:7] = {1,2,3,4,5,6,7,8};
        
        #10;
        
                #3 EN = 1; // enable

        $display("Writing INPUTS to Memory...");
        EN = 0;
        WRITE = 1;
        LOAD = 0;
        #2;
        
        
        for(integer register = 0; register < 16; register = register + 1) begin
            
            REG_SELECT = register[3:0];
            for(integer element = 0; element < 8; element = element + 1) begin
                EN = 0; #3;
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
                  EN = 1; #3;
                  #2;
                  
            end     
        end
        
//        #2;
        
        $display("Loading to REGISTER FILE...");
        EN = 0;
        WRITE = 0;
        LOAD = 1;
        #2
        EN = 1;
        
        while(!interrupt_pin) begin
            #2;
        end

//        #5;

        $display("Doing MATMUL...");
        EN = 0;
        WRITE = 0;
        LOAD = 0;
        #2;
        EN = 1;
        
        while(!interrupt_pin) begin
            #2;
        end
        

//        #5;

         $display("Reading Results...");
         EN = 0;
         WRITE = 1;
         LOAD = 1;
         #2;
         EN = 1;
         
         
        for(integer register = 0; register < 8; register = register + 1) begin
            REG_SELECT = register[3:0];
            for(integer element = 0; element < 8; element = element + 1) begin
                EN = 0; #3;
                IDX_SELECT = element[2:0];
                EN = 1; #3;
                #2;                
            end     
        end
        
        
        
        $display("BYE!");
        $finish; 
    end
    
    
//        input CLK,
//    input RST,
//    input [8:0] AUX,
//    input [15:0] DATA_IN,
//    output [15:0] DATA_OUT,
//    output INTERRUPT_PIN,
//    output READ_LED,
//    output WRITE_LED,
//    output LOAD_LED,
//    output MATMUL_LED
    
//        wire load_buffer = AUX[1];
//    wire write_buffer = AUX[0];
//    wire idx_buffer = AUX[4:2];
//    wire reg_select_buffer = AUX[8:5];
    
        ChipTop top_module_00(
            .EN(EN),
            .CLK(CLK),
            .CLEAR(RST),
            .AUX({REG_SELECT,IDX_SELECT,LOAD,WRITE}),
            .DATA_IN(DATA_IN),
            .DATA_OUT(DATA_OUT),
            .INTERRUPT_PIN(interrupt_pin),
            .READ_LED(read_led),
            .WRITE_LED(write_led),
            .LOAD_LED(load_led),
            .MATMUL_LED(matmul_led)
        );

//    FSM top_module_0(
//        .rst(RST),
//        .clk(CLK),
//        .en(EN),
//        .write(WRITE),      
//        .load(LOAD),
//        .idx(IDX_SELECT),
//        .reg_select(REG_SELECT),
//        .data_in(DATA_IN),
//        .data_out(DATA_OUT),
//        .int_to_ps(interrupt_pin),
//        .read_led(read_led),
//        .write_led(write_led),
//        .load_led(load_led),
//        .matmul_led(matmul_led)
//    );

endmodule