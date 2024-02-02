module top_module();

    input CLK;
    input EN;                           // Enable the top module
    
    input WRITE;                        // Write to memory
    input LOAD;                         // Load to RF

    input [7:0]    ADDR;               // address of the data (read or accessed)
    input [15:0]    DATA_IN;            // data to be written to memory

    input CLR_MEM;                      // Reset Memory Contents [not yet implemented]

    output  [15:0]  DATA_OUT;           // data out for reading memory (not array)



    // Buffers

    reg [4:0] IDX_BUFFER = 0;
    reg [15:0] DATA_BUFFER [0:7];
    reg [3:0] REG_SELECT_BUFFER = 0;


    // internal memory
    reg [15:0] INT_MEMORY [0:255];

    localparam MATRIX_EDGE_LEN = 8;
    reg [4:0] ELEMENT_COUNTER = 0;      // # of loaded elements

    initial begin

        // Init internal memory
        for(integer i = 0; i < 256; i = i + 1) begin
            INT_MEMORY[i[7:0]] <= 16'b0;
        end

        // init data buffer
        for(integer i = 0; i < 8; i = i + 1) begin
            DATA_BUFFER[2:0] <= 16'b0;
        end
    end

    always@(posedge CLK) begin
        if(EN) begin

            // Loading to internal memory
            if(LOAD) begin
                INT_MEMORY[ADDR] <= DATA_IN;
            end


            // If done loading to memory
            else if(LOAD) begin

                // Start the painful writing process
                if(WRITE) begin
                    
                    DATA_BUFFER[0] <= INT_MEMORY[IDX_BUFFER];
                    DATA_BUFFER[1] <= INT_MEMORY[IDX_BUFFER + 8'd8];
                    DATA_BUFFER[2] <= INT_MEMORY[IDX_BUFFER + 8'd16];
                    DATA_BUFFER[3] <= INT_MEMORY[IDX_BUFFER + 8'd24];
                    DATA_BUFFER[4] <= INT_MEMORY[IDX_BUFFER + 8'd32];
                    DATA_BUFFER[5] <= INT_MEMORY[IDX_BUFFER + 8'd40];
                    DATA_BUFFER[6] <= INT_MEMORY[IDX_BUFFER + 8'd48];
                    DATA_BUFFER[7] <= INT_MEMORY[IDX_BUFFER + 8'd56];

                end


            end
        end
    end

    




    SystolicArray systolicArray8x8(
        .CLK(CLK),
        .EN(SA_EN),
        .RF_EN(RF_EN),
        .WRITE(LOAD),
        .IDX(IDX),
        .DIN(DIN),
        .REG_SELECT(REG_SELECT)
    );


    


    assign DATA_OUT = DATA_OUT_BUFFER;

endmodule