module Clock(
	input Clk_100M,
	input BTNS,
	input minUp,
	input hourUp,
	input [7:0]PWM,

	output [7:0]SegmentDrivers,
	output [7:0]SevenSegment,
	output reg [5:0]Seconds
	
	);
	
	//Seconds[5:0]<='d27
	reg[3:0]minutes;
	reg[3:0]minutes10;
	reg[3:0]hours;
	reg[3:0]hours10;
	reg[31:0]Count;
	reg[5:0]seconds;
	//reg[7:0]segZero;
	reg pressed;
	reg buttonState;
	reg HbuttonState;
	wire debounced;
	wire Hdebounced;
	
	
	
	wire Reset; // Define a local wire to carry the Reset signal
   Delay_Reset Delay_Reset1(Clk_100M, BTNS, Reset);
//------------------------------------------------

	SS_Driver SS_Driver1(
		Clk_100M, Reset,hours10, hours, minutes10, minutes, PWM, // Use temporary test values 
		SegmentDrivers, SevenSegment
		);
		
		minuteButton minuteButton1(
			Clk_100M, minUp,debounced
		);
		hourButton hourButton1(
			Clk_100M, hourUp, Hdebounced
		);
		

		

		
	always @(posedge Clk_100M) begin
		//segZero[7:4]<=4'hF;
		//SegmentDrivers<=segZero;
		if(Reset)begin
			seconds<='b0;
			minutes<='b0;
			minutes10<='b0;
			hours<='b0;
			hours10<='b0;
		end
		if(debounced =='b1)begin
			if(buttonState=='b0)begin
				minutes <= minutes +1'b1;
				if(minutes =='d9)begin
					minutes<='d0;
					minutes10<=minutes10+1'b1;
					if(minutes10 =='d5)begin
						minutes10<='d0;
					end
				end
			end
			buttonState <='b1;
		end
		else if(debounced =='b0) begin
			
			buttonState <='b0;
		end
		
		if(Hdebounced =='b1)begin
			if(HbuttonState=='b0)begin
				hours <= hours +1'b1;
				if(hours =='d9 && hours10 =='d0 )begin
					hours<='d0;
					hours10<=hours10+1'b1;
				end
				if(hours =='d9 && hours10 == 'd1)begin
					hours<='d0;
					hours10<=hours10+1'b1;
				end
				if(hours =='d3 && hours10 == 'd2)begin
					hours<='d0;
					hours10<='d0;
				end
			end
			HbuttonState <='b1;
		end
		else if(Hdebounced =='b0) begin
			
			HbuttonState <='b0;
		end

		
		Count<= Count+1'b1;
		if(Count=='h5F5E100)begin //5F5E100 for one second
		Count<=0;
		seconds <= seconds+1'b1;
		if(seconds == 'd59)begin
			seconds <= 'b0;
			minutes<= minutes+1'b1;
				if(minutes =='d9)begin
					minutes<='d0;
					minutes10<=minutes10+1'b1;
					if(minutes10 =='d5)begin
						minutes10<='d0;
						hours<=hours+1'b1;
						if(hours =='d9 && hours10 =='d0 )begin
							hours<='d0;
							hours10<=hours10+1'b1;
						end
						if(hours =='d9 && hours10 == 'd1)begin
							hours<='d0;
							hours10<=hours10+1'b1;
						end
						if(hours =='d3 && hours10 == 'd2)begin
							hours<='d0;
							hours10<='d0;
						end
					end
				end
			end
		end
	end
	always @(*) begin
		Seconds[5:0] <= seconds[5:0];
	//	pressed <=minUp;
	end
	//always @(posedge Clk_100M) Count<= Count+1'b1;
	
	
	
	
	//assign SegmentDrivers = {4'hF, Count[29:26]};
	//assign SevenSegment = Count[25:18];
	
	endmodule
	