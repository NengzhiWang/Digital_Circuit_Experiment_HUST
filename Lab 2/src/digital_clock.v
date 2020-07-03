module digital_clock
(
    input       clk_50MHz,          // ex clock signal of 50MHz
    input       min_correct,        // min correction
    input       hour_correct,       // hour correction
    input       alarm_hour_set,     // set alarm of hour
    input       alarm_min_set,      // set alarm of min
    
    output wire [6:0] sec_01_disp,
    output wire [6:0] sec_10_disp,
    output wire [6:0] min_01_disp,
    output wire [6:0] min_10_disp,
    output wire [6:0] hour_01_disp,
    output wire [6:0] hour_10_disp,
    // clock display

    output wire tone_500,
    output wire tone_1k
    // tone signal

);

/** frequenct divide circuit **/

    wire clk_1Hz;
    wire clk_500Hz;
    wire clk_1kHz;

    mult_freq_div Freq_Div
    (
        .clk        (clk_50MHz),
        .clr_n      (1'b1),
        .clk_1Hz    (clk_1Hz),
        .clk_500Hz  (clk_500Hz),
        .clk_1kHz   (clk_1kHz)
    );

/** digital clock circuit **/

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

/** alarm setting circuit **/

    wire [3:0] alarm_min_01;
    wire [3:0] alarm_min_10;
    wire [3:0] alarm_hour_01;
    wire [3:0] alarm_hour_10;
    wire alarm_setting;
    assign alarm_setting = (alarm_min_set || alarm_hour_set);

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

/** alarm compare circuit **/

    wire alarm_equal;
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

        .alarm_en           (alarm_equal)
    );

/** timing alarm circuit **/
    wire timing_en_1;
    wire timing_en_2;
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

/** display circuit **/

    wire [3:0] sec_01;
    wire [3:0] sec_10;
    wire [3:0] min_01;
    wire [3:0] min_10;
    wire [3:0] hour_01;
    wire [3:0] hour_10;

    assign sec_01   = clock_sec_01;
    assign sec_10   = clock_sec_10;
    assign min_01   = (alarm_setting == 1'b1)   ?   alarm_min_01  : clock_min_01;
    assign min_10   = (alarm_setting == 1'b1)   ?   alarm_min_10  : clock_min_10;
    assign hour_01  = (alarm_setting == 1'b1)   ?   alarm_hour_01 : clock_hour_01;
    assign hour_10  = (alarm_setting == 1'b1)   ?   alarm_hour_10 : clock_hour_10;

    disp_decoder sec_01_decoder
    (
        .BCD_num        (sec_01),
        .Dis_num        (sec_01_disp)
    );

    disp_decoder sec_10_decoder
    (
        .BCD_num        (sec_10),
        .Dis_num        (sec_10_disp)
    );

    disp_decoder min_01_decoder
    (
        .BCD_num        (min_01),
        .Dis_num        (min_01_disp)
    );

    disp_decoder min_10_decoder
    (
        .BCD_num        (min_10),
        .Dis_num        (min_10_disp)
    );

    disp_decoder hour_01_decoder
    (
        .BCD_num        (hour_01),
        .Dis_num        (hour_01_disp)
    );

    disp_decoder hour_10_decoder
    (
        .BCD_num        (hour_10),
        .Dis_num        (hour_10_disp)
    );


/** tone circuit **/
    wire en_500;
    wire en_1k;

    assign en_500 = timing_en_1;
    assign en_1k = timing_en_2 || alarm_equal;

    tone T
    (
        .clk_1Hz        (clk_1Hz),
        .clk_500Hz      (clk_500Hz),
        .clk_1kHz       (clk_1kHz),
        .en_500         (en_500),
        .en_1k          (en_1k),

        .tone_500       (tone_500),
        .tone_1k        (tone_1k)
    );

endmodule