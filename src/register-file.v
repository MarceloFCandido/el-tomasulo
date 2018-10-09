module registerFile(CLK, CLR, wren, numW, depW, dataW, numR0, depR0, dataR0, numR1, depR1, dataR1);
	input CLK, CLR, wren;
	input [2:0] numW, numR0, numR1, depW; 
	input [15:0] dataW;
	output reg [2:0] depR0, depR1;
	output reg [15:0] dataR0, dataR1;
	
	reg [15:0] regs[7:0];
	reg [2:0] depRegs[7:0];
	reg [2:0] R0, R1;
	
	always @(posedge CLK, posedge CLR) begin 
		if (CLR) begin
			regs[0] = 16'b0;
			regs[1] = 16'b0;
			regs[2] = 16'b0;
			regs[3] = 16'b0;
			regs[4] = 16'b0;
			regs[5] = 16'b0;
			regs[6] = 16'b0;
			regs[7] = 16'b0;
			
			depRegs[0] = 3'b0;
			depRegs[1] = 3'b0;
			depRegs[2] = 3'b0;
			depRegs[3] = 3'b0;
			depRegs[4] = 3'b0;
			depRegs[5] = 3'b0;
			depRegs[6] = 3'b0;
			depRegs[7] = 3'b0;
		end else if (wren) begin
			// Nao quer escrever dependencia
			if (depW == 3'b000) begin
				depRegs[numW] = 3'b000;
				regs[numW] = dataW;
			// Quer escrever dependencia
			end else begin
				depRegs[numW] = depW;
			end
			R0 = numR0;
			// Confere se ha dependencia no registrador
			if (depRegs[R0] != 3'b000) begin
				depR0 = depRegs[R0];
			// Nao ha depedencia
			end else begin
				depR0 = 3'b000;
				dataR0 = regs[R0];
			end
			
			R1 = numR1;
			// Confere se ha dependencia no registrador
			if (depRegs[R1] != 3'b000) begin
				depR1 = depRegs[R1];
			// Nao ha depedencia
			end else begin
				depR1 = 3'b000;
				dataR1 = regs[R1];
			end
		end
		
	end
	
endmodule
