/*
    Wang Nengzhi
    U201713082
    SES1701
*/

module decoder_3_8
(
    input       [2:0] x,    // input signal, 3-bit
    input       enable,     // enable signal
    output reg  [7:0] y     // output signal, 8-bit
);
    always @(*)
    begin
        if (enable)
        begin
            // enable, decode
            case(x)
                3'b000: y = 8'h01;
                3'b001: y = 8'h02;
                3'b010: y = 8'h04;
                3'b011: y = 8'h08;
                3'b100: y = 8'h10;
                3'b101: y = 8'h20;
                3'b110: y = 8'h40;
                3'b111: y = 8'h80;
            endcase
            end
            
            else
            begin
                // not enable
                y = 8'b0000_0000;
            end
    end
endmodule