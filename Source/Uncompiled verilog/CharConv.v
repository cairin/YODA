/*
	Project: 	The Fourier Awakens
	Course:		EEE4084F YODA
	University: UCT
	Date: 		20/05/2016
	Authors: 	Benji Lewis, Robbie Katz, Cairin Michie
	File:			CharConv.v
	Details:		Convert Char to Seven Segment Binary 
*/

module CharConv(
	input [7:0] char,
	output reg [6:0]SevenSegment
    );
	 
//------------------------------------------------------------------------------
// Combinational circuit to convert BCD input to seven-segment output
always @(char) begin
case(char)                 // gfedcba
"a"   : SevenSegment <= 7'b1110111; //       a
"d"   : SevenSegment <= 7'b1011110; //      ---
"e"   : SevenSegment <= 7'b1111001; //     |   |
"f"   : SevenSegment <= 7'b1110001; //    f| g |b
"m"   : SevenSegment <= 7'b0010101; //      ---
"o"   : SevenSegment <= 7'b0111111; //     |   |
"p"   : SevenSegment <= 7'b1110011; //    e|   |c
"q"   : SevenSegment <= 7'b1101011; //      ---
"r"   : SevenSegment <= 7'b0110011; //       d
"v"   : SevenSegment <= 7'b0111110;
"w"   : SevenSegment <= 7'b0101010;
default: SevenSegment <= 7'b0000000;
endcase
end
//------------------------------------------------------------------------------
endmodule