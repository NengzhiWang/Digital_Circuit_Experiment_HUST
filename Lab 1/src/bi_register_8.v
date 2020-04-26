/*
    Wang Nengzhi
    U201713082
    SES1701
*/

module bi_register_8
(
    input       clk,        // 1Hz clock
    input       reset_n,    // reset signal, 0 is effect
    output reg  [7:0] Q     // parallel output
);

    reg dir;        // Data Direction Register

    always @(posedge clk or negedge reset_n)
    begin
        if (~reset_n)
        // reset register
        begin
            Q <= 8'b0000_0001;
            dir <= 1'b0;
        end
        else if (dir == 1'b0)
        // left shift
        begin
            Q <= {Q[6:0], Q[7]};
            if (Q == 8'b0100_0000)
                // change direction
                dir <= 1'b1;
            else
                dir <= 1'b0;      
        end
        else if (dir == 1'b1)
        // right shift
        begin
            Q <= {Q[0], Q[7:1]};
            if (Q == 8'b0000_0010)
                // change direction
                dir <= 1'b0;
            else
                dir <= 1'b1; 
           
        end
    end

endmodule