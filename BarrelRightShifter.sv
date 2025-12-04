module BarrelRightShifter(
    input [10:0] A,
    input [3:0] B,
    output [10:0] Y
);

    wire [10:0] shift8, shift4, shift2, shift1;

    Two2OneMuxAB shiftEight (
        .Sel(B[3]),
        .A({A[2:0], 8'b0}),
        .B(A),
        .Out(shift8)
    );

    Two2OneMuxAB shiftFour (
        .Sel(B[2]),
        .A({shift8[4:0], 4'b0}),
        .B(shift8),
        .Out(shift4)
    );

    Two2OneMuxAB shiftTwo (
        .Sel(B[1]),
        .A({shift4[8:0], 2'b0}),
        .B(shift4),
        .Out(shift2)
    );

    Two2OneMuxAB shiftOne (
        .Sel(B[0]),
        .A({shift2[9:0], 1'b0}),
        .B(shift2),
        .Out(shift1)
    );

    assign Y = shift1;

endmodule