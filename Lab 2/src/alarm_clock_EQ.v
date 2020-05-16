module alarm_clock_EQ
(

    input [3:0] clock_sec_01,
    input [3:0] clock_sec_10,
    input [3:0] clock_min_01,
    input [3:0] clock_min_10,
    input [3:0] clock_hour_01,
    input [3:0] clock_hour_10,

    input [3:0] alarm_min_01,
    input [3:0] alarm_min_10,
    input [3:0] alarm_hour_01,
    input [3:0] alarm_hour_10,

    output wire alarm_en
);

    // 10 of hour is equal
    wire hour_10_equal;
    assign hour_10_equal    = (clock_hour_10 == alarm_hour_10);
    // 01 of hour is equal
    wire hour_01_equal;
    assign hour_01_equal    = (clock_hour_01 == alarm_hour_01);
    // 10 of min is equal
    wire min_10_equal;
    assign min_10_equal     = (clock_min_10 == alarm_min_10);
    // 01 of min is equal
    wire min_01_equal;
    assign min_01_equal     = (clock_min_01 == alarm_min_01);
    // clock is equal to alarm
    wire equal;
    assign equal = (hour_10_equal & hour_01_equal & min_10_equal & min_01_equal);
    // enable clock in 0-29 sec
    assign alarm_en = (equal & clock_sec_10 < 4'b0011);

endmodule