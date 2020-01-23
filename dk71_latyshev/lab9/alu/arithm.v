`timescale 1ns/1ps

`include "//home/yan/QWER/kpi-computer-architecture-course/dk71_latyshev/lab9/alu/defines.v"

`define ALU_ADDSUB 3'b00?
`define ALU_MUL_L 3'b010
`define ALU_MUL_H 3'b011
`define ALU_DIV 3'b100
`define ALU_REM 3'b101

module arithm(first_op, second_op, arithm_sel, o_data, ovf, cf);

input [2:0] arithm_sel;
input [`REG_WIDTH-1:0] first_op;
input [`REG_WIDTH-1:0] second_op;

output reg [`REG_WIDTH-1:0] o_data;
output reg ovf = 0;
output reg cf = 0;

wire [`REG_WIDTH-1:0] second_op_inv;
wire [`REG_WIDTH+1:0] addsub_temp;
wire signed [`REG_WIDTH*2-1:0] mul_temp;
wire signed [`REG_WIDTH-1:0] div_temp;

assign second_op_inv = second_op ^ {`REG_WIDTH{arithm_sel[0]}};
assign addsub_temp = {first_op, arithm_sel[0]} + {second_op_inv, arithm_sel[0]};
assign mul_temp = first_op * second_op;
assign div_temp = first_op / second_op;

always @* begin

	casez(arithm_sel)
		`ALU_ADDSUB: begin
			{cf, o_data} = addsub_temp[`REG_WIDTH+1:1];
			ovf = (second_op_inv[`REG_WIDTH-1] ^ first_op[`REG_WIDTH-1]) ^ cf;
		end
		`ALU_MUL_L: begin
			o_data = mul_temp[`REG_WIDTH-1:0];
			cf = 0;
			ovf = 0;
		end
		`ALU_MUL_H: begin
			o_data = mul_temp[`REG_WIDTH*2-1:`REG_WIDTH];
			cf = 0;
			ovf = 0;
		end
		`ALU_DIV: begin
			o_data = div_temp;
			cf = 0;
			ovf = 0;
		end
		`ALU_REM: begin
			o_data = first_op % second_op;
			cf = 0;
			ovf = 0;
		end
		default: begin
			o_data = 0;
			cf = 0;
			ovf = 0;
		end
	endcase

end
endmodule
