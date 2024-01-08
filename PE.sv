module PE(C, A, B, A_out, B_out, CLK, EN);
    output  [31:0]  C, A_out, B_out;
    input   [31:0]  A, B;
    input           CLK, EN;
    

    reg [31:0]  A_data, B_data, ACC;

    always@(posedge CLK) begin
        if (EN) begin
            A_data <= A;
            B_data <= B;
            ACC <= ACC + (A * B);
        end
    end 

    assign A_out = A_data;
    assign B_out = B_data;
    assign C = ACC;

endmodule
