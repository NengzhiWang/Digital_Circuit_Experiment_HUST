/*
    Wang Nengzhi
    U201713082
    SES1701
*/

module bi_direction_counter_8
(
    input       clk,            // clock signal
    input       reset_n,        // reset_n signal, 0 is effect
    output reg  [2:0] num_out   // num output
);
    reg M;                      // 0: num++; 1: num--

    always @(posedge clk or negedge reset_n)
    begin
        if (~reset_n)
        begin
            num_out <= 3'b000;
            M <= 1'b0;
        end
        else if (M == 1'b0)
        begin
            num_out <= num_out + 3'b001;
            if (num_out == 3'b110)
                M <= 1'b1;
            else
                M <= 1'b0;
        end
        else if (M == 1'b1)
        begin
            num_out <= num_out - 3'b001;
            if (num_out == 3'b001)
                M <= 1'b0;
            else
                M <= 1'b1;
        end
    end
endmodule
