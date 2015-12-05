// display32OnHex
//	Source:Team 5
// Contact: Nathan.Genetzky@jacks.sdstate.com
// Last Modified: 10-17-2014
// Precondition: Include "SevenSegmentDisplayDecoder" from Team 5.
//					Connect the 7 bits of "toHex*" to each hardware hex output in Big endian order.
//					Connect 32 Bits to be displayed to "HexDisplay32Bits"

//	Copy the code below to instantiate. Must be created within MasterVerilog

/* //Team 5::display32OnHex
display32OnHex uAllHex(
	.input HexDisplay32Bits(HexDisplay32Bits),
	.toHex0(Hex0),
	.toHex1(Hex1),
	.toHex2(Hex2),
	.toHex3(Hex3),
	.toHex4(Hex4),
	.toHex5(Hex5),
	.toHex6(Hex6),
	.toHex7(Hex7)
	)
*/

module DisplayAllHex(
	input [31:0] HexDisplay32Bits,
	output [6:0] toHex0,toHex1,toHex2,toHex3,toHex4,toHex5,toHex6,toHex7
	);
	//Registers to latch value to be displayed on hex
reg [3:0] displayAtHex0, displayAtHex1, displayAtHex2, displayAtHex3, displayAtHex4, displayAtHex5,displayAtHex6, displayAtHex7; 

//Display HexDisplay32Bits to SevenSegmentDisplayDecoder module via displayAtHex0-7
always @(HexDisplay32Bits)
	begin
		displayAtHex0 = HexDisplay32Bits[3:0];
		displayAtHex1 = HexDisplay32Bits[7:4];
		displayAtHex2 = HexDisplay32Bits[11:8];
		displayAtHex3 = HexDisplay32Bits[15:12];
		displayAtHex4 = HexDisplay32Bits[19:16];
		displayAtHex5 = HexDisplay32Bits[23:20];
		displayAtHex6 = HexDisplay32Bits[27:24];
		displayAtHex7 = HexDisplay32Bits[31:28];
	end
SevenSegmentDisplayDecoder uHEX0	(.ssOut_L(toHex0[6:0]), .nIn(displayAtHex0[3:0]));
SevenSegmentDisplayDecoder uHEX1	(.ssOut_L(toHex1[6:0]), .nIn(displayAtHex1[3:0]));
SevenSegmentDisplayDecoder uHEX2	(.ssOut_L(toHex2[6:0]), .nIn(displayAtHex2[3:0]));
SevenSegmentDisplayDecoder uHEX3	(.ssOut_L(toHex3[6:0]), .nIn(displayAtHex3[3:0]));
SevenSegmentDisplayDecoder uHEX4	(.ssOut_L(toHex4[6:0]), .nIn(displayAtHex4[3:0]));
SevenSegmentDisplayDecoder uHEX5	(.ssOut_L(toHex5[6:0]), .nIn(displayAtHex5[3:0]));
SevenSegmentDisplayDecoder uHEX6	(.ssOut_L(toHex6[6:0]), .nIn(displayAtHex6[3:0]));
SevenSegmentDisplayDecoder uHEX7	(.ssOut_L(toHex7[6:0]), .nIn(displayAtHex7[3:0]));

endmodule