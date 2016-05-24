/*
	Project: 	The Fourier Awakens
	Course:		EEE4084F YODA
	University: UCT
	Date: 		20/05/2016
	Authors: 	Benji Lewis, Robbie Katz, Cairin Michie
	File:			Main.v
	Details:		Central Processing
*/

//========================================Define Module's I/O========================================
module Main(
		//100MHz clock
		input Clk_100M,									
		//On-board buttons
		input BTNL,											
		input BTNR,
		input BTNN,
		input BTNS,
		//UART Receive
		input UART_Rx,
		//Audio Output
		output reg AUD_PWM,
		output reg AUD_SD=1'b1,
		//Seven Segment Display
		output [7:0]SegmentDrivers,
		output [7:0] SevenSegment
	);

//====================Parameter Definitions====================
	parameter 	N = 32;				//Number of DDS Modules
	
//========================================Register Definitions========================================
	reg  [4:0]	NumMod = 'd31;
	//Seven Segment display chars
	reg  [0:7]	c1;					
	reg  [0:7]	c2;	
	reg  [0:7]	c3;	
	reg  [0:7]	c4;
	
	reg 			reset;	 
	reg 			busyState;
	//PWM Registers
	reg  [10:0] PWM;
	reg  [10:0] PWMsum;
	//Waveform coefficient registers 
	reg  [15:0] a 			[0:N];	
	reg  [15:0] b 			[0:N];
	reg  [15:0] square	[0:N];
	reg  [15:0] triangle	[0:N];
	reg  [15:0] saw		[0:N];
	reg  [15:0] clarinet	[0:N];
	reg  [15:0] guitar	[0:N];
	
	reg  [14:0] Mloop 	[0:N];	//Store M values
	reg  [31:0]	M	=	'd1;	
	reg  [5:0]	j;
	//Stoer State of the buttons
	reg  			buttonStateL;
	reg  			buttonStateR;
	reg  			buttonStateN;
	reg  			buttonStateS;
	//Store states of user interface
	reg	[1:0] State;
	reg	[2:0] WaveState;
	//Amplitude of output
	reg	[14:0]Amp;

//========================================Wire Definitions========================================
	//UART Wires
	wire 			busyR;
	wire [ 7:0]	dataR;
	
	wire [ 9:0]	PWMout[0:N];		//PWM output wire
	wire 			Reset;
	wire 			AUD_out;				//Audio output wire
	//Debounce button wires
	wire			debouncedL;
	wire			debouncedR;
	wire			debouncedN;
	wire			debouncedS;
	
//========================================Module Definitions========================================
	Delay_Reset Delay_Reset1(	//Delay 
		Clk_100M, BTNS, Reset
		);

	SS_Driver SS_Driver1(		//Seven Segment Display
		Clk_100M, Reset,c1, c2, c3,c4,
		SegmentDrivers, SevenSegment
		);
		
	AUD AUD1(						//Audio Output
		Clk_100M, PWM, 
		AUD_out
		);
		
	Receive Receive1(				//UART Receive
		Clk_100M,
		UART_Rx,
		dataR,
		busyR
	);
	
	Debouncer ModeL(				//Debounce Left Button
		Clk_100M,
		BTNL,
		debouncedL
	);
	Debouncer ModeR(				//Debounce Right Button
		Clk_100M,
		BTNR,
		debouncedR
	);
	Debouncer ValU(				//Debounce North Button
		Clk_100M,
		BTNN,
		debouncedN
	);
	Debouncer ValD(				//Debounce South Button
		Clk_100M,
		BTNS,
		debouncedS
	);
	
//====================Define DDS Modules in loop using Generate====================
	generate
		genvar i;
		for (i=0; i<N; i=i+1) begin
			DDS DDS( Clk_100M,0,Mloop[i],
			PWMout[i],a[i],b[i],reset);
		end
	endgenerate	
	
//========================================ALWAYS========================================	
	always @(*)begin

//====================Initialize Coefficients====================
		//Triangle Wave
		triangle[0]		=	'd60000;
		triangle[1]		=	'd0;
		triangle[2]		=	'd6667;
		triangle[3]		=	'd0;
		triangle[4]		=	'd2400;
		triangle[5]		=	'd0;
		triangle[6]		=	'd1224;
		triangle[7]		=	'd0;
		triangle[8]		=	'd741;
		triangle[9]		=	'd0;
		triangle[10]	=	'd496;
		triangle[11]	=	'd0;
		triangle[12]	=	'd355;
		triangle[13]	=	'd0;
		triangle[14]	=	'd267;
		triangle[15]	=	'd0;
		triangle[16]	=	'd208;
		triangle[17]	=	'd0;
		triangle[18]	=	'd166;
		triangle[19]	=	'd0;
		triangle[20]	=	'd136;
		triangle[21]	=	'd0;
		triangle[22]	=	'd113;
		triangle[23]	=	'd0;
		triangle[24]	=	'd96;
		triangle[25]	=	'd0;
		triangle[26]	=	'd82;
		triangle[27]	=	'd0;
		triangle[28]	=	'd71;
		triangle[29]	=	'd0;
		triangle[30]	=	'd62;
		triangle[31]	=	'd0;
		//Square Wave
		square[0]		=	'd60000;
		square[1]		=	'd0;
		square[2]		=	'd20000;
		square[3]		=	'd0;
		square[4]		=	'd12000;
		square[5]		=	'd0;
		square[6]		=	'd8571;
		square[7]		=	'd0;
		square[8]		=	'd6667;
		square[9]		=	'd0;
		square[10]		=	'd5455;
		square[11]		=	'd0;
		square[12]		=	'd4615;
		square[13]		=	'd0;
		square[14]		=	'd4000;
		square[15]		=	'd0;
		square[16]		=	'd3529;
		square[17]		=	'd0;
		square[18]		=	'd3158;
		square[19]		=	'd0;
		square[20]		=	'd2857;
		square[21]		=	'd0;
		square[22]		=	'd2609;
		square[23]		=	'd0;
		square[24]		=	'd2400;
		square[25]		=	'd0;
		square[26]		=	'd2222;
		square[27]		=	'd0;
		square[28]		=	'd2069;
		square[29]		=	'd0;
		square[30]		=	'd1935;
		square[31]		=	'd0;
		//Sawtooth Wave
		saw[0]			=	'd38196;
		saw[1]			=	'd19098;
		saw[2]			=	'd12732;
		saw[3]			=	'd9552;
		saw[4]			=	'd7638;
		saw[5]			=	'd6366;
		saw[6]			=	'd5454;
		saw[7]			=	'd4776;
		saw[8]			=	'd3529;
		saw[9]			=	'd3158;
		saw[10]			=	'd2857;
		saw[11]			=	'd2608;
		saw[12]			=	'd2400;
		saw[13]			=	'd2222;
		saw[14]			=	'd2069;
		saw[15]			=	'd1935;
		saw[16]			=	'd1818;
		saw[17]			=	'd1714;
		saw[18]			=	'd1621;
		saw[19]			=	'd1538;
		saw[20]			=	'd1463;
		saw[21]			=	'd1395;
		saw[22]			=	'd1333;
		saw[23]			=	'd1277;
		saw[24]			=	'd1224;
		saw[25]			=	'd1176;
		saw[26]			=	'd1132;
		saw[27]			=	'd1091;
		saw[28]			=	'd1053;
		saw[29]			=	'd1017;
		saw[30]			=	'd984;
		saw[31]			=	'd952;
		//Clarinet Instrument
		clarinet[0]		=	'd60000;
		clarinet[1]		=	'd21900;
		clarinet[2]		=	'd16200;
		clarinet[3]		=	'd600;
		clarinet[4]		=	'd5100;
		clarinet[5]		=	'd12000;
		clarinet[6]		=	'd4800;
		clarinet[7]		=	'd0;
		clarinet[8]		=	'd0;
		clarinet[9]		=	'd0;
		clarinet[10]	=	'd0;
		clarinet[11]	=	'd0;
		clarinet[12]	=	'd0;
		clarinet[13]	=	'd0;
		clarinet[14]	=	'd0;
		clarinet[15]	=	'd0;
		clarinet[16]	=	'd0;
		clarinet[17]	=	'd0;
		clarinet[18]	=	'd0;
		clarinet[19]	=	'd0;
		clarinet[20]	=	'd0;
		clarinet[21]	=	'd0;
		clarinet[22]	=	'd0;
		clarinet[23]	=	'd0;
		clarinet[24]	=	'd0;
		clarinet[25]	=	'd0;
		clarinet[26]	=	'd0;
		clarinet[27]	=	'd0;
		clarinet[28]	=	'd0;
		clarinet[29]	=	'd0;
		clarinet[30]	=	'd0;
		clarinet[31]	=	'd0;
		//Guitar Instrument
		guitar[0]		=	'd47244;
		guitar[1]		=	'd31889;
		guitar[2]		=	'd60000;
		guitar[3]		=	'd7559;
		guitar[4]		=	'd7559;
		guitar[5]		=	'd6614;
		guitar[6]		=	'd0;
		guitar[7]		=	'd472;
		guitar[8]		=	'd9449;
		guitar[9]		=	'd2835;
		guitar[10]		=	'd709;
		guitar[11]		=	'd0;
		guitar[12]		=	'd472;
		guitar[13]		=	'd472;
		guitar[14]		=	'd472;
		guitar[15]		=	'd0;
		guitar[16]		=	'd0;
		guitar[17]		=	'd0;
		guitar[18]		=	'd0;
		guitar[19]		=	'd0;
		guitar[20]		=	'd0;
		guitar[21]		=	'd0;
		guitar[22]		=	'd0;
		guitar[23]		=	'd0;
		guitar[24]		=	'd0;
		guitar[25]		=	'd0;
		guitar[26]		=	'd0;
		guitar[27]		=	'd0;
		guitar[28]		=	'd0;
		guitar[29]		=	'd0;
		guitar[30]		=	'd0;
		guitar[31]		=	'd0;
	
//====================Define M Values====================
		Mloop[0]			<=   M;
		Mloop[1]			<= 2*M;
		Mloop[2]			<= 3*M;
		Mloop[3]			<= 4*M;
		Mloop[4]			<= 5*M;
		Mloop[5]			<= 6*M;
		Mloop[6]			<= 7*M;
		Mloop[7]			<= 8*M;
		Mloop[8]			<= 9*M;
		Mloop[9]			<=	10*M;
		Mloop[10]		<=	11*M;
		Mloop[11]		<=	12*M;
		Mloop[12]		<=	13*M;
		Mloop[13]		<=	14*M;
		Mloop[14]		<=	15*M;
		Mloop[15]		<=	16*M;
		Mloop[16]		<=	17*M;
		Mloop[17]		<=	18*M;
		Mloop[18]		<=	19*M;
		Mloop[19]		<=	20*M;
		Mloop[20]		<=	21*M;
		Mloop[21]		<=	22*M;
		Mloop[22]		<=	23*M;
		Mloop[23]		<=	24*M;
		Mloop[24]		<=	25*M;
		Mloop[25]		<=	26*M;
		Mloop[26]		<=	27*M;
		Mloop[27]		<=	28*M;
		Mloop[28]		<=	29*M;
		Mloop[29]		<=	30*M;
		Mloop[30]		<=	31*M;
		Mloop[31]		<=	32*M;
	
//====================Assign Audio Output====================
		AUD_PWM	<=	AUD_out;
		
//====================Determine PWM Values====================
		PWMsum	=	0;
		//Loop through all modules
		for (j = 0; j< N;j=j+1)begin
			if(j<=NumMod)begin							//If current module is within the requestsed number of modules
				PWMsum	=	PWMsum + PWMout[j];		//Accumulate Values
			end				
		end
		PWM	<=	(PWMsum);								//Assign PWM Sum to register
		
//====================Assign Seven Segment Display====================
		if(State=='b00)begin				//MODE State
			c1	<=	"m";
			c2	<=	"o";
			c3	<=	"d";
			c4	<=	" ";
		end
		else if(State=='b01)begin		//WAVEFORM State
			c1	<=	"w";
			c2	<=	"a";
			c3	<=	"v";
			c4	<=	"e";
		end
		if(State=='b10)begin				//FREQUENCY State
			c1	<=	"f";
			c2	<=	"r";
			c3	<=	"e";
			c4	<=	"q";
		end
		if(State=='b11)begin				//AMPLITUDE State
			c1	<=	"a";
			c2	<=	"m";
			c3	<=	"p";
			c4	<=	" ";
		end
	end
	
//========================================On each Clock Cycle========================================
	always @(posedge Clk_100M)begin

//====================Debounce buttons====================
		//Left
		if(debouncedL == 'b1)begin
			if(buttonStateL == 'b0)begin
				State	<=	State-'d1;
			end
			buttonStateL	<=	'b1;
		end
		else if(debouncedL == 'b0) begin
			buttonStateL <='b0;
		end
		//Right
		if(debouncedR == 'b1)begin
			if(buttonStateR == 'b0)begin
				State	<=	State+'d1;
			end
			buttonStateR	<=	'b1;
		end
		else if(debouncedR == 'b0) begin
			buttonStateR	<=	'b0;
		end
		//North
		if(debouncedN == 'b1)begin
			//Determine current state, increment accordingly
			if(buttonStateN == 'b0)begin
				//Number of Modules
				if(State == 'b00)begin
					NumMod	<=	NumMod+'b1;
				end
				//Waveform
				else if(State == 'b01)begin
					if(WaveState == 'd5)
						WaveState	<=	'd0;
					else
						WaveState	<=	WaveState+'b1;
				end
				//Octave
				else if(State == 'b10)begin
					M	<=	M*2;
				end
				//Amplitude
				else if(State == 'b11)begin
					if(Amp < 'd100000)
						Amp	<=	Amp + 'd10000;
				end
			end
			buttonStateN	<=	'b1;
		end
		else if(debouncedN == 'b0) begin
			buttonStateN	<=	'b0;
		end
		//South
		if(debouncedS == 'b1)begin
			//Determine current state, decrement accordingly
			if(buttonStateS == 'b0)begin
				//Number of modules
				if(State == 'b00)begin
					NumMod	<=	NumMod-'b1;
				end
				//Waveform
				else if(State == 'b01)begin
					if(WaveState == 'd0)
						WaveState	<=	'd5;
					else
						WaveState	<=	WaveState-'b1;
				end
				//Octave
				else if(State == 'b10)begin
					if(M >= 2)
						M	<=	M/2;
				end
				//Amplitude
				else if(State == 'b11)begin
					if(Amp > 11000)
						Amp	<=	Amp-'d10000;
				end
			end
			buttonStateS	<=	'b1;
		end
		else if(debouncedS == 'b0) begin
			buttonStateS	<=	'b0;
		end
		
//====================Determine which WAVEFORM to output====================
		case(WaveState)
			//Square wave
			3'b000:
				begin
					for(j = 0; j< N;j=j+1)begin
						a[j]	<=	square[j];
						b[j]	<=	0;
					end
				end
			//Triangle
			3'b001:
				begin
					for(j = 0; j< N;j=j+1)begin
						a[j]	<=	0;
						b[j]	<=	triangle[j];
					end
				end
			//Sawtooth
			3'b010:
				begin
					for(j = 0; j< N;j=j+1)begin
						b[j]	<=	0;
						a[j]	<=	saw[j];
					end
				end
			//Clarinet
			3'b011:
				begin
					for(j = 0; j< N;j=j+1)begin
						a[j]	<=	clarinet[j];
						b[j]	<=	0;
					end
				end
			//Guitar
			3'b100:
				begin
					for(j = 0; j< N;j=j+1)begin
						a[j]	<=	guitar[j];
						b[j]	<=	0;
					end
				end
			//Sine
			3'b101:
				begin
					for(j = 0; j< N;j=j+1)begin
						if(j == 0)begin
							a[j]	<=	0;
							b[j] 	<=	60000;
						end
						else begin
							a[j]	<=	0;
							b[j]	<=	0;
						end
					end
				end
			default: 
				begin
					for(j = 0; j< N;j=j+1)begin
						a[j]	<=	square[j];
						b[j]	<=	0;
					end
				end
		endcase
//====================Determine UART Recveive Data to change frequency====================
		if(busyState && busyR == 0)begin
			reset <=1;
			case (dataR)
				"1":		M	<=	1;
				"2":		M	<=	2;
				"3":		M	<=	3;
				"4":		M	<=	4;
				"5":		M	<=	5;
				"6":		M	<=	6;
				"7":		M	<=	7;
				"8":		M	<=	8;
				"9":		M	<=	9;
				default: M	<=	2;
			endcase
			
			busyState <= busyR;

		end
		else begin
					reset<=0;
			busyState <= busyR;
		end
	end
endmodule
