`timescale 1ns / 1ps


// Encapsulate the wires for reduced AXI GPIO blocks needed

module ChipTop(
    input EN,
    input CLK,
    input CLEAR,
    input [8:0] AUX,
    input [15:0] DATA_IN,
    output [15:0] DATA_OUT,
    output INTERRUPT_PIN,
    output READ_LED,
    output WRITE_LED,
    output LOAD_LED,
    output MATMUL_LED,
    output EN_LED
    );
    

    FSM systolic_core(
        .rst(CLEAR), .clk(CLK), .en(EN), .write(AUX[0]), .load(AUX[1]), .data_in(DATA_IN),
        .idx(AUX[4:2]), .reg_select(AUX[8:5]), .data_out(DATA_OUT), .int_to_ps(INTERRUPT_PIN),
        .read_led(READ_LED), .write_led(WRITE_LED), .load_led(LOAD_LED), .matmul_led(MATMUL_LED)
    );
    
    assign EN_LED = EN;
    
    
    
    
endmodule
