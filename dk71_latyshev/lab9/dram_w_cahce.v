`timescale 1ns/1ps


module cache #(parameter WIDTH = 32, VOLUME = 64)(i_data, o_data, addr, we, clk, re, stall);

input [WIDTH-1:0] i_data;
input [WIDTH-1:0] addr;
input we, re;
input clk;

output [31:0] o_data;
output stall;

reg [WIDTH-1:0] fifo [VOLUME-1:0];
reg [VOLUME-1:0] valid;
reg [WIDTH-1:0] tag [VOLUME-1:0];
reg [WIDTH-1:0] CacheData [VOLUME-1:0];
reg [WIDTH-1:0] out_addr;
reg hit;
reg [WIDTH-1:0] fifoMax; 
reg [WIDTH-1:0] fifoMaxIndex; 
reg rew;

wire [WIDTH-1:0] DRamOut;
wire [WIDTH-1:0] DRamIn;
wire [WIDTH-1:0] DRamAddr;
wire DRamWE;

reg [WIDTH-1:0] addr_reg;

assign DRamAddr = addr;
assign DRamWE = we;
assign DRamIn = i_data;
assign stall = 0;

assign o_data = CacheData[out_addr];

integer i;


dram dram_0(DRamIn, DRamOut, DRamAddr, DRamWE, clk);

initial begin
	for(i = 0; i < 64; i = i + 1)begin
		CacheData[i] = 0;
		tag[i] = 0;
		fifo[i] = i;
	end
	hit = 0;
	valid = 0;
	out_addr = 0;
	fifoMaxIndex = 0;
	fifoMax = 0;
	rew = 0;
end

always @(posedge clk && !we && rew) begin


	for(i = 0; (i < VOLUME) && (!hit); i = i + 1) begin
		if((tag[i] == addr) && valid[i]) begin
			out_addr <= i;
			hit <= 1;
		end
	end

	 if(!hit)begin
			fifoMax <= fifo[0];

			for(i = 1; i < VOLUME; i = i + 1)begin
				if(fifoMax < fifo[i])begin
					fifoMax <= fifo[i];
					fifoMaxIndex <= i;					
				end
			end

			CacheData[fifoMaxIndex] <= DRamOut;
			tag[fifoMaxIndex] <= addr;
			out_addr <= fifoMaxIndex;
			valid[fifoMaxIndex] <= 1;
			fifo[fifoMaxIndex] <= 0;
			rew = 0;

			for(i = 0; i < VOLUME; i = i + 1)begin
				if(valid[i])
					fifo[i] = fifo[i] + 1;
			end			
	end

end

always @(posedge clk && we) begin
	for(i = 0; i < VOLUME; i = i + 1)
		if(tag[i] == addr)
			valid[i] <= 0;
end

always @(posedge re) begin
	rew <= 1;
	hit = 0;
end


endmodule


module dram #(parameter WIDTH = 32, VOLUME = 512)(i_data, o_data, addr, we, clk);

localparam ADDR_WIDTH = WIDTH;

input [WIDTH-1:0] i_data;
input [ADDR_WIDTH-1:0] addr;
input we, clk;

output [WIDTH-1:0] o_data;

reg [WIDTH-1:0] ram [VOLUME-1:0];

assign o_data = ram[addr];

initial $readmemb("//home/yan/QWER/kpi-computer-architecture-course/dk71_latyshev/lab9/mem_data.dat", ram);

always @(posedge clk) begin
	if(we) ram[addr] <= i_data;
end
endmodule