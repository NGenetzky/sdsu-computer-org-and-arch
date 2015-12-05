module MasterVerilog(
	input clk_27, clk_50,
	input [17:0] switch,
	output [8:0] green,
	output [17:0] red,
	input [3:0] pushBut,
	output [6:0] Hex0,Hex1,Hex2,Hex3,Hex4,Hex5,Hex6,Hex7
);
//Using the following MIF file:
//		InstructionTestSet(11062014).mif
//NOT these:
//
//								START		LED Output
//****************************************************************************************************
//assign red[10:0] = wDataAddress;
assign green[7:6] = wSelect_MVDisplay[1:0];
assign red[15] = !MemRead_H_Write_L;
assign red[16] = button0;
assign red[17] = switch[17];
//assign green[7:3] = switch[4:0]; //wSelect_ProcDsplay;
assign red[8:0] = statusLights[8:0];
assign green[2:0] = TimeStep;
//****************************************************************************************************
//								FINISH	LED Output
wire [31:0] ProcessorOutput, ProcessorInput;
wire [2:0] TimeStep;
wire [8:0] statusLights;
//(wDataAddress[6]? qRAM : qROM); // if wDataAddress[6]==0 => qRAM
///		The Processor.
// Ideally your entire processor is contained within a module.
Processor(
	.clock(button0),
	.ProcessorEnable(switch[17]), 
	.ProcessorReset(0),
	.selectHexView(switch[4:0]),//(wSelect_ProcDsplay),
	
	.DataIn(ProcessorInput), 	// From ROM or RAM 
	.DataOut(ProcessorOutput), 	// to RAM
	.MemAddress(wDataAddress),
	.memRead_orWrite_L(MemRead_H_Write_L),
	
	.OperationFinished(),
	.TimeStep(TimeStep),
	.HexDisplay(HexDisplay32Bits),
	.statusLights(statusLights)
	);
	
//								START		Memory
//****************************************************************************************************
wire MemRead_H_Write_L, wMFC;
wire [31:0] qRAM, qROM, wVirtualReg; 
wire [6:0] wDataAddress;
virtualreg uVirtualReg(
	.clock(button3),
	.inputData(switch[15:0]),
	.MSB_orLSB_L(switch[16]),
	.vir_reg(wVirtualReg)
);
Memory(
	.dataIn(ProcessorOutput),
	.address(wDataAddress),
	.read_orWrite_L(MemRead_H_Write_L),
	.clock(clk_27),
	.dataOut(ProcessorInput)
	);
//****************************************************************************************************
//								FINISH	Memory

//								START		HexDisplay
//****************************************************************************************************
reg [4:0] select_MVDisplay, select_ProcDsplay;
wire [4:0] wSelect_MVDisplay, wSelect_ProcDsplay;
assign wSelect_MVDisplay = select_MVDisplay;
assign wSelect_ProcDsplay = select_ProcDsplay;
wire [31:0] HexDisplay32Bits;
always @(posedge button1)
begin
	select_ProcDsplay = switch[4:0];
end

always @(posedge button2)
begin
	select_MVDisplay = switch[2:0];
end

wire [31:0] HexDisplayRegisters;
Mux4to1 MuxMVDisplay(
	.s(select_MVDisplay),	//Button 2 clk	
	.w0(HexDisplay32Bits),  //Jordan's Display Mux
	.w1(wDataAddress), 			//Time Step
	.w2(ProcessorInput),		//Address going to Data
	.w3(ProcessorOutput),			//Virtual Registers 		filled via switches and button 3
	.f(HexDisplayRegisters)
	);
DisplayAllHex uAllHex(
	.HexDisplay32Bits(HexDisplayRegisters),
	.toHex0(Hex0),.toHex1(Hex1),.toHex2(Hex2),.toHex3(Hex3),.toHex4(Hex4),.toHex5(Hex5),.toHex6(Hex6),.toHex7(Hex7)
	); 		
//****************************************************************************************************
//								FINISH	HexDisplay

//								START	Debouncer
//****************************************************************************************************
wire button0, button1, button2, button3;
Debounce4Buttons uDebouncer(
	.clk_27(clk_27), .in0(pushBut[0]),.in1(pushBut[1]),.in2(pushBut[2]),.in3(pushBut[3]),
	.out0(button0),.out1(button1),.out2(button2),.out3(button3)
);
endmodule //end MAIN


