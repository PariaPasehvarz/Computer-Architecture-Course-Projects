module PipelineW (
    input [1:0] resultSrcW,
    input [31:0] ALUResultW,
    input [31:0] RDW,
    input [31:0] PCPlus4W,
    input [31:0] extImmW,
    output [31:0] resultW
);

    Mux4to1 resMux (
        .sel(resultSrcW),
        .a(ALUResultW),
        .b(RDW),
        .c(PCPlus4W),
        .d(extImmW),
        .w(resultW)
    );

endmodule
