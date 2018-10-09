module ASRS(CLK, CLR, opcode, rd, rs, offset, full);
	input CLK, CLR;
	input [2:0] opcode, rd, rs;
	input [6:0] offset;
	output full;
	
	
	reg [3:0] busy;
	reg [2:0] opers[3:0];
	reg [15:0] Vjs[3:0];
	reg [15:0] Vks[3:0];
	reg [3:0] Qjs[3:0];
	reg [3:0] Qks[3:0];
	
	assign full = busy[0] & busy[1] & busy[2] & busy[3];
	
	
	
	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin
			busy = 4'b0;
			
			opers[0] = 3'b0;
			opers[1] = 3'b0;
			opers[2] = 3'b0;
			opers[3] = 3'b0;
			
			Vjs[0] = 16'b0;
			Vjs[1] = 16'b0;
			Vjs[2] = 16'b0;
			Vjs[3] = 16'b0;
			
			Vks[0] = 16'b0;
			Vks[1] = 16'b0;
			Vks[2] = 16'b0;
			Vks[3] = 16'b0;
			
			Qjs[0] = 4'b0;
			Qjs[1] = 4'b0;
			Qjs[2] = 4'b0;
			Qjs[3] = 4'b0;
			
			Qks[0] = 4'b0;
			Qks[1] = 4'b0;
			Qks[2] = 4'b0;
			Qks[3] = 4'b0;
		end
		
		
		
		if (~busy[0]) begin
			
		end else if (~busy[1]) begin
			
		end else if (~busy[2]) begin
			
		end else if (~busy[3]) begin
			
		end
		
	end
	
endmodule 