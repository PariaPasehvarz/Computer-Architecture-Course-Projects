module MainController(
    input clk, rst,
    input zero, neg,
    input [6:0] op,
    output reg [2:0] immSrc,
    output reg adrSrc, regWrite, memWrite, PCUpdate, branch, IRWrite,
    output reg [1:0] resultSrc, ALUSrcA, ALUSrcB, ALUOp
);

parameter [6:0]  R_T    = 7'b0110011,
                 I_T    = 7'b0010011,
                 S_T    = 7'b0100011,
                 B_T    = 7'b1100011,
                 U_T    = 7'b0110111,
                 J_T    = 7'b1101111,
                 LW_T   = 7'b0000011,
                 JALR_T = 7'b1100111;

parameter [4:0] IF       = 5'b00000,
                 ID       = 5'b00001,
                 EX_I     = 5'b00010,
                 MEM_I    = 5'b01100,
                 EX_R     = 5'b00011,
                 MEM_R    = 5'b01110,
                 EX_B     = 5'b00100,
                 EX_J     = 5'b00101,
                 MEM_J    = 5'b01000,
                 WB_J     = 5'b10000,
                 EX_JALR  = 5'b01001,
                 MEM_JALR = 5'b00110,
                 EX_S     = 5'b00111,
                 MEM_S    = 5'b01101,
                 EX_LW    = 5'b01010,
                 MEM_LW   = 5'b01011,
                 WB_LW    = 5'b10001,
                 MEM_U    = 5'b01111;

reg [4:0] ps;
reg [4:0] ns = IF;

always @(ps or op) begin
    case (ps)
        IF: ns <= ID;
        ID: begin
            ns <= (op == I_T) ? EX_I :
                      (op == R_T) ? EX_R :
                      (op == B_T) ? EX_B :
                      (op == J_T) ? EX_J :
                      (op == U_T) ? MEM_U :
                      (op == S_T) ? EX_S :
                      (op == JALR_T) ? EX_JALR :
                      (op == LW_T) ? EX_LW :
                      IF;
        end
        EX_I: ns <= MEM_I;
        MEM_I: ns <= IF;
        EX_R: ns <= MEM_R;
        MEM_R: ns <= IF;
        EX_B: ns <= IF;
        EX_J: ns <= MEM_J;
        MEM_J: ns <= WB_J;
        WB_J: ns <= IF;
        EX_S: ns <= MEM_S;
        MEM_S: ns <= IF;
        EX_JALR: ns <= MEM_JALR;
        MEM_JALR: ns <= MEM_I;
        EX_LW: ns <= MEM_LW;
        MEM_LW: ns <= WB_LW;
        WB_LW: ns <= IF;
        MEM_U: ns <= IF;
    endcase
end

always @(ps) begin
    {resultSrc, memWrite, ALUOp, ALUSrcA, ALUSrcB, immSrc, regWrite, PCUpdate, branch, IRWrite} <= 14'b0;
    case (ps)
        IF: begin adrSrc <= 1'b0; ALUSrcA <= 2'b00; ALUSrcB <= 2'b10; ALUOp <= 2'b00; 
        resultSrc <= 2'b10; {PCUpdate, IRWrite} <= 2'b11; end

        ID: begin ALUSrcA <= 2'b01; ALUSrcB <= 2'b01; ALUOp <= 2'b00; immSrc <= 3'b010; end

        EX_I: begin ALUSrcA <= 2'b10; ALUSrcB <= 2'b01; immSrc <= 3'b000; ALUOp <= 2'b11; end
        MEM_I: begin resultSrc <= 2'b00; regWrite <= 1'b1; end

        EX_JALR: begin ALUSrcA <= 2'b10; ALUSrcB <= 2'b01; {immSrc, ALUOp} <= 2'b00; end
        MEM_JALR: begin ALUSrcA <= 2'b01; ALUSrcB <= 2'b10; {ALUOp, resultSrc} <= 2'b00; PCUpdate <= 1'b1; end

        EX_LW: begin ALUSrcA <= 2'b10; ALUSrcB <= 2'b01; {immSrc, ALUOp} <= 2'b00; end
        MEM_LW: begin resultSrc <= 2'b00; adrSrc <= 1'b1; end
        WB_LW: begin resultSrc <= 2'b01; regWrite <= 1'b1; end

        EX_R: begin ALUSrcA <= 2'b10; ALUSrcB <= 2'b00; ALUOp <= 2'b10; end
        MEM_R: begin resultSrc <= 2'b00; regWrite <= 1'b1; end
        EX_B: begin ALUSrcA <= 2'b10; ALUOp <= 2'b01; {resultSrc, ALUSrcB} <= 2'b00; branch <= 1'b1; end

        EX_J: begin ALUSrcA <= 2'b01; ALUSrcB <= 2'b10; ALUOp <= 2'b00; end
        MEM_J: begin regWrite <= 1'b1; ALUSrcA <= 2'b01; ALUSrcB <= 2'b01; immSrc <= 3'b011;
        {ALUOp, resultSrc} <= 2'b00; end
        WB_J: begin resultSrc <= 2'b00; PCUpdate <= 1'b1; end

        EX_S: begin ALUSrcA <= 2'b10; ALUSrcB <= 2'b01; {ALUOp,immSrc} <= 2'b00; end
        MEM_S: begin resultSrc <= 2'b00; {adrSrc, memWrite} <= 2'b11; end
        MEM_U: begin resultSrc <= 2'b11; immSrc <= 3'b100; regWrite <= 1'b1; end
    endcase
end

always @(posedge clk or posedge rst) begin
    if (rst) ps <= IF;
    else ps <= ns;
end

endmodule