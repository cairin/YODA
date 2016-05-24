/*
	Project: 	The Fourier Awakens
	Course:		EEE4084F YODA
	University: UCT
	Date: 		20/05/2016
	Authors: 	Benji Lewis, Robbie Katz, Cairin Michie
	File:			Debouncer.v
	Details:		Debounce buttons
*/

module Debouncer(
	input Clk_100M,
	input pressed,
	output reg debounced
    );
	reg[23:0]delay;
	reg buttonState;
	reg delayState;
	always @(posedge Clk_100M) begin
			if(buttonState=='b1 && pressed =='b0 && delay=='b0)begin
				debounced <='b0;
				delayState<='b1;
				buttonState<='b0;
			end
			else if(buttonState=='b0 && pressed =='b1 && delay=='b0)begin
				debounced <='b1;
				delayState<='b1;
				buttonState<='b1;
			end
			if(delayState == 'b1)begin
			
				delay <= delay + 1'b1;
				if(delay == 'h1e8480 )begin
					delay <= 'b0;
					delayState<='b0;
				end
				
			end

			
	end

endmodule
