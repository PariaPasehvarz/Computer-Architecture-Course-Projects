module DataMemory (
    input [31:0] address,
    input [31:0] writeData,
    input writeEnable,
    input clk,
    output reg [31:0] readData
);

    reg [7:0] memory [0:65535]; // 2^16-1
    
    reg [31:0] memoryAddress;
    assign memoryAddress = {address[31:2], 2'b00}; 

    initial $readmemb("test_cases/arr1.mem", memory);

    always @(posedge clk) begin
        if (writeEnable)
            {memory[memoryAddress], memory[memoryAddress + 1], memory[memoryAddress + 2], memory[memoryAddress + 3]} <= writeData;
    end

    always @(address, memoryAddress) begin
           readData = {memory[memoryAddress], memory[memoryAddress + 1], memory[memoryAddress + 2], memory[memoryAddress + 3]};
    end

endmodule
