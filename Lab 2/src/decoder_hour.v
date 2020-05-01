module decoder_hour
(
    input   [1:0] Q_4,
    input   [3:0] Q_6,
    input   format,
    output reg [3:0] Q_10,
    output reg [3:0] Q_1
);
    wire [5:0] Q_in;
    assign Q_in = {Q_4, Q_6};
    reg [7:0] Q_out;
    assign Q_10 = [7:4] Q_out;
    always @(*)
    begin
        case(Q_in)
            6'b00_0000: Q_out = 8'b0000_0000;


        endcase
    end
endmodule