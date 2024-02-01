// Parallel Shifting Register --> Replace FIFOs

module X_REG(CLK, EN, WRITE, IDX, DIN, DOUT);
    input           CLK;
    input           EN;

    input           WRITE;         // When EN && !WRITE, every clock cycle, spit data
    
    input   [4:0]  IDX;            // Absolute INDX
    input   [15:0]  DIN;
    output  [15:0]  DOUT;

    

    reg     [15:0]  PIPE    [0:31];


    // Buffers
    // reg     [15:0]  DIN_BUFFER = 0;
    // reg     [4:0]  IDX_BUFFER = 0;

    reg     [15:0]  DOUT_BUFFER = 0;

    initial begin

        // Initialize Memory 
        for(integer i = 0; i < 32; i = i + 1) begin
            PIPE[i] = 0;
        end
    end


    /*Synthesizable RTL Code according to Prof. Adi Teman

        SRC: https://www.youtube.com/watch?v=BIqLk23hE90

        Sequential circuits always sample the inputs.
        Then, process them using combinational circuits

        This is how they should look like:
        --> FF --> COMBINATIONAL LOGIC --> FF -->


        However!
            - The extra buffers can be a problem especially if we have 
            limited resources. 
            - Modularity given by always_comb may be good for complex circuits
            but can be difficult for synthesis tools to synthesize the code.
            Because it lacks timing information.
    */
    
    
    // // Combinational Circuit
    // always_comb begin
    //     PIPE[IDX_BUFFER] = DIN_BUFFER;
    // end


    // Data Sampling (IN REG)
    always@(posedge CLK) begin
        if (EN) begin
            if(WRITE) begin

                // DIN_BUFFER <= DIN;
                // IDX_BUFFER <= IDX;

                PIPE[IDX] <= DIN;
            end

            else if (!WRITE) begin
                DOUT_BUFFER <= PIPE[0];

                // Set the Tail to 0
                // IDX_BUFFER <= 5'd31;
                // DIN_BUFFER <= 16'b0;

                for(integer i = 0; i < 31; i = i + 1) begin
                    PIPE[i] <= PIPE[i+1];
                end

                PIPE[31] <= 0;
            end
        end
    end

    // OUT REG
    assign DOUT = DOUT_BUFFER;

endmodule