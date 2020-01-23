`timescale 1ns/1ps

`define DATA_MEMORY_MIN 0
`define DATA_MEMORY_MAX 127

`define GPIO_MIN 128
`define GPIO_MAX 130

module data_control #(parameter WIDTH = 1)(addr, mem_write_in, mem_write_out, o_data_addr);

localparam ADDR_WIDTH = $clog2(WIDTH);

input [WIDTH-1:0] addr;
input mem_write_in;

output [WIDTH-1:0] mem_write_out;
output reg [ADDR_WIDTH-1:0] o_data_addr;

decod dec_0(o_data_addr, mem_write_out, mem_write_in);

always @* begin
	if(`DATA_MEMORY_MIN <= addr && addr <= `DATA_MEMORY_MAX) begin
		o_data_addr <= 0;
	end
	else if(`GPIO_MIN <= addr && addr <= `GPIO_MAX) begin
		o_data_addr <= 1;
	end
	else o_data_addr <= 31;
end
	
endmodule


module decod(addr, o_data, en);

input [4:0] addr;
input en;

output reg [31:0] o_data;

always @* begin

if(!en) o_data = 0;
else begin
	casez(addr)
		0:  o_data = 32'b00000000000000000000000000000001;
		1:  o_data = 32'b00000000000000000000000000000010;
		2:  o_data = 32'b00000000000000000000000000000100;
		3:  o_data = 32'b00000000000000000000000000001000;
		4:  o_data = 32'b00000000000000000000000000010000;
		5:  o_data = 32'b00000000000000000000000000100000;
		6:  o_data = 32'b00000000000000000000000001000000;
		7:  o_data = 32'b00000000000000000000000010000000;
		8:  o_data = 32'b00000000000000000000000100000000;
		9:  o_data = 32'b00000000000000000000001000000000;
		10: o_data = 32'b00000000000000000000010000000000;
		11: o_data = 32'b00000000000000000000100000000000;
		12: o_data = 32'b00000000000000000001000000000000;
		13: o_data = 32'b00000000000000000010000000000000;
		14: o_data = 32'b00000000000000000100000000000000;
		15: o_data = 32'b00000000000000001000000000000000; 
		16: o_data = 32'b00000000000000010000000000000000;
		17: o_data = 32'b00000000000000100000000000000000;
		18: o_data = 32'b00000000000001000000000000000000;
		19: o_data = 32'b00000000000010000000000000000000;
		20: o_data = 32'b00000000000100000000000000000000;
		21: o_data = 32'b00000000001000000000000000000000;
		22: o_data = 32'b00000000010000000000000000000000;
		23: o_data = 32'b00000000100000000000000000000000;
		24: o_data = 32'b00000001000000000000000000000000;
		25: o_data = 32'b00000010000000000000000000000000;
		26: o_data = 32'b00000100000000000000000000000000;
		27: o_data = 32'b00001000000000000000000000000000;
		28: o_data = 32'b00010000000000000000000000000000;
		29: o_data = 32'b00100000000000000000000000000000;
		30: o_data = 32'b01000000000000000000000000000000;
		31: o_data = 32'b10000000000000000000000000000000;
	endcase
	end
end
endmodule 