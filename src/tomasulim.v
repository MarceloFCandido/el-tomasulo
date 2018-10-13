module tomasulim(CLK, CLR);

	input CLK, CLR;
	
	reg [9:0] counter;
	reg [9:0] maisAntiga;
	reg [1:0] quemSai;
	reg [3:0] teste;
	
	wire [4:0] addrOut;
	wire [2:0] depR0, depR1;
	wire [15:0] q, instrOut, IRout, dataR0, dataR1;
	wire cheio, vazio;
	
	reg [2:0]step;
	reg adc, rtr;											//Controle da fila de instrucoes
	wire [8:0]busy;										//Controle de preenchimento das estacoes de reserva
	reg [8:0] start;										//Controle de inicio da estacao utilizada
	reg [2:0] dependencia0, dependencia1;			//Dependencias geradas
	reg [15:0] dado0,dado1;								//Possiveis dados referentes aos registradores
	
	reg IRin; 					//Habilita escrita do Registrador de Instrucoes
	reg [2:0] numR0,numR1;	//Indice correspondente aos registradores
	reg wren;					//Habilita escrita do banco de registradores
	reg [15:0] dataW;			//Dado de escrita
	reg [2:0] depW, numW;		//Dependencia / Registrador de escrita				
	
	// Variaveis para a estacao de addSub
	wire [9:0] clockInstr[3:0];
	wire [15:0] Valor1[3:0];
	wire [15:0] Valor2[3:0];	
	wire [2:0] OP[3:0];
	wire [3:0] despacho, confirma;
	wire [2:0] ID_out[3:0];
	wire [18:0] CDB;
	
	// Variaveis para a UA de load e store
	reg strAddSub;
	reg [1:0] IDaddSub;
	reg [15:0] Dado1, Dado2; 
	reg [2:0] OPAddSub; 
	wire [15:0] resultAddSub; 
	wire confAddSub, busyAddSub;
	
	always @(posedge CLK, posedge CLR) begin
		//Resetando as variaveis
		if(CLR)begin
			adc = 1'b0;
			rtr = 1'b0;
			step = 3'b0;
			IRin = 1'b0;
			numR0 = 3'b0;			
			numR1 = 3'b0;
			start = 9'b0;
			dataW = 16'b0;
			wren = 1'b0;
			counter = 10'b0;
			maisAntiga = 10'b1111111111;
			// quemSai = 2'b00;
			teste = 4'b0000;
		end else begin		
			case(step)
				//PC incrementa e manda o endereco para a memoria
				3'b000:	begin
					step = 3'b001;
				end
				//Saida da memoria vai para a fila
				3'b001:	begin
					step = 3'b010;
					adc = 1'b1;
				end
				//Preparando para retirar da fila
				3'b010:	begin
					step = 3'b011;
					rtr = 1'b1;
				end
				//Habilitando a entrada de IR e retirando da fila
				3'b011:	begin
					step = 3'b100;
					rtr = 1'b0;
					IRin = 1'b1;			//So toma efeito no proximo ciclo
				end
				
				//Preparando a requisicao de dados
				3'b100: begin
					IRin = 1'b0;
					counter = counter + 1'b1;
					numR0 = IRout[5:3];			//BUSCANDO NO BANCO DE REGISTRADORES, so tem efeito no proximo ciclo
					numR1 = IRout[8:6];
					step = 3'b101;
				end
				
				//Buscando Estacao
				3'b101: begin
					if(~busy[1])begin
						start[1] = 1'b1;
						depW = 3'b001;
						numW = numR0;
						step = 3'b110;
					end else if(~busy[2]) begin
						start[2] = 1'b1;
						depW = 3'b010;
						numW = numR0;
						step = 3'b110;
					end else if(~busy[3]) begin
						start[3] = 1'b1;
						depW = 3'b011;
						numW = numR0;
						step = 3'b110;
					end else if(~busy[4]) begin
						start[4] = 1'b1;
						depW = 3'b100;
						numW = numR0;
						step = 3'b110;
					end else begin
						//Logica de stall, ja que nao existe nenhuma estacao disponivel
						// Nao e necessario fazer nada
					end
					
				end
				// 
				3'b110 : begin
					wren = 1'b1; //Escrevendo dependencia
					
				end
			endcase
			// Conferindo se alguma estacao quer despachar
			if ((despacho[0] || despacho[1] || despacho[2] || despacho[3]) && ~busyAddSub) begin
				if (despacho[0] && clockInstr[0] < maisAntiga) begin
					teste = 4'b0001;
					maisAntiga = clockInstr[0];
					quemSai = 2'b00;
				end
				if (despacho[1] && clockInstr[1] < maisAntiga) begin
					maisAntiga = clockInstr[1];
					quemSai = 2'b01;
				end
				if (despacho[2] && clockInstr[2] < maisAntiga) begin
					maisAntiga = clockInstr[2];
					quemSai = 2'b10;
				end
				if (despacho[3] && clockInstr[3] < maisAntiga) begin
					maisAntiga = clockInstr[3];
					quemSai = 2'b11;
				end
				// Iniciando a UA correspondente;
				strAddSub = 1'b1;
				Dado1 = Valor1[quemSai];
				Dado2 = Valor2[quemSai];
				IDaddSub = ID_out[quemSai];
				OPAddSub = OP[quemSai];
				maisAntiga = 10'b1111111111;
			end			
		end
	end
	
	ram1pm instrUnit(addrOut, CLK, 16'b0, 1'b0, q);						//Memoria de instrucoes
	programCounter pc(CLK, CLR, ~cheio, addrOut);						//PC
	instrQueue iq(CLK, CLR, cheio, vazio, adc, rtr, q, instrOut);	//Fila de instrucoes
	instrRegister IR(CLK, CLR, IRin, instrOut, IRout);					//Registrador de instrucoes
	
	//Banco de registradores
	registerFile RF(CLK, CLR, wren, numW, depW, dataW, numR0, depR0, dataR0, numR1, depR1, dataR1);
	
	//Estacoes de reserva
	ASRS Est1(3'b001, CLK, CLR, start[1], busy[1], clockInstr[0], Valor1[0], Valor2[0], OP[0], despacho[0], ID_out[0], confirma[0], CDB, counter, IRout, depR0, dataR0, depR1, dataR1 );
	ASRS Est2(3'b010, CLK, CLR, start[2], busy[2], clockInstr[1], Valor1[1], Valor2[1], OP[1], despacho[1], ID_out[1], confirma[1], CDB, counter, IRout, depR0, dataR0, depR1, dataR1 );
	ASRS Est3(3'b011, CLK, CLR, start[3], busy[3], clockInstr[2], Valor1[2], Valor2[2], OP[2], despacho[2], ID_out[2], confirma[2], CDB, counter, IRout, depR0, dataR0, depR1, dataR1 );
	ASRS Est4(3'b100, CLK, CLR, start[4], busy[4], clockInstr[3], Valor1[3], Valor2[3], OP[3], despacho[3], ID_out[3], confirma[3], CDB, counter, IRout, depR0, dataR0, depR1, dataR1 );
	
	// Unidades de aritmetica
	UA addSub(CLK, CLR, strAddSub, IDaddSub, Dado1, Dado2, OPAddSub, resultAddSub, confAddSub, busyAddSub);
	
endmodule
