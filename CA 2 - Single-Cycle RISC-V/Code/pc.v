module PC (
    input [31:0] input_data,
    input clock,
    input reset,
    output reg [31:0] output_data
);

    always @(posedge clock) begin
        if (reset)
            output_data <= 32'b0;
        else
            output_data <= input_data;
    end

endmodule
