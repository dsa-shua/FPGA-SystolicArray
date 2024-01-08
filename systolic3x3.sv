module systolic3x3(
    output  [31:0]  C0, C1, C2, C3, C4, C5, C6, C7, C8,
    input   [31:0]  A0, A3, A6, // LEFT SIDE ONLY
    input   [31:0]  B0, B1, B2, // TOP SIDE ONLY
    input           CLK,
    input           EN
    );

    wire    [31:0]  A1, A2, A4, A5, A7, A8, B3, B4, B5, B6, B7, B8;
    wire    [31:0]  R0, R1, R2, D0, D1, D2; 
    

    PE CELL0(.C(C0), .A(A0), .B(B0), .A_out(A1), .B_out(B3), .CLK(CLK), .EN(EN));
    PE CELL1(.C(C1), .A(A1), .B(B1), .A_out(A2), .B_out(B4), .CLK(CLK), .EN(EN));
    PE CELL2(.C(C2), .A(A2), .B(B2), .A_out(R0), .B_out(B5), .CLK(CLK), .EN(EN));

    PE CELL3(.C(C3), .A(A3), .B(B3), .A_out(A4), .B_out(B6), .CLK(CLK), .EN(EN));
    PE CELL4(.C(C4), .A(A4), .B(B4), .A_out(A5), .B_out(B7), .CLK(CLK), .EN(EN));
    PE CELL5(.C(C5), .A(A5), .B(B5), .A_out(R1), .B_out(B8), .CLK(CLK), .EN(EN));
    
    PE CELL6(.C(C6), .A(A6), .B(B6), .A_out(A7), .B_out(D0), .CLK(CLK), .EN(EN));
    PE CELL7(.C(C7), .A(A7), .B(B7), .A_out(A8), .B_out(D1), .CLK(CLK), .EN(EN));
    PE CELL8(.C(C8), .A(A8), .B(B8), .A_out(R2), .B_out(D2), .CLK(CLK), .EN(EN));

endmodule