// This file should be the basis for the controller.


module SystolicArray_tb();

    reg CLK = 0;
    reg EN = 0;         // enable the whole module
    reg RF_EN = 0;
    reg WRITE = 0;
    
    reg [4:0]   IDX = 0;
    reg [15:0]  DATA = 0;
    reg [3:0]   REG_SELECT;


    initial begin
        $display("Hello Systolic Array with RF!");
        $dumpfile("waveform.vcd");
        $dumpvars(0, SystolicArray_tb);

        $display("Writing to Registers...");
        WRITE = 1;

        EN = 1;
        RF_EN = 1;

        // For every register
        for(integer i = 0; i < 16; i = i + 1) begin
            // $display("Current REG: %d", i);
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



        // Extra 2 Cycles due to pipeline(?)
        
        
        // At this point, the data is currently at this module's DATA_BUFFER
        #10 CLK = ~CLK;
        #10 CLK = ~CLK;

       // At this point, the data is currently at RF's DIN_BUFFER 

        #10 CLK = ~CLK;
        #10 CLK = ~CLK;

        // At this point, the data should be released by the X_REG's
        
        ///////////////////////////////////////////////////////////////////////////


        // Do MATMUL
        $display("Doing matmul...");

        WRITE = 0;

        // Let Time Flow!
        for(integer i = 0; i < 30; i = i + 1) begin
            #10 CLK = ~CLK;
            #10 CLK = ~CLK;
        end

        $display("Bye!");
        $finish;
    end



    SystolicArray sa_module(
        .CLK(CLK), .EN(EN), .RF_EN(RF_EN), .WRITE(WRITE), .IDX(IDX), .DIN(DATA), .REG_SELECT(REG_SELECT)
    );


endmodule