module Adder(
    input a, b, c,
    output g, p, s
);

    assign g = a & b;
    assign p = (a & ~b) | (~a & b);
    assign s = (p & ~c) | (~p & c);
    
endmodule