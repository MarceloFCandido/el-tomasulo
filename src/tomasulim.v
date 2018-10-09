module tomasulim(CLK, CLR, adc, rtr, IRin);

	input CLK, CLR, adc, rtr, IRin;
	wire [4:0] addrOut;
	wire [15:0] q, instrOut, IRout;
	wire cheio, vazio;
	
	ram1pm instrUnit(addrOut, CLK, 16'b0, 1'b0, q);
	programCounter pc(CLK, CLR, ~cheio, addrOut);
	instrQueue iq(CLK, CLR, cheio, vazio, adc, rtr, q, instrOut);
	instrRegister IR(CLK, CLR, IRin, instrOut, IRout);
	
	
	
endmodule
