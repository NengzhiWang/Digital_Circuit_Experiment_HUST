module set_alarm
(
    input       clk,
    input       min_set,
    input       hour_set,
    // output wire alarm_set,
    output wire [3:0] min_01,
    output wire [3:0] min_10,
    output wire [3:0] hour_01,
    output wire [3:0] hour_10
);
    // assign alarm_set = min_set || hour_set;

    counter_60 min_alarm
    (
        .clk        (clk),
        .clr_n      (1'b1),
        .en         (min_set),
        .Q_10       (min_10),
        .Q_01       (min_01),
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