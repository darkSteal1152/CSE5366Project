module CarryLookAheadAdder(
    input  logic [10:0] A,
    input  logic [10:0] B,
    input  logic        c_in,
    output logic [10:0] S,
    output logic        c_out
);

    wire [3:0] S0, S1;
    wire [2:0] S2;
    wire       c4, c8;
    wire       G0, P0, G1, P1, G2, P2;

    CLA_4bit cla0 (
        .A(A[3:0]), .B(B[3:0]), .c_in(c_in),
        .S(S0), .c_out(c4), .G_out(G0), .P_out(P0)
    );

    CLA_4bit cla1 (
        .A(A[7:4]), .B(B[7:4]), .c_in(c4),
        .S(S1), .c_out(c8), .G_out(G1), .P_out(P1)
    );

    CLA_3bit cla2 (
        .A(A[10:8]), .B(B[10:8]), .c_in(c8),
        .S(S2), .c_out(c_out), .G_out(G2), .P_out(P2)
    );

    assign S = {S2, S1, S0};

endmodule
