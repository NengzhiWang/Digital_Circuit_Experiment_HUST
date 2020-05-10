module tone
(
    input clk_1Hz,
    input clk_500Hz,
    input clk_1kHz,
    input en_500,
    input en_1k,

    output wire tone_500,
    output wire tone_1k
);
    assign tone_500 = (clk_1Hz & clk_500Hz & en_500) ? 1'b1 : 1'b0;
    assign tone_1k = (clk_1Hz & clk_1kHz & en_1k) ? 1'b1 : 1'b0;

endmodule