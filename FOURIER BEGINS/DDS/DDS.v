
module DDS(
		input Clk_100M,
		input BTNS,
		output reg AUD_PWM,
		output reg AUD_SD=1'b1,
		output [7:0]SegmentDrivers,
		output [7:0] SevenSegment
    );
reg [7:0] PWM;
reg [3:0] delay ;
wire Reset; // Define a local wire to carry the Reset signal
wire AUD_out;
Delay_Reset Delay_Reset1(Clk_100M, BTNS, Reset);

SS_Driver SS_Driver1(
	Clk_100M, Reset,PWM,a, b, c,d, // Use temporary test values 
	SegmentDrivers, SevenSegment
	);
AUD AUD1(
	Clk_100M, PWM, 
	AUD_out
	);
	
reg [31:0]addra;
wire [31:0]douta;
BROM_Sin BROM_Sin1(
  Clk_100M,1'b1,addra,douta
);

	always @(*)begin
		AUD_PWM<=AUD_out;
	end

	always @(posedge Clk_100M)begin
			delay <= delay+1'b1;
			if(delay ==0)begin
				addra <= addra+2'b10;
				PWM <= douta;
				if(addra>'d2047)begin
					addra<= 32'b0;
				end
			
			end
	end
endmodule
