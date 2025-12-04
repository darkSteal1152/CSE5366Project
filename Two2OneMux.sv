module Two2OneMux #(parameter N = 8) (
    input  [N-1:0] R, B,
    input  Cout,
    output [N-1:0] Out
);
    assign Out = Cout ? R : B; // select absolute value
endmodule
