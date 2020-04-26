/*
    Wang Nengzhi
    U201713082
    SES1701
*/

// `include "./bi_direction_counter_8.v"
// `include "./bi_register_8.v"
// `include "./decoder_3_8.v"
// `include "./mux_8.v"
// `include "./freq_div.v"

module LEDs(
    input       clk,            // input, 50MHz clock signal
    input       clr_n,          // reset, 0 is effect
    input       select,         // data select register or counter
    output wire [7:0] LED_pins  // output, for 8 LEDs
);

    wire clk_1Hz;

    // frequency divide
    // input 50MHz clock signal
    // output 1Hz clock signal
    freq_div freq_div_inst
    (
        .clk        (clk),          // input
        .clr_n      (clr_n),        // input
        .clk_1Hz    (clk_1Hz)       // output
    );

    wire [2:0] counter;
    wire [7:0] decoder_out;
    wire [7:0] regeister_out;

    // 3-bit counter
    // input 1Hz clock
    // output 3-bit number from 0 to 7
    bi_direction_counter_8 bi_direction_counter_8_inst
    (
        .clk        (clk_1Hz),          // input
        .reset_n    (clr_n),            // input
        .num_out    (counter)           // output
    );

    // 3-8 decoder
    // input 3-bit number
    // output 8-bit one-hot number
    decoder_3_8 decoder_3_8_inst
    (
        .x          (counter),          // input
        .enable     (1'b1),             // input
        .y          (decoder_out)       // output
    );

    // 8-bit register
    // input 1Hz clock
    // output 8-bit parallel, one-hot
    bi_register_8 bi_register_8_inst
    (
        .clk        (clk_1Hz),          // input
        .reset_n    (clr_n),            // input
        .Q          (regeister_out)     // output
    );

    // mult-data select
    // input
    //      data from decoder
    //      data fron register
    //      select
    mux_8 mux_8_inst
    (
        .x1         (decoder_out),      // input
        .x2         (regeister_out),    // input
        .select     (select),           // input
        .y          (LED_pins)          // output
    );

endmodule