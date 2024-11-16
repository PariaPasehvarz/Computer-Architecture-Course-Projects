module RISC_V (
    input clk,
    input rst
);

    wire MemWrite, ALUSrc, RegWrite, zero, sign;
    wire [1:0] PCSrc;
    wire [1:0] ResultSrc;
    wire [2:0] ImmSrc;
    wire [2:0] ALUControl, func3;
    wire [6:0] opcode, func7;
    
    datapath DP (
        .rst(rst),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite),
        .clk(clk),
        .zero(zero),
        .sign(sign),
        .opcode(opcode),
        .func3(func3),
        .func7(func7)
    );

    Controller CU (
        .zero(zero),
        .sign(sign),
        .opcode(opcode),
        .func3(func3),
        .func7(func7),
        .PCSrc(PCSrc),
        .ResultSrc(ResultSrc),
        .MemWrite(MemWrite),
        .ALUControl(ALUControl),
        .ALUSrc(ALUSrc),
        .ImmSrc(ImmSrc),
        .RegWrite(RegWrite)
    );

endmodule
