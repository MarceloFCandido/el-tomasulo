module tomasulim(CLK, CLR, adc, rtr, IRin, wren, numW, depW, dataW, numR0, numR1);

	input CLK, CLR, adc, rtr, IRin, wren;
	input [2:0] numW, depW, numR0, numR1;
	input [15:0] dataW;
	wire [4:0] addrOut;
	wire [2:0] depR0, depR1;
	wire [15:0] q, instrOut, IRout, dataR0, dataR1;
	wire cheio, vazio, adc, rtr, IRin;
	
	ram1pm instrUnit(addrOut, CLK, 16'b0, 1'b0, q);						//Memoria de instrucoes
	programCounter pc(CLK, CLR, ~cheio, addrOut);						//PC
	instrQueue iq(CLK, CLR, cheio, vazio, adc, rtr, q, instrOut);	//Fila de instrucoes
	instrRegister IR(CLK, CLR, IRin, instrOut, IRout);					//Registrador de instrucoes
	
	
	//Banco de registradores
	registerFile RF(CLK, CLR, wren, numW, depW, dataW, numR0, depR0, dataR0, numR1, depR1, dataR1);
	
	ASRS est1(CLK, CLR, start, busy, Valor1, Valor2, CDB, IRout, numR0, depR0, dataR0, numR1, depR1, dataR1);
	
	
	reg [2:0] dependencia0, dependencia1;
	reg [15:0] dado0,dado1;
	
	always @(posedge CLK, posedge CLR) begin
		//Estagio 1
		//numR0 = IRout[5:3]			BUSCANDO NO BANCO DE REGISTRADORES
		//numR1 = IRout[8:6]
		
		
		//Estagio 2	
		//Estacao x disponivel?
			//Tornar a estacao x indisponivel
			//Passa para a estacao o IRout e os dados de saida do banco de registradore requisitados anteriormente.
			//Prepara para escrita no banco de registradores 
				//depW = X
				//numW = IRout[5:3]
				//wren = 1'b1
		
		
		
		
	end
	
endmodule
