module decodifier(CLK, CLR, ASFull, LSfull, instr, CDB);
	input CLK, CLR, ASFull, LSFull;
	input [15:0] instr;
	output [15:0] CDB;
	
	reg [2:0] opcode, rd, rs;
	reg [6:0] offset;
	
	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin
			opcode = 3'b0;
			rd = 3'b0;
			rs = 3'b0;
			offset = 7'b0;
		end else begin
			
		end
	end
	
endmodule
