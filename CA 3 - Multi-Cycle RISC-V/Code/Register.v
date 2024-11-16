module Register(Input, Enable, rst, clk, Output);

    input [31:0] Input;
    input Enable, clk, rst;
    output reg [31:0] Output;

    always @(posedge clk or posedge rst) begin
        if (rst)
            Output <= 32'b0;
        else if (Enable)
            Output <= Input;
    end

endmodule