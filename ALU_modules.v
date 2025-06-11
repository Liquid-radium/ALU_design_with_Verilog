module adder(
    input [31:0] a,
    input [31:0] b,
    output [31:0] sum,
    output [31:0] cout
);
assign sum = a^b;
assign cout = a&b;
endmodule

module sub(
    input [31:0] a,
    input [31:0] b,
    output [31:0] diff,
    output [31:0] cout 
);
assign diff = a^b;
assign cout = a&~b;
endmodule

module cmp(
    input [31:0] a,
    input [31:0] b,
    output [31:0] out,
    output [31:0] zero
);
wire [31:0] w1, [31:0] w2;
sub u2(
    .a(a),
    .b(b),
    .diff(w1),
    .cout(w2)
);
assign out = (w2==1);
assign zero = w1;
endmodule

module right_rotate(
    input [31:0] a,
    input [31:0] b,
    output [31:0] out
);
wire [31:0]cout, [31:0]diff;
sub u3(
    .a(32),
    .b(b),
    .diff(diff),
    .cout(cout)
);
assign out = (a >> k) | (a << diff);
endmodule

module left_rotate(
    input [31:0] a,
    input [31:0] b,
    output [31:0] out
);
wire [31:0]cout, [31:0]diff;
sub u3(
    .a(32),
    .b(b),
    .diff(diff),
    .cout(cout)
);
assign out = (a << k) | (a >> diff);
endmodule