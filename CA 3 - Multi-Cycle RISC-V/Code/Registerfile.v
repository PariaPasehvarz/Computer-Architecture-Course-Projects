module RegisterFile(clk, RegWrite,
                    ReadReg1, ReadReg2,
                    WriteReg, WriteD,
                    ReadData1, ReadData2);

    input RegWrite, clk;
    input [31:0] WriteD;
    input [4:0] ReadReg1, ReadReg2, WriteReg;
    output [31:0] ReadData1, ReadData2;
    reg [31:0] registerFile [0:31];


    initial 
        registerFile[0] = 32'b0;

    always @(posedge clk) begin
        if (RegWrite & (|WriteReg))
            registerFile[WriteReg] <= WriteD;
    end

    assign ReadData2 = registerFile[ReadReg2];
    assign ReadData1 = registerFile[ReadReg1];

endmodule