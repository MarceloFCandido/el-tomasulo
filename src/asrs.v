module ASRS(ID_in, CLK, CLR, start, busy, Valor1, Valor2, OP, despacho, ID_out, confirma, CDB, IRout, depR0, dataR0, depR1, dataR1 );	//Estacao de reserva para adicao e subtracao
	//Recebe instrucao, OPcode direcionado, Rd e Rs para numR0 numR1
	
	//Pegar os valores lidos de numR0 e numR1 e verificar se ha dependencia ou dado e direcionar
	
	//Se ha dependencia monitorar o CDB constantemente ate o resultado sair, quando sair, armazenar o resultado
	//else se os dados sao validos: mandar para UA e esvazia a Estacao de reserva e reinicia o contador de etapas
	
	//Repete o else para o CDB
	
	input CLK, CLR, start;
	input confirma;
	input [2:0]ID_in;
	
	output reg [2:0]ID_out;
	output reg busy;
	output reg despacho;
	output reg [2:0]OP;
	output reg [15:0] Valor1,Valor2;
	
	input [18:0] CDB;
	input [15:0]IRout;		//OPCode 3 - Rd 3 - Rs 3 - Offset 7

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
				2'b01: begin
						if(Qj != 3'b000 || Qk != 3'b000)begin
							if(CDB[18:16] == Qj)begin
								Vj = CDB[15:0];
								Qj = 3'b000;
							end						
							if(CDB[18:16] == Qk)begin
								Vk = CDB[15:0];
								Qk = 3'b000;
							end
						end else begin
							despacho = 1'b1;
							Valor1 = Vj;
							Valor2 = Vk;
							OP = OPcode;
							ID_out = ID_in;
							cont = 2'b10;
						end
				end
				2'b10: begin
						if(confirma)begin
								busy = 1'b0;
								Vj = 16'b0;		
								Vk = 16'b0;
								Qj = 3'b0;
								Qk = 3'b0;
								OPcode = 3'b0;
								cont = 2'b0;
								despacho = 1'b0;
						end	
				end
				
			
			
			endcase
		end
		
	end
	
	
endmodule 