// `timescale 1ns / 1ps

// 32 Element 16-Bit FIFO 
module hFIFO(DATA_IN, DATA_OUT, CLK, WRITE, ENABLE, 
            ALMOST_FULL, ALMOST_EMPTY, FULL, EMPTY);
    input   [15:0]  DATA_IN;
    output  [15:0]  DATA_OUT;
    
    input WRITE;
    input ENABLE;
    input CLK;

    output ALMOST_FULL;
    output FULL;
    output ALMOST_EMPTY;
    output EMPTY;

    reg [7:0] tail = 0;
    integer i = 0;
            // SHIFT


    localparam DEPTH = 8'd32;
    localparam ALMOST_FULL_TH = 28;
    localparam ALMOST_EMPTY_TH = 4;

    // Make sure it is initialized!
    reg [15:0] PIPE [0:31];
    reg [15:0] OUT_BUFF = 0;


    // initialize FIFO to 0
    initial begin
        for(i = 0; i < 31; i = i + 1) begin
            PIPE[i] = 0;
        end
    end

    always@(posedge CLK) begin
        if (ENABLE && WRITE && tail < DEPTH) begin
            PIPE[tail[4:0]] <= DATA_IN;
            tail <= tail + 1;
        end

        else if (ENABLE && !WRITE && tail != 0) begin
            OUT_BUFF <= PIPE[0];
            
            // Shift the FIFO Elements
            for(i = 0; i < 30; i = i + 1) begin
                PIPE[i] <= PIPE[i+1];
            end
            
            
            tail <= tail - 1;

            // When ith element is moved to i - 1, let ith element be 0 --> clear
            PIPE[tail[4:0]-1] <= 0; // IDK what I did but it solved the disappearing PIPE[1] data when clearing.
        end
    end
 


    // Status Pins
    assign FULL         = (tail == DEPTH)   ? 1 : 0;
    assign EMPTY        = (tail == 0)       ? 1 : 0;
    
    assign ALMOST_FULL  = (tail > ALMOST_FULL_TH)  ? 1 : 0;
    assign ALMOST_EMPTY = (tail < ALMOST_EMPTY_TH) ? 1 : 0;

    assign DATA_OUT     = OUT_BUFF;
endmodule