module tile_4x4(
    // IO
    input   [31:0]  N_RX0 [0:1], N_RX1 [0:1], N_CX0 [0:1], N_CX1 [0:1],
    output  [31:0]  N_RY0 [0:1], N_RY1 [0:1], N_CY0 [0:1], N_CY1 [0:1],
    
    // AUX
    input   CLK, EN
);

    // Interconnect
    wire    [31:0]  N_R0 [0:1], N_R1 [0:1], N_C0 [0:1], N_C1 [0:1]; 

    // Architecture
    base T0(.CLK(CLK), .EN(EN), 
        // Input
        .N_RX0(N_RX0[0]), 
        .N_RX1(N_RX0[1]), 
        .N_CX0(N_CX0[0]), 
        .N_CX1(N_CX0[1]),

        // Output 
        .N_RY0(N_R0[0]), 
        .N_RY1(N_R0[1]), 
        .N_CY0(N_C0[0]), 
        .N_CY1(N_C0[1])
    );
    
    
    
    base T1(.CLK(CLK), .EN(EN), 
        // Input
        .N_RX0(N_R0[0]), 
        .N_RX1(N_R0[1]), 
        .N_CX0(N_CX1[0]), 
        .N_CX1(N_CX1[1]),

        // Ouput 
        .N_RY0(N_RY0[0]), 
        .N_RY1(N_RY0[1]), 
        .N_CY0(N_C1[0]), 
        .N_CY1(N_C1[1])
    );


    base T2(.CLK(CLK), .EN(EN), 
        // Input
        .N_RX0(N_RX1[0]), 
        .N_RX1(N_RX1[1]), 
        .N_CX0(N_C0[0]), 
        .N_CX1(N_C0[1]),

        // Ouput 
        .N_RY0(N_R1[0]), 
        .N_RY1(N_R1[1]), 
        .N_CY0(N_CY0[0]), 
        .N_CY1(N_CY0[1])
    );



    base T3(.CLK(CLK), .EN(EN), 
        // Input
        .N_RX0(N_R1[0]), 
        .N_RX1(N_R1[1]), 
        .N_CX0(N_C1[0]), 
        .N_CX1(N_C1[1]),

        // Ouput 
        .N_RY0(N_RY1[0]), 
        .N_RY1(N_RY1[1]), 
        .N_CY0(N_CY1[0]), 
        .N_CY1(N_CY1[1])
    );
    
    
    
    
    
    




endmodule