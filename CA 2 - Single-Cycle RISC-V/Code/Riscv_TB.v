`timescale 1ns/1ns

module riscv_testbench ;
    reg clk = 1'b0, rst = 1'b0;

    RISC_V riscv(clk, rst);

    always #1 clk = ~clk;
    initial begin
        #10
        rst = 1'b1;
        #10 rst = 1'b0;
        #1000
        $stop;
    end

endmodule
