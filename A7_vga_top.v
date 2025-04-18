`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:00 12/14/2017 
// Design Name: 
// Module Name:    vga_top 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
// Date: 04/04/2020
// Author: Yue (Julien) Niu
// Description: Port from NEXYS3 to NEXYS4
//////////////////////////////////////////////////////////////////////////////////

//I though maybe it was a synchronization error but I can't quiet understand why it is not working.
//the timer itself works fine but the timer does not reset, nor does it set a pr when you die.
module vga_top(
	input ClkPort,
	input BtnC,
	input BtnU,
	input BtnR,
	input BtnL,
	input BtnD,

	//VGA signal
	output hSync, vSync,
	output [3:0] vgaR, vgaG, vgaB,
	
	//SSD signal 
	output An0, An1, An2, An3, An4, An5, An6, An7,
	output Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp,
	
	//output MemOE, MemWR, RamCS,
	output  QuadSpiFlashCS
	);
	wire Reset;
	assign Reset=BtnC;
	wire bright;
	wire[9:0] hc, vc;
	wire[15:0] score;
	wire up,down,left,right;
	wire [3:0] anode;
	wire [11:0] rgb;
	wire rst;
	
	reg [3:0]	SSD;
	wire [3:0]	SSD7, SSD6, SSD5, SSD4, SSD3, SSD2, SSD1, SSD0;
	wire [2:0] 	ssdscan_clk;
	
	reg [27:0]	DIV_CLK;
	always @ (posedge ClkPort or posedge Reset)  
	begin : CLOCK_DIVIDER
      if (Reset)
			DIV_CLK <= 0;
	  else
			DIV_CLK <= DIV_CLK + 1'b1;
	end
	wire move_clk;
	assign move_clk=DIV_CLK[19]; //slower clock to drive the movement of objects on the vga screen

	
	
	display_controller dc(
		.clk(ClkPort), 
		.hSync(hSync), 
		.vSync(vSync), 
		.bright(bright), 
		.hCount(hc), 
		.vCount(vc)
	);
	
	wire deadFlag;
	block_controller sc(
		.clk(move_clk), 
		.bright(bright),
		.rst(BtnC), 
		.up(BtnU), 
		.down(BtnD),
		.left(BtnL),
		.right(BtnR),
		.hCount(hc), 
		.vCount(vc), 
		.rgb(rgb), 
		.deadFlag(deadFlag)
	);
	assign vgaR = rgb[11:8];
  	assign vgaG = rgb[7:4];
  	assign vgaB = rgb[3:0];
	
	wire[7:0] An, SSD_CATHODES;
	timer_display td(
		.clk(ClkPort),
		.rst(BtnC),
		.dead(deadFlag),
		.An(An),
		.SSD_CATHODES(SSD_CATHODES)
	);

	assign {An7, An6, An5, An4, An3, An2, An1, An0} = An;
	assign {Ca, Cb, Cc, Cd, Ce, Cf, Cg, Dp} = SSD_CATHODES;

	
	// disable mamory ports
	//assign {MemOE, MemWR, RamCS, QuadSpiFlashCS} = 4'b1111;
	assign QuadSpiFlashCS = 1'b1;
	

endmodule
