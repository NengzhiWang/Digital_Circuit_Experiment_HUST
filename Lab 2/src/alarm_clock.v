module alarm_clock
(
    input       clk_1Hz,            // 1Hz clock signal
    input       hour_correct,       // hour correction
    input       min_correct,        // min correction
    input       alarm_hour_set,     // set alarm of hour
    input       alarm_min_set,      // set alarm of min
    
    output wire [3:0] sec_01,
    output wire [3:0] sec_10,
    output wire [3:0] min_01,
    output wire [3:0] min_10,
    output wire [3:0] hour_01,
    output wire [3:0] hour_10,

    output wire alarm_en,
    output wire timing_en_1,
    output wire timing_en_2

    // output wire 
);
 



    wire [3:0] clock_sec_01;
    wire [3:0] clock_sec_10;
    wire [3:0] clock_min_01;
    wire [3:0] clock_min_10;
    wire [3:0] clock_hour_01;
    wire [3:0] clock_hour_10;
    wire sec_cout;
    wire min_cout;

    wire min_en;
    wire hour_en;   
    assign hour_en  = (sec_cout & min_cout) || hour_correct;
    assign min_en   = (sec_cout || min_correct);


    wire [3:0] alarm_min_01;
    wire [3:0] alarm_min_10;
    wire [3:0] alarm_hour_01;
    wire [3:0] alarm_hour_10;


    // wire [15:0] clock_time;
    // wire [15:0] alarm_time;



/** time display **/
    wire alarm_setting;
    assign alarm_setting = (alarm_min_set || alarm_hour_set);
    assign sec_01   = clock_sec_01;
    assign sec_10   = clock_sec_10;
    assign min_01   = (alarm_setting == 1'b1)   ?   alarm_min_01  : clock_min_01;
    assign min_10   = (alarm_setting == 1'b1)   ?   alarm_min_10  : clock_min_10;
    assign hour_01  = (alarm_setting == 1'b1)   ?   alarm_hour_01 : clock_hour_01;
    assign hour_10  = (alarm_setting == 1'b1)   ?   alarm_hour_10 : clock_hour_10;

/** 24h clock **/
    counter_60 sec_counter
    (
        .clk        (clk_1Hz),
        .clr_n      (1'b1),
        .en         (1'b1),
        .Q_01       (clock_sec_01),
        .Q_10       (clock_sec_10),
        .cout       (sec_cout)
    );

    counter_60 min_counter
    (
        .clk        (clk_1Hz),
        .clr_n      (1'b1),
        .en         (min_en),
        .Q_01       (clock_min_01),
        .Q_10       (clock_min_10),
        .cout       (min_cout)
    );

    counter_24 hour_counter
    (
        .clk        (clk_1Hz),
        .clr_n      (1'b1),
        .en         (hour_en),
        .Q_01       (clock_hour_01),
        .Q_10       (clock_hour_10)
    );

/** set alarm clock **/
    set_alarm alarm_seting
    (
        .clk        (clk_1Hz),
        .min_set    (alarm_min_set),
        .hour_set   (alarm_hour_set),
        .min_01     (alarm_min_01),
        .min_10     (alarm_min_10),
        .hour_01    (alarm_hour_01),
        .hour_10    (alarm_hour_10)
    );


    alarm_clock_EQ ALARM
    (
        .clock_sec_01       (clock_sec_01),
        .clock_sec_10       (clock_sec_10),
        .clock_min_10       (clock_min_10),
        .clock_min_01       (clock_min_01),
        .clock_hour_01      (clock_hour_01),
        .clock_hour_10      (clock_hour_10),

        .alarm_min_01       (alarm_min_01),
        .alarm_min_10       (alarm_min_10),
        .alarm_hour_01      (alarm_hour_01),
        .alarm_hour_10      (alarm_hour_10),

        .alarm_en           (alarm_en)
    );

/****/

    timing_alarm T_alarm
    (
        .clock_sec_01       (clock_sec_01),
        .clock_sec_10       (clock_sec_10),
        .clock_min_10       (clock_min_10),
        .clock_min_01       (clock_min_01),
        .clock_hour_01      (clock_hour_01),
        .clock_hour_10      (clock_hour_10),

        .timing_en_1        (timing_en_1),
        .timing_en_2        (timing_en_2)
    );
endmodule 