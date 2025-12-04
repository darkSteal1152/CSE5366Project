module AddSub(
    input [23:0] input_b,      // original B input
    input add_sub,             // 0 = add, 1 = subtract
    output [23:0] cor_b        // corrected B based on mode
);

    assign cor_b = (add_sub) ? ~input_b + 1 : input_b;

endmodule
