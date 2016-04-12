module Clock(
	input Clk_100M,
	
	output [7:0]SegmentDrivers,
	output [7:0]SevenSegment
	);
	
	reg [29:0]Count;
	
	always @(posedge Clk_100M) Count<= Count+1'b1;
	
	assign SegmentDrivers = {4'hF, Count[29:26]};
	assign SevenSegment = Count[25:18];
	
	endmodule
	