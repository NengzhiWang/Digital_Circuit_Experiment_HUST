/*
    Wang Nengzhi
    U201713082
    SES1701
*/

module mux_8
(
    input       [7:0] x1,       // input signal 1
    input       [7:0] x2,       // input signal 2
    input       select,     // data select
    output reg  [7:0] y     // output
);

    always @(*)
    begin
        if (select == 1'b1)
            y = x1;
        else if (select == 1'b0)
            y = x2;
    end

endmodule