/*
    mod 60 counter with 2 BCD code
*/
module counter_60
(
    input       clk,            // 1Hz clock signal
    input       clr_n,          // clear signal
    input       en,             // high enable signal
    output reg  [3:0] Q_10,     // BCD code
    output reg  [3:0] Q_01,     // BCD code
    output wire cout
);

    assign cout = (Q_10 == 4'b0101 & Q_01 == 4'b1001);
    always@(posedge clk or negedge clr_n)
    begin
        if (~clr_n)
            // clear the counter to 0
            begin
                Q_01 <= 4'b0000;
                Q_10 <= 4'b0000;
                // cout <= 1'b0;
            end
        else if (~en)
            // not enable, do not add
            begin
                Q_01 <= Q_01;
                Q_10 <= Q_10;
                // cout <= 1'b0;
            end
        else if (Q_10 == 4'b0101 & Q_01 == 4'b1001)
            // end of counter (59)
            begin
                Q_10 <= 4'b0000;
                Q_01 <= 4'b0000;
                // cout <= 1'b0;
            end
        else if (Q_01 == 4'b 1001)
            // Q_01 = 9 => Q_10++, Q_01 <= 0
            begin
                Q_01 <= 4'b0000;
                Q_10 <= Q_10 + 1'b1;
                // cout <= 1'b0;
            end
          
        else
            // Q_01 ++
            begin
                Q_01 <= Q_01 + 1'b1;
                // cout <= 1'b0;
            end
    end

endmodule
