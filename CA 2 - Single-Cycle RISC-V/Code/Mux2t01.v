module Mux2To1 (
    input [31:0] a0,
    input [31:0] a1,
    input sel,
    output reg [31:0] out
);

    always @* begin
        out = sel ? a1 : a0;
    end

endmodule
