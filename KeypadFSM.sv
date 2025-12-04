// modified module for Keypad FSM
// used in KeypadBase
// when row is detected scans col for pressed button
// returns col to be decoded

module KeypadFSM(
    input clk,
    input [3:0] row,
    output reg [3:0] col,
    output sense,
    // Debug
    output reg [3:0] state,
    output trig
);

    assign trig = row[0] || row[1] || row[2] || row[3]; // if any keypad press
    assign sense = state == 8;

    always @ (posedge clk) begin
        case (state)
        0: begin col = 4'b0001; state = 1; end                      // start scan with col 1
        1: if (trig) begin state = 8; end else begin state = 2; end // if found col 1 exit
        2: begin col = 4'b0010; state = 3; end                      // scan col 2
        3: if (trig) begin state = 8; end else begin state = 4; end // if found col 2 exit
        4: begin col = 4'b0100; state = 5; end                      // scan col 3
        5: if (trig) begin state = 8; end else begin state = 6; end // if found col 3 exit
        6: begin col = 4'b1000; state = 7; end                      // scan col 4
        7: if (trig) begin state = 8; end else begin state = 0; end // if found col 4 exit else repeat scan
        8: begin state = 9; end                                     // exit state
        9: if (~trig) begin state = 0; end                          // restart scan when button release
        endcase
    end

endmodule
