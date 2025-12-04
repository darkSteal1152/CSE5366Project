module LeadingZeroCounter #(parameter N = 11)(
    input wire [N-1:0] A,
    output reg [3:0] Count
);
    integer i;
    reg found;

    always @(*) begin
        Count = 0;
        found = 0;
        for (i = N-1; i >= 0; i = i - 1) begin
            if (!found && A[i] == 1'b1) begin
                Count = N - 1 - i;
                found = 1;
            end
        end
    end
endmodule
