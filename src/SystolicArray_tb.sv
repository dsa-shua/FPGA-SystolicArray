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

    wire [15:0]  Y_00, Y_10, Y_20, Y_30, Y_40, Y_50, Y_60, Y_70;
    wire [15:0]  Y_01, Y_11, Y_21, Y_31, Y_41, Y_51, Y_61, Y_71;
    wire [15:0]  Y_02, Y_12, Y_22, Y_32, Y_42, Y_52, Y_62, Y_72;
    wire [15:0]  Y_03, Y_13, Y_23, Y_33, Y_43, Y_53, Y_63, Y_73;
    wire [15:0]  Y_04, Y_14, Y_24, Y_34, Y_44, Y_54, Y_64, Y_74;
    wire [15:0]  Y_05, Y_15, Y_25, Y_35, Y_45, Y_55, Y_65, Y_75;
    wire [15:0]  Y_06, Y_16, Y_26, Y_36, Y_46, Y_56, Y_66, Y_76;
    wire [15:0]  Y_07, Y_17, Y_27, Y_37, Y_47, Y_57, Y_67, Y_77;

    



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
        .DIN_15(DATA_15),

        .Y_00(Y_00), .Y_10(Y_10), .Y_20(Y_20), .Y_30(Y_30), .Y_40(Y_40), .Y_50(Y_50), .Y_60(Y_60), .Y_70(Y_70),
        .Y_01(Y_01), .Y_11(Y_11), .Y_21(Y_21), .Y_31(Y_31), .Y_41(Y_41), .Y_51(Y_51), .Y_61(Y_61), .Y_71(Y_71),
        .Y_02(Y_02), .Y_12(Y_12), .Y_22(Y_22), .Y_32(Y_32), .Y_42(Y_42), .Y_52(Y_52), .Y_62(Y_62), .Y_72(Y_72),
        .Y_03(Y_03), .Y_13(Y_13), .Y_23(Y_23), .Y_33(Y_33), .Y_43(Y_43), .Y_53(Y_53), .Y_63(Y_63), .Y_73(Y_73),
        .Y_04(Y_04), .Y_14(Y_14), .Y_24(Y_24), .Y_34(Y_34), .Y_44(Y_44), .Y_54(Y_54), .Y_64(Y_64), .Y_74(Y_74),
        .Y_05(Y_05), .Y_15(Y_15), .Y_25(Y_25), .Y_35(Y_35), .Y_45(Y_45), .Y_55(Y_55), .Y_65(Y_65), .Y_75(Y_75),
        .Y_06(Y_06), .Y_16(Y_16), .Y_26(Y_26), .Y_36(Y_36), .Y_46(Y_46), .Y_56(Y_56), .Y_66(Y_66), .Y_76(Y_76),
        .Y_07(Y_07), .Y_17(Y_17), .Y_27(Y_27), .Y_37(Y_37), .Y_47(Y_47), .Y_57(Y_57), .Y_67(Y_67), .Y_77(Y_77)

        
    );


endmodule