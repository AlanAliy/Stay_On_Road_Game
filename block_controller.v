`timescale 1ns / 1ps

module block_controller(
    input  clk,                // pixel clock
    input  fastClock,          // ROM clock for car sprite
    input  bright,
    input  rst,
    input  up, input down, input left, input right,
    input  [9:0] hCount, vCount,
    output reg  [11:0] rgb,
    output reg  deadFlag = 0
);
    //------------------------------------------------------------
    //  constants / colours
    //------------------------------------------------------------
    localparam XCENTER = 10'd464;
    localparam YCENTER = 10'd275;

    localparam CAR_W = 30;
    localparam CAR_H = 30;
    localparam HALF_W = CAR_W >> 1;

    localparam BLACK = 12'h000;
    localparam GRAY1 = 12'h666, GRAY4 = 12'hCCC;
    localparam GREEN1 = 12'h0F0, GREEN3 = 12'h0A0;
    localparam CAR_OUTSIDE_COLOR = 12'h0F0;   // pink key colour

    //------------------------------------------------------------
    //  sprite position
    //------------------------------------------------------------
    reg [9:0] xpos = XCENTER - HALF_W;
    reg [9:0] ypos = YCENTER + 10'd100;

    //------------------------------------------------------------
    //  road-edge memories
    //------------------------------------------------------------
    reg [9:0] leftEdge  [0:479];
    reg [9:0] rightEdge [0:479];
	//------------------------------------------------------------
	//  dynamic difficulty
	//------------------------------------------------------------
	reg [15:0] distance = 0;     // counts scan-lines survived
	reg [3:0]  level    = 1;     // 1 .. 15   (scales the bend)
    //------------------------------------------------------------
    //  car sprite ROM
    //------------------------------------------------------------
    wire [11:0] carColor;
    formula_car_rom fc (
        .clk        (fastClock),
        .color_data (carColor),
        .row        (vCount - ypos),
        .col        (hCount - xpos)
    );

    //------------------------------------------------------------
    //  road-centre state machine - scripted movement
    //------------------------------------------------------------
    reg  signed [10:0] centerX  = XCENTER;
    reg  signed [4:0]  deltaX   = 0;
    reg         [8:0]  rowsLeft = 0;
    reg         [2:0]  scriptPtr = 0;
    reg         [3:0]  vScroll  = 0;

    // tiny ROM script
    reg  signed [4:0] delta_rom [0:3];
    reg         [8:0] rows_rom  [0:3];

    initial begin
        delta_rom[0] =  5'sd0;  rows_rom[0] = 9'd10 ;   // straight 40 rows
        delta_rom[1] =  8'sd3;  rows_rom[1] = 9'd18 ;   // sharp RIGHT      \
        delta_rom[2] =  5'sd0;  rows_rom[2] = 9'd10 ;   // short straight    > hair-pin feel
        delta_rom[3] = -8'sd3;  rows_rom[3] = 9'd18 ;   // sharp LEFTL
    end
    
    localparam SCRIPT_LEN = 4;

    //------------------------------------------------------------
    //  helper wires
    //------------------------------------------------------------
    wire block_fill =
        (vCount >= ypos) &&
        (vCount <= ypos + CAR_H - 1) &&
        (hCount >= xpos) &&
        (hCount <= xpos + CAR_W - 1);

    wire road_pixel =
        (hCount >= leftEdge[vCount]) &&
        (hCount <= rightEdge[vCount]);

    //------------------------------------------------------------
    //  RGB combinational mux
    //------------------------------------------------------------
    wire [10:0] hasher = vCount+vScroll;
    
    always @* begin
        if (!bright)                       rgb = BLACK;
        else if (block_fill &&
                 (carColor != CAR_OUTSIDE_COLOR))
                                            rgb = carColor;
        else if (road_pixel) begin
            case (hCount[3] ^ hasher[3])
                1'b0:  rgb = GRAY1;
                1'b1:  rgb = GRAY4;
            endcase
        end else begin
            case (hCount[3] ^ hasher[3])
                1'b0:  rgb = GREEN1;
                1'b1:  rgb = GREEN3;
            endcase
        end
    end

    //------------------------------------------------------------
    //  sequential logic
    //------------------------------------------------------------
    integer v;
    wire [9:0] carFrontY = ypos + CAR_H - 1;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // reset road edges
            for (v=0; v<480; v=v+1) begin
                leftEdge [v] <= XCENTER - 50;
                rightEdge[v] <= XCENTER + 50;
            end
            xpos <= XCENTER - HALF_W;
            ypos <= YCENTER + 100;
            deadFlag <= 1'b0;
            centerX <= XCENTER;
            deltaX  <= 0;
            rowsLeft <= 0;
            scriptPtr <= 0;

			distance <= 0;
  	        level    <= 1;

        end else if (deadFlag) begin
            // same reset after crash
            for (v=0; v<480; v=v+1) begin
                leftEdge [v] <= XCENTER - 50;
                rightEdge[v] <= XCENTER + 50;
            end
            xpos <= XCENTER - HALF_W;
            ypos <= YCENTER + 100;
            deadFlag <= 1'b0;
            centerX <= XCENTER;
            deltaX  <= 0;
            rowsLeft <= 0;
            scriptPtr <= 0;

			distance <= 0;
  	        level    <= 1;
        
        end else begin
            //----------------------------------------------------
            // (A) shift stored edges down 1 row every clock
            //----------------------------------------------------
            for (v=479; v>0; v=v-1) begin
                leftEdge [v] <= leftEdge [v-1];
                rightEdge[v] <= rightEdge[v-1];
            end

            //----------------------------------------------------
            // (B) new scan-line tasks (once each row)
            //----------------------------------------------------
            if (hCount == 0) begin

				vScroll <= vScroll - 1; // insted of decrementing on every pixel clock, only do it once when you’ve finished a line

				// —— DIFFICULTY UPDATE ——  
               // 1) increment distance by 1 row
               distance <= distance + 1;
               // 2) bump level every 200 rows (clamp at 8 for safety)
               if (distance % 200 == 0 && level < 8)
                   level <= level + 1;

                if (rowsLeft == 0) begin
                    deltaX   <= delta_rom[scriptPtr];
                    rowsLeft <= rows_rom [scriptPtr];

				// 3) load the next script entry…
                   deltaX <= delta_rom[scriptPtr] + (delta_rom[scriptPtr] > 0 ? level : (delta_rom[scriptPtr] < 0 ? -level : 0));

                // 4) shorten how many rows each bend lasts
                   rowsLeft <= (rows_rom[scriptPtr] > level*2)
                               ? rows_rom[scriptPtr] - level*2
                               : 1;     // never zero

                    scriptPtr<= (scriptPtr==SCRIPT_LEN-1)? 0 : scriptPtr+1;
                end 
				else
                    rowsLeft <= rowsLeft - 1;

                centerX <= centerX + deltaX;
                leftEdge [0] <= centerX - 50;
                rightEdge[0] <= centerX + 50;
            end

            //----------------------------------------------------
            // (C) car movement
            //----------------------------------------------------
            if (right)      xpos <= xpos + 2;
            else if (left)  xpos <= xpos - 2;

            //----------------------------------------------------
            // (D) collision test
            //----------------------------------------------------
            if ( (xpos + CAR_W -1) > rightEdge[carFrontY] ||
                 xpos              < leftEdge [carFrontY] )
                deadFlag <= 1'b1;       
        end
    end

    //------------------------------------------------------------
    // helper for collision Y
    //------------------------------------------------------------
    

endmodule
