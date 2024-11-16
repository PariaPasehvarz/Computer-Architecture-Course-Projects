module ALU(AluOpcode, InputA , InputB, ZeroFlag, NegFlag, Result);

    parameter[2:0] ADD = 3'b000,
                   SUB = 3'b001,
                   AND = 3'b010,
                   OR = 3'b011,
                   SLT = 3'b101,
                   SLTU = 3'b100,
                   XOR = 3'b110;

    input [2:0] AluOpcode;
    input signed [31:0] InputA, InputB;
    output ZeroFlag, NegFlag;
    output reg signed [31:0] Result;
    
    always @(InputA or InputB or AluOpcode) begin
        case (AluOpcode)
            ADD   :  Result = InputA + InputB;
            SUB   :  Result = InputA - InputB;
            OR    :  Result = InputA | InputB;
            AND   :  Result = InputA & InputB;
            SLT   :  Result = InputA < InputB ? 32'd1 : 32'd0;
            XOR   :  Result = InputA ^ InputB;
            SLTU  :  Result = {1'b0, InputA} < {1'b0, InputB} ? 32'd1 : 32'd0;
        endcase
    end

    assign NegFlag = Result[31];
    assign ZeroFlag = (~|Result);

endmodule