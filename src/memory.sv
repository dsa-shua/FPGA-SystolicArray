
// Single Port MEMORY

module memory(
    CLK, EN, RST, WRITE, DATA_IN, ADDR, DATA_OUT
);

    input CLK;
    input EN;

    input RST;

    input WRITE;

    input [15:0]    DATA_IN;
    input [7:0]    ADDR;


    output [15:0]   DATA_OUT;


    // Give plenty of space for now...
    reg [15:0] DATA_SPACE [0:255];
 
    reg [15:0] DATA_OUT_BUFFER;

    initial begin
        for(integer i = 0; i < 256; i = i + 1) begin
            DATA_SPACE[i] = 0;
        end
        DATA_OUT_BUFFER = 0;
    end


    // always@(negedge RST)begin
    //     for(integer i = 0; i < 256; i = i + 1) begin
    //         DATA_SPACE[i[7:0]] <= 16'b0;
    //     end
    // end

    always@(posedge CLK) begin
        if(EN) begin
            if (WRITE) begin
                DATA_SPACE[ADDR] <= DATA_IN;
            end
            else if (!WRITE) begin
                DATA_OUT_BUFFER <= DATA_SPACE[ADDR];
            end
        end
    end

    
    assign DATA_OUT = DATA_OUT_BUFFER;


endmodule