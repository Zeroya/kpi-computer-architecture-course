`timescale 1ns/1ps

`include "/home/yan/QWER/kpi-computer-architecture-course/dk71_latyshev/lab9/alu/defines.v"

`define ALU_AND 3'b000
`define ALU_OR 3'b001
`define ALU_NOR 3'b010
`define ALU_XOR 3'b011
`define ALU_STL 3'b100

module logic(first_op, second_op, log_sel, o_data);

input [`REG_WIDTH-1:0] first_op;
input [`REG_WIDTH-1:0] second_op;
input [2:0] log_sel;

output reg [`REG_WIDTH-1:0] o_data;

always @* begin
	casez(log_sel)
		`ALU_AND: o_data = first_op & second_op;
		`ALU_OR: o_data = first_op | second_op;
		`ALU_NOR: o_data = ~(first_op | second_op);
		`ALU_XOR: o_data = first_op ^ second_op;
		`ALU_STL: o_data = first_op < second_op;
		default: o_data = 0;
	endcase


end
endmodule 