module Mux4to1 (
    input [1:0] sel,
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    input [31:0] d,
    output reg [31:0] w
);

    always @* begin
        case (sel)
            2'b00: w = a;
            2'b01: w = b;
            2'b10: w = c;
            2'b11: w = d;
            default: w = 32'bz;
        endcase
    end

endmodule
