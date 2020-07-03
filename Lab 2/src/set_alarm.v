/*
    alarm setup circuit
    enable min and hour counter to set time of alarm clock
*/ 
module set_alarm
(
    input       clk,            // 1Hz clock signal input
    input       min_set,        // min set enable
    input       hour_set,       // hour set enable
    output wire [3:0] min_01,   
    output wire [3:0] min_10,
    output wire [3:0] hour_01,
    output wire [3:0] hour_10   // BCD codes
);

    counter_60 min_alarm
    (
        .clk        (clk),
        .clr_n      (1'b1),
        .en         (min_set),
        .Q_01       (min_01),
        .Q_10       (min_10),
        .cout       ()
    );

    counter_24 hour_alarm
    (
        .clk        (clk),
        .clr_n      (1'b1),
        .en         (hour_set),
        .Q_01       (hour_01),
        .Q_10       (hour_10)
    );


endmodule