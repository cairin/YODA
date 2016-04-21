module DDS(
	input CLK,
	input [31:0]Start,
	input [31:0]M,
	output reg[7:0]PWM
    );


reg [31:0]addra;
wire [31:0]douta;
BROM_Sin LU1(
  CLK,1'b1,addra,douta
);
initial addra <= Start;

always@(posedge CLK) begin

		PWM<=douta;
		addra<=addra+M;
		if(addra>'d1023)begin
			addra<=addra-'d1024;
		end
end

//    	addra <= addra+2'b10;
//				PWM <= douta;
//				if(addra>'d2047)begin
//					addra<= 32'b0;
//				end


endmodule
