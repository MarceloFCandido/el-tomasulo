module instrRegister(CLK, CLR, IRin, instrIn, instrOut);
	input CLK, CLR, IRin;
	input [15:0] instrIn;
	output reg [15:0] instrOut;
	
	always @(negedge CLK, posedge CLR) begin
		if (CLR) begin
			instrOut = 16'b0;
		end else if (IRin) begin
			instrOut = instrIn;
		end
	end
	
endmodule 