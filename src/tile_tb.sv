// `timescale 1ns / 1ps
module tile_tb();

    localparam TILE_SIZE = 8;
    localparam ELEMENTS = 64;
    localparam SEQ_LEN = 8 + 8 + 8 - 1; // 23

    // AUX
    reg CLK = 0;
    reg EN = 1;


    // Edge Registers
    reg [15:0]  xR0X = 0;
    reg [15:0]  xR1X = 0;
    reg [15:0]  xR2X = 0;
    reg [15:0]  xR3X = 0;
    reg [15:0]  xR4X = 0;
    reg [15:0]  xR5X = 0;
    reg [15:0]  xR6X = 0;
    reg [15:0]  xR7X = 0;

    reg [15:0]  xC0X = 0;
    reg [15:0]  xC1X = 0;
    reg [15:0]  xC2X = 0;
    reg [15:0]  xC3X = 0;
    reg [15:0]  xC4X = 0;
    reg [15:0]  xC5X = 0;
    reg [15:0]  xC6X = 0;
    reg [15:0]  xC7X = 0;

    

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
    

    initial begin
        $display("Hello 8x8 systolic array!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, tile_tb);

        xR0X = 0;
        xR1X = 0;
        xR2X = 0;
        xR3X = 0;
        xR4X = 0;
        xR5X = 0;
        xR6X = 0;
        xR7X = 0;

        xC0X = 0;
        xC1X = 0;
        xC2X = 0;
        xC3X = 0;
        xC4X = 0;
        xC5X = 0;
        xC6X = 0;
        xC7X = 0;

        for(idx = 0; idx < MAX_ITER; idx = idx + 1) begin
            xR0X = sR0X[idx];
            xR1X = sR1X[idx];
            xR2X = sR2X[idx];
            xR3X = sR3X[idx];
            xR4X = sR4X[idx];
            xR5X = sR5X[idx];
            xR6X = sR6X[idx];
            xR7X = sR7X[idx];

            xC0X = sC0X[idx];
            xC1X = sC1X[idx];
            xC2X = sC2X[idx];
            xC3X = sC3X[idx];
            xC4X = sC4X[idx];
            xC5X = sC5X[idx];
            xC6X = sC6X[idx];
            xC7X = sC7X[idx];


            #10 CLK = ~CLK;
            $display("============================================================================");
            $display("Iteration: %d", idx);

            #10 CLK = ~CLK;
        end
        #10;
        $display("Bye!");
        $finish;
    end

    

    tile systolicArray(
        .CLK(CLK), .EN(EN),
        
        .N_R0X(xR0X), .N_R1X(xR1X), .N_R2X(xR2X), .N_R3X(xR3X), .N_R4X(xR4X), .N_R5X(xR5X), .N_R6X(xR6X), .N_R7X(xR7X), 
        .N_C0X(xC0X), .N_C1X(xC1X), .N_C2X(xC2X), .N_C3X(xC3X), .N_C4X(xC4X), .N_C5X(xC5X), .N_C6X(xC6X), .N_C7X(xC7X),
        
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



endmodule