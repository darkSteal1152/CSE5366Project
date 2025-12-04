module CLA_3bit (
    input  [2:0] A, B,
    input        c_in,
    output [2:0] S,
    output       c_out,
    output       G_out,
    output       P_out
);

    wire [2:0] g, p, c;

    Adder adder0 (.a(A[0]), .b(B[0]), .c(c_in),   .g(g[0]), .p(p[0]), .s(S[0]));
    Adder adder1 (.a(A[1]), .b(B[1]), .c(c[0]),   .g(g[1]), .p(p[1]), .s(S[1]));
    Adder adder2 (.a(A[2]), .b(B[2]), .c(c[1]),   .g(g[2]), .p(p[2]), .s(S[2]));

    assign c[0] = g[0] | (p[0] & c_in);
    assign c[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c_in);
    assign c[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c_in);

    assign c_out = c[2];
    assign G_out = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]);
    assign P_out = p[2] & p[1] & p[0];

endmodule
