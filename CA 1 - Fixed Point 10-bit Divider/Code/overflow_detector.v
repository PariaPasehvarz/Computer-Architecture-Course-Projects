module overflow_detector (
  input wire clk,
  input wire [3:0] counter_out,
  input wire [9:0] Q_next,
  output reg ov
);

  assign  ov = (counter_out == 4'b1001) && (Q_next[9:4] != 6'b000000);

endmodule
