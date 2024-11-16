module RegIF_ID(
    input clk, 
    input rst, 
    input clr, 
    input en,
    input [31:0] instrF,
    input [31:0] PCF, 
    input [31:0] PCPlus4F,
    output reg [31:0] instrD, 
    output reg [31:0] PCD, 
    output reg [31:0] PCPlus4D
);
    
    always @(posedge clk or posedge rst) begin
        
        if(rst || clr) begin
            instrD   <= 32'b0;
            PCD      <= 32'b0;
            PCPlus4D <= 3'b0;
        end 

        else if(en) begin
            instrD   <= instrF;
            PCD      <= PCF;
            PCPlus4D <= PCPlus4F;
        end
        
    end

endmodule
