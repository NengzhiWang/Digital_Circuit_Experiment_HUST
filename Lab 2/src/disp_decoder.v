module disp_decoder
(
    input 		[3:0] BCD_num,
    output reg 	[6:0] Dis_num
);
    always @(*)
    begin
        case(BCD_num) 
            4'b0000:	Dis_num = 7'b1000000;
            4'b0001:	Dis_num = 7'b1111001;
            4'b0010:	Dis_num = 7'b0100100;
            4'b0011:	Dis_num = 7'b0110000;
            4'b0100:	Dis_num = 7'b0011001;
            4'b0101:	Dis_num = 7'b0010010;
            4'b0110:	Dis_num = 7'b0000010;
            4'b0111:	Dis_num = 7'b1111000;
            4'b1000:	Dis_num = 7'b0000000;
            4'b1001:	Dis_num = 7'b0010000;
            default:	Dis_num = 7'bz;
        endcase
    end
endmodule
    