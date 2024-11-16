`timescale 1ns/1ns
module RegisterACC(clock, rst, loading_done, ld,shift, A, Q, data_in, sub_result, data_out);

input            clock;
input            rst;
input            ld;
input		 loading_done;
input shift;
input      [9:0]  A;
input      [9:0]  Q;
input      [10:0] data_in;
input      [10:0] sub_result;
output reg [10:0] data_out;

always @(posedge clock)
begin
    if(rst && loading_done)
        data_out <= {10'b0, A[9]};
    else
	if(ld && loading_done && shift)
		data_out<= {sub_result[9:0], Q[9]};
	else if(loading_done && shift)
		data_out<= {data_in[9:0], Q[9]};
end

endmodule