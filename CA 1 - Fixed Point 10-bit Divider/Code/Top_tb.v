`timescale 1ns/1ns

module testbench_top;
   reg clk, rst, start;
   reg [9:0] A, B;
   wire ov;
   wire [9:0] Q;
   wire busy , valid,dvz;
   div_top uut (clk,start,A, B, Q, busy, valid,ov,dvz);

   assign clk = 0;
   initial begin forever #5 clk = ~clk; end

   initial
   begin
      // Devide by zero :
      A = 10'b1101010000;
      B = 10'b0;
      rst = 1; start = 0; 
     #10 rst = 0; start = 1;#10 start=0; #380;
      // Main Tests: 
        A = 10'b0001100100;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011010111;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011101101;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0010111010;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110001010;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011001011;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101101111;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100111001;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111100100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011011000;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110000010;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111011101;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001111000;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011110111;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101010101;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000101110;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111010110;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100001111;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011101010;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001001001;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000010100;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000111011;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111100000;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100000111;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001100000;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011100001;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101000010;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110101011;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000101111;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011010010;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111010101;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001111111;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111110111;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110010000;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100110100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011000000;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111111001;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0010101000;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100100011;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100101010;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001001011;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011101101;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101001011;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000100101;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001000111;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0010101010;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110100001;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011100011;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0010100100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101100110;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111101011;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000111000;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111110100;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111011101;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101001101;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100000100;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0010000001;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100000111;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011001001;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001000111;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101100001;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0010001100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100001000;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101100010;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000110001;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110101100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110010001;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100111101;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000110000;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111111100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110100010;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000100010;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001100101;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000100101;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001001010;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101110000;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110111101;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100000100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101100010;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101111100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101011100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011000101;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111001010;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0101000011;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100001000;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001011100;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100000100;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001010011;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111000101;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000010010;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100011011;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0000011000;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0100101011;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011100101;
        B = 10'b0000011000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011100101;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0111010001;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110000011;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0011101110;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0001011100;
        B = 10'b0000001000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

        A = 10'b0110101100;
        B = 10'b0000010000;
        rst = 1; start = 0;
        #10 rst = 0; start = 1;#10 start=0; #380;

      $stop;
   end

endmodule
