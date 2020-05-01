module alarm_clock_EQ
(
    input [3:0] clock_min_10,
    input [3:0] clock_min_01,
    input [3:0] clock_hour_01,
    input [3:0] clock_hour_10,

    input [3:0] alarm_min_01,
    input [3:0] alarm_min_10,
    input [3:0] alarm_hour_01,
    input [3:0] alarm_hour_10,
    output wire equal
);
    wire [15:0] clock_time;
    wire [15:0] alarm_time;

    assign clock_time = {clock_hour_10, clock_hour_01, clock_min_10, clock_min_01};
    assign alarm_time = {alarm_hour_10, alarm_hour_01, alarm_min_10, alarm_min_01};

    assign equal = (clock_time == alarm_time) ? 1'b1 : 1'b0;

endmodule