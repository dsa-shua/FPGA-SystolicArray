`timescale 1ns / 1ps

module ChipTop_IO_tb();
    reg RST = 0;
    reg CLK = 0;
    reg EN;
    reg WRITE;
    reg LOAD;
    reg [8:0] AUX_MONITOR = 0;
    
    wire [15:0] DATA_OUT;
    reg [15:0] DATA_IN;

    reg [2:0] IDX_SELECT;
    reg [3:0] REG_SELECT;

    wire interrupt_pin;
    wire read_led, write_led, load_led, matmul_led, en_led;


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
      EN = 1;
      IDX_SELECT = 7;
      REG_SELECT = 15;
      WRITE = 1;
      LOAD = 0;
      RST = 0;
      DATA_IN = 16'h0008;
      AUX_MONITOR = {REG_SELECT,IDX_SELECT,LOAD,WRITE};
      #10;
      
      $finish;
    end
    

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
            .MATMUL_LED(matmul_led),
            .EN_LED(en_led)
        );


endmodule