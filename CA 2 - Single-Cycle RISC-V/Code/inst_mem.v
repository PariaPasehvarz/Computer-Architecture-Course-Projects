module InstructionMemory (
    input [31:0] pc,
    output [31:0] instruction
);

    reg [7:0] instruction_memory [0:65535]; // 2^16-1

    wire [31:0] address;
    assign address = {pc[31:2], 2'b00};

    initial $readmemb("instruction.mem", instruction_memory);
    assign instruction = {instruction_memory[address], instruction_memory[address + 1], instruction_memory[address + 2], instruction_memory[address + 3]};

endmodule
