module adder(
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] sum,
    output        cout
);
    assign {cout, sum} = a + b;
endmodule

module sub(
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] diff,
    output        cout
);
    assign {cout, diff} = a - b;
endmodule

module cmp(
    input  [31:0] a,
    input  [31:0] b,
    output [31:0] out,
    output        zero
);
    wire [31:0] diff;
    wire        dummy;

    sub sub_u1(
        .a(a),
        .b(b),
        .diff(diff),
        .cout(dummy)
    );

    assign out  = (a>b);       
    assign zero = (diff == 0);
endmodule

module right_rotate(
    input  [31:0] a,
    input  [4:0]  b,      // rotate amount up to 31
    output [31:0] out
);
    assign out = (a >> b) | (a << (32 - b));
endmodule

module left_rotate(
    input  [31:0] a,
    input  [4:0]  b,      // rotate amount up to 31
    output [31:0] out
);
    assign out = (a << b) | (a >> (32 - b));
endmodule

