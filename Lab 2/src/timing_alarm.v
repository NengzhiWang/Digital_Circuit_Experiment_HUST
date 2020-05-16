module timing_alarm
(
    // clock signal
    input [3:0] clock_sec_01,
    input [3:0] clock_sec_10,
    input [3:0] clock_min_10,
    input [3:0] clock_min_01,
    input [3:0] clock_hour_01,
    input [3:0] clock_hour_10,
    // tone enable signal
    output wire timing_en_1,    // 500Hz
    output wire timing_en_2     // 1kHz
);
    wire sec_01;
    wire sec_10;

    wire min_01;
    wire min_10;
    // xx:59:55 to xx:59:59, 500Hz
    assign min_01 = (clock_min_01 == 4'b1001);
    assign sec_01 = (clock_sec_01 >= 4'b0101);

    assign min_10 = (clock_min_10 == 4'b0101);
    assign sec_10 = (clock_sec_10 == 4'b0101);

    assign timing_en_1 = ((sec_01 & sec_10 & min_01 & min_10) == 1'b1);
    // xx:00:00, 1kHz
    assign timing_en_2 = ({clock_min_10, clock_min_01, clock_sec_10, clock_sec_01} == 16'b0);

endmodule