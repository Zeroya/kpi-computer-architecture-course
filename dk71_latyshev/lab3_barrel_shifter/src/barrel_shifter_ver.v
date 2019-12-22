`timescale 1ns/1ps

module barrel_shifter(bs_opsel, shift_amount, data_in, result);

input  [2:0]  bs_opsel;
input  [4:0]  shift_amount;
input  [31:0] data_in;
output reg[31:0] result;

wire [63:0] left;
wire [64:0] rigt; 
wire sign, issigned;

assign issigned = bs_opsel[2];
assign sign = data_in[31] & issigned;
assign left = {data_in, data_in} << shift_amount;
assign rigt = $signed({sign, data_in, data_in}) >>> shift_amount;

always @* begin
	casez(bs_opsel)
		3'b?00: result = left[31:0];
		3'b010: result = rigt[63:32];
		3'b011: result = rigt[31:0];
		3'b?01: result = left[63:32];
		3'b11?: result = rigt[63:32];
	endcase
end

endmodule
