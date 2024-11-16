module ALU (
    input signed [31:0] operand_A, operand_B,
    input [2:0] operation,
    output is_zero,
    output is_negative,
    output reg signed [31:0] result
);

    assign is_zero = ~|result;
    assign is_negative = result[31];

    always @ (operand_A, operand_B, operation) begin
        case (operation)
            3'b000:  result = operand_A & operand_B;
            3'b001:  result = operand_A | operand_B;
            3'b010:  result = operand_A + operand_B;
            3'b110:  result = operand_A - operand_B;
            3'b011:  result = operand_A ^ operand_B;
            3'b100:  result = ({{1'b0}, operand_A} < {{1'b0}, operand_B}) ? 32'b1 : 32'b0;
            3'b111:  result = (operand_A < operand_B) ? 32'b1 : 32'b0;
            default: result = 32'b0;
        endcase
    end

endmodule
