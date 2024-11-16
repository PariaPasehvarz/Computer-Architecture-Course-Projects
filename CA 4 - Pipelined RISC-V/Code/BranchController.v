module BranchController(
    input zero, neg,
    inout [2:0] branchE,
    input [1:0] jumpE,
    output reg [1:0] PCSrcE
);

    parameter [2:0] UJ = 3'b000,
                    BEQ = 3'b001,
                    BNE = 3'b010,
                    BLT = 3'b011,
                    BGE = 3'b100;

    parameter [1:0] JAL = 2'b01,
                    JALR = 2'b10;
    
    always @(jumpE, zero, neg, branchE) begin
        case(branchE)
            UJ : PCSrcE <= (jumpE == JAL)  ? 2'b01 :
                             (jumpE == JALR) ? 2'b10 : 2'b00;

            BEQ : PCSrcE <= (zero)           ? 2'b01 : 2'b00;
            BNE : PCSrcE <= (~zero)          ? 2'b01 : 2'b00;
            BLT : PCSrcE <= (neg)            ? 2'b01 : 2'b00;
            BGE : PCSrcE <= (zero | ~neg)    ? 2'b01 : 2'b00;
        endcase
    end

endmodule