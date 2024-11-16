module ImmExt (
    input [31:7] in,
    input [2:0] ImmSrc,
    output reg [31:0] out
);

    always @* begin
        case(ImmSrc)
            3'b000: out = {{20{in[31]}}, in[31:20]}; // I-type: Sign-extend 12-bit immediate
            3'b001: out = {{20{in[31]}}, in[31:25], in[11:7]}; // S-type: Sign-extend 12-bit immediate
            3'b010: out = {{20{in[31]}}, in[7], in[30:25], in[11:8], 1'b0}; // B-type: Sign-extend 13-bit immediate
            3'b011: out = {{12{in[31]}}, in[31], in[19:12], in[20], in[30:21], 1'b0}; // UJ-type: Sign-extend 21-bit immediate
            3'b100: out = {in[31:12], {12{1'b0}}}; // U-type: Zero-extend 20-bit immediate
        endcase
    end

endmodule
