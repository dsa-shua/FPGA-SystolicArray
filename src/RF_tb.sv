module RF_tb();

    reg CLK = 0;
    reg RF_EN = 1;

    reg WRITE = 0;

    reg [15:0]  DATA;
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
            $display("Current REG: %d", i);
            REG_SELECT = i[3:0];

            // for every element
            for(integer j = 1; j < 9; j = j + 1) begin
                

                DATA = j[15:0];
                
                if(i < 8) begin
                    IDX = j[4:0] + i[4:0];
                end
                else begin
                    IDX = j[4:0] + i[4:0] - 8;
                end

                // $display("  Current IDX: %d | Resulting IDX: %d | DATA: %d", j, IDX, DATA);
                

                #10 CLK = ~CLK;
                #10 CLK = ~CLK;
            end
        end


        ////// Important!  //////

        // We need one more cycle since data is 
        // currently on a buffer, not the REGISTER!

        #10 CLK = ~CLK;
        #10 CLK = ~CLK;

        /////////////////////////

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
        .IDX(IDX), .DIN(DATA), .REG_SELECT(REG_SELECT),
        .X_OUT(DOUT[0:7]), .W_OUT(DOUT[8:15]));
    


endmodule