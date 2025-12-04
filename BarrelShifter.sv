module BarrelShifter(
    input [10:0] A,
    input [3:0] B,
    output [10:0] Y
);

    wire [10:0] shift8, shift4, shift2, shift1;

    Two2OneMuxAB shiftEight (
        .Sel(B[3]),
        .A({8'b0, A[10:8]}),
        .B(A),
        .Out(shift8)
    );

    Two2OneMuxAB shiftFour (
        .Sel(B[2]),
        .A({4'b0, shift8[10:4]}),
        .B(shift8),
        .Out(shift4)
    );

    Two2OneMuxAB shiftTwo (
        .Sel(B[1]),
        .A({2'b0, shift4[10:2]}),
        .B(shift4),
        .Out(shift2)
    );

    Two2OneMuxAB shiftOne (
        .Sel(B[0]),
        .A({1'b0, shift2[10:1]}),
        .B(shift2),
        .Out(shift1)
    );

    assign Y = shift1;

endmodule