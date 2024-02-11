`timescale 1ns / 1ps

module FSM(
    input rst,
    input clk,
    input en,
    input write,
    input load,
    input [15:0] data_in,
    input [2:0] idx,
    input [3:0] reg_select, 
    output [15:0] data_out,
    output int_to_ps,           // use to interrupt the CPU after changing state (edge trigger)
    output read_led,
    output write_led,
    output load_led,
    output matmul_led
);
    
    reg [31:0] load_counter = 0;
    reg [31:0] matmul_counter = 0;  
    reg int_buffer = 0;
    localparam MAX_MM_CYCLES = 24;
    localparam MAX_LOAD_CYCLES = 9;
    
    
    always@(posedge clk) begin
        // loading
        if(load && !write) begin
            matmul_counter <= 0;
            if(load_counter < MAX_LOAD_CYCLES) begin
                load_counter <= load_counter + 1;
                int_buffer <= 0;
            end
            else begin
                int_buffer <= 1;
            end
        end 
        
        // Writing to memory
        else if (!load && write) begin
            int_buffer <= 0;
            load_counter <= 0;
            matmul_counter <= 0;
        end
        
        // doing matmul
        else if (!load && !write) begin
            load_counter <= 0;
            if (matmul_counter < MAX_MM_CYCLES) begin
                matmul_counter <= matmul_counter + 1;
                int_buffer <= 0;
            end
            else begin
                int_buffer <= 1;
            end
        end

        // reading or else...
        else begin
            load_counter <= 0;
            matmul_counter <= 0;
            int_buffer <= 0;
        end
    end
    
    // Instantiation
    controller control_module(
        .RST(rst),
        .CLK(clk),
        .EN(en),
        .WRITE(write),
        .IDX(idx),
        .REG_SELECT(reg_select),
        .LOAD(load),
        .DATA_IN(data_in),
        .DATA_OUT(data_out)
    );
    
    // Interrupt
    assign int_to_ps = int_buffer;
    
    // Status LEDs
    assign read_led = (load && write);
    assign write_led = (!load && write);
    assign load_led = (load && !write);
    assign matmul_led = (!load && !write);
    
endmodule
