`timescale 1ns/1ns
module div_top( 
input clk, 
input start,
input [9:0] A,
input [9:0] B, 
output [9:0] Q_next,
output busy,
output valid,
output ovf,
output dvz
);

wire rst, loading_done, ld_a, ld_b, gT, CO_CNT,shift,count_enable; 

fixed_point_division2 CUT1(clk, rst, loading_done,start,ld_a,ld_b,shift,count_enable,A,B,Q_next,ovf,gT, dvz,CO_CNT);

div_CU CUT2 (clk,start,dvz,gT,CO_CNT,ovf,busy,ld_a,ld_b,rst,valid,loading_done,shift,count_enable);

endmodule