module tone
(
    input       clk_1Hz,
    input       clk_500Hz,
    input       clk_1kHz,
    input       en_500,
    input       en_1k,

    output wire tone_500,
    output wire tone_1k
);
    assign tone_500 = (clk_1Hz & en_500) ? clk_500Hz : 1'b0;
    assign tone_1k  = (clk_1Hz & en_1k)  ? clk_1kHz  : 1'b0;

endmodule