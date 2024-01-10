module MUX8(DATA_OUT, S0,S1,S2,S3,S4,S5,S6,S7,SELECT,ENABLE);

    input   [31:0]  S0, S1, S2, S3, S4, S5, S6, S7;
    input   [2:0]   SELECT;
    input           ENABLE;
    output  [31:0]  DATA_OUT;

    reg [31:0] D_REG = 0;

    /* verilator lint_off LATCH */  always_comb begin 
        if (ENABLE) begin
            case (SELECT) 
                3'b000: D_REG = S0; 
                3'b001: D_REG = S1; 
                3'b010: D_REG = S2; 
                3'b011: D_REG = S3; 
                
                3'b100: D_REG = S4; 
                3'b101: D_REG = S5; 
                3'b110: D_REG = S6;
                // 3'b111: D_REG = S7;
                default: D_REG = S7; // arbitrary
            endcase
        end
    end

    assign DATA_OUT = D_REG;

endmodule