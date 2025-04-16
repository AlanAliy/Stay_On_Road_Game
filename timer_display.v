`timescale 1ns/1ps
module timer_display(
  input        clk,        // 100 MHz system clock
  input        rst,      // active‑low reset (e.g. ~BtnC)
  input        dead,       // pulse when the player dies
  output reg[7:0] An,         // An7…An0
  output reg[7:0] SSD_CATHODES         // {Ca,Cb,Cc,Cd,Ce,Cf,Cg,Dp}
);

//this divider ticks at 100Mhz, 100 million times per second
//I think I need this for accurate timing
//I dont think it is a problem but it might be
//every time centi_div is 1 million -1 (since it was going to add on that clock), we log centisecond+1
  reg [19:0] centi_div;
  wire       centi_sec = (centi_div == 1_000_000-1);

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      centi_div <= 0;
     end
    else if (centi_div == 1_000_000-1) begin
      centi_div <= 0;
      end
    else begin
      centi_div <= centi_div + 1;
      end
  end


  reg [15:0] cur_centi, best_centi;
  always @(posedge clk or  posedge rst) begin
    if (rst) begin
      cur_centi  <= 0;
      best_centi <= 0;
    end 
	
	else if (dead) begin
      if (cur_centi > best_centi) 
	  best_centi <= cur_centi;
      cur_centi <= 0;
    end 
	
	else if (centi_sec) begin
      cur_centi <= cur_centi + 1;
    end
  end

  
  wire [2:0] ssdscan_clk = centi_div[19:17];


  //this part is to seperate our digits and find tenths seconds 
  wire [15:0] cur_tenths  = cur_centi / 10;
  wire [9:0]  cur_secs    = cur_tenths / 10;
  wire [3:0]  SSD0 = cur_tenths % 10,
              SSD1 = cur_secs   % 10,
              SSD2 = (cur_secs/10)  % 10,
              SSD3 = (cur_secs/100) % 10;

  wire [15:0] best_tenths = best_centi / 10;
  wire [9:0]  best_secs   = best_tenths / 10;
  wire [3:0]  SSD4 = best_tenths % 10,
              SSD5 = best_secs   % 10,
              SSD6 = (best_secs/10)  % 10,
              SSD7 = (best_secs/100) % 10;


  //turn SSDs on in turns
  always @(*) begin
    An = {
      !(~ssdscan_clk[2] && ~ssdscan_clk[1] && ~ssdscan_clk[0]),
      !(~ssdscan_clk[2] && ~ssdscan_clk[1] &&  ssdscan_clk[0]),
      !(~ssdscan_clk[2] &&  ssdscan_clk[1] && ~ssdscan_clk[0]),
      !(~ssdscan_clk[2] &&  ssdscan_clk[1] &&  ssdscan_clk[0]),
      !(ssdscan_clk[2] && ~ssdscan_clk[1] && ~ssdscan_clk[0]),
      !(ssdscan_clk[2] && ~ssdscan_clk[1] &&  ssdscan_clk[0]),
      !(ssdscan_clk[2] &&  ssdscan_clk[1] && ~ssdscan_clk[0]),
      !(ssdscan_clk[2] &&  ssdscan_clk[1] &&  ssdscan_clk[0])
      };
  end


  reg [3:0] SSD;
  reg Dp;
  always @(*) begin: SSD_SCAN_OUT
    case (ssdscan_clk)
      3'b000: begin  SSD = SSD0; Dp = 1; end  
      3'b001: begin SSD = SSD1; Dp = 0; end //dp is on for division between tenth and second
      3'b010: begin SSD = SSD2; Dp = 1; end
      3'b011: begin SSD = SSD3; Dp = 1; end
      3'b100: begin SSD = SSD4; Dp = 1; end
      3'b101: begin SSD = SSD5; Dp = 0; end
      3'b110: begin SSD = SSD6; Dp = 1; end
      3'b111: begin SSD = SSD7; Dp = 1; end
    endcase
  end


  always @(*) begin: HEX_TO_SSD
    case (SSD)
      4'h0: SSD_CATHODES = 8'b00000010;
      4'h1: SSD_CATHODES = 8'b10011110;
      4'h2: SSD_CATHODES = 8'b00100100;
      4'h3: SSD_CATHODES = 8'b00001100;
      4'h4: SSD_CATHODES = 8'b10011000;
      4'h5: SSD_CATHODES = 8'b01001000;
      4'h6: SSD_CATHODES = 8'b01000000;
      4'h7: SSD_CATHODES = 8'b00011110;
      4'h8: SSD_CATHODES = 8'b00000000;
      4'h9: SSD_CATHODES = 8'b00001000;
      4'hA: SSD_CATHODES = 8'b00010000;
      4'hB: SSD_CATHODES = 8'b11000000;
      4'hC: SSD_CATHODES = 8'b01100010;
      4'hD: SSD_CATHODES = 8'b10000100;
      4'hE: SSD_CATHODES = 8'b01100000;
      4'hF: SSD_CATHODES = 8'b01110000;
      default: SSD_CATHODES = 8'b11111111;
    endcase
    SSD_CATHODES[0] = Dp ? 1'b1 : 1'b0;
  end



endmodule