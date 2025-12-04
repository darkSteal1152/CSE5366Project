// given module for Keypad Input
// processes Keypad with KeypadBase and ShiftReg
// takes pressed key and shifts the DISPLAY

module KeypadInput #(
    parameter DIGITS = 4
) (
    input clk,
    input reset,
    input [3:0] row,
    output [3:0] col,
    output [(DIGITS*4)-1:0] out,
    output [3:0] value,
    output trig
);

    KeypadBase keypad_base (
        .clk(clk),
        .row(row),
        .col(col),
        .value(value),
        .valid(trig)
    );

    ShiftReg #(.COUNT(DIGITS)) shift_reg (
        .trig(trig),
        .in(value),
        .out(out),
        .reset(reset)
    );
    
endmodule