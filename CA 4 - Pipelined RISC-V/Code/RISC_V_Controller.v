module RISC_V_Controller(
    input clk,
    input rst,
    input[6:0] op, 
    input[2:0] func3, 
    input func7,
    output regWriteD, 
    output[1:0] resultSrcD, 
    output memWriteD,
    output[1:0] jumpD, 
    output[2:0] branchD, 
    output[2:0] ALUControlD,
    output ALUSrcD, 
    output[2:0] immSrcD, 
    output luiD);

    wire [1:0] ALUOp;

    MainController MainController(
        .op(op),
        .func3(func3),
        .regWriteD(regWriteD),
        .resultSrcD(resultSrcD),
        .memWriteD(memWriteD),
        .jumpD(jumpD),
        .branchD(branchD),
        .ALUOp(ALUOp), 
        .ALUSrcD(ALUSrcD), 
        .immSrcD(immSrcD), 
        .luiD(luiD)
    );
    
    ALU_Controller ALUdecoder(
        .func3(func3),
        .func7(func7),
        .ALUOp(ALUOp), 
        .ALUControl(ALUControlD)
    );
    
endmodule