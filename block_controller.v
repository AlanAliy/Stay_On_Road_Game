`timescale 1ns / 1ps

module block_controller(
	input clk, //this clock must be a slow enough clock to view the changing positions of the objects
	input bright,
	input rst,
	input up, input down, input left, input right,
	input [9:0] hCount, vCount,
	output reg [11:0] rgb,
	output reg deadFlag = 0
   );
	
	//these two values dictate the center of the block, incrementing and decrementing them leads the block to move in certain directions
	reg [9:0] xpos, ypos;
	reg [9:0] leftEdge[0:479];
	reg [9:0] rightEdge[0:479];

	reg [9:0] delta; //change of curve;
	
	localparam RED   = 12'b1111_0000_0000;
	
	localparam GREEN1 = 12'b0000_1111_0000;
	localparam GREEN2 = 12'b0000_0101_0000;
	localparam GREEN3 = 12'b0000_1010_0000;
	localparam GREEN4 = 12'b0000_1101_0000;
	
	localparam GRAY1 =  12'b0110_0110_0110;
	localparam GRAY2 =  12'b1001_1001_1001;
	localparam GRAY3 =  12'b0100_0100_0100;
	localparam GRAY4 =  12'b1100_1100_1100;
	
	localparam BLACK = 12'b0000_0000_0000;
	
	localparam XCENTER = 10'd464;
	localparam YCENTER = 10'd275;



	//create tspeed, and  xrEdge, xlEdge, deathflag

	reg [5:0] tspeed = 2;
	reg [12:0] dif_count = 0;


	
	localparam H_VISIBLE_START = 144;
	localparam V_VISIBLE_START = 35;
	/*when outputting the rgb value in an always block like this, make sure to include the if(~bright) statement, as this ensures the monitor 
	will output some data to every pixel and not just the images you are trying to display*/
	// the +-5 for the positions give the dimension of the block (i.e. it will be 10x10 pixels)


initial begin
  xpos = XCENTER;
  ypos = YCENTER + 100;
  // (you can also initialize leftEdge/rightEdge here if you like)
end





wire block_fill = 
    (vCount >= (ypos - 5)) &&
    (vCount <= (ypos + 5)) &&
    (hCount >= (xpos - 5)) &&
    (hCount <= (xpos + 5));

wire road_parts  = (hCount >= (XCENTER - 50)) && (hCount <= (XCENTER + 50));
	



	always @(*) begin
		if (!bright)
			rgb = BLACK;
		else if (block_fill)
			rgb = RED;              // single pixel
		else if (road_parts) begin
			case(hCount[3] ^ vCount[3])
				1'd0: rgb = GRAY1;
				1'd1: rgb = GRAY4;
			endcase
		end
		else begin
			case(hCount[3] ^ vCount[3])
				1'd0: rgb = GREEN1;
				1'd1: rgb = GREEN3;
			endcase
		end
	end
		//the +-5 for the positions give the dimension of the block (i.e. it will be 10x10 pixels)

	
		
		/* Note that the top left of the screen does NOT correlate to vCount=0 and hCount=0. The display_controller.v file has the 
			synchronizing pulses for both the horizontal sync and the vertical sync begin at vcount=0 and hcount=0. Recall that after 
			the length of the pulse, there is also a short period called the back porch before the display area begins. So effectively, 
			the top left corner corresponds to (hcount,vcount)~(144,35). Which means with a 640x480 resolution, the bottom right corner 
			corresponds to ~(783,515).  
		*/
	integer v;

	always @(posedge clk or posedge rst) begin
		if (rst) begin
		// reset the road edges
			for (v = 0; v < 480; v = v + 1) begin
				leftEdge[v]  <= XCENTER - 50;
				rightEdge[v] <= XCENTER + 50;
			end
		// reset car position and alive flag
			xpos     <= XCENTER;
			ypos     <= YCENTER + 100;
		end 

		else if(deadFlag) begin
			for (v = 0; v < 480; v = v + 1) begin
				leftEdge[v]  <= XCENTER - 50;
				rightEdge[v] <= XCENTER + 50;
			end
		// reset car position and alive flag
			xpos     <= XCENTER;
			ypos     <= YCENTER + 100;
			deadFlag <= 0;
		end
		
		else begin
		// shift the road one row
			for (v = 479; v > 0; v = v - 1) begin
				leftEdge[v]  <= leftEdge[v-1];
				rightEdge[v] <= rightEdge[v-1];
			end
			leftEdge[0] <= leftEdge[1];

			// move the car
			if (right)      xpos <= xpos + 2;
			else if (left)  xpos <= xpos - 2;

			// collision detection
			if ((xpos + 5) > rightEdge[ypos] || (xpos - 5) < leftEdge[ypos])
				deadFlag <= 1'b1;
    end
  end
	
	//the background color reflects the most recent button press


	
	
endmodule
