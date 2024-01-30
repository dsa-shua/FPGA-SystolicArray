module tile_4x4_tb();

    localparam TILE_SIZE = 4;
    localparam N = 16;


    // AUX
    reg CLK = 0;
    reg EN = 1;


    // Edge Registers
    reg [31:0] xRX00 = 0;
    reg [31:0] xRX01 = 0;
    reg [31:0] xRX10 = 0;
    reg [31:0] xRX11 = 0;

    reg [31:0] xCX00 = 0;
    reg [31:0] xCX01 = 0;
    reg [31:0] xCX10 = 0;
    reg [31:0] xCX11 = 0;


    // Edge Registers Seq (A = B')
    reg [31:0] sRX00 [0:10] = {1,  2,  3,  4,  0,  0,  0, 0, 0, 0, 0};
    reg [31:0] sRX01 [0:10] = {0,  5,  6,  7,  8,  0,  0, 0, 0, 0, 0};
    reg [31:0] sRX10 [0:10] = {0,  0,  9, 10, 11, 12,  0, 0, 0, 0, 0};
    reg [31:0] sRX11 [0:10] = {0,  0,  0, 13, 14, 15, 16, 0, 0, 0, 0};

    reg [31:0] sCX00 [0:10] = {1,  2,  3,  4,  0,  0,  0, 0, 0, 0, 0};
    reg [31:0] sCX01 [0:10] = {0,  5,  6,  7,  8,  0,  0, 0, 0, 0, 0};
    reg [31:0] sCX10 [0:10] = {0,  0,  9, 10, 11, 12,  0, 0, 0, 0, 0};
    reg [31:0] sCX11 [0:10] = {0,  0,  0, 13, 14, 15, 16, 0, 0, 0, 0};


    // Unused: Output Edge
    wire [31:0] o0, o1, o2, o3, o4, o5, o6, o7;

    // index
    reg [31:0] idx = 0;

    
    initial begin
        $display("Hello 4x4 Systolic Array!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, tile_4x4_tb);

        for(idx = 0; idx < 11; idx = idx + 1) begin
            // Setup
            xRX00 = sRX00[idx];
            xRX01 = sRX01[idx];
            xRX10 = sRX10[idx];
            xRX11 = sRX11[idx];

            xCX00 = sCX00[idx];
            xCX01 = sCX01[idx];
            xCX10 = sCX10[idx];
            xCX11 = sCX11[idx];
            
            
            #10 CLK = ~CLK;
            $display("Iteration: %d", i);

            #10 CLK = ~CLK;
        end

        #10; 
        $display("Bye!");
        $finish;
    end

    
    // // Architecture
    // systolic4x4 tile_4x4(.CLK(CLK), .EN(EN)
    //     .N_RX0[0]()
    // );



endmodule