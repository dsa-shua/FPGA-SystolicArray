// `timescale 1ns / 1ps

// TODO: make an 8x8 systolic array
// This is better done using Vivado Block Diagram but we do it the hard way. 
// The design is a bit weird: all outputs are instantly accessible. 
//      We can definitely design a better PE unit where it just passes the data 
//      for collection when done.

// Another solution:
//      Write RTL for a 2x2 systolic array. Then write going upwards:
//          2x2 --> connect 4 to make  4x4 --> 8x8
//      The only problem: we no longer have "direct" access to the output.
//      We have to propagate the output if we need it.
//      We can always view it during simulations using GTKWave or Vivado.
//      Another problem: I dont know if double blocking is possible in Vivado.
//
//      Decide if you want direct access to the outputs.
//          Pros: fast access.
//          Cons: need complicated hardware (more wires, if not, complex FSM)



/*
Basic Systolic Array Tile
    - no direct PE output
*/

module SYSTOLIC(CLK, EN, N_RX0, N_RX1, N_CX0, N_CX1, N_RY0, N_RY1, N_CY0, N_CY1);

    // Aux I/O
    input CLK, EN;

    // Left Edge (Row Inputs)
    input   [31:0]  N_RX0, N_RX1;

    // Top Edge (Column Inputs)
    input   [31:0]  N_CX0, N_CX1;

    // Output wires for next tile
    output  [31:0]  N_RY0, N_RY1, N_CY0, N_CY1;



    // TODO: decide if this needs to be removeed.
    // Per Cell Output Data
    wire    [31:0] C00, C01, C10, C11;

    // Wires Connecting Rows (except input connections)
    wire    [31:0]  N_R0, N_R1;

    // Wires Connecting Columns (except input connections)
    wire    [31:0]  N_C0, N_C1;   

    // Interconnect
    PE Cell00(.C(C00), .A(N_RX0), .B(N_CX0), .A_out(N_R0), .B_out(N_C0), .CLK(CLK), .EN(EN));
    PE Cell01(.C(C01), .A(N_R0), .B(N_CX1), .A_out(N_RY0), .B_out(N_C1), .CLK(CLK), .EN(EN));
    PE Cell10(.C(C10), .A(N_RX1), .B(N_C0), .A_out(N_R1), .B_out(N_CY0), .CLK(CLK), .EN(EN));
    PE Cell11(.C(C11), .A(N_R1), .B(N_C1), .A_out(N_RY1), .B_out(N_CY1), .CLK(CLK), .EN(EN));
    
    

    
endmodule
