`timescale 1ns/1ps

`define REG_WIDTH 32

module incrementer #(parameter WIDTH = 1)(i_data, o_data);

input [WIDTH-1:0] i_data;

output [WIDTH-1:0] o_data;

assign o_data = i_data + 1;

endmodule

