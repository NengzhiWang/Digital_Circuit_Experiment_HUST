module test(
    input x,
    output reg y
    
);
    reg z;
    assign z = x;

    wire b;
    always @(x)
    begin
        b = x;
    end
endmodule
