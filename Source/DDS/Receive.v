
module Receive(
		input Clk_100M,
		input UART_Rx,
		output reg [7:0] DATA,
		output reg BUSY
    );

reg [9:0] DATAFLL =0;
reg RX_FLG;
reg [15:0] PRSCL =0;
reg [3:0] INDEX = 0;

always @(posedge Clk_100M)begin

	if(RX_FLG=='b0 && UART_Rx=='b0)begin
		INDEX <= 0;
		PRSCL <= 0;
		BUSY<='b1;
		RX_FLG<='b1;
	end
	
	if(RX_FLG=='b1)begin
		DATAFLL[INDEX]<=UART_Rx;
		if(PRSCL<9999)begin
			PRSCL<=PRSCL +1;
		end
		else PRSCL <=0;
		
		if(PRSCL==4999)begin
			if(INDEX<9)begin
				INDEX <=INDEX +1;
			end
			else begin
				if(DATAFLL[0] =='b0 && DATAFLL[9]=='b1)begin
					DATA<=DATAFLL[8:1];
				end
				else begin
					DATA<= 10'b0000000000;
				end
				RX_FLG<='b0;
				BUSY <='b0;
			end
		end
		
	end
	
end

endmodule
