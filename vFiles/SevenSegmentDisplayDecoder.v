//SevenSegmentDisplayDecoder
//	Source:Team 5
// Contact: Nathan.Genetzky@jacks.sdstate.com
// Last Modified: 10-15-2014
/*
SevenSegmentDisplayDecoder uHEX(
	.ssOut(),	 // [6:0] Connect to the 7-Segment that should display the Hex Value
	.ssOut_L(),	 // [6:0] Connect to the active low 7-Segment that should display the Hex Value
	.nIn(),		 // [3:0] Binary Encoded Hex Value
	)
*/
module SevenSegmentDisplayDecoder(ssOut,ssOut_L , nIn);
  output reg [6:0] ssOut;
  output reg [6:0] ssOut_L;
  input [3:0] nIn;
  // ssOut format {g, f, e, d, c, b, a}
  always @(nIn)
  begin
    case (nIn)
      4'h0: ssOut = 7'b0111111;
      4'h1: ssOut = 7'b0000110;
      4'h2: ssOut = 7'b1011011;
      4'h3: ssOut = 7'b1001111;
      4'h4: ssOut = 7'b1100110;
      4'h5: ssOut = 7'b1101101;
      4'h6: ssOut = 7'b1111101;
      4'h7: ssOut = 7'b0000111;
      4'h8: ssOut = 7'b1111111;
      4'h9: ssOut = 7'b1100111;
      4'hA: ssOut = 7'b1110111;
      4'hB: ssOut = 7'b1111100;
      4'hC: ssOut = 7'b0111001;
      4'hD: ssOut = 7'b1011110;
      4'hE: ssOut = 7'b1111001;
      4'hF: ssOut = 7'b1110001;
      default: ssOut = 7'b1001001;
    endcase
	 ssOut_L = ~ssOut;
	end
endmodule

/*
module SevenSegmentDisp(
	output reg [6:0] ssOut, ssOut_L,
	input [3:0] nIn, 
	input isHex_L
	); //Combines both the modules below.
	// ssOut format {g, f, e, d, c, b, a}
always @(nIn, isHex_L)
  begin
  if(isHex_L==0)
		 case (nIn) 
			4'h0: ssOut = 7'b0111111;
			4'h1: ssOut = 7'b0000110;
			4'h2: ssOut = 7'b1011011;
			4'h3: ssOut = 7'b1001111;
			4'h4: ssOut = 7'b1100110;
			4'h5: ssOut = 7'b1101101;
			4'h6: ssOut = 7'b1111101;
			4'h7: ssOut = 7'b0000111;
			4'h8: ssOut = 7'b1111111;
			4'h9: ssOut = 7'b1100111;
			4'hA: ssOut = 7'b1110111;
			4'hB: ssOut = 7'b1111100;
			4'hC: ssOut = 7'b0111001;
			4'hD: ssOut = 7'b1011110;
			4'hE: ssOut = 7'b1111001;
			4'hF: ssOut = 7'b1110001;
			default: ssOut = 7'b1001001;
		 endcase
	else
		case (nIn) //1 means ON 
      4'h0: ssOut = 7'b0000000;	//display NOTHING
      4'h1: ssOut = 7'b1000000;	// minus sign
      4'h2: ssOut = 7'b1011011;
      4'h3: ssOut = 7'b1001111;
      4'h4: ssOut = 7'b1100110;
      4'h5: ssOut = 7'b1101101;
      4'h6: ssOut = 7'b1111101;
      4'h7: ssOut = 7'b0000111;
      4'h8: ssOut = 7'b1111111;
      4'h9: ssOut = 7'b1100111;
      4'hA: ssOut = 7'b1110111;
      4'hB: ssOut = 7'b1111100;
      4'hC: ssOut = 7'b0111001;
      4'hD: ssOut = 7'b1011110;
      4'hE: ssOut = 7'b1111001;
      4'hF: ssOut = 7'b1110001;
      default: ssOut = 7'b1001001;//debug
    endcase
	 ssOut_L = ~ssOut; // makes output active low
	end
endmodule
*/