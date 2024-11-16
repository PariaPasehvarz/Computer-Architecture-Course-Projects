module PipelineM (
    input [31:0] ALUResultM,
    input [31:0] writeDataM,
    input memWriteM,
    input clk,
    output [31:0] RDM,

    input regWriteM,
    input regWriteW,
    input [31:0] ALUResultW,
    input [31:0] RDW,
    input [4:0] RdM,
    input [4:0] RdW,
    input [1:0] resultSrcM,
    input [1:0] resultSrcW,
    input [31:0] PCPlus4M,
    input [31:0] PCPlus4W,
    input [31:0] extImmM,
    input [31:0] extImmW,
    input rst
);

    DataMemory DM (
        .memAdr(ALUResultM),
        .writeData(writeDataM),
        .memWrite(memWriteM),
        .clk(clk),
        .readData(RDM)
    );

    RegMEM_WB regMEMWB (
        .clk(clk),
        .rst(rst),
        .regWriteM(regWriteM),
        .regWriteW(regWriteW),
        .ALUResultM(ALUResultM),
        .ALUResultW(ALUResultW),
        .RDM(RDM),
        .RDW(RDW),
        .RdM(RdM),
        .RdW(RdW),
        .resultSrcM(resultSrcM),
        .resultSrcW(resultSrcW),
        .PCPlus4M(PCPlus4M),
        .PCPlus4W(PCPlus4W),
        .extImmM(extImmM),
        .extImmW(extImmW)
    );

endmodule
