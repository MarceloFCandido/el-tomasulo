module ASRS(CLK, CLR, opcode, rs, rd, full);
	input CLK, CLR;
	input [2:0] opcode;
	input [2:0] rs, rd;
	output reg full;
	
	reg [2:0] op;
	reg [15:0] Vj;
	reg [15:0] Vk;
	reg [3:0] Qj;
	reg [3:0] Qk;
	
	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin
			full = 1'b0;
			op = 3'b0;
			Vj = 16'b0;
			Vk = 16'b0;
			Qj = 4'b0;
			Qk = 4'b0;
		end else if (~full) begin
			if (opcode == 3'b001 || opcode == 3'b010) begin
				
			end
		end
	end
	
endmodule 