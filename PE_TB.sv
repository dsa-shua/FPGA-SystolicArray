module PE_TB();

    wire    [31:0]  C, A_out, B_out;
    reg     [31:0]  A_reg, B_reg;
    reg             CLK = 1;
    logic           ENABLE = 1;

    reg     [31:0]  A_seq [0:2] = {1, 2, 3};
    reg     [31:0]  B_seq [0:2] = {10, 11, 12};
    reg     [31:0]   INDEX;


    initial begin
        $display("Hello World!");
        
        $dumpfile("waveform.vcd");
        $dumpvars(0, top);
        
        A_reg = 0;
        B_reg = 0;


        for(INDEX = 0; INDEX < 3; INDEX = INDEX + 1) begin
            A_reg = A_seq[INDEX];
            B_reg = B_seq[INDEX];
            
            #10 CLK = ~CLK;
            $display("Time: %0t, A_reg: %d, B_reg: %d",$time, A_reg,B_reg);
            #10 CLK = ~CLK;
        end
        
        $display("Bye!");
        $finish;
    end

    

    PE PE_CELL(C, A_reg, B_reg, A_out, B_out, CLK, ENABLE);

endmodule
