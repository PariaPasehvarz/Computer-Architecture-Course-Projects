module Mux4To1 (
    input [31:0] a0,
    input [31:0] a1,
    input [31:0] a2,
    input [31:0] a3,
    input [1:0] sel,
    output reg [31:0] out
);

    always @* begin
        case (sel)
            2'b00: out = a0;
            2'b01: out = a1;
            2'b10: out = a2;
            default: out = a3;
        endcase
    end

endmodule
