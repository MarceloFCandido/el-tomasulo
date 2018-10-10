module ASRS(CLK, CLR, start, busy, Valor1, Valor2, CDB, IRout, numR0, depR0, dataR0, numR1, depR1, dataR1);	//Estacao de reserva para adicao e subtracao
	//Recebe instrucao, OPcode direcionado, Rd e Rs para numR0 numR1
	
	//Pegar os valores lidos de numR0 e numR1 e verificar se ha dependencia ou dado e direcionar
	
	//Se ha dependencia monitorar o CDB constantemente ate o resultado sair, quando sair, armazenar o resultado
	//else se os dados sao validos: mandar para UA e esvazia a Estacao de reserva e reinicia o contador de etapas
	
	//Repete o else para o CDB
	
	input CLK, CLR, start;
	output reg busy;
	
	output [15:0] Valor1,Valor2;
	input [15:0] CDB;
	input [15:0]IRout;		//OPCode 3 - Rd 3 - Rs 3 - Offset 7
	output [2:0] numR0, numR1; //NECESSARIO??
	input	 [2:0] depR0, depR1;
	input [15:0] dataR0, dataR1;
	
	reg [1:0] cont;
	
	reg [15:0] Vj, Vk;
	reg [2:0] Qj, Qk;
	reg [2:0] OPcode;
	

	
	always @(posedge CLK, posedge CLR)begin
		if(CLR)begin
				busy = 1'b0;
				Vj = 16'b0;		
				Vk = 16'b0;
				Qj = 3'b0;
				Qk = 3'b0;
				OPcode = 3'b0;
				cont = 2'b0;
		end else begin
			case(cont)
				2'b00: begin
						if(start)begin
							busy = 1'b1;
							Vj = dataR0;		
							Vk = dataR1;
							Qj = depR0;
							Qk = depR1;
							OPcode = IRout[2:0];
							cont = 2'b01;
						end
				end
			
			
			endcase
		end
		
	end
	
	
endmodule 