`timescale 1ns/1ps

module test;

reg [2:0] bs_opsel_sig;
reg [4:0] shift_amount_sig;
reg [31:0] data_in_sig;
wire [31:0] result_sig;

barrel_shifter barrel_shifter_inst
(
	.bs_opsel(bs_opsel_sig) ,	// input [2:0] bs_opsel_sig
	.shift_amount(shift_amount_sig) ,	// input [4:0] shift_amount_sig
	.data_in(data_in_sig) ,	// input [31:0] data_in_sig
	.result(result_sig) 	// output [31:0] result_sig
);

integer i;
initial begin
	shift_amount_sig = 5'h12;
	bs_opsel_sig = 0;
	data_in_sig = 32'hdeadbaba;
	
	for(i = 0; i <= 7; i = i + 1) begin
		bs_opsel_sig = i;
		#2;
	end

	shift_amount_sig = 0;
	bs_opsel_sig = 0;
	data_in_sig = 0;
end


initial begin
	#100 $stop();
end

endmodule
