module decodifier(CLK, CLR, ASFull, LSfull, instr, opcode, rd, rs, offset);
	
	input CLK, CLR, ASFull, LSFull;
	input [15:0] instr;
	
	output reg [2:0] opcode, rd, rs;
	output reg [6:0] offset;
	
	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin
			opcode = 3'b0;
			rd = 3'b0;
			rs = 3'b0;
			offset = 7'b0;
		end else begin
			opcode = instr[2:0];
			rd = instr[5:3];
			rs = instr[8:6];
			offset = instr[15:9];
		end
	end
	
endmodule
