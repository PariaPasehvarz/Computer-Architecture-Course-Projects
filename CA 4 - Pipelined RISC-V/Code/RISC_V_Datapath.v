module RISC_V_Datapath(
    input clk, 
    input rst, 
    input regWriteD, 
    input memWriteD, 
    input ALUSrcD, 
    input luiD,
    input [1:0] resultSrcD, 
    input [1:0] jumpD,
    input [2:0] ALUControlD, 
    input [2:0] branchD, 
    input [2:0] immSrcD,
    output [6:0] op,
    output [2:0] func3,
    output func7);

    wire regWriteW, regWriteM, memWriteM, luiE, 
         luiM, regWriteE, 
         ALUSrcE, memWriteE, flushE, zero, neg, 
         stallF, stallD, flushD;

    wire [1:0] resultSrcW, resultSrcM, jumpE, 
               PCSrcE, resultSrcE, forwardAE, forwardBE;
    wire [2:0] branchE, ALUControlE;
    wire [4:0] RdW, RdM, Rs1E, Rs2E, RdE, Rs1D, Rs2D, RdD;

    wire [31:0] ALUResultM, writeDataM, PCPlus4M, extImmM, RDM,
                resultW, extImmW, ALUResultW, PCPlus4W, RDW,
                RD1E, RD2E, PCE, SrcAE, SrcBE, writeDataE,        
                PCTargetE, extImmE, PCPlus4E, ALUResultE,         
                PCPlus4D, instrD, PCD, RD1D, RD2D, extImmD,
                PCF_Prime, PCF, instrF, PCPlus4F;

    assign op    = instrD[6:0];
    assign RdD   = instrD[11:7];
    assign func3 = instrD[14:12];
    assign Rs1D  = instrD[19:15];
    assign Rs2D  = instrD[24:20];
    assign func7 = instrD[30];            

    Adder PCFAdder(.a(PCF), .b(32'd4), .w(PCPlus4F));

    Register PCreg(.in(PCF_Prime), .clk(clk), .en(~stallF),.rst(rst), .out(PCF));

    InstructionMemory IM(.pc(PCF), .instruction(instrF));

    Mux4to1 PCmux(
        .sel(PCSrcE), 
        .a(PCPlus4F), 
        .b(PCTargetE), 
        .c(ALUResultE), 
        .d(32'bz), 
        .w(PCF_Prime)
    );

    RegIF_ID RegIFID(
        .clk(clk),
        .rst(rst), 
        .en(~stallD), 
        .clr(flushD),
        .PCF(PCF),                 
        .PCD(PCD),
        .PCPlus4F(PCPlus4F),       
        .PCPlus4D(PCPlus4D),
        .instrF(instrF),
        .instrD(instrD)
    );

    RegisterFile RF(
        .clk(clk), 
        .regWrite(regWriteW),
        .writeRegister(RdW), 
        .writeData(resultW),
        .readData1(RD1D), 
        .readData2(RD2D),
        .readRegister1(instrD[19:15]), 
        .readRegister2(instrD[24:20])
    );
    
    ImmExtension Extend(
        .immSrc(immSrcD), 
        .w(extImmD),
        .data(instrD[31:7])
    );

    ALU ALU_Instance(
        .ALUControl(ALUControlE), 
        .a(SrcAE), 
        .b(SrcBE), 
        .zero(zero), 
        .neg(neg), 
        .w(ALUResultE)
    );


    RegID_EX RegIDEX(
        .clk(clk),
        .rst(rst),
        .clr(flushE), 
        .regWriteD(regWriteD),     
        .regWriteE(regWriteE), 
        .PCD(PCD),                 
        .PCE(PCE),
        .Rs1D(Rs1D),               
        .Rs1E(Rs1E),
        .Rs2D(Rs2D),               
        .Rs2E(Rs2E),
        .RdD(RdD),                 
        .RdE(RdE),
        .RD1D(RD1D),               
        .RD1E(RD1E),
        .RD2D(RD2D),               
        .RD2E(RD2E), 
        .resultSrcD(resultSrcD),   
        .resultSrcE(resultSrcE),
        .memWriteD(memWriteD),     
        .memWriteE(memWriteE),
        .jumpD(jumpD),             
        .jumpE(jumpE),
        .branchD(branchD),         
        .branchE(branchE),
        .ALUControlD(ALUControlD), 
        .ALUControlE(ALUControlE), 
        .ALUSrcD(ALUSrcD),         
        .ALUSrcE(ALUSrcE),    
        .extImmD(extImmD),         
        .extImmE(extImmE),
        .luiD(luiD),               
        .luiE(luiE),
        .PCPlus4D(PCPlus4D),       
        .PCPlus4E(PCPlus4E) 
    );
     
    
    Mux4to1 SrcAReg (
        .sel(forwardAE), .a(RD1E), .b(resultW), .c(ALUResultM), .d({31'b0, luiM}), .w(SrcAE)
    );

    Mux4to1 BSrcBReg(
        .sel(forwardBE), .a(RD2E), .b(resultW), .c(ALUResultM), .d({31'b0, luiM}), .w(writeDataE)
    );

    Mux2to1 SrcBReg(
        .sel(ALUSrcE), .a(writeDataE), .b(extImmE), .w(SrcBE)
    );

    Adder PCEAdder(
        .a(PCE), .b(extImmE), .w(PCTargetE)
    );

    RegEX_MEM RegEX_MEM(
        .clk(clk), 
        .rst(rst),
        .PCPlus4M(PCPlus4M),       
        .PCPlus4E(PCPlus4E),
        .resultSrcE(resultSrcE),   
        .resultSrcM(resultSrcM),
        .writeDataE(writeDataE),   
        .writeDataM(writeDataM),
        .luiE(luiE),               
        .luiM(luiM),
        .regWriteE(regWriteE),     
        .regWriteM(regWriteM), 
        .RdE(RdE),                 
        .RdM(RdM),
        .memWriteE(memWriteE),     
        .memWriteM(memWriteM),
        .ALUResultE(ALUResultE),   
        .ALUResultM(ALUResultM),
        .extImmE(extImmE),         
        .extImmM(extImmM)
    );

    PipelineM MStage (
        .ALUResultM(ALUResultM),
        .writeDataM(writeDataM),
        .memWriteM(memWriteM),
        .clk(clk),
        .RDM(RDM),
        .regWriteM(regWriteM),
        .regWriteW(regWriteW),
        .ALUResultW(ALUResultW),
        .RDW(RDW),
        .RdM(RdM),
        .RdW(RdW),
        .resultSrcM(resultSrcM),
        .resultSrcW(resultSrcW),
        .PCPlus4M(PCPlus4M),
        .PCPlus4W(PCPlus4W),
        .extImmM(extImmM),
        .extImmW(extImmW),
        .rst(rst)
    );

    PipelineW WStage (
        .resultSrcW(resultSrcW),
        .ALUResultW(ALUResultW),
        .RDW(RDW),
        .PCPlus4W(PCPlus4W),
        .extImmW(extImmW),
        .resultW(resultW)
    );


    HazardUnit Hazard(
        .Rs1D(Rs1D), 
        .Rs2D(Rs2D),
        .Rs1E(Rs1E), 
        .Rs2E(Rs2E),
        .RdE(RdE), 
        .RdM(RdM), 
        .RdW(RdW), 
        .luiM(luiM),
        .PCSrcE(PCSrcE), 
        .resultSrc0(resultSrcE[0]), 
        .regWriteW(regWriteW), 
        .regWriteM(regWriteM), 
        .stallD(stallD), 
        .stallF(stallF),
        .flushD(flushD), 
        .flushE(flushE), 
        .forwardAE(forwardAE), 
        .forwardBE(forwardBE)
    );

    BranchController BranchCotroller(
        .branchE(branchE), 
        .jumpE(jumpE), 
        .neg(neg), 
        .zero(zero), 
        .PCSrcE(PCSrcE)
    );

endmodule
