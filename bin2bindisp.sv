module bin2bindisp
  #(parameter WIDTH = 16, CHARS = 20)
   (input  [WIDTH-1:0] bin,
    output reg [7:0]   disp [CHARS-1:0]);

    integer i;

    always @(*) begin
        for (i = 0; i < CHARS; i = i + 1) begin
            if (i < WIDTH)
                disp[CHARS-1-i] = bin[i] ? CHAR_1 : CHAR_0;
            else
                disp[CHARS-1-i] = CHAR_BLANK;
        end
    end
endmodule
