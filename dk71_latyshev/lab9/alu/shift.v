`timescale 1ns/1ps

`include "/home/yan/QWER/kpi-computer-architecture-course/dk71_latyshev/lab9/alu/defines.v"

`define ALU_SLL 3'b001
`define ALU_SRL 3'b010
`define ALU_ROR 3'b011
`define ALU_SRA 3'b100
`define ALU_ROL 3'b101

`define SEL_WIDTH 3
`define SA_WIDTH 5

module shift(sel_shift, shift_amount, data_in, o_data);

input  [`SEL_WIDTH-1:0]  sel_shift;
input  [`SA_WIDTH-1:0]  shift_amount;
input  [`REG_WIDTH-1:0] data_in;
output reg[`REG_WIDTH-1:0] o_data;

wire [`REG_WIDTH*2-1:0] temp1, temp2; 
wire arithm, is_arithm_shift;

assign is_arithm_shift = sel_shift[2];
assign arithm = data_in[`REG_WIDTH-1] & is_arithm_shift;
assign temp1 = {data_in, data_in} << shift_amount;
assign temp2 = $signed({arithm, data_in, data_in}) >>> shift_amount;

always @* begin

	casez(sel_shift)
		`ALU_SLL: o_data = temp1[`REG_WIDTH-1:0];
		`ALU_SRL: o_data = temp2[`REG_WIDTH*2-1:`REG_WIDTH];
		`ALU_ROR: o_data = temp2[`REG_WIDTH-1:0];
		`ALU_ROL: o_data = temp1[`REG_WIDTH*2-1:`REG_WIDTH];
		`ALU_SRA: o_data = temp2[`REG_WIDTH*2-1:`REG_WIDTH];
		default o_data = 0;
	endcase
end

endmodule
