module instrQueue(CLK, CLR, cheio, vazio, adc, rtr, instrIn, instrOut);
	
	input CLK, CLR, adc, rtr;
	input [15:0] instrIn;
	output cheio, vazio;
	output reg [15:0] instrOut;
	
	reg [2:0] frente, tras;
	reg [7:0] iValid;
	reg [15:0] instrs[7:0];
	
	assign cheio = iValid[0] & iValid[1] & iValid[2] & iValid[3] & iValid[4] & iValid[5] & iValid[6] & iValid[7];
	assign vazio = (frente == tras);
	
	always @(posedge CLK, posedge CLR) begin
		if (CLR) begin
			iValid[7:0] = 8'b0;
			frente = 3'b0;
			tras = 3'b0;
		end else begin
			if (adc) begin
				instrs[tras] = instrIn;
				iValid[tras] = 1'b1;
				tras = tras + 1'b1;
			end else if (rtr) begin
				instrOut = instrs[frente];
				iValid[frente] = 1'b0;
				frente = frente + 1'b1;
			end
		end
	end
	
endmodule
