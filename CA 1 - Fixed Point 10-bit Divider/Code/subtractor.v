`timescale 1ns/1ns
module subtractor(clock, sub, ACC, B, result);

input            clock;
input            sub;
input      [10:0]  ACC;
input      [9:0] B;
output reg [10:0] result;

assign result = (sub) ? (ACC - {1'b0, B}) : result;

endmodule
