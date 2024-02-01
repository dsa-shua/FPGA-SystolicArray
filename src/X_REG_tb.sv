module X_REG_tb();

    reg CLK = 0;
    reg EN;

    reg WRITE;

    reg [4:0] IDX = 0;
    reg [15:0] DIN = 0;
    wire [15:0] DOUT;

    initial begin

        $display("Hello X_REG TB!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, X_REG_tb);

        EN = 1;
        WRITE = 1;

        // Write 

        $display("Sequential writing...");
        for(integer i = 0; i < 32; i = i + 1) begin
            DIN = i[15:0] + 16'b1;
            IDX = i[4:0];

            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end


        $display("Sequential Reading...");
        WRITE = 0;
        for(integer i = 0; i < 32; i = i + 1) begin
            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end


        $display("Insert Writing...");
        WRITE = 1; 
        for(integer i = 10; i < 21; i = i + 1) begin
            DIN = i[15:0] * 2;
            IDX = i[4:0];

            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end 

        $display("Insert Reading...");
        WRITE = 0;
        for(integer i = 0; i < 32; i = i + 1) begin
            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end 


        EN = 0;
        #10;
        $display("Bye!");
        $finish;
    end

    // Architecture
    X_REG REG0(
        .CLK(CLK), .EN(EN), .WRITE(WRITE), .IDX(IDX), .DIN(DIN), .DOUT(DOUT));


endmodule