
// TILE + Edge Registers
// Inputs to this guy should come from controller.sv


module SystolicArray(
    CLK, EN, RF_EN, WRITE, IDX, 
    
    DIN_0,
    DIN_1,
    DIN_2,
    DIN_3,
    DIN_4,
    DIN_5,
    DIN_6,
    DIN_7,
    DIN_8,
    DIN_9,
    DIN_10,
    DIN_11,
    DIN_12,
    DIN_13,
    DIN_14,
    DIN_15
    
);

    input CLK;
    
    input EN;

    input RF_EN;
    
    input WRITE;                    // WHEN LOAD IS LOW: When H, fill register file
    
    input [4:0]     IDX;             

    input [15:0]    DIN_0;
    input [15:0]    DIN_1;
    input [15:0]    DIN_2;
    input [15:0]    DIN_3;
    input [15:0]    DIN_4;
    input [15:0]    DIN_5;
    input [15:0]    DIN_6;
    input [15:0]    DIN_7;
    input [15:0]    DIN_8;
    input [15:0]    DIN_9;
    input [15:0]    DIN_10;
    input [15:0]    DIN_11;
    input [15:0]    DIN_12;
    input [15:0]    DIN_13;
    input [15:0]    DIN_14;
    input [15:0]    DIN_15;


    


    // FOR REGISTER FILE // 

    reg [15:0] DATA_BUFFER [0:15];
    reg [4:0]   IDX_BUFFER = 0;
    reg [3:0]   REG_SELECT_BUFFER = 0;

    initial begin
        for(integer i = 0; i < 16; i = i + 1) begin
            DATA_BUFFER[i[3:0]] = 16'b0;
        end
    end

    always@(posedge CLK) begin

        // If this module is enabled...
        if(EN) begin

            // If we are currently writing...
            if(WRITE) begin
                // Write to register file!
                // DATA_BUFFER <= DIN;

                DATA_BUFFER[0] <= DIN_0;
                DATA_BUFFER[1] <= DIN_1;
                DATA_BUFFER[2] <= DIN_2;
                DATA_BUFFER[3] <= DIN_3;
                DATA_BUFFER[4] <= DIN_4;
                DATA_BUFFER[5] <= DIN_5;
                DATA_BUFFER[6] <= DIN_6;
                DATA_BUFFER[7] <= DIN_7;
                DATA_BUFFER[8] <= DIN_8;
                DATA_BUFFER[9] <= DIN_9;
                DATA_BUFFER[10] <= DIN_10;
                DATA_BUFFER[11] <= DIN_11;
                DATA_BUFFER[12] <= DIN_12;
                DATA_BUFFER[13] <= DIN_13;
                DATA_BUFFER[14] <= DIN_14;
                DATA_BUFFER[15] <= DIN_15;




                IDX_BUFFER <= IDX;
            end

        end


    end



    // These connects to the edges registers of Systolic Array
    wire    [15:0]  X_OUT   [0:7];
    wire    [15:0]  W_OUT   [0:7];


    reg SA_EN;                          // When H, SA is enabled and MATMUL starts
    always_comb begin
        SA_EN = !WRITE;                 // Only when done writing can we do MATMUL!!
    end

    ////////////////////////////////////////////////////////////////////////





    // FOR SYSTOLIC ARRAY //

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






    ////////////////////// ARCHITECTURE //////////////////////


// Systolic Array Tile
    tile systolicArray8x8(
            // AUX
            .CLK(CLK), .EN(SA_EN),
            

            // Edge Registers Inputs
            .N_R0X(X_OUT[0]), .N_R1X(X_OUT[1]), .N_R2X(X_OUT[2]), .N_R3X(X_OUT[3]), .N_R4X(X_OUT[4]), .N_R5X(X_OUT[5]), .N_R6X(X_OUT[6]), .N_R7X(X_OUT[7]), 
            .N_C0X(W_OUT[0]), .N_C1X(W_OUT[1]), .N_C2X(W_OUT[2]), .N_C3X(W_OUT[3]), .N_C4X(W_OUT[4]), .N_C5X(W_OUT[5]), .N_C6X(W_OUT[6]), .N_C7X(W_OUT[7]),
            

            // Systolic Array Outputs
            .Y_00(Y_00), .Y_10(Y_10), .Y_20(Y_20), .Y_30(Y_30), .Y_40(Y_40), .Y_50(Y_50), .Y_60(Y_60), .Y_70(Y_70),
            .Y_01(Y_01), .Y_11(Y_11), .Y_21(Y_21), .Y_31(Y_31), .Y_41(Y_41), .Y_51(Y_51), .Y_61(Y_61), .Y_71(Y_71),
            .Y_02(Y_02), .Y_12(Y_12), .Y_22(Y_22), .Y_32(Y_32), .Y_42(Y_42), .Y_52(Y_52), .Y_62(Y_62), .Y_72(Y_72),
            .Y_03(Y_03), .Y_13(Y_13), .Y_23(Y_23), .Y_33(Y_33), .Y_43(Y_43), .Y_53(Y_53), .Y_63(Y_63), .Y_73(Y_73),
            .Y_04(Y_04), .Y_14(Y_14), .Y_24(Y_24), .Y_34(Y_34), .Y_44(Y_44), .Y_54(Y_54), .Y_64(Y_64), .Y_74(Y_74),
            .Y_05(Y_05), .Y_15(Y_15), .Y_25(Y_25), .Y_35(Y_35), .Y_45(Y_45), .Y_55(Y_55), .Y_65(Y_65), .Y_75(Y_75),
            .Y_06(Y_06), .Y_16(Y_16), .Y_26(Y_26), .Y_36(Y_36), .Y_46(Y_46), .Y_56(Y_56), .Y_66(Y_66), .Y_76(Y_76),
            .Y_07(Y_07), .Y_17(Y_17), .Y_27(Y_27), .Y_37(Y_37), .Y_47(Y_47), .Y_57(Y_57), .Y_67(Y_67), .Y_77(Y_77), 


            // Unused Edge Pins
            .N_C0Y(N_C0Y), .N_C1Y(N_C1Y), .N_C2Y(N_C2Y), .N_C3Y(N_C3Y), .N_C4Y(N_C4Y), .N_C5Y(N_C5Y), .N_C6Y(N_C6Y), .N_C7Y(N_C7Y), 
            .N_R0Y(N_R0Y), .N_R1Y(N_R1Y), .N_R2Y(N_R2Y), .N_R3Y(N_R3Y), .N_R4Y(N_R4Y), .N_R5Y(N_R5Y), .N_R6Y(N_R6Y), .N_R7Y(N_R7Y)
    );

    RF registerFile(
        .CLK(CLK),
        .RF_EN(RF_EN),
                
        .WRITE(WRITE),

        .IDX(IDX_BUFFER),
        
        .DATA_IN_0(DATA_BUFFER[0]),
        .DATA_IN_1(DATA_BUFFER[1]),
        .DATA_IN_2(DATA_BUFFER[2]),
        .DATA_IN_3(DATA_BUFFER[3]),
        .DATA_IN_4(DATA_BUFFER[4]),
        .DATA_IN_5(DATA_BUFFER[5]),
        .DATA_IN_6(DATA_BUFFER[6]),
        .DATA_IN_7(DATA_BUFFER[7]),
        .DATA_IN_8(DATA_BUFFER[8]),
        .DATA_IN_9(DATA_BUFFER[9]),
        .DATA_IN_A(DATA_BUFFER[10]),
        .DATA_IN_B(DATA_BUFFER[11]),
        .DATA_IN_C(DATA_BUFFER[12]),
        .DATA_IN_D(DATA_BUFFER[13]),
        .DATA_IN_E(DATA_BUFFER[14]),
        .DATA_IN_F(DATA_BUFFER[15]),

        .X_OUT(X_OUT),
        .W_OUT(W_OUT)
    );


endmodule