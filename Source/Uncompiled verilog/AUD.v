/*
	Project: 	The Fourier Awakens
	Course:		EEE4084F YODA
	University: UCT
	Date: 		20/05/2016
	Authors: 	Benji Lewis, Robbie Katz, Cairin Michie
	File:			AUD.v
	Details:		PWM Audio Output
*/

module AUD(
	input CLK, 
	input [10:0]PWM,
	output reg AUD_out
    );
	reg [10:0]PWMcount;
	
	always @(posedge CLK)begin
		PWMcount<=PWMcount + 1'b1;
		if(PWM<PWMcount)
			AUD_out<=1'b1;
		else 
			AUD_out<='b0;
	
		
	end
	
endmodule
