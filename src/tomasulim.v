module tomasulim(CLK, CLR, adc, rtr, IRin, wren, numW, depW, dataW, numR0, numR1);

	input CLK, CLR, adc, rtr, IRin, wren;
	input [2:0] numW, depW, numR0, numR1;
	input [15:0] dataW;
	wire [4:0] addrOut;
	wire [2:0] depR0, depR1;
	wire [15:0] q, instrOut, IRout, dataR0, dataR1;
	wire cheio, vazio, adc, rtr, IRin;
	
	ram1pm instrUnit(addrOut, CLK, 16'b0, 1'b0, q);
	programCounter pc(CLK, CLR, ~cheio, addrOut);
	instrQueue iq(CLK, CLR, cheio, vazio, adc, rtr, q, instrOut);
	instrRegister IR(CLK, CLR, IRin, instrOut, IRout);
	
	registerFile RF(CLK, CLR, wren, numW, depW, dataW, numR0, depR0, dataR0, numR1, depR1, dataR1);
	
//	always @(posedge CLK, posedge CLR) begin
//		// IF
//		
//		// ID
//		
//		// EX
//		
//		// WB
//		
//	end
	
endmodule
