module CLA_4bit (
    input  [3:0] A, B,     // 4-bit inputs
    input        c_in,     // carry in
    output [3:0] S,        // 4-bit sum output
    output       c_out,    // carry out (to next block)
    output       G_out,    // group generate
    output       P_out     // group propagate
);

    wire [3:0] g, p, c;

    // Bit-wise Adder units
    Adder adder0 (.a(A[0]), .b(B[0]), .c(c_in),   .g(g[0]), .p(p[0]), .s(S[0]));
    Adder adder1 (.a(A[1]), .b(B[1]), .c(c[0]),   .g(g[1]), .p(p[1]), .s(S[1]));
    Adder adder2 (.a(A[2]), .b(B[2]), .c(c[1]),   .g(g[2]), .p(p[2]), .s(S[2]));
    Adder adder3 (.a(A[3]), .b(B[3]), .c(c[2]),   .g(g[3]), .p(p[3]), .s(S[3]));

    // Carry Lookahead Logic
    CLA cla_inst (
        .p(p),
        .g(g),
        .c0(c_in),
        .c(c)
    );

    assign c_out = c[3];

    // Group Generate and Propagate (for chaining higher-level CLA blocks)
    assign G_out = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
    assign P_out = &p; // equivalent to p[3] & p[2] & p[1] & p[0]

endmodule
