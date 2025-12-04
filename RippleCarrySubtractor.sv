module RippleCarrySubtractor #(parameter N = 8) (
    input  [N-1:0] A, B,
    output [N-1:0] R,
    output Cout
);
    wire [N-1:0] B_comp;
    wire [N:0] carry;

    assign B_comp = ~B; // inverse of b
    assign carry[0] = 1'b1; // init carry

    // series of full adder
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin: fa_stage
            FullAdder FA (
                .A(A[i]),
                .B(B_comp[i]),
                .Cin(carry[i]),
                .Sum(R[i]),
                .Cout(carry[i+1])
            );
        end
    endgenerate

    // 1 if a > b; 0 if a < b;
    assign Cout = carry[N];

endmodule