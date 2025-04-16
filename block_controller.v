`timescale 1ns / 1ps

module block_controller(
	input clk, //this clock must be a slow enough clock to view the changing positions of the objects
	input bright,
	input rst,
	input up, input down, input left, input right,
	input [9:0] hCount, vCount,
	output reg [11:0] rgb,
	output reg [11:0] background,
	output reg deadFlag = 0
   );
	wire block_fill;
	
	//these two values dictate the center of the block, incrementing and decrementing them leads the block to move in certain directions
	reg [9:0] xpos, ypos;
	reg [9:0] leftEdge[0:479];
	reg [9:0] rightEdge[0:479];

	reg [9:0] delta; //change of curve;
	
	localparam RED   = 12'b1111_0000_0000;
	
	localparam GREEN1 = 12'b0000_1111_0000;
	localparam GREEN2 = 12'b0000_0101_0000;
	localparam GREEN3 = 12'b0000_1010_0000;
	
	localparam GRAY1 =  12'b0110_0110_0110;
	localparam GRAY2 =  12'b1001_1001_1001;
	localparam GRAY3 =  12'b0100_0100_0100;
	
	localparam BLACK = 12'b0000_0000_0000;
	
	localparam XCENTER = 10'd464;
	localparam YCENTER = 10'd275;

    reg [2:0] road_hash;
    reg [2:0] grass_hash;


	//create tspeed, and  xrEdge, xlEdge, deathflag

	reg [5:0] tspeed = 2;
	reg [12:0] dif_count = 0;


	
	localparam H_VISIBLE_START = 144;
	localparam V_VISIBLE_START = 35;
	/*when outputting the rgb value in an always block like this, make sure to include the if(~bright) statement, as this ensures the monitor 
	will output some data to every pixel and not just the images you are trying to display*/
	
	always@ (*) begin
    	if(~bright )	//force black if not inside the display area
			rgb = BLACK;
		else if (block_fill) 
			rgb = RED; 
		else if (road_parts)begin
			//!FIXME
			//I put these hash cases here to see if I can make it generate different tones of colors
			//semi randomly. For some reason they warp the image and colors making the green black? the gray seems
			//to be fine but has much larger of a road than is meanr for it. when the car collides it understands and makes
			// a set of pixels in that area black again?
			//if you want the colors to work correctly you can undo this b deleteing the case statements
      		case (road_hash)	

        		3'd0, 3'd1: rgb = GRAY1;
       			3'd2, 3'd3: rgb = GRAY2;
        		default:    rgb = GRAY3;
			endcase
		end
		else begin
      		case (grass_hash)
        		3'd0, 3'd1: background = GREEN2;
        		3'd2, 3'd3: background = GREEN1;
        		default:    background = GREEN3;
      		endcase
      	end
	end
		//the +-5 for the positions give the dimension of the block (i.e. it will be 10x10 pixels)
	assign block_fill = vCount>=(ypos-5) && vCount<=(ypos+5) && hCount>=(xpos-5) && hCount<=(xpos+5);
	assign road_parts =  (hCount >= (XCENTER - 50)) && (hCount <= XCENTER + 50);
	integer v;


	  always @(posedge clk or posedge rst) begin
    if (rst || deadFlag) begin
      // reset the road edges
      for (v = 0; v < 480; v = v + 1) begin
        leftEdge[v]  <= XCENTER - 50;
        rightEdge[v] <= XCENTER + 50;
      end
      // reset car position and alive flag
      xpos     <= XCENTER;
      ypos     <= YCENTER + 100;
      deadFlag <= 1'b0;
    end else begin
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
