module memory_tb();

    reg CLK = 0;
    reg EN = 1;
        
    reg WRITE = 1;

    reg RST = 1;

    reg [15:0] DATA_IN;
    reg [7:0]   ADDR;

    wire [15:0] DATA_OUT;

    

    initial begin
        $display("Hello Memory!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, memory_tb);

        
        $display("Filling Memory...");
        for(integer i = 0; i < 256; i = i + 1) begin
            DATA_IN = (i[15:0] + 16'b1) * 16'd10;
            ADDR = i[7:0]; 


            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        $display("Reading from Memory...");

        WRITE = 0;
        for(integer i = 0; i < 256; i = i + 1) begin
            ADDR = i[7:0]; 


            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end
        
        #20; RST = 0;
        #20; RST = 1;

        EN = 0;

        #10;

        $display("Bye!");
        $finish;
    end

    memory myMEMORY(CLK, EN, RST, WRITE, DATA_IN, ADDR, DATA_OUT);

endmodule