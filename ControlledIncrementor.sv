module ControlledIncrementor(
    input logic [4:0] A, 
    input logic Select,
    output logic [4:0] S
);

    logic [4:0] Cin;

    HalfAdderInc HA (
        .A(A[0]),
        .Select(Select),
        .S(S[0]),
        .C(Cin[0])
    );

    FullAdderInc FA1 (
        .Cin(Cin[0]), 
        .A(A[1]), 
        .B(1'b0),
        .S(S[1]), 
        .Cout(Cin[1])
    );

    FullAdderInc FA2 (
        .Cin(Cin[1]), 
        .A(A[2]), 
        .B(1'b0),
        .S(S[2]), 
        .Cout(Cin[2])
    );

    FullAdderInc FA3 (
        .Cin(Cin[2]), 
        .A(A[3]), 
        .B(1'b0),
        .S(S[3]), 
        .Cout(Cin[3])
    );

    FullAdderInc FA4 (
        .Cin(Cin[3]), 
        .A(A[4]), 
        .B(1'b0),
        .S(S[4]), 
        .Cout(Cin[4])
    );

endmodule
