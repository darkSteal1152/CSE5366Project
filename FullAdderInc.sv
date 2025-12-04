module FullAdderInc (
    input logic Cin, A, B,
    output logic S, Cout
);

    assign S = Cin ^ A ^ B;
    assign Cout = (Cin & A) | (A & B) | (Cin & B);

endmodule
