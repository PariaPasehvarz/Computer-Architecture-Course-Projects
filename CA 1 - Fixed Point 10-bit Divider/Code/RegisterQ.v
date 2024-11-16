`timescale 1ns/1ns
module RegisterQ(clock, rst, loading_done, ldgt,shift, A, data_in, data_out);

input            clock;
input            rst;
input            ldgt;
input            loading_done;
input shift;
input      [9:0]  A;
input      [9:0] data_in;
output reg [9:0] data_out;

always @(posedge clock)
begin
    if(rst && loading_done)
        data_out <= {A[8:0], 1'b0};
    else
	if(ldgt && loading_done && shift)
		data_out<= {data_in[8:0], 1'b1};
	else if(loading_done && shift)
		data_out<= {data_in[8:0], 1'b0};
end

endmodule