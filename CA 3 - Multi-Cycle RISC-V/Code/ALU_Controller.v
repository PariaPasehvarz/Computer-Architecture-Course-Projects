module ALU_Controller(func3, func7, ALUOp, ALUControl);

    parameter[2:0]  ADD = 3'b000,
                    SUB = 3'b001,
                    AND = 3'b010,
                    OR =  3'b011,
                    SLT = 3'b101,
                    SLTU = 3'b100,
                    XOR = 3'b110;

    parameter[1:0]  S_T =  2'b00,
                    B_T = 2'b01,
                    R_T =  2'b10,
                    I_T =  2'b11;

    input [2:0] func3;
    input func7;
    input [1:0] ALUOp;

    output reg [2:0] ALUControl;
    
    always @(ALUOp or func3 or func7)begin
        case (ALUOp)
            B_T   : ALUControl <= SUB;
            S_T   : ALUControl <= ADD;
            I_T   : ALUControl <=  
                        (func3 == 3'b000) ? ADD:
                        (func3 == 3'b100) ? XOR:
                        (func3 == 3'b110) ? OR:
                        (func3 == 3'b011) ? SLTU:
                        (func3 == 3'b010) ? SLT: 3'bzzz;
            R_T   : ALUControl <= 
                        (func3 == 3'b000 & ~func7) ? ADD:
                        (func3 == 3'b000 & func7)  ? SUB:
                        (func3 == 3'b111) ? AND:
                        (func3 == 3'b110) ? OR:
                        (func3 == 3'b011) ? SLTU:
                        (func3 == 3'b010) ? SLT : 3'bzzz;
            default: ALUControl <= ADD;
        endcase
    end
endmodule