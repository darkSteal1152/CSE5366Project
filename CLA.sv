module CLA(
    input [3:0] p, g,   // propagate and generate signals
    input c0,           // initial carry-in
    output [3:0] c      // carry-outs for bits 1–4 (c[0] is carry into bit 1)
);

    assign c[0] = g[0] | (p[0] & c0);
    assign c[1] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & c0);
    assign c[2] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & c0);
    assign c[3] = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]) | (p[3] & p[2] & p[1] & p[0] & c0);

endmodule
