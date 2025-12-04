module ModularExponentSubtractor #(parameter N = 8) (
    input  [N-1:0] A, B,
    output [N-1:0] Out,
    output C
);
    wire [N-1:0] R, B_twos;
    wire Cout;

    RippleCarrySubtractor #(N) sub (
        .A(A), 
        .B(B), 
        .R(R), 
        .Cout(Cout)
    );

    TwosComplementConverter #(N) comp (
        .R(R), 
        .B(B_twos)
    );

    Two2OneMux #(N) mux (
        .R(R), 
        .B(B_twos), 
        .Cout(Cout), 
        .Out(Out)
    );

    assign C = Cout;

endmodule