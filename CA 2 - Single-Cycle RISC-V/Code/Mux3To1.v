module Mux3To1 (
    input [31:0] a0,
    input [31:0] a1,
    input [31:0] a2,
    input [1:0] sel,
    output reg [31:0] out
);

    always @* begin
        case (sel)
            2'b01: out = a1;
            2'b00: out = a0;
            default: out = a2;
        endcase
    end

endmodule
