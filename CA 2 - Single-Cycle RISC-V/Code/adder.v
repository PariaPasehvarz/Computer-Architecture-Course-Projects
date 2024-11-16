module Adder (
    input signed [31:0] input_a,
    input signed [31:0] input_b,
    output signed [31:0] sum
);

    assign sum = input_a + input_b;

endmodule
