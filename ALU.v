module alu(
    input[31:0] a,
    input [31:0] b,
    output [31:0] y,
    output carry_flag,
    output neg_flag,
    output zero_flag,
    output overflow_flag,
);

wire [31:0] a_or_b;
wire [31:0] a_and_b;
wire [31:0] a_xor_b;
wire [31:0] a_not_b;
wire [31:0] a_nor_b;
wire [31:0] a_nand_b;
wire [31:0] a_sum_b;
wire [31:0] a_sub_b;
wire [31:0] a_shiftr_b;
wire [31:0] a_shiftl_b;
wire [31:0] a_cmp_b;
wire [31:0] a_rror_b;
wire [31:0] a_lror_b;

assign a_or_b = a|b;
assign a_and_b = a&b;
assign a_xor_b = a^b;
assign a_not_b = ~a;
assign a_nor_b = ~(a|b);
assign a_nand_b = ~(a&b);
adder u1 (
    .a(a),
    .b(b),
    .sum(a_sum_b),
    .cout(carry_flag)
);
assign neg_flag = a_sum_b[31];
sub u1 (
    .a(a),
    .b(b),
    .diff(a_sub_b),
    .cout(carry_flag)
);
assign neg_flag = a_sub_b[31];
assign a_shiftr_b = a >> b;
assign a_shiftl_b = a << b;
cmp u1(
    .a(a),
    .b(b),
    .out(a_cmp_b),
    .zero(zero_flag)
);
right_rotate u1(
    .a(a),
    .b(b),
    .out(a_rror_b)
);
left_rotate u1(
    .a(a),
    .b(b),
    .out(a_lror_b) 
);

always @(*) begin
    case (alu_control)
        4'd0:  y = a_or_b;
        4'd1:  y = a_and_b;
        4'd2:  y = a_nand_b;
        4'd3:  y = a_nor_b;
        4'd4:  y = a_not_b;
        4'd5:  y = a_xor_b;
        4'd6:  y = a_sum_b;
        4'd7:  y = a_sub_b;
        4'd8:  y = a_shiftl_b;
        4'd9:  y = a_shiftr_b;
        4'd10: y = a_cmp_b;
        4'd11: y = a_lror_b;
        4'd12: y = a_rror_b;
        default: y = 1'b0;  // default case if sel is 14 or 15
    endcase
end
  
endmodule
