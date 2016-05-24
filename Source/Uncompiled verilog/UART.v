module UART(
      input Clk_100M,
      input UART_Rx,
		input BTNS,
		output reg [7:0] LED,
		output reg UART_Tx,
		output [7:0]SegmentDrivers,
		output [7:0] SevenSegment
	 );
	 reg [7:0] data;
	 reg [31:0] dataString;
	 //reg [2:0]indexx =3'b000;
	 reg start;
	 wire busy;
	 wire Tx;
	 reg startR;
	 reg dec[15:0];
	 wire busyR;
	 wire [7:0]dataR;
	 reg [3:0] a,b,c,d;

	Transmit transmit1(
	
      Clk_100M,
		start,
	   busy,
	   data,
	   Tx
		
	);
	
		wire Reset; // Define a local wire to carry the Reset signal
   Delay_Reset Delay_Reset1(Clk_100M, BTNS, Reset);
	
	SS_Driver SS_Driver1(
		Clk_100M, Reset,a, b, c,d, // Use temporary test values 
		SegmentDrivers, SevenSegment
		);
		

	Receive Receive1(
		Clk_100M,
		UART_Rx,
		dataR,
		busyR
	);
	
	always @(negedge busyR)begin
	 

			dataString <= +{dataString[23:0],dataR};
			data<="f";
	end

always @(posedge Clk_100M)begin

	if(busy=='b0)begin
		//data<=LED;

		start<='b1;	end
	else start <='b0;
	
	
			if(dataR=="1")LED<=1;
		else if(dataR=="2")LED<=8'd3;
		else if(dataR=="3")LED<=8'd7;
		else if(dataR=="4")LED<=8'd15;
		else if(dataR=="5")LED<=8'd31;
		else if(dataR=="6")LED<=8'd63;
		else if(dataR=="7")LED<=8'd127;
		else if(dataR=="8")LED<=8'd255;	
		else LED <=8'd0;
		
	
			if(dataString[31:24] == "8") a<=4'd8;
			if(dataString[31:24] == "7") a<=4'd7;
			if(dataString[31:24] == "6") a<=4'd6;
			if(dataString[31:24] == "5") a<=4'd5;
			if(dataString[31:24] == "4") a<=4'd4;
			if(dataString[31:24] == "3") a<=4'd3;
			if(dataString[31:24] == "2") a<=4'd2;
			if(dataString[31:24] == "1") a<=4'd1;
			if(dataString[31:24] == "0") a<=4'd0;
			
			if(dataString[23:16] == "8") b<=4'd8;
			if(dataString[23:16] == "7") b<=4'd7;
			if(dataString[23:16] == "6") b<=4'd6;
			if(dataString[23:16] == "5") b<=4'd5;
			if(dataString[23:16] == "4") b<=4'd4;
			if(dataString[23:16] == "3") b<=4'd3;
			if(dataString[23:16] == "2") b<=4'd2;
			if(dataString[23:16] == "1") b<=4'd1;
			if(dataString[23:16] == "0") b<=4'd0;


			if(dataString[15:8] == "8") c<=4'd8;
			if(dataString[15:8] == "7") c<=4'd7;
			if(dataString[15:8] == "6") c<=4'd6;
			if(dataString[15:8] == "5") c<=4'd5;
			if(dataString[15:8] == "4") c<=4'd4;
			if(dataString[15:8] == "3") c<=4'd3;
			if(dataString[15:8] == "2") c<=4'd2;
			if(dataString[15:8] == "1") c<=4'd1;
			if(dataString[15:8] == "0") c<=4'd0;

			if(dataString[7:0] == "8") d<=4'd8;
			if(dataString[7:0] == "7") d<=4'd7;
			if(dataString[7:0] == "6") d<=4'd6;
			if(dataString[7:0] == "5") d<=4'd5;
			if(dataString[7:0] == "4") d<=4'd4;
			if(dataString[7:0] == "3") d<=4'd3;
			if(dataString[7:0] == "2") d<=4'd2;
			if(dataString[7:0] == "1") d<=4'd1;
			if(dataString[7:0] == "0") d<=4'd0;

	
	
	
	
end

always @(*)begin 
UART_Tx<=Tx;

end 
endmodule
