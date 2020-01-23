`timescale 1ns/1ps

`include "/home/yan/QWER/kpi-computer-architecture-course/dk71_latyshev/lab9/alu/defines.v"

module alu(first_op, second_op, alu_sel, ovf_flag, cf_flag, zero_flag, alu_o_data);
//REGISTERS AND WIRES DESCRIPTION

input [`REG_WIDTH-1:0] first_op;
input [`REG_WIDTH-1:0] second_op;
input [`ALU_SEL_WIDTH-1:0] alu_sel;

output reg ovf_flag = 0, zero_flag = 0, cf_flag = 0;
output reg [`REG_WIDTH-1:0] alu_o_data = 0;

wire [`REG_WIDTH-1:0] shift_res, logic_res, arithm_res;
wire arithm_ovf, arithm_cf;

	
//EXTERNALS MODULES
	
shift shifter_0(alu_sel[`SHIFT_DIAP], second_op[`SHIFT_SA_DIAP], first_op[`REG_WIDTH-1:0], shift_res[`REG_WIDTH-1:0]);

arithm arithm_0(first_op[`REG_WIDTH-1:0], second_op[`REG_WIDTH-1:0], alu_sel[`ARITHM_DIAP], arithm_res[`REG_WIDTH-1:0], arithm_ovf, arithm_cf);

logic logic_0(first_op[`REG_WIDTH-1:0], second_op[`REG_WIDTH-1:0], alu_sel[`LOGIC_DIAP], logic_res[`REG_WIDTH-1:0]);

//MAIN BLOCK
always @* begin
	
	casez(alu_sel[`ALU_OP_DIAP])
	
		`SHIFT: begin
			alu_o_data = shift_res;
			ovf_flag = 0;
			cf_flag = 0;
		end
		
		`ARITHM: begin
			alu_o_data = arithm_res;
			ovf_flag = arithm_ovf;
			cf_flag = arithm_cf;
		end
		
		`LOGIC: begin
			alu_o_data = logic_res;
			ovf_flag = 0;
			cf_flag = 0;
		end
		
		default: begin
			alu_o_data = 0;
			ovf_flag = 0;
			cf_flag = 0;
		end
	endcase
	
	zero_flag = ~| alu_o_data;
end
endmodule
