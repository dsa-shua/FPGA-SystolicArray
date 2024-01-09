// FIFO_tb.sv -- test bench for FIFO.sv

module FIFO_tb();

    reg [31:0]  data_i, data_o;
    reg         W;
    reg         EN = 1;
    wire        AF, F, AE, E;

    reg CLK = 0;

    localparam MAX_ITER = 16;
    reg [31:0] i;

    initial begin
        $display("Hello fifo!");
        $dumpfile("waveform-fifo.vcd");
        $dumpvars(0, FIFO_tb);

        // Test for Writing the FIFO
        W = 1; // specify writing mode
        for(i = 0; i < MAX_ITER + 2; i = i + 1) begin
            data_i = i + 32'b1;

            #10 CLK = ~CLK;
            // $display("============================================================================");
            // $display("Iteration: %d", i);
            #10 CLK = ~CLK;
        end

        // Test for reading from FIFO
        W = 0;
        for(i = 0; i < MAX_ITER + 2; i = i + 1) begin


            #10 CLK = ~CLK;


            #10 CLK = ~CLK;
        end



        #10
        $display("Bye");
        $finish;
    end

    myFIFO myFIFO0(data_i, data_o, CLK, W, EN, AF, AE, F, E);
    

endmodule