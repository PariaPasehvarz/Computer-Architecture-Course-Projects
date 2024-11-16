module InstrDataMemory (memAdr, writeData, memWrite, clk, readData);
    input [31:0] memAdr, writeData;
    input memWrite, clk;
    output  [31:0] readData;
    reg [31:0] readData;

    reg [7:0] dataMem [0:$pow(2, 16)-1];

    wire [31:0] adr;
    assign adr = {memAdr[31:2], 2'b00};
    
    initial $readmemb("test_cases/arr1.mem", dataMem);

    always @(posedge clk) begin
        if (memWrite)
            {dataMem[adr], dataMem[adr +1 ], dataMem[adr + 2], dataMem[adr+3]} <= writeData;
    end
    
    assign readData = {dataMem[adr ], dataMem[adr + 1], dataMem[adr + 2], dataMem[adr + 3]};
    
endmodule