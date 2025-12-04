module TopLevel (
    input clk,
    input reset,
    input op,
    input Clear,
    input keyA, keyB, keyC,
    input clearA, clearB,
    input [3:0] row, 
    output flagA, flagB, flagC,
    output [3:0] col,
    output [7:0] lcd_data,
    output lcd_rs,
    output lcd_rw,
    output lcd_e
);

    // input button handler
    logic inA, inB, inC;

    // input logic reg
    reg [15:0] A;
    reg [15:0] B;
    reg [15:0] C;
    wire [1:0] Operation;
    wire [15:0] keypad_out;
	wire [3:0] keypad_value;
	wire trig;

    // output logic reg
    reg [31:0] opA, opB;
    reg [4:0] Exponent;
    reg [10:0] Mantissa;

    // floating point internal reg
    reg SA, SB;
    reg [4:0] EA, EB;
    reg [9:0] MA, MB;

    // exponent sub reg
    reg [3:0] shift;
    reg S;
    
    // CLA adder reg
    reg [10:0] M, M1, M2, MSUM;
    reg[4:0] E;
    reg Cout;

    // reg for subtraction or negative
    reg [10:0] M3;
    reg [3:0] shiftr;
    reg [4:0] dec, exp;
    reg[10:0] minused, maxused;

    // assign plus or minus
    assign Operation = op ? 2'b01 : 2'b10;

    // split floating point
    assign SA = A[15];
    assign SB = B[15] ^ ~op;
    assign EA = A[14:10];
    assign EB = B[14:10];
    assign MA = A[9:0];
    assign MB = B[9:0];

    // button handlers
    OnOffToggle input_a (
        .OnOff(keyA), 
        .IN(1'b1),
        .OUT(inA)
    );

    OnOffToggle input_b (
        .OnOff(keyB), 
        .IN(1'b1),
        .OUT(inB)
    );

    OnOffToggle input_c (
        .OnOff(keyC), 
        .IN(1'b1),
        .OUT(inC)
    );

    // subtract exponents
    ModularExponentSubtractor #(.N(5)) modular_exponent_subtractor (
        .A(EA), 
        .B(EB),
        .Out(shift),
        .C(S)
    );

    // shift mantissa
    Two2OneMux #(.N(11)) mantissa_shifter_mux (
        .R({1'b1, MB}), 
        .B({1'b1, MA}),
        .Cout(S),
        .Out(M)
    );

    // select higher mantissa
    Two2OneMux #(.N(11)) mantissa_adder_mux (
        .R({1'b1, MA}), 
        .B({1'b1, MB}),
        .Cout(S),
        .Out(M2)
    );

    // select exponent
    Two2OneMux #(.N(5)) exponent_inc_mux (
        .R(EA), 
        .B(EB),
        .Cout(S),
        .Out(E)
    );

    // shift lower mantissa
    BarrelShifter mantissa_right_shifter(
        .A(M),
        .B(shift[3:0]),
        .Y(M1)
    );

    // handle negative addition
    assign M3 = (SA ^ SB) ? ~M1 + 1 : M1;

    // add mantissas
    CarryLookAheadAdder CLAA(
        .A(M3),
        .B(M2),
        .c_in(1'b0), // optional, usually 0
        .S(MSUM),
        .c_out(Cout)
    );

    // count leading zero for subtraction
    LeadingZeroCounter #(.N(11)) zero_counter (
        .A(MSUM),
        .Count(shiftr)
    );

    // increment exponent
    ControlledIncrementor controlled_exponent_incrementor(
        .A(E), 
        .Select(Cout),
        .S(exp)
    );

    // adjust exponent for subtraction
    assign dec = E - {1'b0, shiftr};

    // adjust mantissa for addition
    BarrelShifter mantissa_normalizer_bit_shifter(
        .A(MSUM),
        .B(Cout),
        .Y(maxused)
    );

    // adjust mantissa for subtraction
    BarrelRightShifter mantissa_normalizer_right_shifter(
        .A(MSUM),
        .B(shiftr),
        .Y(minused)
    );

    // output assignment
    assign Exponent = (SA ^ SB) ? dec : exp;
    assign Mantissa = (SA ^ SB) ? minused : maxused;

    // input from keypad
    KeypadInput #(.DIGITS(4)) keypad (
        .clk(clk),
        .reset(Clear),
        .row(row),
        .col(col),
        .out(keypad_out),
        .value(keypad_value),
        .trig(trig)
    );

    // logic for input output reg
    reg [15:0] regA, regB, regC;

	always @(posedge clk) begin
		if (reset) begin
			regA <= 0;
			regB <= 0;
            regC <= 0;
		end else begin
			if (clearA)
				regA <= 0;
			else if (inA)
				regA <= keypad_out;

			if (clearB)
				regB <= 0;
			else if (inB)
				regB <= keypad_out;

            if (!inC)
                regC <= 0;
            else if (inC)
                regC <= {(SA ^ SB), Exponent, Mantissa[9:0]};
		end
	end

	assign A = regA;
	assign B = regB;
    assign C = regC;

    assign flagA = inA;
    assign flagB = inB;
    assign flagC = inC;

    // send data to LCD
    LCD #(
        .WIDTH(16),
        .DIGITS(5),
        .FLOAT(0),
        .MODE(1),
        .LINES(4),
        .CHARS(20)
    ) lcd_unit (
        .clk(clk),
        .lcd_data(lcd_data),
        .lcd_rs(lcd_rs),
        .lcd_rw(lcd_rw),
        .lcd_e(lcd_e),
        .lcd_reset(reset),
        .A(A),
        .B(B),
        .C(C),
        .Operation(Operation)
    );

endmodule
