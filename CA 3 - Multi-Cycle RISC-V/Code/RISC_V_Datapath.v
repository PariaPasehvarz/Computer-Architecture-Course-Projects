module RISC_V_Datapath(clk, rst, PCWrite, AdrSlc, MemWrite,
                    IRWrite, ResultSlc, AluOpcode,
                    InputA, InputB, ImmSlc, RegWrite,
                    Opcode, Func3, Func7, ZeroFlag, NegFlag);

    input [2:0] AluOpcode, ImmSlc;
    input [1:0] ResultSlc, InputA, InputB;
    input clk, rst, PCWrite, AdrSlc, MemWrite, IRWrite, RegWrite;
    output [6:0] Opcode;
    output Func7, ZeroFlag, NegFlag;
    output [2:0] Func3;

    wire [31:0] ALUResult, ALUOut,Result;
    wire [31:0] ImmExt, instr, Data;
    wire [31:0] RD1, RD2, A, B, SrcA, SrcB;
    wire [31:0] PC, Adr, ReadData, OldPC;

    Register PCR   (.Input(Result),    .Enable(PCWrite), .rst(rst), .clk(clk), .Output(PC));
    Register OldPCR(.Input(PC),        .Enable(IRWrite), .rst(rst), .clk(clk), .Output(OldPC));
    Register IR    (.Input(ReadData),  .Enable(IRWrite), .rst(rst), .clk(clk), .Output(instr));
    Register MDR   (.Input(ReadData),  .Enable(1'b1),    .rst(rst), .clk(clk), .Output(Data));
    Register AR    (.Input(RD1),       .Enable(1'b1),    .rst(rst), .clk(clk), .Output(A));
    Register BR    (.Input(RD2),       .Enable(1'b1),    .rst(rst), .clk(clk), .Output(B));
    Register ALUR  (.Input(ALUResult), .Enable(1'b1),    .rst(rst), .clk(clk), .Output(ALUOut));

    Mux2to1 AdrMux(.sel(AdrSlc),    .a(PC),     .b(Result), .w(Adr));

    Mux4to1 AMux     (.sel(InputA),   .a(PC),     .b(OldPC),  .c(A),         .d(32'd0),  .w(SrcA));
    Mux4to1 BMux     (.sel(InputB),   .a(B),      .b(ImmExt), .c(32'd4),     .d(32'd0),  .w(SrcB));
    Mux4to1 ResultMux(.sel(ResultSlc), .a(ALUOut), .b(Data),   .c(ALUResult), .d(ImmExt), .w(Result));

    ImmExtension Extend(
        .ImmSlc(ImmSlc), .ImmData(instr[31:7]), .Result(ImmExt)
    );

    ALU ALU_Instance(
        .AluOpcode(AluOpcode), .InputA(SrcA), .InputB(SrcB), 
        .ZeroFlag(ZeroFlag), .NegFlag(NegFlag), .Result(ALUResult)
    );

    InstrDataMemory DM(
        .memAdr(Adr), .writeData(B), .clk(clk), 
        .memWrite(MemWrite), .readData(ReadData)
    );

    RegisterFile RF(
        .clk(clk), 
        .RegWrite(RegWrite),
        .WriteD(Result), 
        .ReadData1(RD1), .ReadData2(RD2),
        .ReadReg1(instr[19:15]), 
        .ReadReg2(instr[24:20]),
        .WriteReg(instr[11:7])
    );

    assign Opcode = instr[6:0];
    assign Func3 = instr[14:12];
    assign Func7 = instr[30];
endmodule