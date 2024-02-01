// RegisterFile & Internal Controller

// Assumption:
//      The SW part already transposed the weight matrix.
//      
//      Future Work: TRANSPOSER.sv

module RF(CLK, RF_EN, WRITE, IDX, DIN, REG_SELECT, X_OUT, W_OUT);

    input CLK;
    input RF_EN;
    
    input WRITE;                        // Are we writing to the registers?
    
    input [4:0] IDX;
    input [15:0] DIN;


    input [3:0] REG_SELECT;             

    output [15:0] X_OUT [0:7];
    output [15:0] W_OUT [0:7];


    reg [15:0] REG_EN; // Enable which register 
    // reg REG_WRITE; 

    // reg [15:0]  DATA_BUFFER = 0;

    reg [15:0]  DIN_BUFFER = 0;
    reg [4:0]   IDX_BUFFER = 0;
    reg [3:0]   REG_SELECT_BUFFER = 0;
    reg [15:0]  SPIT_COUNTER = 0;

    // Depending on which register is selected: 
    always_comb begin

        // When writing, just one at a time
        if (WRITE) begin
            case (REG_SELECT_BUFFER)
                0: REG_EN   = 16'b1;
                1: REG_EN   = 16'b1 << 1;
                2: REG_EN   = 16'b1 << 2;
                3: REG_EN   = 16'b1 << 3;
                
                4: REG_EN   = 16'b1 << 4;
                5: REG_EN   = 16'b1 << 5;
                6: REG_EN   = 16'b1 << 6;
                7: REG_EN   = 16'b1 << 7;
                
                8: REG_EN   = 16'b1 << 8;
                9: REG_EN   = 16'b1 << 9;
                10: REG_EN  = 16'b1 << 10;
                11: REG_EN  = 16'b1 << 11;
                
                12: REG_EN  = 16'b1 << 12;
                13: REG_EN  = 16'b1 << 13;
                14: REG_EN  = 16'b1 << 14;
                15: REG_EN  = 16'b1 << 15;
                default: REG_EN = 16'b0;            // TODO: Double Check
            endcase
        end

        // When not writing, enable all registers
        else if (!WRITE) begin
            REG_EN = 16'hFFFF;
        end
    end



    always@(posedge CLK) begin
        if(RF_EN) begin

            // During WRITE, select one REG at a time
            if(WRITE) begin
                DIN_BUFFER <= DIN;
                IDX_BUFFER <= IDX;
                REG_SELECT_BUFFER <= REG_SELECT;
            end


            // After write, 
            else if (!WRITE) begin
                
            end

        end 
    end


    // Input Matrix
    X_REG X_REG_0(.CLK(CLK), .EN(REG_EN[0]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(X_OUT[0]));

    X_REG X_REG_1(.CLK(CLK), .EN(REG_EN[1]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(X_OUT[1]));

    X_REG X_REG_2(.CLK(CLK), .EN(REG_EN[2]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(X_OUT[2]));

    X_REG X_REG_3(.CLK(CLK), .EN(REG_EN[3]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(X_OUT[3]));

    X_REG X_REG_4(.CLK(CLK), .EN(REG_EN[4]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(X_OUT[4]));

    X_REG X_REG_5(.CLK(CLK), .EN(REG_EN[5]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(X_OUT[5]));

    X_REG X_REG_6(.CLK(CLK), .EN(REG_EN[6]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(X_OUT[6]));

    X_REG X_REG_7(.CLK(CLK), .EN(REG_EN[7]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(X_OUT[7]));

    

    // Weights Matrix    
    X_REG X_REG_8(.CLK(CLK), .EN(REG_EN[8]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(W_OUT[0]));

    X_REG X_REG_9(.CLK(CLK), .EN(REG_EN[9]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(W_OUT[1]));

    X_REG X_REG_A(.CLK(CLK), .EN(REG_EN[10]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(W_OUT[2]));

    X_REG X_REG_B(.CLK(CLK), .EN(REG_EN[11]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(W_OUT[3]));

    X_REG X_REG_C(.CLK(CLK), .EN(REG_EN[12]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(W_OUT[4]));

    X_REG X_REG_D(.CLK(CLK), .EN(REG_EN[13]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(W_OUT[5]));

    X_REG X_REG_E(.CLK(CLK), .EN(REG_EN[14]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(W_OUT[6]));

    X_REG X_REG_F(.CLK(CLK), .EN(REG_EN[15]), .WRITE(WRITE),
        .IDX(IDX_BUFFER), .DIN(DIN_BUFFER), .DOUT(W_OUT[7]));

    


    

endmodule