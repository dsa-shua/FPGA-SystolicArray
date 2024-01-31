module RF_tb();

    reg CLK = 0;
    
    reg [15:0]  DATA;
    reg [31:0]  ADDR;

    reg RF_WRITE = 0;

    wire [15:0] R_OUT   [0:7];
    wire [15:0] C_OUT   [0:7];
    wire [3:0]  FIFO_STATUS [0:15];


    initial begin
        $display("Hello REGISTER FILE");
        $dumpfile("waveform.vcd");
        $dumpvars(0, RF_tb);

        DATA = 0;
        ADDR = 0;
        RF_WRITE = 1;

        for(integer i = 0; i < 64; i = i + 1) begin
            DATA = i[15:0];
            ADDR = i;

            #10 CLK = ~CLK;
            $display("Iteration: %d", i);
            #10 CLK = ~CLK;

        end

        RF_WRITE = 0;

        #10;
        $display("Bye~");
        $finish;
    end
    

    


    RF regFile(
        .CLK(CLK),
        .RF_ENABLE(1),
        .FIFO_ENABLE(0),
        .FIFO_WRITE(0),
        .RF_WRITE(RF_WRITE),
        .ADDR(ADDR),
        .DATA(DATA),
        .R_OUT(R_OUT),
        .C_OUT(C_OUT),
        .FIFO_STATUS(FIFO_STATUS)
        
    );



endmodule