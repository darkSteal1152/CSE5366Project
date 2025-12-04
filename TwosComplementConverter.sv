module TwosComplementConverter #(parameter N = 8) (
    input  [N-1:0] R,
    output [N-1:0] B
);
    //assign B = ~R + 1'b1;  // Compute two's complement

    wire [N-1:0] R_comp;
    wire [N:0] carry;

    assign carry[0] = 1'b1; // init carry

    // generate series of half adders
    genvar i;
    generate
        for (i = 0; i < N; i = i + 1) begin: ha_stage
            assign R_comp[i] = R[i] ^ 1'b1;

            HalfAdder HA (
                .A(R_comp[i]),
                .B(carry[i]),
                .Sum(B[i]),
                .Cout(carry[i+1])
            );
        end
    endgenerate
    
endmodule