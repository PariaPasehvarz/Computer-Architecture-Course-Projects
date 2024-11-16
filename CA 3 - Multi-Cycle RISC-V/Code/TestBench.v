module TB();

    reg clk, rst;

    RISC_V risc_v(.clk(clk), .rst(rst));

    always #5 clk = ~clk;

    initial begin
        clk = 1'b0;
        #21 rst = 1'b1;
        #31 rst = 1'b0;
        #4000 $stop;
    end
    
endmodule