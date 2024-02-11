`timescale 1ns / 1ps

// Parallel Shifting Register --> Replace FIFOs

module X_REG(CLK, EN, WRITE, IDX, DIN, DOUT);
    input           CLK;
    input           EN;

    input           WRITE;         // When EN && !WRITE, every clock cycle, spit data
    
    input   [4:0]  IDX;            // Absolute INDX
    input   [15:0]  DIN;
    output  [15:0]  DOUT;

    reg     [15:0]  PIPE    [0:31];
    reg     [15:0]  DOUT_BUFFER = 0;

    initial begin

        // Initialize Memory 
        for(integer i = 0; i < 32; i = i + 1) begin
            PIPE[i] = 0;
        end
    end

  
    // Data Sampling (IN REG)
    always@(posedge CLK) begin
        if (EN) begin
            if(WRITE) begin

                PIPE[IDX] <= DIN;
            end

            else if (!WRITE) begin
                DOUT_BUFFER <= PIPE[0];

                for(integer i = 0; i < 31; i = i + 1) begin
                    PIPE[i] <= PIPE[i+1];
                end

                PIPE[31] <= 0;
            end
        end
    end

    // OUT REG
    assign DOUT = DOUT_BUFFER;

endmodule