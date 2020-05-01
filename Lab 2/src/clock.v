module clock
(
    input       clk,
    input       min_correct,
    input       hour_correct,
    output wire [3:0] sec_01,
    output wire [3:0] sec_10,
    output wire [3:0] min_01,
    output wire [3:0] min_10,
    output wire [3:0] hour_01,
    output wire [3:0] hour_10
);

    wire sec_cout;
    wire min_cout;
    
    wire min_en;
    wire hour_en;

    assign min_en   = (sec_cout || min_correct);
    assign hour_en  = (sec_cout & min_cout) || hour_correct;

    counter_60 sec_counter
    (
        .clk        (clk),
        .clr_n      (1'b1),
        .en         (1'b1),
        .Q_10       (sec_10),
        .Q_01       (sec_01),
        .cout       (sec_cout)
    );


    counter_60 min_counter
    (
        .clk        (clk),
        .clr_n      (1'b1),
        .en         (min_en),
        .Q_10       (min_10),
        .Q_01       (min_01),
        .cout       (min_cout)
    );

    counter_24 hour_counter
    (
        .clk        (clk),
        .clr_n      (1'b1),
        .en         (hour_en),
        .Q_01       (hour_01),
        .Q_10       (hour_10)
    );


endmodule 