// `timescale 1ns / 1ps
module tile_tb();

    localparam TILE_SIZE = 8;
    localparam ELEMENTS = 64;
    localparam SEQ_LEN = 8 + 8 + 8 - 1; // 23

    // AUX
    reg CLK = 0;
    reg EN = 1;

    
    // Edge Registers Seq
    reg [15:0]  sR0X [0:22] = {1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sR1X [0:22] = {0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sR2X [0:22] = {0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sR3X [0:22] = {0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sR4X [0:22] = {0,0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sR5X [0:22] = {0,0,0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sR6X [0:22] = {0,0,0,0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sR7X [0:22] = {0,0,0,0,0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0};

    reg [15:0]  sC0X [0:22] = {1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sC1X [0:22] = {0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sC2X [0:22] = {0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sC3X [0:22] = {0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sC4X [0:22] = {0,0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sC5X [0:22] = {0,0,0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sC6X [0:22] = {0,0,0,0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0,0};
    reg [15:0]  sC7X [0:22] = {0,0,0,0,0,0,0,1,2,3,4,5,6,7,8,0,0,0,0,0,0,0,0};



    // Outputs
    reg  [15:0]  Y_00, Y_10, Y_20, Y_30, Y_40, Y_50, Y_60, Y_70;
    reg  [15:0]  Y_01, Y_11, Y_21, Y_31, Y_41, Y_51, Y_61, Y_71;
    reg  [15:0]  Y_02, Y_12, Y_22, Y_32, Y_42, Y_52, Y_62, Y_72;
    reg  [15:0]  Y_03, Y_13, Y_23, Y_33, Y_43, Y_53, Y_63, Y_73;
    reg  [15:0]  Y_04, Y_14, Y_24, Y_34, Y_44, Y_54, Y_64, Y_74;
    reg  [15:0]  Y_05, Y_15, Y_25, Y_35, Y_45, Y_55, Y_65, Y_75;
    reg  [15:0]  Y_06, Y_16, Y_26, Y_36, Y_46, Y_56, Y_66, Y_76;
    reg  [15:0]  Y_07, Y_17, Y_27, Y_37, Y_47, Y_57, Y_67, Y_77;

    // Unused Edges
    wire  [15:0] N_C0Y, N_C1Y, N_C2Y, N_C3Y, N_C4Y, N_C5Y, N_C6Y, N_C7Y;
    wire  [15:0] N_R0Y, N_R1Y, N_R2Y, N_R3Y, N_R4Y, N_R5Y, N_R6Y, N_R7Y;


    reg [31:0]  idx = 0;

    localparam  MAX_ITER = SEQ_LEN + 2;
    


    ///////////////////////////////////////////////////////////////////////////////////////////

    // FIFOS
    reg     [15:0]  R_DIN       [0:7];
    reg     [15:0]  C_DIN       [0:7];
    reg             FIFO_WRITE          = 0;
    reg             FIFO_EN             = 0;             


    wire    [15:0]  R_DOUT      [0:7];
    wire    [15:0]  C_DOUT      [0:7];
    wire    [3:0]   FIFO_STATUS [0:15];


    ///////////////////////////////////////////////////////////////////////////////////////////

    initial begin
        $display("Hello 8x8 systolic array!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, tile_tb);

        // Temporarily Disable the Systolic Array & Enable the FIFOs
        EN = 0;
        FIFO_EN = 1;
        FIFO_WRITE = 1;

        $display("Filling FIFOs...");
        

        // Initialize R_DIN Registers
        for(integer i = 0; i < 8; i = i + 1) begin
            R_DIN[i] = 0;
        end


        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        // FILL FIFO
        for(integer i = 0; i < 24; i = i + 1) begin
            R_DIN[0] = sR0X[i];
            R_DIN[1] = sR1X[i];
            R_DIN[2] = sR2X[i];
            R_DIN[3] = sR3X[i];
            R_DIN[4] = sR4X[i];
            R_DIN[5] = sR5X[i];
            R_DIN[6] = sR6X[i];
            R_DIN[7] = sR7X[i];


            C_DIN[0] = sC0X[i];
            C_DIN[1] = sC1X[i];
            C_DIN[2] = sC2X[i];
            C_DIN[3] = sC3X[i];
            C_DIN[4] = sC4X[i];
            C_DIN[5] = sC5X[i];
            C_DIN[6] = sC6X[i];
            C_DIN[7] = sC7X[i];
            


            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        // Enable SYSTOLIC ARRAY
        EN = 1;
        FIFO_EN = 1;
        FIFO_WRITE = 0;
        CLK = 0;

        $display("Done with FIFOs!");


        /////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        // DO MATRIX MULTIPLICATION
        $display("Performing Matrix Multiplication...");
        for(idx = 0; idx < MAX_ITER; idx = idx + 1) begin
            #10 CLK = ~CLK;
            $display("Iteration: %d", idx);
            #10 CLK = ~CLK;
        end
        
        $display("Done with MATMUL!");

        #10;
        $display("Bye!");
        $finish;
    end



    ///////////////////////////////////////////////////////////////////////////////////////////

    // ARCHITECTURE
    

    tile systolicArray(
        .CLK(CLK), .EN(EN),
        
        .N_R0X(R_DOUT[0]), .N_R1X(R_DOUT[1]), .N_R2X(R_DOUT[2]), .N_R3X(R_DOUT[3]), .N_R4X(R_DOUT[4]), .N_R5X(R_DOUT[5]), .N_R6X(R_DOUT[6]), .N_R7X(R_DOUT[7]), 
        .N_C0X(C_DOUT[0]), .N_C1X(C_DOUT[1]), .N_C2X(C_DOUT[2]), .N_C3X(C_DOUT[3]), .N_C4X(C_DOUT[4]), .N_C5X(C_DOUT[5]), .N_C6X(C_DOUT[6]), .N_C7X(C_DOUT[7]),
        
        .Y_00(Y_00), .Y_10(Y_10), .Y_20(Y_20), .Y_30(Y_30), .Y_40(Y_40), .Y_50(Y_50), .Y_60(Y_60), .Y_70(Y_70),
        .Y_01(Y_01), .Y_11(Y_11), .Y_21(Y_21), .Y_31(Y_31), .Y_41(Y_41), .Y_51(Y_51), .Y_61(Y_61), .Y_71(Y_71),
        .Y_02(Y_02), .Y_12(Y_12), .Y_22(Y_22), .Y_32(Y_32), .Y_42(Y_42), .Y_52(Y_52), .Y_62(Y_62), .Y_72(Y_72),
        .Y_03(Y_03), .Y_13(Y_13), .Y_23(Y_23), .Y_33(Y_33), .Y_43(Y_43), .Y_53(Y_53), .Y_63(Y_63), .Y_73(Y_73),
        .Y_04(Y_04), .Y_14(Y_14), .Y_24(Y_24), .Y_34(Y_34), .Y_44(Y_44), .Y_54(Y_54), .Y_64(Y_64), .Y_74(Y_74),
        .Y_05(Y_05), .Y_15(Y_15), .Y_25(Y_25), .Y_35(Y_35), .Y_45(Y_45), .Y_55(Y_55), .Y_65(Y_65), .Y_75(Y_75),
        .Y_06(Y_06), .Y_16(Y_16), .Y_26(Y_26), .Y_36(Y_36), .Y_46(Y_46), .Y_56(Y_56), .Y_66(Y_66), .Y_76(Y_76),
        .Y_07(Y_07), .Y_17(Y_17), .Y_27(Y_27), .Y_37(Y_37), .Y_47(Y_47), .Y_57(Y_57), .Y_67(Y_67), .Y_77(Y_77), 

        .N_C0Y(N_C0Y), .N_C1Y(N_C1Y), .N_C2Y(N_C2Y), .N_C3Y(N_C3Y), .N_C4Y(N_C4Y), .N_C5Y(N_C5Y), .N_C6Y(N_C6Y), .N_C7Y(N_C7Y), 
        .N_R0Y(N_R0Y), .N_R1Y(N_R1Y), .N_R2Y(N_R2Y), .N_R3Y(N_R3Y), .N_R4Y(N_R4Y), .N_R5Y(N_R5Y), .N_R6Y(N_R6Y), .N_R7Y(N_R7Y)
    );


    


    // EDGE FIFOs
    hFIFO R_FIFO_0(.DATA_IN(R_DIN[0]), .DATA_OUT(R_DOUT[0]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[0][3]), .ALMOST_EMPTY(FIFO_STATUS[0][2]), .FULL(FIFO_STATUS[0][1]), .EMPTY(FIFO_STATUS[0][0]));

    hFIFO R_FIFO_1(.DATA_IN(R_DIN[1]), .DATA_OUT(R_DOUT[1]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[1][3]), .ALMOST_EMPTY(FIFO_STATUS[1][2]), .FULL(FIFO_STATUS[1][1]), .EMPTY(FIFO_STATUS[1][0]));
    
    hFIFO R_FIFO_2(.DATA_IN(R_DIN[2]), .DATA_OUT(R_DOUT[2]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[2][3]), .ALMOST_EMPTY(FIFO_STATUS[2][2]), .FULL(FIFO_STATUS[2][1]), .EMPTY(FIFO_STATUS[2][0]));
    
    hFIFO R_FIFO_3(.DATA_IN(R_DIN[3]), .DATA_OUT(R_DOUT[3]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[3][3]), .ALMOST_EMPTY(FIFO_STATUS[3][2]), .FULL(FIFO_STATUS[3][1]), .EMPTY(FIFO_STATUS[3][0]));

    hFIFO R_FIFO_4(.DATA_IN(R_DIN[4]), .DATA_OUT(R_DOUT[4]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[4][3]), .ALMOST_EMPTY(FIFO_STATUS[4][2]), .FULL(FIFO_STATUS[4][1]), .EMPTY(FIFO_STATUS[4][0]));
    
    hFIFO R_FIFO_5(.DATA_IN(R_DIN[5]), .DATA_OUT(R_DOUT[5]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[5][3]), .ALMOST_EMPTY(FIFO_STATUS[5][2]), .FULL(FIFO_STATUS[5][1]), .EMPTY(FIFO_STATUS[5][0]));
    
    hFIFO R_FIFO_6(.DATA_IN(R_DIN[6]), .DATA_OUT(R_DOUT[6]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[6][3]), .ALMOST_EMPTY(FIFO_STATUS[6][2]), .FULL(FIFO_STATUS[6][1]), .EMPTY(FIFO_STATUS[6][0]));
    
    hFIFO R_FIFO_7(.DATA_IN(R_DIN[7]), .DATA_OUT(R_DOUT[7]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[7][3]), .ALMOST_EMPTY(FIFO_STATUS[7][2]), .FULL(FIFO_STATUS[7][1]), .EMPTY(FIFO_STATUS[7][0]));



    hFIFO C_FIFO_0(.DATA_IN(C_DIN[0]), .DATA_OUT(C_DOUT[0]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[8][3]), .ALMOST_EMPTY(FIFO_STATUS[8][2]), .FULL(FIFO_STATUS[8][1]), .EMPTY(FIFO_STATUS[8][0]));

    hFIFO C_FIFO_1(.DATA_IN(C_DIN[1]), .DATA_OUT(C_DOUT[1]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[9][3]), .ALMOST_EMPTY(FIFO_STATUS[9][2]), .FULL(FIFO_STATUS[9][1]), .EMPTY(FIFO_STATUS[9][0]));
    
    hFIFO C_FIFO_2(.DATA_IN(C_DIN[2]), .DATA_OUT(C_DOUT[2]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[10][3]), .ALMOST_EMPTY(FIFO_STATUS[10][2]), .FULL(FIFO_STATUS[10][1]), .EMPTY(FIFO_STATUS[10][0]));
    
    hFIFO C_FIFO_3(.DATA_IN(C_DIN[3]), .DATA_OUT(C_DOUT[3]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[11][3]), .ALMOST_EMPTY(FIFO_STATUS[11][2]), .FULL(FIFO_STATUS[11][1]), .EMPTY(FIFO_STATUS[11][0]));

    hFIFO C_FIFO_4(.DATA_IN(C_DIN[4]), .DATA_OUT(C_DOUT[4]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[12][3]), .ALMOST_EMPTY(FIFO_STATUS[12][2]), .FULL(FIFO_STATUS[12][1]), .EMPTY(FIFO_STATUS[12][0]));
    
    hFIFO C_FIFO_5(.DATA_IN(C_DIN[5]), .DATA_OUT(C_DOUT[5]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[13][3]), .ALMOST_EMPTY(FIFO_STATUS[13][2]), .FULL(FIFO_STATUS[13][1]), .EMPTY(FIFO_STATUS[13][0]));
    
    hFIFO C_FIFO_6(.DATA_IN(C_DIN[6]), .DATA_OUT(C_DOUT[6]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[14][3]), .ALMOST_EMPTY(FIFO_STATUS[14][2]), .FULL(FIFO_STATUS[14][1]), .EMPTY(FIFO_STATUS[14][0]));
    
    hFIFO C_FIFO_7(.DATA_IN(C_DIN[7]), .DATA_OUT(C_DOUT[7]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_EN), 
                .ALMOST_FULL(FIFO_STATUS[15][3]), .ALMOST_EMPTY(FIFO_STATUS[15][2]), .FULL(FIFO_STATUS[15][1]), .EMPTY(FIFO_STATUS[15][0]));

    


endmodule