module Controller (
    input zero, sign,
    input [6:0] opcode,
    input [2:0] func3,
    input [6:0] func7,
    output reg [1:0] PCSrc,
    output reg [1:0] ResultSrc,
    output reg MemWrite,
    output reg [2:0] ALUControl,
    output reg ALUSrc,
    output reg [2:0] ImmSrc,
    output reg RegWrite
);

    parameter R_TYPE = 7'b0110011;
    parameter LOAD = 7'b0000011;
    parameter IMMEDIATE = 7'b0010011;
    parameter JALR = 7'b1100111;
    parameter STORE = 7'b0100011;
    parameter JAL = 7'b1101111;
    parameter BRANCH = 7'b1100011;
    parameter LUI = 7'b0110111;

    parameter ADD = 3'b000;
    parameter SUB = 3'b000;
    parameter SLTU = 3'b010;
    parameter SLT = 3'b011;
    parameter OR = 3'b110;
    parameter AND = 3'b111;
    parameter LW = 3'b010;
    parameter ADDI = 3'b000;
    parameter SLTUI = 3'b010;
    parameter SLTI = 3'b011;
    parameter XORI = 3'b100;
    parameter ORI = 3'b110;
    parameter JALR_FUNC3 = 3'b000;
    parameter SW = 3'b010;
    parameter BEQ = 3'b000;
    parameter BNE = 3'b001;
    parameter BLT = 3'b100;
    parameter BGE = 3'b101;

    assign {PCSrc, ResultSrc, MemWrite, ALUSrc, ImmSrc, RegWrite} = 6'b0;

    always @ (opcode, func3, func7) begin
        case(opcode)
            R_TYPE: begin 
                RegWrite = 1; ImmSrc = 3'bXXX; ALUSrc = 0; MemWrite = 0; ResultSrc = 2'b00; PCSrc = 2'b00;
                case(func3)
                    ADD: ALUControl = 3'b010;
                    SUB: ALUControl = 3'b110;
                    SLTU: ALUControl = 3'b100;
                    SLT: ALUControl = 3'b111;
                    OR: ALUControl = 3'b001;
                    AND: ALUControl = 3'b000;
                    default: ALUControl = 3'bXXX;
                endcase
            end
            LOAD: begin 
                RegWrite = 1; ImmSrc = 3'b000; ALUSrc = 1; MemWrite = 0; ResultSrc = 2'b01; PCSrc = 2'b00;
                if (func3 == LW) ALUControl = 3'b010; 
                else ALUControl = 3'bXXX;
            end
            IMMEDIATE: begin
                RegWrite = 1; ImmSrc = 3'b000; ALUSrc = 1; MemWrite = 0; ResultSrc = 2'b00; PCSrc = 2'b00;
                case(func3)
                    ADDI: ALUControl = 3'b010;
                    SLTUI: ALUControl = 3'b100;
                    SLTI: ALUControl = 3'b111;
                    XORI: ALUControl = 3'b011;
                    ORI: ALUControl = 3'b001;
                    default: ALUControl = 3'bXXX;
                endcase
            end
            JALR: begin
                RegWrite = 1; ImmSrc = 3'b000; ALUSrc = 1; MemWrite = 0; ResultSrc = 2'b10; PCSrc = 2'b10;
                if (func3 == JALR_FUNC3) ALUControl = 3'b010; 
                else ALUControl = 3'bXXX;
            end
            STORE: begin
                RegWrite = 0; ImmSrc = 3'b001; ALUSrc = 1; MemWrite = 1; ResultSrc = 2'bXX; PCSrc = 2'b00;
                if (func3 == SW) ALUControl = 3'b010; 
                else ALUControl = 3'bXXX;
            end
            JAL: begin
                RegWrite = 1; ImmSrc = 3'b011; ALUSrc = 1'bX; MemWrite = 0; ResultSrc = 2'b10; PCSrc = 2'b01;
                ALUControl = 3'b010; 
            end

            BRANCH: begin
                RegWrite = 0; ImmSrc = 3'b010; ALUSrc = 0; MemWrite = 0; ResultSrc = 2'b00;
                case(func3)
                    BEQ: begin
                        ALUControl = 3'b011;
                        PCSrc = (zero == 1) ? 1 : 2'b00;
                    end
                    BNE: begin
                        ALUControl = 3'b011;
                        PCSrc = (zero == 1) ? 0 : 2'b01;
                    end
                    BLT: begin
                        ALUControl = 3'b111;
                        PCSrc = (sign == 1) ? 1 : 2'b00;
                    end
                    BGE: begin
                        ALUControl = 3'b111;
                        PCSrc = (sign == 0 || zero == 1) ? 1 : 2'b00;
                    end
                    default: begin
                        ALUControl = 3'b0;
                        PCSrc = 2'b00;
                    end
                endcase
            end

            LUI: begin
                RegWrite = 1; ALUSrc = 1'bX; MemWrite = 0; ResultSrc = 2'b11; PCSrc = 2'b00;
                ALUControl = 3'bXXX;
            end
            default: begin
                RegWrite = 0; ALUSrc = 0; MemWrite = 0; ResultSrc = 2'b00; PCSrc = 2'b00;
                ALUControl = 3'bXXX;
                ImmSrc = 3'bXXX;
            end
        endcase
    end

endmodule
