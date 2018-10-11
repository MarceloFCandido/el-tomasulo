module UA(CLK, CLR, ID_out, Dado1, Dado2, op, Resultado, confirmacao);
	input CLK, CLR;
	input [15:0]Dado1, Dado2;
	input [2:0]op;
	input [2:0]ID_out;
	
	output reg confirmacao;
	output reg [18:0]Resultado;
	reg [1:0]cont;
	
	always @(posedge CLK)begin
		if(CLR)begin
			cont = 2'b00;
			Resultado = 16'b0;		
			confirmacao = 1'b0;
		end else begin
		
			confirmacao = 1'b0;
			if(cont == 2'b10)begin
				case(op)
					3'b001 :	Resultado[15:0] = Dado1 + Dado2;		//Soma
					3'b010 :	Resultado[15:0] = Dado1 - Dado2;		//Subtracao
					
					3'b011 : Resultado[15:0] = Dado1 + Dado2;		//Calculo de endereco para L e S
					3'b100 : Resultado[15:0] = Dado1 + Dado2;
					default: ;
				endcase
				
				Resultado[18:16] = ID_out;
				confirmacao = 1'b1;
				cont = 2'b0;
			end else begin 
				cont = cont + 1'b1;
			end
		end
	end
	
endmodule
