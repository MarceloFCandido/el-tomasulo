module tomasulim(CLK, CLR, adc, rtr);

	input CLK, CLR, adc, rtr;
	wire [4:0] addrOut;
	wire [15:0] q, instrOut;
	wire cheio, vazio;
	
	ram1pm instrUnit(addrOut, CLK, 16'b0, 1'b0, q);
	programCounter pc(CLK, CLR, ~cheio, addrOut);
	instrQueue iq(CLK, CLR, cheio, vazio, adc, rtr, q, instrOut);
	
	
endmodule
