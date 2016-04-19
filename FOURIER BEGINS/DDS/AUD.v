module AUD(
	input CLK, 
	input [7:0]PWM,
	output reg AUD_out
    );
	reg [7:0]PWMcount;
	
	always @(posedge CLK)begin
		PWMcount<=PWMcount + 1'b1;
		if(PWM<PWMcount)
			AUD_out<=1'b1;
		else 
			AUD_out<='b0;
		
	end
	
endmodule
