module RISC_V(clk, rst);
    input clk, rst;
    
    wire [2:0] func3, ALUControl, immSrc;
    wire [6:0] op; 
    wire [1:0] resultSrc, ALUSrcA, ALUSrcB;
    wire zero, neg, PCSrc, memWrite, func7, 
         regWrite, ALUSrc, PCWrite, adrSrc, IRWrite;

    RISC_V_Controller CU(
        .clk(clk), .rst(rst), .op(op), 
        .func3(func3), .immSrc(immSrc), 
        .func7(func7), .zero(zero), 
        .neg(neg), .PCWrite(PCWrite),
        .adrSrc(adrSrc), .memWrite(memWrite), 
        .IRWrite(IRWrite), .resultSrc(resultSrc), 
        .ALUControl(ALUControl), .ALUSrcA(ALUSrcA),
        .ALUSrcB(ALUSrcB), .regWrite(regWrite)
    );

    RISC_V_Datapath DP(
        .clk(clk), .rst(rst), .NegFlag(neg),
        .PCWrite(PCWrite), .AdrSlc(adrSrc),
        .MemWrite(memWrite), .IRWrite(IRWrite), 
        .ResultSlc(resultSrc), .ImmSlc(immSrc), 
        .AluOpcode(ALUControl), .Opcode(op),
        .InputA(ALUSrcA), .Func3(func3),
        .InputB(ALUSrcB), .ZeroFlag(zero),
        .RegWrite(regWrite), .Func7(func7)
    );
    
endmodule