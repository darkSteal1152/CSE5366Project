module OnOffToggle(
    input OnOff, IN,
    output OUT
);

    reg state, nextstate;
    parameter ON = 1'b1, OFF = 1'b0;

    always @(negedge OnOff) begin
        state <= nextstate;
    end

    always @(state) begin
        case (state)
            OFF: nextstate = ON;
            ON: nextstate = OFF;
        endcase
    end

    assign OUT = state * IN;
    
endmodule