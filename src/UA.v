module UA(Dado1, Dado2, op, Resultado);
	input [15:0]Dado1, Dado2;
	input [2:0]op;
	
	output reg [15:0]Resultado;
	
	always @(Dado1,Dado2,op)begin
		case(op)
			3'b001 :	Resultado = Dado1 + Dado2;		//Soma
			3'b010 :	Resultado = Dado1 - Dado2;		//Subtracao
			
			3'b011 : Resultado = Dado1 + Dado2;		//Calculo de endereco para L e S
			3'b100 : Resultado = Dado1 + Dado2;
			default: 
		endcase
	end
	
endmodule
