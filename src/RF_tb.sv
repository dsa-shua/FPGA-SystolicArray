module RF_tb();

    reg CLK = 0;
    reg RF_EN = 1;

    reg WRITE = 0;

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
    reg [15:0]  DATA_A = 0;
    reg [15:0]  DATA_B = 0;
    reg [15:0]  DATA_C = 0;
    reg [15:0]  DATA_D = 0;
    reg [15:0]  DATA_E = 0;
    reg [15:0]  DATA_F = 0;

    reg [15:0] DATA_IN [0:15];

    reg [4:0]   IDX;
    reg [3:0]   REG_SELECT;

    wire [15:0] DOUT [0:15];

    initial begin
        $display("Hello RF TB!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, RF_tb);
        

        $display("Writing to Registers...");
        WRITE = 1;

        // For every register
        
        
        for(integer i = 0; i < 16; i = i + 1) begin
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
            DATA_A = i[15:0];
            DATA_B = i[15:0];
            DATA_C = i[15:0];
            DATA_D = i[15:0];
            DATA_E = i[15:0];
            DATA_F = i[15:0];

            IDX = i[4:0];

            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end
        

        ////// Important!  //////

        // We need one more cycle since data is 
        // currently on a buffer, not the REGISTER!

        #10 CLK = ~CLK;
        #10 CLK = ~CLK;

        // #100;

        ///////////////////////

        $display("Spitting contents...");
        WRITE = 0;
        for(integer i = 0; i < 25; i = i + 1) begin
            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end



        #10;
        $display("Bye!");
        $finish;
    end

    RF registerFile(.CLK(CLK), .RF_EN(RF_EN), .WRITE(WRITE),
        .IDX(IDX),
        
        .DATA_IN_0(DATA_0),
        .DATA_IN_1(DATA_1),
        .DATA_IN_2(DATA_2),
        .DATA_IN_3(DATA_3),
        .DATA_IN_4(DATA_4),
        .DATA_IN_5(DATA_5),
        .DATA_IN_6(DATA_6),
        .DATA_IN_7(DATA_7),
        .DATA_IN_8(DATA_8),
        .DATA_IN_9(DATA_9),
        .DATA_IN_A(DATA_A),
        .DATA_IN_B(DATA_B),
        .DATA_IN_C(DATA_C),
        .DATA_IN_D(DATA_D),
        .DATA_IN_E(DATA_E),
        .DATA_IN_F(DATA_F),

        .X_OUT(DOUT[0:7]), .W_OUT(DOUT[8:15]));
    


endmodule