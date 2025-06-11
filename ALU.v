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
        4'd0: begin
            y = a_or_b;
            zero_flag = (y==0);
        end
        4'd1:  begin
            y = a_and_b;
            zero_flag = (y==0);
        end
        4'd2:  begin
            y = a_nand_b;
            zero_flag = (y==0);
        end
        4'd3:  begin
            y = a_nor_b;
            zero_flag = (y==0);
        end
        4'd4:  begin
            y = a_not_b;
            zero_flag = (y==0);
        end
        4'd5:  begin
            y = a_xor_b;
            zero_flag = (y==0);
        end
        4'd6:  begin
            y = a_sum_b;
            zero_flag = (y==0);
        end
        4'd7:  begin
            y = a_sub_b;
            zero_flag = (y==0);
            neg flag = (y[31] == 1);
            overflow_flag = (y[30]&y[31] == 1);
        end
        4'd8:  begin
            y = a_shiftl_b;
            zero_flag = (y==0);
            neg flag = (y[31] == 1);
            overflow_flag = (y[30]&y[31] == 1);
        end
        4'd9:  begin
            y = a_shiftr_b;
            zero_flag = (y==0);
            neg flag = (y[31] == 1);
        end
        4'd10: begin
            y = a_cmp_b;
            zero_flag = (y==0);
        end
        4'd11: y = a_lror_b;
        4'd12: y = a_rror_b;
        default: y = 1'b0;  // default case if sel is 14 or 15
    endcase
end
  
endmodule
