module counter_24
(
    input 		clk,            // 1Hz clock signal
    input 		clr_n,          // clear signal
    input 		en,             // high enable signal
    output reg 	[3:0] Q_01,     // BCD code
    output reg 	[3:0] Q_10      // BCD code
);
    always@(posedge clk or negedge clr_n)
    begin
        if (~clr_n)
            // clear the counter to 0
            begin
                Q_01 <= 4'b0000;
                Q_10 <= 4'b0000;
            end
        else if (~en)
            // not enable, do not add
            begin
                Q_01 <= Q_01;
                Q_10 <= Q_10;
            end
        else if (Q_10 == 4'b0010 & Q_01 == 4'b0011)
            // end of counter (23)
            begin
                Q_10 <= 4'b0000;
                Q_01 <= 4'b0000;
            end
        else if (Q_01 == 4'b 1001)
            // Q_01 = 9 => Q_10++, Q_01 <= 0
            begin
                Q_01 <= 4'b0000;
                Q_10 <= Q_10 + 1'b1;
            end
        else
            // Q_01 ++
            begin
                Q_01 <= Q_01 + 1'b1;
            end
    end
    
endmodule