`timescale 1ns/1ps

module reg_file #(parameter REG_WIDTH = 1, NUM_OF_REGS = 1)(i_data, write_addr, clk, we, read_addr_a, o_data_a, read_addr_b, o_data_b, arst_n);

localparam ADDR_WIDTH = $clog2(REG_WIDTH);

input [REG_WIDTH-1:0] i_data;
input [ADDR_WIDTH-1:0] write_addr;
input [ADDR_WIDTH-1:0] read_addr_a;
input [ADDR_WIDTH-1:0] read_addr_b;
input clk, we, arst_n;

output [`REG_WIDTH-1:0] o_data_a;
output [`REG_WIDTH-1:0] o_data_b;

reg [REG_WIDTH-1:0] regs [NUM_OF_REGS-1:0];

integer i;

assign o_data_a = read_addr_a == 0 ? 0 : regs[read_addr_a];
assign o_data_b = read_addr_b == 0 ? 0 : regs[read_addr_b];

always @(negedge clk or negedge arst_n) begin
	if(!arst_n) begin
		for(i = 0; i < NUM_OF_REGS; i = i + 1)
			regs[i] <= 32'b0;
	end
	else if(we && write_addr) regs[write_addr] <= i_data;
end
endmodule
