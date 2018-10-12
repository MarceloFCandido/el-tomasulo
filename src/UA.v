module UA(CLK, CLR, start, ID_out, Dado1, Dado2, op, Resultado, confirmacao, busy);

	input CLK, CLR, start;
	input [15:0]Dado1, Dado2;
	input [2:0]op;
	input [2:0]ID_out;
	
	output reg confirmacao;
	output reg busy;
	output reg [18:0] Resultado;
	
	reg [1:0] cont;
	
	always @(posedge CLK)begin
		if(CLR)begin
			cont = 2'b00;
			Resultado = 16'b0;		
			confirmacao = 1'b0;
			busy = 1'b0;
		end else begin
			case (cont)
				2'b00: begin // 1o ciclo
					if (start) begin 
						confirmacao = 1'b0;
						busy = 1'b1;
						cont = 2'b01;
					end
				end
				2'b01: begin // 2o ciclo
					cont = 2'b10;
				end
				2'b10: begin // 3o ciclo
					case(op)
						// Caso add/sub
						3'b001 :	Resultado[15:0] = Dado1 + Dado2;		//Soma
						3'b010 :	Resultado[15:0] = Dado1 - Dado2;		//Subtracao
						// Caso load/store
						3'b011 : Resultado[15:0] = Dado1 + Dado2;		//Calculo de endereco para L e S
						3'b100 : Resultado[15:0] = Dado1 + Dado2;
						default: ;
					endcase
					confirmacao = 1'b1;
					busy = 1'b0;
					cont = 2'b00;
				end
			endcase
		end
	end
endmodule
