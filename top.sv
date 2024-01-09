module top();

    wire    [31:0]  C0, C1, C2, C3, C4, C5, C6, C7, C8;
    // wire    [31:0]  A0, A1, A2, A3, A4, A5, A6, A7, A8;
    // wire    [31:0]  B0, B1, B2, B3, B4, B5, B6, B7, B8;

    

    reg     [31:0]  A0_reg, A3_reg, A6_reg; // input regs
    reg     [31:0]  B0_reg, B1_reg, B2_reg; // weight regs
    
    reg             CLK = 0;                // remember to start from LOW!
    logic           ENABLE = 1;


    // TODO: Finish the proper sequence and check correctness
    reg     [31:0]  A0_seq [0:7] = {1, 2, 3, 0, 0, 0, 0, 0};
    reg     [31:0]  A3_seq [0:7] = {0, 4, 5, 6, 0, 0, 0, 0};
    reg     [31:0]  A6_seq [0:7] = {0, 0, 7, 8, 9, 0, 0, 0};

    // Untransposed weights!
    // reg     [31:0]  B0_seq [0:7] = {10, 11, 12, 0, 0, 0, 0, 0};
    // reg     [31:0]  B1_seq [0:7] = {0, 13, 14, 15, 0, 0, 0, 0};
    // reg     [31:0]  B2_seq [0:7] = {0, 0, 16, 17, 18, 0, 0, 0};

    // Important! Tranpose the Weights!
    reg     [31:0]  B0_seq [0:7] = {10, 13, 16, 0, 0, 0, 0, 0};
    reg     [31:0]  B1_seq [0:7] = {0, 11, 14, 17, 0, 0, 0, 0};
    reg     [31:0]  B2_seq [0:7] = {0, 0, 12, 15, 18, 0, 0, 0};

    reg     [31:0]  i;

    parameter MAX_ITER = 8;


    initial begin
        $display("Hello systolic array!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, top);

        A0_reg = 0;
        A3_reg = 0;
        A6_reg = 0;

        B0_reg = 0;
        B1_reg = 0;
        B2_reg = 0;


        for(i = 0; i < 9; i = i + 1) begin
            A0_reg = A0_seq[i];
            A3_reg = A3_seq[i];
            A6_reg = A6_seq[i];

            B0_reg = B0_seq[i];
            B1_reg = B1_seq[i];
            B2_reg = B2_seq[i];

            #10 CLK = ~CLK;
            $display("============================================================================");
            $display("Iteration: %d", i);
            $display("Time: %0t, A0_reg: %3d, A3_reg: %3d, A6_reg: %3d",$time, A0_reg,A3_reg, A6_reg);
            $display("           B0_reg: %3d, B1_reg: %3d, B2_reg: %3d",B0_reg,B1_reg, B2_reg);
            $display("C0: %3d | C1: %3d | C2: %3d", C0, C1, C2);
            $display("C3: %3d | C4: %3d | C5: %3d", C3, C4, C5);
            $display("C6: %3d | C7: %3d | C8: %3d", C6, C7, C8);
            #10 CLK = ~CLK;
        end

        #10;
        $display("Bye!");
        $finish;
        
    end


    systolic3x3 systolic_array(
        .C0(C0), .C1(C1), .C2(C2), .C3(C3), .C4(C4), .C5(C5), .C6(C6), .C7(C7), .C8(C8),
        .A0(A0_reg), .A3(A3_reg), .A6(A6_reg),
        .B0(B0_reg), .B1(B1_reg), .B2(B2_reg),
        .CLK(CLK), .EN(ENABLE)
    );

endmodule