// `timescale 1ns / 1ps


// Test Module for Basic Systolic Array Tile
module tile_tb();

    localparam TILE_SIZE = 2;   // edge 
    localparam N = 4;


    // AUX
    reg CLK = 0;
    reg EN = 1;

    // Edge Registers
    reg [31:0]  xRX0 = 0;
    reg [31:0]  xRX1 = 0;
    reg [31:0]  xCX0 = 0;
    reg [31:0]  xCX1 = 0;


    // Edge Registers Seq
    reg [31:0]  sRX0 [0:4] = {1, 2, 0, 0, 0};
    reg [31:0]  sRX1 [0:4] = {0, 3, 4, 0, 0};
    reg [31:0]  sCX0 [0:4] = {5, 7, 0, 0, 0};
    reg [31:0]  sCX1 [0:4] = {0, 6, 8, 0, 0};


    // Unused: Systolic Output Edges
    wire [31:0] out0, out1, out2, out3;

    // use for for loop
    reg [31:0]  idx = 0;
    
    initial begin
        $display("Hello Basic Systolic Array Tile");
        $dumpfile("waveform.vcd");
        $dumpvars(0, tile_tb);


        for(idx = 0; idx < (N+1); idx = idx + 1) begin
            // Setup
            xRX0 = sRX0[idx];
            xRX1 = sRX1[idx];
            xCX0 = sCX0[idx];
            xCX1 = sCX1[idx];

            #10 CLK = ~CLK;
            // No need to show the data?
            $display("Iteration: %d", idx);
            #10 CLK = ~CLK;

        end

        #10;

        $display("Bye!");
        $finish;
    end


    // Architecture
    SYSTOLIC systolic_array_base(
        .CLK(CLK),
        .EN(EN),
        .N_RX0(xRX0),
        .N_RX1(xRX1),
        .N_CX0(xCX0),
        .N_CX1(xCX1),
        .N_RY0(out0),
        .N_RY1(out1),
        .N_CY0(out2),
        .N_CY1(out3)
    );


endmodule
