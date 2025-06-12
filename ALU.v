module alu(
    input  [31:0] a,
    input  [31:0] b,
    input  [3:0]  alu_control,
    output reg [31:0] y,
    output reg carry_flag,
    output reg neg_flag,
    output reg zero_flag,
    output reg overflow_flag
);

    wire [31:0] a_or_b     = a | b;
    wire [31:0] a_and_b    = a & b;
    wire [31:0] a_xor_b    = a ^ b;
    wire [31:0] a_not_b    = ~a;
    wire [31:0] a_nor_b    = ~(a | b);
    wire [31:0] a_nand_b   = ~(a & b);
    wire [31:0] a_shiftr_b = a >> b;
    wire [31:0] a_shiftl_b = a << b;

    wire [31:0] a_sum_b;
    wire [31:0] a_sub_b;
    wire [31:0] a_cmp_b;
    wire [31:0] a_rror_b;
    wire [31:0] a_lror_b;

    // Modules with unique instance names
    adder adder_u (
        .a(a), .b(b), .sum(a_sum_b), .cout(carry_flag) // You may set carry_flag inside always
    );

    sub sub_u (
        .a(a), .b(b), .diff(a_sub_b), .cout(carry_flag)
    );

    cmp cmp_u (
        .a(a), .b(b), .out(a_cmp_b), .zero(zero_flag)
    );

    right_rotate rr_u (
        .a(a), .b(b), .out(a_rror_b)
    );

    left_rotate lr_u (
        .a(a), .b(b), .out(a_lror_b)
    );

    // ALU logic
    always @(*) begin
        carry_flag = 0;
        neg_flag = 0;
        zero_flag = 0;
        overflow_flag = 0;

        case (alu_control)
            4'd0: begin
                y = a_or_b;
                zero_flag = (y == 0);
            end
            4'd1: begin
                y = a_and_b;
                zero_flag = (y == 0);
            end
            4'd2: begin
                y = a_nand_b;
                zero_flag = (y == 0);
            end
            4'd3: begin
                y = a_nor_b;
                zero_flag = (y == 0);
            end
            4'd4: begin
                y = a_not_b;
                zero_flag = (y == 0);
            end
            4'd5: begin
                y = a_xor_b;
                zero_flag = (y == 0);
            end
            4'd6: begin
                y = a_sum_b;
                zero_flag = (y == 0);
                neg_flag = y[31];
            end
            4'd7: begin
                y = a_sub_b;
                zero_flag = (y == 0);
                neg_flag = y[31];
                overflow_flag = ((a[31] ^ b[31]) & (a[31] ^ y[31]));
            end
            4'd8: begin
                y = a_shiftl_b;
                zero_flag = (y == 0);
                neg_flag = y[31];
            end
            4'd9: begin
                y = a_shiftr_b;
                zero_flag = (y == 0);
                neg_flag = y[31];
            end
            4'd10: begin
                y = a_cmp_b;
                zero_flag = (zero);
            end
            4'd11: y = a_lror_b;
            4'd12: y = a_rror_b;
            default: y = 32'b0;
        endcase
    end

initial begin
    $dumpfile("waves.vcd");
    $dumpvars(0,ALU.v);
end
 
endmodule
