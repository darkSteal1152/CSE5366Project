// given module for Keypad
// uses state machine to scan col with row
// decodes key with row and col

module KeypadBase(
    input clk,
    input [3:0] row,
    output [3:0] col,
    output [3:0] value,
    output valid,
    output slow_clock,
    output sense,
    output valid_digit,
    output [3:0] inv_row    
);

    assign inv_row = ~row;

    ClockDiv #(.DIV(100000)) clock_div (
        .clk(clk),
        .clk_out(slow_clock)
    );

    KeypadFSM keypad_fsm (
        .clk(slow_clock),
        .row(inv_row),
        .col(col),
        .sense(sense)
    );

    KeypadDecoder #(.BASE(16)) keypad_decoder (
        .row(inv_row),
        .col(col),
        .value(value),
        .valid(valid_digit)
    );

    assign valid = valid_digit && sense;
    
endmodule