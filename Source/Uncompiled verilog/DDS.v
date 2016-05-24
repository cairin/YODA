/*
	Project: 	The Fourier Awakens
	Course:		EEE4084F YODA
	University: UCT
	Date: 		20/05/2016
	Authors: 	Benji Lewis, Robbie Katz, Cairin Michie
	File:			DDS.v
	Details:		DDS Module
*/

module DDS(
	input CLK,
	input [31:0]Start,
	input [31:0]M,
	output reg[9:0]PWM,
	input [16:0] a,
	input [16:0] b,
	input reset

    );

reg [6:0] counter;
reg [11:0]addrA;
wire [9:0]doutA;
reg [11:0]addrB;
wire [9:0]doutB;
blk_mem_gen_v7_3 LU1(
  CLK,addrA,doutA, CLK, addrB, doutB 
);
initial addrA <= 'd0;
initial addrB <=  'd1024;

always@(posedge CLK) begin
		if(reset)begin
			addrA<= Start;
			addrB<=Start + 'd1024;
		end
		else
		if(counter ==0)begin
			//PWM<= doutA/M + b*doutB;
			PWM<= (a*doutA)/131072 + (b*doutB)/131072; //+doutB ;
			addrA<=addrA+M;
			addrB<=addrB+M;
			if(addrA>'d4095)begin
				addrA<=addrA-'d4096;
			end
			if(addrB>'d4095)begin
				addrB<=addrB-'d4096;
			end
			counter <= counter+'b1;
		end
		else 			counter <= counter+'b1;
		
		


end

//    	addra <= addra+2'b10;
//				PWM <= douta;
//				if(addra>'d2047)begin
//					addra<= 32'b0;
//				end


endmodule
