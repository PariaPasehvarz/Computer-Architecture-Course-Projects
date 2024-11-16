module ALU(
    input [2:0] ALUControl,
    input signed [31:0] a, b,
    output zero, neg,
    output reg signed [31:0] w
);
    
    parameter[2:0] ADD = 3'b000,
                   SUB = 3'b001,
                   AND = 3'b010,
                   OR = 3'b011,
                   SLT = 3'b101,
                   SLTU = 3'b100,
                   XOR = 3'b110;
    
    always @(a or b or ALUControl) begin
        case (ALUControl)
            ADD   :  w = a + b;
            SUB   :  w = a - b;
            AND   :  w = a & b;
            OR    :  w = a | b;
            SLT   :  w = a < b ? 32'd1 : 32'd0;
            XOR   :  w = a ^ b;
            SLTU  :  w = {1'b0, a} < {1'b0, b} ? 32'd1 : 32'd0;
            default:  w = {32{1'bz}};
        endcase
    end

    assign zero = (~|w);
    assign neg = w[31];

endmodule