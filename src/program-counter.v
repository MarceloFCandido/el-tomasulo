module programCounter(CLK, CLR, incr, addrOut);
	input CLK, CLR, incr;
	output [4:0] addrOut;
	
	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin
			addrOut = 5'b0;
		end else begin
			if (incr) begin
				addrOut = addrOut + 1'b1;
			end
		end
	end
	
endmodule
