
module ADDER(
	input CLK,
	input [31:0]M,
//	input [31:0]ADRold,
	output reg[31:0]ADRnew	
    );
reg [31:0]Mr;
reg [31:0]ADRo;
wire ADRold;
phase phase1(

);


always @(posedge CLK)begin
		ADRnew<=ADRold + M;
		if(PWM<PWMcount)
			AUD_out<=1'b1;
		else 
			AUD_out<='b0;
	end

endmodule
