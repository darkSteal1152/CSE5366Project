module Two2OneMuxAB (
    input  Sel,
    input [23:0] A, B,
    output [23:0] Out
);

    assign Out = Sel ? A : B;

endmodule