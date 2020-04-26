/*
    Wang Nengzhi
    U201713082
    SES1701
*/

module freq_div
(
    input       clk,        // input, 50MHz clock signal
    input       clr_n,      // reset, 0 is effect
    output reg  clk_1Hz     // output, 1Hz clock signal
);
    reg [25:0] clk_cnt;     // 26-bit counter
    always @(posedge clk or negedge clr_n)
    begin
        if (~clr_n)
        // set zero
        begin
            clk_cnt <= 0;
            clk_1Hz <= 0;
        end
        else
        begin
            //if (clk_cnt == 'd24_999_999)
            if (clk_cnt == 'd1)            // test, divide 4
            // 25M posedge, reset counter, output flip
            begin
                clk_cnt <= 'b0;
                clk_1Hz <= ~clk_1Hz;
            end

            else
            // counter ++
                clk_cnt <= clk_cnt + 1;
        end
    end

endmodule