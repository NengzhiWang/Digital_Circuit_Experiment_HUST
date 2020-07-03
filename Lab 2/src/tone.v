/*
sound drive circuit
input
    mult-clocks signals and enable signal of 500 or 1k Hz sound
output
    drive signal
*/
module tone
(
    input       clk_1Hz,        // 1Hz clock
    input       clk_500Hz,      // 500Hz clock
    input       clk_1kHz,       // 1kHz clock
    input       en_500,         // 500Hz enable
    input       en_1k,          // 1kHz enable

    output wire tone_500,       // 500Hz drive signal
    output wire tone_1k         // 1kHz drive signal
);
    assign tone_500 = (clk_1Hz & en_500) ? clk_500Hz : 1'b0;
    assign tone_1k  = (clk_1Hz & en_1k)  ? clk_1kHz  : 1'b0;

endmodule