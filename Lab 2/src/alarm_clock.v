module alarm_clock
(
    input       clk,
    input       min_correct,
    input       hour_correct,
    input       alarm_min_set,
    input       alarm_hour_set,
    output wire [3:0] sec_01,
    output wire [3:0] sec_10,
    output wire [3:0] min_01,
    output wire [3:0] min_10,
    output wire [3:0] hour_01,
    output wire [3:0] hour_10,
    output wire alarm_en
);

    wire sec_cout;
    wire min_cout;
    
    wire min_en;
    wire hour_en;

    assign min_en   = (sec_cout || min_correct);
    assign hour_en  = (sec_cout & min_cout) || hour_correct;

    wire [3:0] clock_sec_10;
    wire [3:0] clock_sec_01;
    wire [3:0] clock_min_10;
    wire [3:0] clock_min_01;
    wire [3:0] clock_hour_01;
    wire [3:0] clock_hour_10;

    wire [3:0] alarm_min_01;
    wire [3:0] alarm_min_10;
    wire [3:0] alarm_hour_01;
    wire [3:0] alarm_hour_10;


    wire [15:0] clock_time;
    wire [15:0] alarm_time;

    assign clock_time = {clock_hour_10, clock_hour_01, clock_min_10, clock_min_01};
    assign alarm_time = {alarm_hour_10, alarm_hour_01, alarm_min_10, alarm_min_01};

    assign alarm_en = (clock_time == alarm_time) ? 1'b1 : 1'b0;


    // wire alarm_set;

    assign min_10   = (alarm_min_set == 1'b1)   ?   alarm_min_10 : clock_min_10;
    assign min_01   = (alarm_min_set == 1'b1)   ?   alarm_min_01 : clock_min_01;
    assign hour_10  = (alarm_hour_set == 1'b1)  ?   alarm_hour_10 : clock_hour_10;
    assign hour_01  = (alarm_hour_set == 1'b1)  ?   alarm_hour_01 : clock_hour_01;
    assign sec_01 = clock_sec_01;
    assign sec_10 = clock_sec_10;

    counter_60 sec_counter
    (
        .clk        (clk),
        .clr_n      (1'b1),
        .en         (1'b1),
        .Q_10       (clock_sec_10),
        .Q_01       (clock_sec_01),
        .cout       (sec_cout)
    );


    counter_60 min_counter
    (
        .clk        (clk),
        .clr_n      (1'b1),
        .en         (min_en),
        .Q_10       (clock_min_10),
        .Q_01       (clock_min_01),
        .cout       (min_cout)
    );

    counter_24 hour_counter
    (
        .clk        (clk),
        .clr_n      (1'b1),
        .en         (hour_en),
        .Q_01       (clock_hour_01),
        .Q_10       (clock_hour_10)
    );


    set_alarm alarm_seting
    (
        .clk        (clk),
        .min_set    (alarm_min_set),
        .hour_set   (alarm_hour_set),
        // .alarm_set  (alarm_set),
        .min_01     (alarm_min_01),
        .min_10     (alarm_min_10),
        .hour_01    (alarm_hour_01),
        .hour_10    (alarm_hour_10)
    );

endmodule 