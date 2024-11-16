module RegisterFile (
    input [4:0] read_address_1,
    input [4:0] read_address_2,
    input [4:0] write_address,
    input [31:0] write_data,
    input write_enable,
    input clock,
    output reg [31:0] read_data_1,
    output reg [31:0] read_data_2
);


    reg [31:0] register_file [0:31];

    assign read_data_1 = register_file[read_address_1];
    assign read_data_2 = register_file[read_address_2];
    assign register_file[0] = 32'b0;


    always @(posedge clock) begin
        if (write_enable) begin
            if (write_address != 5'b00000) // ensuring we are not writing to register 0
                register_file[write_address] <= write_data;
        end
    end
endmodule
