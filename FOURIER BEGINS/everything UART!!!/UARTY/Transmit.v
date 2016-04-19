
module Transmit(
		input Clk_100M,
		input start,
		output reg busy,
		input [7:0]data,
	   output reg UART_Tx = 'b1
    );

	reg [15:0] PRSCL;
	reg [3:0]INDEX;
	reg [9:0] DATAFLL;
	reg TX_FLG = 'b0;
	
	always @(posedge Clk_100M)begin
		if(TX_FLG == 'b0 && start == 'b1)begin
			TX_FLG <='b1;
			busy <= 'b1;
			DATAFLL[0]<='b0;
			DATAFLL[9] <='b1;
			
			DATAFLL[8:1] <= data;
		end
		
		if(TX_FLG=='b1)begin
			if(PRSCL < 9999)begin
				PRSCL <=PRSCL +'b1;
			end
			else PRSCL<=0;
			if(PRSCL==4999)begin
				UART_Tx<=DATAFLL[INDEX];
				if(INDEX <9)begin
				INDEX <= INDEX+'b1;
				end
				else begin
					TX_FLG<='b0;
					busy<='b0;
					INDEX<=0;
				end
			end
		end
	end

endmodule
