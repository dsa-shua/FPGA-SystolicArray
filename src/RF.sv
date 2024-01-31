// Register File for Edge FIFOs

module RF(CLK, RF_ENABLE, FIFO_ENABLE, FIFO_WRITE, RF_WRITE, ADDR, DATA, R_OUT, C_OUT, FIFO_STATUS);

    input           CLK;
    input           RF_ENABLE;
    input           FIFO_ENABLE;
    input           FIFO_WRITE;
    input           RF_WRITE;

    input   [31:0]  ADDR;                   // Index of an item
    input   [15:0]  DATA;                   // Data input to a FIFO

    output  [15:0]  R_OUT       [0:7];
    output  [15:0]  C_OUT       [0:7];

    output  [3:0]   FIFO_STATUS [0:15];



    reg     [15:0]  R_DIN       [0:7];
    reg     [15:0]  C_DIN       [0:7];


    reg     [15:0]  IN_SEQ      [0:7][0:7];


    ///////////////////////                INITIALIZATION             //////////////////////////

    initial begin
        
        // Initialize Registers to FIFOs
        for(integer i = 0; i < 8; i = i + 1) begin
            R_DIN[i] = 0;
            C_DIN[i] = 0;
        end

        // Initialize Memory
        for(integer i = 0; i < 8; i = i + 1) begin
            for(integer j = 0; j < 8; j = j + 1) begin
                IN_SEQ[i][j] = 0;
            end
        end


    end


    // FOR DEBUGGING! DELETE THIS WHEN DONE
    always@(negedge RF_WRITE) begin
        $display("\nRF_WRITE NEG EDGE!");
        for(integer i = 0; i < 8; i = i + 1) begin
            for(integer j = 0; j < 8; j = j + 1) begin
                $display("  DATA[%d][%d] = %d",i,j,IN_SEQ[i][j]);
            end
        end
    end

    //////////////////////////////////////////////////////////////////////////////////////////////


    always@(posedge CLK) begin
        if(RF_ENABLE) begin
            
            // If FIFO is not enabled yet --> we take in data from host, store to MEM, not FIFO
            if(!FIFO_ENABLE && RF_WRITE) begin
                IN_SEQ[ADDR[5:3]][ADDR[2:0]] <= DATA;
            end
        end
    end

/*
// Architecture 

    hFIFO R_FIFO_0(.DATA_IN(R_DIN[0]), .DATA_OUT(R_DOUT[0]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[0][3]), .ALMOST_EMPTY(FIFO_STATUS[0][2]), .FULL(FIFO_STATUS[0][1]), .EMPTY(FIFO_STATUS[0][0]));

    hFIFO R_FIFO_1(.DATA_IN(R_DIN[1]), .DATA_OUT(R_DOUT[1]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[1][3]), .ALMOST_EMPTY(FIFO_STATUS[1][2]), .FULL(FIFO_STATUS[1][1]), .EMPTY(FIFO_STATUS[1][0]));
    
    hFIFO R_FIFO_2(.DATA_IN(R_DIN[2]), .DATA_OUT(R_DOUT[2]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[2][3]), .ALMOST_EMPTY(FIFO_STATUS[2][2]), .FULL(FIFO_STATUS[2][1]), .EMPTY(FIFO_STATUS[2][0]));
    
    hFIFO R_FIFO_3(.DATA_IN(R_DIN[3]), .DATA_OUT(R_DOUT[3]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[3][3]), .ALMOST_EMPTY(FIFO_STATUS[3][2]), .FULL(FIFO_STATUS[3][1]), .EMPTY(FIFO_STATUS[3][0]));

    hFIFO R_FIFO_4(.DATA_IN(R_DIN[4]), .DATA_OUT(R_DOUT[4]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[4][3]), .ALMOST_EMPTY(FIFO_STATUS[4][2]), .FULL(FIFO_STATUS[4][1]), .EMPTY(FIFO_STATUS[4][0]));
    
    hFIFO R_FIFO_5(.DATA_IN(R_DIN[5]), .DATA_OUT(R_DOUT[5]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[5][3]), .ALMOST_EMPTY(FIFO_STATUS[5][2]), .FULL(FIFO_STATUS[5][1]), .EMPTY(FIFO_STATUS[5][0]));
    
    hFIFO R_FIFO_6(.DATA_IN(R_DIN[6]), .DATA_OUT(R_DOUT[6]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[6][3]), .ALMOST_EMPTY(FIFO_STATUS[6][2]), .FULL(FIFO_STATUS[6][1]), .EMPTY(FIFO_STATUS[6][0]));
    
    hFIFO R_FIFO_7(.DATA_IN(R_DIN[7]), .DATA_OUT(R_DOUT[7]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[7][3]), .ALMOST_EMPTY(FIFO_STATUS[7][2]), .FULL(FIFO_STATUS[7][1]), .EMPTY(FIFO_STATUS[7][0]));



    hFIFO C_FIFO_0(.DATA_IN(C_DIN[0]), .DATA_OUT(C_DOUT[0]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[8][3]), .ALMOST_EMPTY(FIFO_STATUS[8][2]), .FULL(FIFO_STATUS[8][1]), .EMPTY(FIFO_STATUS[8][0]));

    hFIFO C_FIFO_1(.DATA_IN(C_DIN[1]), .DATA_OUT(C_DOUT[1]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[9][3]), .ALMOST_EMPTY(FIFO_STATUS[9][2]), .FULL(FIFO_STATUS[9][1]), .EMPTY(FIFO_STATUS[9][0]));
    
    hFIFO C_FIFO_2(.DATA_IN(C_DIN[2]), .DATA_OUT(C_DOUT[2]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[10][3]), .ALMOST_EMPTY(FIFO_STATUS[10][2]), .FULL(FIFO_STATUS[10][1]), .EMPTY(FIFO_STATUS[10][0]));
    
    hFIFO C_FIFO_3(.DATA_IN(C_DIN[3]), .DATA_OUT(C_DOUT[3]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[11][3]), .ALMOST_EMPTY(FIFO_STATUS[11][2]), .FULL(FIFO_STATUS[11][1]), .EMPTY(FIFO_STATUS[11][0]));

    hFIFO C_FIFO_4(.DATA_IN(C_DIN[4]), .DATA_OUT(C_DOUT[4]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[12][3]), .ALMOST_EMPTY(FIFO_STATUS[12][2]), .FULL(FIFO_STATUS[12][1]), .EMPTY(FIFO_STATUS[12][0]));
    
    hFIFO C_FIFO_5(.DATA_IN(C_DIN[5]), .DATA_OUT(C_DOUT[5]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[13][3]), .ALMOST_EMPTY(FIFO_STATUS[13][2]), .FULL(FIFO_STATUS[13][1]), .EMPTY(FIFO_STATUS[13][0]));
    
    hFIFO C_FIFO_6(.DATA_IN(C_DIN[6]), .DATA_OUT(C_DOUT[6]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[14][3]), .ALMOST_EMPTY(FIFO_STATUS[14][2]), .FULL(FIFO_STATUS[14][1]), .EMPTY(FIFO_STATUS[14][0]));
    
    hFIFO C_FIFO_7(.DATA_IN(C_DIN[7]), .DATA_OUT(C_DOUT[7]), .CLK(CLK), .WRITE(FIFO_WRITE), .ENABLE(FIFO_ENABLE), 
                .ALMOST_FULL(FIFO_STATUS[15][3]), .ALMOST_EMPTY(FIFO_STATUS[15][2]), .FULL(FIFO_STATUS[15][1]), .EMPTY(FIFO_STATUS[15][0]));
*/

endmodule