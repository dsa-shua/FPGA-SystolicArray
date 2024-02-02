module top_module_tb();

    reg CLK;
    reg EN;
    reg WRITE;
    reg LOAD;

    reg [7:0] ADDR;
    reg [15:0] DATA_IN;

    reg [15:0] DATA_OUT;

    wire [15:0] DATA_OUT;


    initial begin
        $display("Hello TOP MODULE!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, top_module_tb);
        
        EN = 1; // enable

        $display("Writing (INPUTS to Memory...");
        WRITE = 1;
        LOAD = 0;

        // Elements
        for(integer i = 0; i < 64; i = i + 1) begin
            DATA_IN = (i[15:0] % 8) + 1;
            ADDR = i[7:0];

            $display("DATA_IN: %d | ADDR: %d", DATA_IN, ADDR);

            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;

        #10

        $display("Writing (WEIGHTS) to Memory...");
        WRITE = 1;
        LOAD = 0;

        // Elements
        for(integer i = 0; i < 64; i = i + 1) begin
            DATA_IN = (i[15:0] % 8) + 1;
            ADDR = i[7:0] + 8'd64;

            $display("DATA_IN: %d | ADDR: %d", DATA_IN, ADDR);

            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;

        #10


        $display("Reading from memory...");

        WRITE = 1;
        LOAD = 1;
        for(integer i = 1; i < 64; i = i + 1) begin
            // DATA_IN = i[15:0];
            ADDR = i[7:0] - 1'b1;

            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10;


        $display("Loading to registers...");

        WRITE = 0;
        LOAD = 1;
        for(integer i = 1; i < 64; i = i + 1) begin
            // DATA_IN = i[15:0];
            ADDR = i[7:0] - 1'b1;
            

            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end


        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10;
        

        $display("MATRIX MULTIPLLICATION BABY!!!");
        WRITE = 0;
        LOAD = 0;
        for(integer i = 1; i < 64; i = i + 1) begin
            // DATA_IN = i[15:0];
            // ADDR = i[7:0] - 1'b1;

            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;
        #10;


        $display("BYE!");
        $finish; 
    end


    top_module top_module_0(
        .CLK(CLK),
        .EN(EN),
        .WRITE(WRITE),
        .LOAD(LOAD),
        .ADDR(ADDR),
        .DATA_IN(DATA_IN),
        .DATA_OUT(DATA_OUT)
    );

endmodule