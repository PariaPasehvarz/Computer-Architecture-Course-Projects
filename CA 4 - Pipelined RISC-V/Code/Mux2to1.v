module Mux2to1 (sel, a, b, w);

    input sel;
    input [31:0] a;
    input [31:0] b;
    output reg [31:0] w;

    always @* begin
        w = sel ? b : a;
    end

endmodule
