module programCounter(CLK, CLR, incr, addrOut);
	input CLK, CLR, incr;
	output reg [4:0] addrOut;
	
	always @(negedge CLK, posedge CLR) begin
		if (CLR) begin
			addrOut = 5'b0;
		end else if (incr) begin
			addrOut = addrOut + 1'b1;
		end
	end
	
endmodule
