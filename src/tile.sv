
/*
*       tile.sv
*       
*       
*
*/

module tile(
    // Aux
    input CLK,
    input EN,

    // Edge Registers
    input   [15:0]  N_R0X, N_R1X, N_R2X, N_R3X, N_R4X, N_R5X, N_R6X, N_R7X, 
    input   [15:0]  N_C0X, N_C1X, N_C2X, N_C3X, N_C4X, N_C5X, N_C6X, N_C7X,

    // Out Edges
    output  [15:0]  N_C0Y, N_C1Y, N_C2Y, N_C3Y, N_C4Y, N_C5Y, N_C6Y, N_C7Y,
    output  [15:0]  N_R0Y, N_R1Y, N_R2Y, N_R3Y, N_R4Y, N_R5Y, N_R6Y, N_R7Y,


    // Direct Outputs (Debugging)
    output  [15:0]  Y_00, Y_10, Y_20, Y_30, Y_40, Y_50, Y_60, Y_70,
    output  [15:0]  Y_01, Y_11, Y_21, Y_31, Y_41, Y_51, Y_61, Y_71,
    output  [15:0]  Y_02, Y_12, Y_22, Y_32, Y_42, Y_52, Y_62, Y_72,
    output  [15:0]  Y_03, Y_13, Y_23, Y_33, Y_43, Y_53, Y_63, Y_73,
    output  [15:0]  Y_04, Y_14, Y_24, Y_34, Y_44, Y_54, Y_64, Y_74,
    output  [15:0]  Y_05, Y_15, Y_25, Y_35, Y_45, Y_55, Y_65, Y_75,
    output  [15:0]  Y_06, Y_16, Y_26, Y_36, Y_46, Y_56, Y_66, Y_76,
    output  [15:0]  Y_07, Y_17, Y_27, Y_37, Y_47, Y_57, Y_67, Y_77
    
);

    // Interconnect (ROW)
    wire    [15:0] N_R00, N_R10, N_R20, N_R30, N_R40, N_R50, N_R60;
    wire    [15:0] N_R01, N_R11, N_R21, N_R31, N_R41, N_R51, N_R61;
    wire    [15:0] N_R02, N_R12, N_R22, N_R32, N_R42, N_R52, N_R62;
    wire    [15:0] N_R03, N_R13, N_R23, N_R33, N_R43, N_R53, N_R63;
    wire    [15:0] N_R04, N_R14, N_R24, N_R34, N_R44, N_R54, N_R64;
    wire    [15:0] N_R05, N_R15, N_R25, N_R35, N_R45, N_R55, N_R65;
    wire    [15:0] N_R06, N_R16, N_R26, N_R36, N_R46, N_R56, N_R66;
    wire    [15:0] N_R07, N_R17, N_R27, N_R37, N_R47, N_R57, N_R67;

    // Interconnect (COL)
    wire    [15:0] N_C00, N_C10, N_C20, N_C30, N_C40, N_C50, N_C60, N_C70; 
    wire    [15:0] N_C01, N_C11, N_C21, N_C31, N_C41, N_C51, N_C61, N_C71;
    wire    [15:0] N_C02, N_C12, N_C22, N_C32, N_C42, N_C52, N_C62, N_C72;
    wire    [15:0] N_C03, N_C13, N_C23, N_C33, N_C43, N_C53, N_C63, N_C73;
    wire    [15:0] N_C04, N_C14, N_C24, N_C34, N_C44, N_C54, N_C64, N_C74;
    wire    [15:0] N_C05, N_C15, N_C25, N_C35, N_C45, N_C55, N_C65, N_C75;
    wire    [15:0] N_C06, N_C16, N_C26, N_C36, N_C46, N_C56, N_C66, N_C76;
    

    // Architecture

// ROW 0 
    hPE C00(.CLK(CLK),  .EN(EN), .C(Y_00), .A(N_R0X), .B(N_C0X), .A_out(N_R00), .B_out(N_C00));
    hPE C10(.CLK(CLK),  .EN(EN), .C(Y_10), .A(N_R00), .B(N_C1X), .A_out(N_R10), .B_out(N_C10));
    hPE C20(.CLK(CLK),  .EN(EN), .C(Y_20), .A(N_R10), .B(N_C2X), .A_out(N_R20), .B_out(N_C20));
    hPE C30(.CLK(CLK),  .EN(EN), .C(Y_30), .A(N_R20), .B(N_C3X), .A_out(N_R30), .B_out(N_C30));
    hPE C40(.CLK(CLK),  .EN(EN), .C(Y_40), .A(N_R30), .B(N_C4X), .A_out(N_R40), .B_out(N_C40));
    hPE C50(.CLK(CLK),  .EN(EN), .C(Y_50), .A(N_R40), .B(N_C5X), .A_out(N_R50), .B_out(N_C50));
    hPE C60(.CLK(CLK),  .EN(EN), .C(Y_60), .A(N_R50), .B(N_C6X), .A_out(N_R60), .B_out(N_C60));
    hPE C70(.CLK(CLK),  .EN(EN), .C(Y_70), .A(N_R60), .B(N_C7X), .A_out(N_R0Y), .B_out(N_C70));


// ROW 1
    hPE C01(.CLK(CLK),  .EN(EN), .C(Y_01), .A(N_R1X), .B(N_C00), .A_out(N_R01), .B_out(N_C01));
    hPE C11(.CLK(CLK),  .EN(EN), .C(Y_11), .A(N_R01), .B(N_C10), .A_out(N_R11), .B_out(N_C11));
    hPE C21(.CLK(CLK),  .EN(EN), .C(Y_21), .A(N_R11), .B(N_C20), .A_out(N_R21), .B_out(N_C21));
    hPE C31(.CLK(CLK),  .EN(EN), .C(Y_31), .A(N_R21), .B(N_C30), .A_out(N_R31), .B_out(N_C31));
    hPE C41(.CLK(CLK),  .EN(EN), .C(Y_41), .A(N_R31), .B(N_C40), .A_out(N_R41), .B_out(N_C41));
    hPE C51(.CLK(CLK),  .EN(EN), .C(Y_51), .A(N_R41), .B(N_C50), .A_out(N_R51), .B_out(N_C51));
    hPE C61(.CLK(CLK),  .EN(EN), .C(Y_61), .A(N_R51), .B(N_C60), .A_out(N_R61), .B_out(N_C61));
    hPE C71(.CLK(CLK),  .EN(EN), .C(Y_71), .A(N_R61), .B(N_C70), .A_out(N_R1Y), .B_out(N_C71));


// ROW 2
    hPE C02(.CLK(CLK),  .EN(EN), .C(Y_02), .A(N_R2X), .B(N_C01), .A_out(N_R02), .B_out(N_C02));
    hPE C12(.CLK(CLK),  .EN(EN), .C(Y_12), .A(N_R02), .B(N_C11), .A_out(N_R12), .B_out(N_C12));
    hPE C22(.CLK(CLK),  .EN(EN), .C(Y_22), .A(N_R12), .B(N_C21), .A_out(N_R22), .B_out(N_C22));
    hPE C32(.CLK(CLK),  .EN(EN), .C(Y_32), .A(N_R22), .B(N_C31), .A_out(N_R32), .B_out(N_C32));
    hPE C42(.CLK(CLK),  .EN(EN), .C(Y_42), .A(N_R32), .B(N_C41), .A_out(N_R42), .B_out(N_C42));
    hPE C52(.CLK(CLK),  .EN(EN), .C(Y_52), .A(N_R42), .B(N_C51), .A_out(N_R52), .B_out(N_C52));
    hPE C62(.CLK(CLK),  .EN(EN), .C(Y_62), .A(N_R52), .B(N_C61), .A_out(N_R62), .B_out(N_C62));
    hPE C72(.CLK(CLK),  .EN(EN), .C(Y_72), .A(N_R62), .B(N_C71), .A_out(N_R2Y), .B_out(N_C72));


// Row 3
    hPE C03(.CLK(CLK),  .EN(EN), .C(Y_03), .A(N_R3X), .B(N_C02), .A_out(N_R03), .B_out(N_C03));
    hPE C13(.CLK(CLK),  .EN(EN), .C(Y_13), .A(N_R03), .B(N_C12), .A_out(N_R13), .B_out(N_C13));
    hPE C23(.CLK(CLK),  .EN(EN), .C(Y_23), .A(N_R13), .B(N_C22), .A_out(N_R23), .B_out(N_C23));
    hPE C33(.CLK(CLK),  .EN(EN), .C(Y_33), .A(N_R32), .B(N_C32), .A_out(N_R33), .B_out(N_C33));
    hPE C43(.CLK(CLK),  .EN(EN), .C(Y_43), .A(N_R33), .B(N_C42), .A_out(N_R43), .B_out(N_C43));
    hPE C53(.CLK(CLK),  .EN(EN), .C(Y_53), .A(N_R43), .B(N_C52), .A_out(N_R53), .B_out(N_C53));
    hPE C63(.CLK(CLK),  .EN(EN), .C(Y_63), .A(N_R53), .B(N_C62), .A_out(N_R63), .B_out(N_C63));
    hPE C73(.CLK(CLK),  .EN(EN), .C(Y_73), .A(N_R63), .B(N_C72), .A_out(N_R3Y), .B_out(N_C73));


// Row 4
    hPE C04(.CLK(CLK),  .EN(EN), .C(Y_04), .A(N_R4X), .B(N_C03), .A_out(N_R04), .B_out(N_C04));
    hPE C14(.CLK(CLK),  .EN(EN), .C(Y_14), .A(N_R04), .B(N_C13), .A_out(N_R14), .B_out(N_C14));
    hPE C24(.CLK(CLK),  .EN(EN), .C(Y_24), .A(N_R14), .B(N_C23), .A_out(N_R24), .B_out(N_C24));
    hPE C34(.CLK(CLK),  .EN(EN), .C(Y_34), .A(N_R24), .B(N_C33), .A_out(N_R34), .B_out(N_C34));
    hPE C44(.CLK(CLK),  .EN(EN), .C(Y_44), .A(N_R34), .B(N_C43), .A_out(N_R44), .B_out(N_C44));
    hPE C54(.CLK(CLK),  .EN(EN), .C(Y_54), .A(N_R44), .B(N_C53), .A_out(N_R54), .B_out(N_C54));
    hPE C64(.CLK(CLK),  .EN(EN), .C(Y_64), .A(N_R54), .B(N_C63), .A_out(N_R64), .B_out(N_C64));
    hPE C74(.CLK(CLK),  .EN(EN), .C(Y_74), .A(N_R64), .B(N_C73), .A_out(N_R4Y), .B_out(N_C74));


// Row 5
    hPE C05(.CLK(CLK),  .EN(EN), .C(Y_05), .A(N_R5X), .B(N_C04), .A_out(N_R05), .B_out(N_C05));
    hPE C15(.CLK(CLK),  .EN(EN), .C(Y_15), .A(N_R05), .B(N_C14), .A_out(N_R15), .B_out(N_C15));
    hPE C25(.CLK(CLK),  .EN(EN), .C(Y_25), .A(N_R15), .B(N_C24), .A_out(N_R25), .B_out(N_C25));
    hPE C35(.CLK(CLK),  .EN(EN), .C(Y_35), .A(N_R25), .B(N_C34), .A_out(N_R35), .B_out(N_C35));
    hPE C45(.CLK(CLK),  .EN(EN), .C(Y_45), .A(N_R35), .B(N_C44), .A_out(N_R45), .B_out(N_C45));
    hPE C55(.CLK(CLK),  .EN(EN), .C(Y_55), .A(N_R45), .B(N_C54), .A_out(N_R55), .B_out(N_C55));
    hPE C65(.CLK(CLK),  .EN(EN), .C(Y_65), .A(N_R55), .B(N_C64), .A_out(N_R65), .B_out(N_C65));
    hPE C75(.CLK(CLK),  .EN(EN), .C(Y_75), .A(N_R65), .B(N_C74), .A_out(N_R5Y), .B_out(N_C75));


// Row 6
    hPE C06(.CLK(CLK),  .EN(EN), .C(Y_06), .A(N_R6X), .B(N_C05), .A_out(N_R06), .B_out(N_C06));
    hPE C16(.CLK(CLK),  .EN(EN), .C(Y_16), .A(N_R06), .B(N_C15), .A_out(N_R16), .B_out(N_C16));
    hPE C26(.CLK(CLK),  .EN(EN), .C(Y_26), .A(N_R16), .B(N_C25), .A_out(N_R26), .B_out(N_C26));
    hPE C36(.CLK(CLK),  .EN(EN), .C(Y_36), .A(N_R26), .B(N_C35), .A_out(N_R36), .B_out(N_C36));
    hPE C46(.CLK(CLK),  .EN(EN), .C(Y_46), .A(N_R36), .B(N_C45), .A_out(N_R46), .B_out(N_C46));
    hPE C56(.CLK(CLK),  .EN(EN), .C(Y_56), .A(N_R46), .B(N_C55), .A_out(N_R56), .B_out(N_C56));
    hPE C66(.CLK(CLK),  .EN(EN), .C(Y_66), .A(N_R56), .B(N_C65), .A_out(N_R66), .B_out(N_C66));
    hPE C76(.CLK(CLK),  .EN(EN), .C(Y_76), .A(N_R66), .B(N_C75), .A_out(N_R6Y), .B_out(N_C76));


// Row 7
    hPE C07(.CLK(CLK),  .EN(EN), .C(Y_07), .A(N_R7X), .B(N_C06), .A_out(N_R07), .B_out(N_C0Y));
    hPE C17(.CLK(CLK),  .EN(EN), .C(Y_17), .A(N_R07), .B(N_C16), .A_out(N_R17), .B_out(N_C1Y));
    hPE C27(.CLK(CLK),  .EN(EN), .C(Y_27), .A(N_R17), .B(N_C26), .A_out(N_R27), .B_out(N_C2Y));
    hPE C37(.CLK(CLK),  .EN(EN), .C(Y_37), .A(N_R27), .B(N_C36), .A_out(N_R37), .B_out(N_C3Y));
    hPE C47(.CLK(CLK),  .EN(EN), .C(Y_47), .A(N_R37), .B(N_C46), .A_out(N_R47), .B_out(N_C4Y));
    hPE C57(.CLK(CLK),  .EN(EN), .C(Y_57), .A(N_R47), .B(N_C56), .A_out(N_R57), .B_out(N_C5Y));
    hPE C67(.CLK(CLK),  .EN(EN), .C(Y_67), .A(N_R57), .B(N_C66), .A_out(N_R67), .B_out(N_C6Y));
    hPE C77(.CLK(CLK),  .EN(EN), .C(Y_77), .A(N_R67), .B(N_C76), .A_out(N_R7Y), .B_out(N_C7Y));


endmodule