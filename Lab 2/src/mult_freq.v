/*
    frequency divide circuit
    50 MHz signal to 1Hz, 500Hz and 1kHz signal
*/
module mult_freq_div
(
    input       clk,        // 50MHz clock input
    input       clr_n,      // clear signal
    output reg  clk_1Hz,    // 1Hz outout
    output reg  clk_500Hz,  // 500Hz output
    output reg  clk_1kHz    // 1kHz output
);

    reg [25:0] clk_cnt_1;     // 26-bit counter
    reg [25:0] clk_cnt_2;     // 26-bit counter
    reg [25:0] clk_cnt_3;     // 26-bit counter
    always @(posedge clk or negedge clr_n)
    begin
        if (~clr_n)
        // set zero
        begin
            clk_cnt_1   <= 0;
            clk_cnt_2   <= 0;
            clk_cnt_3   <= 0;
            clk_1Hz     <= 0;
            clk_500Hz   <= 0;
            clk_1kHz    <= 0;
        end
        else
        begin
            if (clk_cnt_1 == 'd24_999_999)
            // 25M posedge, reset counter, output flip
            begin
                clk_cnt_1   <= 'b0;
                clk_1Hz     <= ~clk_1Hz;
            end
            else
                // counter ++
                clk_cnt_1 <= clk_cnt_1 + 1;


            if (clk_cnt_2 == 'd49999)
            begin
                clk_cnt_2   <= 'b0;
                clk_500Hz   <= ~clk_500Hz;
            end
            else
                // counter ++
                clk_cnt_2 <= clk_cnt_2 + 1;


            if (clk_cnt_3 == 'd24999)
            begin
                clk_cnt_3   <= 'b0;
                clk_1kHz    <= ~clk_1kHz;
            end
            else
                // counter ++
                clk_cnt_3 <= clk_cnt_3 + 1;

        end

    end

endmodule