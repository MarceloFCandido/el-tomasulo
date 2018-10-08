module tomasulim(CLK, CLR);

	input CLK, CLR;
	wire [4:0] addrOut;
	wire [15:0] q;
	wire cheio, vazio, adc, rtr;
	
	ram1pm instrUnit(addrOut, CLK, 16'b0, 1'b0, q);
	programCounter pc(CLK, CLR, ~cheio, addrOut);
	instrQueue iq(CLK, CLR, cheio, vazio, adc, rtr, q, instrOut);
	
	
endmodule
