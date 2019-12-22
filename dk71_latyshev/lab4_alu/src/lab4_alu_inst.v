
`timescale 1ns/1ps

module test;

reg  [31:0] a ; 
reg  [31:0] b ;
reg  [4:0] op;
wire [31:0] res;
wire ovf, zout;
reg [4:0] shamt;


lab4_alu alu
(
	.in_A(a) ,	// input [31:0] a
	.in_B(b) ,	// input [31:0] b
	.in_func(op) ,	// input [4:0] op
	.out_result(res) ,	// output [31:0] res
	.out_overflow(ovf) ,	// output  ovf
	.out_zero(zout) ,	// output  zout
	.shamt(shamt) 	// input [4:0] shamt
);



initial begin 

	a= 32'habcdabcd;
	b= 32'h12345678;
	shamt=5'h8;

	op = 5'b00000;     //SLL  
	#10 op = 5'b00010; //SRL 
	#10 op = 5'b00001; //ROL
	#10 op = 5'b00011; //ROR
	#10 op = 5'b00110; //SRA

	#10 op = 5'b10000; //MULL
	#10 op = 5'b10010; //MULH
	#10 op = 5'b10001; //DIV
	#10 op = 5'b10011; //DIVR

	#10 a= 32'h88888888;
	b= 32'h44444444;
	op = 5'b10110;     //ADD
	#10 op = 5'b10111; //SUB

	#10 a= 32'h11111111;
	b= 32'h00000000;
	op = 5'b11000;     //AND
	#10 op = 5'b11001; //OR
	#10 op = 5'b11010; //NOR
	#10 op = 5'b11011; //XOR
	#10;op = 5'b11111; //SLT

end

initial begin 
	#500 $stop();
end

endmodule
