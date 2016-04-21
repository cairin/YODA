
module Main(
		input Clk_100M,
		input BTNS,
		input UART_Rx,
		output reg AUD_PWM,
		output reg AUD_SD=1'b1,
		output [7:0]SegmentDrivers,
		output [7:0] SevenSegment
    );
	 
reg busyState;
wire busyR;
wire [7:0]dataR;
	 
reg [7:0] PWM;
wire [7:0] PWMout;
reg [28:0] delay ;
reg [31:0]AdrS;
reg [31:0]M='d1;
wire Reset; // Define a local wire to carry the Reset signal
wire AUD_out;
Delay_Reset Delay_Reset1(Clk_100M, BTNS, Reset);

SS_Driver SS_Driver1(
	Clk_100M, Reset,PWM,'d0, 'd1, 'd2,'d3, // Use temporary test values 
	SegmentDrivers, SevenSegment
	);
AUD AUD1(
	Clk_100M, PWM, 
	AUD_out
	);
	
DDS DDS1(
	Clk_100M, AdrS, M,
	PWMout
);


	Receive Receive1(
		Clk_100M,
		UART_Rx,
		dataR,
		busyR
	);
	always @(*)begin
		AdrS<=32'b0;
		AUD_PWM<=AUD_out;
		PWM <= PWMout;
	end

	always @(posedge Clk_100M)begin
		if(busyState && busyR == 0)begin
			
			case (dataR)
			 
			 "1": M<=1;
			 "2": M<=2;
			 "3": M<=3;
			 "4": M<=4;
			 "5": M<=5;
			
			
			 default: M<=2;
			endcase
			
			busyState <= busyR;

		end
		else begin
			busyState <= busyR;
		end
			
	end
endmodule
