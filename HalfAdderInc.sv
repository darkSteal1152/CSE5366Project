module HalfAdderInc (
    input logic A, Select,
    output logic S, C
);

    assign S = A ^ Select;
    assign C = A & Select;

endmodule
