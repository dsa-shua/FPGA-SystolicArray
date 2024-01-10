module MUX8_tb();

    
    reg [31:0] D [0:7] = {10, 11, 12, 13, 14, 15, 16, 17};
    reg [3:0]  select = 4'b0000;
    reg        enable = 1;
    reg CLK = 0;
    wire [31:0] Dout;
    


    initial begin
        $display("Hello MUX8!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, top);
        
        for(select = 0; select <= 4'b0111; select = select + 1) begin
            #10; CLK = ~CLK;
            $display("====================================");
            $display("Time = %0t | DATA = %3d | SELECT = %3d | Dout = %d", $time, D[select[2:0]], select[2:0], Dout);
            #10; CLK = ~CLK;
        end
        enable = 0;

        #50;
        $display("Bye!");
        $finish;
    end

    MUX8 MUX8_LOGIC(Dout, D[0], D[1], D[2], D[3], D[4], D[5], D[6], D[7], select[2:0], enable);

    

endmodule