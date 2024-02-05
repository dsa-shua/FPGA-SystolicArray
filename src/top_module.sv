module top_module(


    input CLK,
    input EN,

    input WRITE,                    // WRITE TO INT_MEM
    

    input [2:0] IDX,                // index of the element
    input [3:0] REG,                // which register

    input LOAD,                     // Load to REGISTER FILE
    
    input [15:0] DATA_IN,

    output [15:0] DATA_OUT

);
    ///////////////////////////////////////////////////////////

    //                      SYSTOLIC ARRAY

    // reg [4:0]   IDX = 0;
    
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


    /////////////////////////////////////////////////////////////
    
    //                  CONTROLLER


    reg [15:0] DATA_OUT_BUFFER = 0;

    // Matrix 1
    reg [15:0] MAT_A0 [0:7];
    reg [15:0] MAT_A1 [0:7];
    reg [15:0] MAT_A2 [0:7];
    reg [15:0] MAT_A3 [0:7];
    reg [15:0] MAT_A4 [0:7];
    reg [15:0] MAT_A5 [0:7];
    reg [15:0] MAT_A6 [0:7];
    reg [15:0] MAT_A7 [0:7];
    

    // Matrix 2
    reg [15:0] MAT_B0 [0:7];
    reg [15:0] MAT_B1 [0:7];
    reg [15:0] MAT_B2 [0:7];
    reg [15:0] MAT_B3 [0:7];
    reg [15:0] MAT_B4 [0:7];
    reg [15:0] MAT_B5 [0:7];
    reg [15:0] MAT_B6 [0:7];
    reg [15:0] MAT_B7 [0:7];


    // Result Matrix
    reg [15:0] MAT_C0 [0:7];
    reg [15:0] MAT_C1 [0:7];
    reg [15:0] MAT_C2 [0:7];
    reg [15:0] MAT_C3 [0:7];
    reg [15:0] MAT_C4 [0:7];
    reg [15:0] MAT_C5 [0:7];
    reg [15:0] MAT_C6 [0:7];
    reg [15:0] MAT_C7 [0:7];


    reg [2:0] IDX_COUNTER = 0;
    reg [2:0] IDX_IN_BUFFER = 0;
    reg [15:0] DATA_IN_BUFFER = 0;

    reg SA_EN = 0;
    reg SA_WRITE = 0;

  
    always_comb begin
        
    end
  
    always@(posedge CLK) begin
        if(EN) begin
            // Always connect results register!




            if(LOAD) begin

                // Load to registers (constant addresses)
                if (!WRITE) begin
                    SA_EN <= 1;
                    SA_WRITE <= 1;

                    DATA_0 <= MAT_A0[IDX_COUNTER];
                    DATA_1 <= MAT_A1[IDX_COUNTER];
                    DATA_2 <= MAT_A2[IDX_COUNTER];
                    DATA_3 <= MAT_A3[IDX_COUNTER];
                    DATA_4 <= MAT_A4[IDX_COUNTER];
                    DATA_5 <= MAT_A5[IDX_COUNTER];
                    DATA_6 <= MAT_A6[IDX_COUNTER];
                    DATA_7 <= MAT_A7[IDX_COUNTER];

                    DATA_8 <= MAT_B0[IDX_COUNTER];
                    DATA_9 <= MAT_B1[IDX_COUNTER];
                    DATA_10 <= MAT_B2[IDX_COUNTER];
                    DATA_11 <= MAT_B3[IDX_COUNTER];
                    DATA_12 <= MAT_B4[IDX_COUNTER];
                    DATA_13 <= MAT_B5[IDX_COUNTER];
                    DATA_14 <= MAT_B6[IDX_COUNTER];
                    DATA_15 <= MAT_B7[IDX_COUNTER];
                    

                    IDX_COUNTER <= IDX_COUNTER + 1;
                    IDX_IN_BUFFER <= IDX_COUNTER;                    
                end

                // LOAD && WRITE == READ!
                else if(WRITE) begin
                    SA_EN <= 0;
                    SA_WRITE <= 0;

                    case (REG) 
                        0: DATA_OUT_BUFFER <= MAT_C0[IDX];
                        1: DATA_OUT_BUFFER <= MAT_C1[IDX];
                        2: DATA_OUT_BUFFER <= MAT_C2[IDX];
                        3: DATA_OUT_BUFFER <= MAT_C3[IDX];
                        4: DATA_OUT_BUFFER <= MAT_C4[IDX];
                        5: DATA_OUT_BUFFER <= MAT_C5[IDX];
                        6: DATA_OUT_BUFFER <= MAT_C6[IDX];
                        7: DATA_OUT_BUFFER <= MAT_C7[IDX];
                    endcase
                end
            end

            

            // If not loading, then 
            else if(!LOAD) begin
                
                // Writing to Seqeunce Registers
                if(WRITE) begin
                    case (REG)
                        4'd0 : MAT_A0[IDX] <= DATA_IN;
                        4'd1 : MAT_A1[IDX] <= DATA_IN;
                        4'd2 : MAT_A2[IDX] <= DATA_IN;
                        4'd3 : MAT_A3[IDX] <= DATA_IN;
                        4'd4 : MAT_A4[IDX] <= DATA_IN;
                        4'd5 : MAT_A5[IDX] <= DATA_IN;
                        4'd6 : MAT_A6[IDX] <= DATA_IN;
                        4'd7 : MAT_A7[IDX] <= DATA_IN;
                        4'd8 : MAT_B0[IDX] <= DATA_IN;
                        4'd9 : MAT_B1[IDX] <= DATA_IN;
                        4'hA : MAT_B2[IDX] <= DATA_IN;
                        4'hB : MAT_B3[IDX] <= DATA_IN;
                        4'hC : MAT_B4[IDX] <= DATA_IN;
                        4'hD : MAT_B5[IDX] <= DATA_IN;
                        4'hE : MAT_B6[IDX] <= DATA_IN;
                        4'hF : MAT_B7[IDX] <= DATA_IN;
                    endcase
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

    // Only when !WRITE (!SA_WRITE), will the matmul begin
        
    SystolicArray sa_module(
        .CLK(CLK), .EN(SA_EN), .RF_EN(SA_EN), .WRITE(SA_WRITE), .IDX(IDX_IN_BUFFER), 
        
        // Inputs to registers
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

        // Systolic Array Outputs
        .Y_00(MAT_C0[0]), .Y_10(MAT_C0[1]), .Y_20(MAT_C0[2]), .Y_30(MAT_C0[3]), .Y_40(MAT_C0[4]), .Y_50(MAT_C0[5]), .Y_60(MAT_C0[6]), .Y_70(MAT_C0[7]),
        .Y_01(MAT_C1[0]), .Y_11(MAT_C1[1]), .Y_21(MAT_C1[2]), .Y_31(MAT_C1[3]), .Y_41(MAT_C1[4]), .Y_51(MAT_C1[5]), .Y_61(MAT_C1[6]), .Y_71(MAT_C1[7]),
        .Y_02(MAT_C2[0]), .Y_12(MAT_C2[1]), .Y_22(MAT_C2[2]), .Y_32(MAT_C2[3]), .Y_42(MAT_C2[4]), .Y_52(MAT_C2[5]), .Y_62(MAT_C2[6]), .Y_72(MAT_C2[7]),
        .Y_03(MAT_C3[0]), .Y_13(MAT_C3[1]), .Y_23(MAT_C3[2]), .Y_33(MAT_C3[3]), .Y_43(MAT_C3[4]), .Y_53(MAT_C3[5]), .Y_63(MAT_C3[6]), .Y_73(MAT_C3[7]),
        .Y_04(MAT_C4[0]), .Y_14(MAT_C4[1]), .Y_24(MAT_C4[2]), .Y_34(MAT_C4[3]), .Y_44(MAT_C4[4]), .Y_54(MAT_C4[5]), .Y_64(MAT_C4[6]), .Y_74(MAT_C4[7]),
        .Y_05(MAT_C5[0]), .Y_15(MAT_C5[1]), .Y_25(MAT_C5[2]), .Y_35(MAT_C5[3]), .Y_45(MAT_C5[4]), .Y_55(MAT_C5[5]), .Y_65(MAT_C5[6]), .Y_75(MAT_C5[7]),
        .Y_06(MAT_C6[0]), .Y_16(MAT_C6[1]), .Y_26(MAT_C6[2]), .Y_36(MAT_C6[3]), .Y_46(MAT_C6[4]), .Y_56(MAT_C6[5]), .Y_66(MAT_C6[6]), .Y_76(MAT_C6[7]),
        .Y_07(MAT_C7[0]), .Y_17(MAT_C7[1]), .Y_27(MAT_C7[2]), .Y_37(MAT_C7[3]), .Y_47(MAT_C7[4]), .Y_57(MAT_C7[5]), .Y_67(MAT_C7[6]), .Y_77(MAT_C7[7])

    );

    assign DATA_OUT = DATA_OUT_BUFFER;


endmodule