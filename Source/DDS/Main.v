
module Main(
		input Clk_100M,
		input BTNS,
		input UART_Rx,
		output reg AUD_PWM,
		output reg AUD_SD=1'b1,
		output [7:0]SegmentDrivers,
		output [7:0] SevenSegment
    );
reg reset;	 
reg busyState;
wire busyR;
wire [7:0]dataR;
parameter N = 31;
reg [10:0] PWM;
reg [10:0] PWMsum;
wire [9:0] PWMout [0:N];

reg [15:0] a [0:N];
reg [15:0] b [0:N];
reg [4:0] Mloop [0:N]; //Change me.
reg [28:0] delay ;
reg [31:0]AdrS;
reg [31:0]M='d1;
reg [4:0]j;
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
	
	generate
		// start of generate block
		genvar i;
		// special variable that doesn't represent any real hardware,
		//	just used for evaluation purposes
		for (i=0; i<N; i=i+1) begin
			DDS DDS( Clk_100M,0,Mloop[i],
			PWMout[i],a[i],0,reset);
		end
//		assign carries[0] = cin;
//		assign cout = carries[N];
	endgenerate //end of generate block


//DDS DDS1(
//	Clk_100M, 0, M,
//	PWMout[0], 'd60000, 0,reset
//);


	

	Receive Receive1(
		Clk_100M,
		UART_Rx,
		dataR,
		busyR
	);
	always @(*)begin
		b[0]='b0;
	
		a[0]='d60000;
		a[1]='d20000;
		a[2]='d12000;
		a[3]='d8571;
		a[4]='d6666;
		a[5]='d5454;
		a[6]='d4615;
		a[7]='d4000;
		a[8]='d3529;
		a[9]='d3158;
		a[10]='d2857;
		a[11]='d2608;
		a[12]='d2400;
		a[13]='d2222;
		a[14]='d2069;
		a[15]='d1935;
		a[16]='d1818;
		a[17]='d1714;
		a[18]='d1621;
		a[19]='d1538;
		a[20]='d1463;
		a[21]='d1395;
		a[22]='d1333;
		a[23]='d1277;
		a[24]='d1224;
		a[25]='d1176;
		a[26]='d1132;
		a[27]='d1091;
		a[28]='d1053;
		a[29]='d1017;
		a[30]='d984;
		a[31]='d952;
		
		Mloop[0]=M;
		Mloop[1]=3*M;
		Mloop[2]=5*M;
		Mloop[3]=7*M;
		Mloop[4]=9*M;
		Mloop[5]=11*M;
		Mloop[6]=13*M;
		Mloop[7]=15*M;
		Mloop[8]=17*M;
		Mloop[9]=19*M;
		Mloop[10]=21*M;
		Mloop[11]=23*M;
		Mloop[12]=25*M;
		Mloop[13]=27*M;
		Mloop[14]=29*M;
		Mloop[15]=31*M;
		Mloop[16]=33*M;
		Mloop[17]=35*M;
		Mloop[18]=37*M;
		Mloop[19]=39*M;
		Mloop[20]=41*M;
		Mloop[21]=43*M;
		Mloop[22]=45*M;
		Mloop[23]=47*M;
		Mloop[24]=49*M;
		Mloop[25]=51*M;
		Mloop[26]=53*M;
		Mloop[27]=55*M;
		Mloop[28]=57*M;
		Mloop[29]=59*M;
		Mloop[30]=61*M;
		Mloop[31]=63*M;
		
		AdrS<=32'b0;
		AUD_PWM<=AUD_out;
		
		PWMsum = 0;
		for (j = 0; j< N;j=j+1)begin
			PWMsum = PWMsum + PWMout[j];
		end
		PWM <= PWMsum;
		//PWM <= PWMout[0] +PWMout[1]+PWMout[2]+PWMout[3]+ PWMout[4]+PWMout[5]+PWMout[6]+PWMout[7] 
		//+PWMout[8]+PWMout[9]+PWMout[10]+ PWMout[11]+PWMout[12]+PWMout[13]+PWMout[14]+PWMout[15];
	end

	always @(posedge Clk_100M)begin

		if(busyState && busyR == 0)begin
			reset <=1;
			case (dataR)
			 
			 "1": M<=1;
			 "2": M<=2;
			 "3": M<=3;
			 "4": M<=4;
			 "5": M<=5;
			 "6": M<=6;
			 "7": M<=7;
			 "8": M<=8;
			 "9": M<=9;
			 			
			 default: M<=2;
			endcase
			
			busyState <= busyR;

		end
		else begin
					reset<=0;
			busyState <= busyR;
		end
			
	end
endmodule
