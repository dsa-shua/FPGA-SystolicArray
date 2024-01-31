// hFIFO_tb.sv >> Test Bench for hFIFO.sv 

module hFIFO_tb();

    reg [15:0]  data_i, data_o;
    reg         W;
    reg         EN = 1;
    wire        AF, F, AE, E;

    reg CLK = 0;

    localparam MAX_ITER = 32;
    reg [15:0] i;

    initial begin
        $display("Hello hFIFO!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, hFIFO_tb);


        $display("1st Writing Test");
        // Test for Writing the FIFO
        W = 1; // specify writing mode
        for(i = 0; i < MAX_ITER + 2; i = i + 1) begin
            data_i = i + 16'b1;

            #10 CLK = ~CLK;
 
            #10 CLK = ~CLK;
        end

        $display("1st Reading Test");
        // Test for reading from FIFO
        W = 0;
        for(i = 0; i < MAX_ITER + 2; i = i + 1) begin


            #10 CLK = ~CLK;


            #10 CLK = ~CLK;
        end

        $display("2nd Writing Test");
        W = 1; // specify writing mode
        for(i = 0; i < MAX_ITER + 2; i = i + 1) begin
            data_i = i + 16'b1;

            #10 CLK = ~CLK;

            #10 CLK = ~CLK;
        end

        $display("2nd Reading Test");
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

    hFIFO FIFO0(data_i, data_o, CLK, W, EN, AF, AE, F, E);
    

endmodule