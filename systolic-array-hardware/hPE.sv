`timescale 1ns / 1ps

module hPE(
    input RST,
    input CLK, EN,
    input [15:0] A, B,
    output wire [15:0] C, A_out, B_out
    );
    
    
    reg [15:0] A_data;
    reg [15:0] B_data;
    reg [15:0] ACC;
    
    
    initial begin
        A_data = 0;
        B_data = 0;
        ACC = 0;
    end 
    
   
    
    always@(posedge CLK) begin
        if(EN && !RST) begin
            ACC <= ACC + (A_data * B_data);
            A_data <= A;
            B_data <= B;
        end
        
        if (!EN && RST) begin
            ACC <= 0;
        end
    end
    
    assign A_out = A_data;
    assign B_out = B_data;
    assign C = ACC;
    
endmodule
