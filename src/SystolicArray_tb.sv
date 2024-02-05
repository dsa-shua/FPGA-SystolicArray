// This file should be the basis for the controller.


module SystolicArray_tb();

    reg CLK = 0;
    reg EN = 0;         // enable the whole module
    reg RF_EN = 0;
    reg WRITE = 0;
    
    reg [2:0]   IDX = 0;
    
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

    



    initial begin
        $display("Hello Systolic Array with RF!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, SystolicArray_tb);

        $display("Writing to Registers...");
        WRITE = 1;

        EN = 1;
        RF_EN = 1;

        // For every register
        
        for(integer i = 1; i < 9; i = i + 1) begin
            IDX = i[2:0] - 1'b1;
            DATA_0 = i[15:0];
            DATA_1 = i[15:0];
            DATA_2 = i[15:0];
            DATA_3 = i[15:0];
            DATA_4 = i[15:0];
            DATA_5 = i[15:0];
            DATA_6 = i[15:0];
            DATA_7 = i[15:0];
            DATA_8 = i[15:0];
            DATA_9 = i[15:0];
            DATA_10 = i[15:0];
            DATA_11 = i[15:0];
            DATA_12 = i[15:0];
            DATA_13 = i[15:0];
            DATA_14 = i[15:0];
            DATA_15 = i[15:0];

            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end



        // Extra 2 Cycles due to pipeline(?)
        
        
        // At this point, the data is currently at this module's DATA_BUFFER
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;

       // At this point, the data is currently at RF's DIN_BUFFER 

        #10 CLK = ~CLK;
        #10 CLK = ~CLK;

        // At this point, the data should be released by the X_REG's
        
        ///////////////////////////////////////////////////////////////////////////


        // Do MATMUL
        $display("Doing matmul...");

        WRITE = 0;

        // Let Time Flow!
        for(integer i = 0; i < 30; i = i + 1) begin
            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        $display("Bye!");
        $finish;
    end



    SystolicArray sa_module(
        .CLK(CLK), .EN(EN), .RF_EN(RF_EN), .WRITE(WRITE), .IDX(IDX), 
        
        
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
        .DIN_15(DATA_15)
        
    );


endmodule