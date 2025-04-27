module formula_car_rom
	(
		input wire clk,
		input wire [4:0] row,
		input wire [4:0] col,
		output reg [11:0] color_data
	);

	(* rom_style = "block" *)

	//signal declaration
	reg [4:0] row_reg;
	reg [4:0] col_reg;

	always @(posedge clk)
		begin
		row_reg <= row;
		col_reg <= col;
		end

	always @(*) begin
		if(({row_reg, col_reg}>=10'b0000000000) && ({row_reg, col_reg}<10'b0000001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0000001001)) color_data = 12'b000011110001;
		if(({row_reg, col_reg}==10'b0000001010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0000001011)) color_data = 12'b010101100101;
		if(({row_reg, col_reg}==10'b0000001100)) color_data = 12'b011101100111;
		if(({row_reg, col_reg}==10'b0000001101)) color_data = 12'b010001010100;
		if(({row_reg, col_reg}==10'b0000001110)) color_data = 12'b000100000001;
		if(({row_reg, col_reg}==10'b0000001111)) color_data = 12'b001000100010;
		if(({row_reg, col_reg}==10'b0000010000)) color_data = 12'b011001110111;
		if(({row_reg, col_reg}==10'b0000010001)) color_data = 12'b011001010110;
		if(({row_reg, col_reg}==10'b0000010010)) color_data = 12'b100001111001;

		if(({row_reg, col_reg}>=10'b0000010011) && ({row_reg, col_reg}<10'b0000101001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0000101001)) color_data = 12'b100001110110;
		if(({row_reg, col_reg}==10'b0000101010)) color_data = 12'b000100000011;
		if(({row_reg, col_reg}==10'b0000101011)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b0000101100)) color_data = 12'b010100000000;
		if(({row_reg, col_reg}==10'b0000101101)) color_data = 12'b001000000000;
		if(({row_reg, col_reg}==10'b0000101110)) color_data = 12'b011101010000;
		if(({row_reg, col_reg}==10'b0000101111)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b0000110000)) color_data = 12'b010100000000;
		if(({row_reg, col_reg}==10'b0000110001)) color_data = 12'b000100000000;
		if(({row_reg, col_reg}==10'b0000110010)) color_data = 12'b000000010000;
		if(({row_reg, col_reg}==10'b0000110011)) color_data = 12'b010001010011;

		if(({row_reg, col_reg}>=10'b0000110100) && ({row_reg, col_reg}<10'b0001001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0001001001)) color_data = 12'b011001110111;
		if(({row_reg, col_reg}==10'b0001001010)) color_data = 12'b000100000001;
		if(({row_reg, col_reg}==10'b0001001011)) color_data = 12'b100100000000;
		if(({row_reg, col_reg}==10'b0001001100)) color_data = 12'b110100110011;
		if(({row_reg, col_reg}==10'b0001001101)) color_data = 12'b100101110101;
		if(({row_reg, col_reg}==10'b0001001110)) color_data = 12'b111110100000;
		if(({row_reg, col_reg}==10'b0001001111)) color_data = 12'b101110010011;
		if(({row_reg, col_reg}==10'b0001010000)) color_data = 12'b101101100111;
		if(({row_reg, col_reg}==10'b0001010001)) color_data = 12'b110000000000;
		if(({row_reg, col_reg}==10'b0001010010)) color_data = 12'b001000000000;
		if(({row_reg, col_reg}==10'b0001010011)) color_data = 12'b000000010010;

		if(({row_reg, col_reg}>=10'b0001010100) && ({row_reg, col_reg}<10'b0001101001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0001101001)) color_data = 12'b011001100110;
		if(({row_reg, col_reg}==10'b0001101010)) color_data = 12'b010000000000;
		if(({row_reg, col_reg}==10'b0001101011)) color_data = 12'b111100110011;
		if(({row_reg, col_reg}==10'b0001101100)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0001101101)) color_data = 12'b110010011010;
		if(({row_reg, col_reg}==10'b0001101110)) color_data = 12'b110100100000;
		if(({row_reg, col_reg}==10'b0001101111)) color_data = 12'b110101010100;
		if(({row_reg, col_reg}==10'b0001110000)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0001110001)) color_data = 12'b110101100101;
		if(({row_reg, col_reg}==10'b0001110010)) color_data = 12'b101100000001;
		if(({row_reg, col_reg}==10'b0001110011)) color_data = 12'b010000100001;

		if(({row_reg, col_reg}>=10'b0001110100) && ({row_reg, col_reg}<10'b0010001000)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0010001000)) color_data = 12'b000011110001;
		if(({row_reg, col_reg}==10'b0010001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0010001010)) color_data = 12'b110010001000;
		if(({row_reg, col_reg}>=10'b0010001011) && ({row_reg, col_reg}<10'b0010001110)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0010001110)) color_data = 12'b000100100111;
		if(({row_reg, col_reg}==10'b0010001111)) color_data = 12'b011001101000;
		if(({row_reg, col_reg}>=10'b0010010000) && ({row_reg, col_reg}<10'b0010010010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0010010010)) color_data = 12'b101110011000;

		if(({row_reg, col_reg}>=10'b0010010011) && ({row_reg, col_reg}<10'b0010101001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0010101001)) color_data = 12'b010101000100;
		if(({row_reg, col_reg}==10'b0010101010)) color_data = 12'b011001110111;
		if(({row_reg, col_reg}>=10'b0010101011) && ({row_reg, col_reg}<10'b0010101101)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0010101101)) color_data = 12'b011101110110;
		if(({row_reg, col_reg}==10'b0010101110)) color_data = 12'b000001000110;
		if(({row_reg, col_reg}==10'b0010101111)) color_data = 12'b010001000110;
		if(({row_reg, col_reg}>=10'b0010110000) && ({row_reg, col_reg}<10'b0010110010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0010110010)) color_data = 12'b100010101010;
		if(({row_reg, col_reg}==10'b0010110011)) color_data = 12'b001100110011;
		if(({row_reg, col_reg}==10'b0010110100)) color_data = 12'b100010011010;

		if(({row_reg, col_reg}>=10'b0010110101) && ({row_reg, col_reg}<10'b0011001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}>=10'b0011001001) && ({row_reg, col_reg}<10'b0011001011)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b0011001011)) color_data = 12'b100110011010;
		if(({row_reg, col_reg}==10'b0011001100)) color_data = 12'b100001111000;
		if(({row_reg, col_reg}==10'b0011001101)) color_data = 12'b010001010110;
		if(({row_reg, col_reg}==10'b0011001110)) color_data = 12'b000100110110;
		if(({row_reg, col_reg}==10'b0011001111)) color_data = 12'b001101000101;
		if(({row_reg, col_reg}==10'b0011010000)) color_data = 12'b010001010101;
		if(({row_reg, col_reg}==10'b0011010001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0011010010)) color_data = 12'b010001000100;
		if(({row_reg, col_reg}==10'b0011010011)) color_data = 12'b000000000001;
		if(({row_reg, col_reg}==10'b0011010100)) color_data = 12'b011001100110;

		if(({row_reg, col_reg}>=10'b0011010101) && ({row_reg, col_reg}<10'b0011101001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0011101001)) color_data = 12'b000000010000;
		if(({row_reg, col_reg}==10'b0011101010)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b0011101011)) color_data = 12'b000100000000;
		if(({row_reg, col_reg}==10'b0011101100)) color_data = 12'b011001100110;
		if(({row_reg, col_reg}==10'b0011101101)) color_data = 12'b100001111000;
		if(({row_reg, col_reg}==10'b0011101110)) color_data = 12'b000101000110;
		if(({row_reg, col_reg}==10'b0011101111)) color_data = 12'b010001011000;
		if(({row_reg, col_reg}==10'b0011110000)) color_data = 12'b100010011001;
		if(({row_reg, col_reg}==10'b0011110001)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}>=10'b0011110010) && ({row_reg, col_reg}<10'b0011110100)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b0011110100)) color_data = 12'b011001110110;

		if(({row_reg, col_reg}>=10'b0011110101) && ({row_reg, col_reg}<10'b0100001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0100001001)) color_data = 12'b000100000000;
		if(({row_reg, col_reg}==10'b0100001010)) color_data = 12'b000100100000;
		if(({row_reg, col_reg}==10'b0100001011)) color_data = 12'b010101100101;
		if(({row_reg, col_reg}==10'b0100001100)) color_data = 12'b010000110011;
		if(({row_reg, col_reg}==10'b0100001101)) color_data = 12'b010101010110;
		if(({row_reg, col_reg}==10'b0100001110)) color_data = 12'b000001000111;
		if(({row_reg, col_reg}==10'b0100001111)) color_data = 12'b001101000110;
		if(({row_reg, col_reg}==10'b0100010000)) color_data = 12'b010001010100;
		if(({row_reg, col_reg}==10'b0100010001)) color_data = 12'b010000110100;
		if(({row_reg, col_reg}==10'b0100010010)) color_data = 12'b010101000100;
		if(({row_reg, col_reg}==10'b0100010011)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b0100010100)) color_data = 12'b011101110111;

		if(({row_reg, col_reg}>=10'b0100010101) && ({row_reg, col_reg}<10'b0100101100)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0100101100)) color_data = 12'b100110011000;
		if(({row_reg, col_reg}==10'b0100101101)) color_data = 12'b000000000010;
		if(({row_reg, col_reg}==10'b0100101110)) color_data = 12'b001001000110;
		if(({row_reg, col_reg}==10'b0100101111)) color_data = 12'b000000010010;
		if(({row_reg, col_reg}==10'b0100110000)) color_data = 12'b010101000011;

		if(({row_reg, col_reg}>=10'b0100110001) && ({row_reg, col_reg}<10'b0101001100)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0101001100)) color_data = 12'b010101000100;
		if(({row_reg, col_reg}==10'b0101001101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b0101001110)) color_data = 12'b001001000111;
		if(({row_reg, col_reg}==10'b0101001111)) color_data = 12'b000100010100;
		if(({row_reg, col_reg}==10'b0101010000)) color_data = 12'b001000000000;
		if(({row_reg, col_reg}==10'b0101010001)) color_data = 12'b100110001001;

		if(({row_reg, col_reg}>=10'b0101010010) && ({row_reg, col_reg}<10'b0101101010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0101101010)) color_data = 12'b100110011001;
		if(({row_reg, col_reg}==10'b0101101011)) color_data = 12'b001100110100;
		if(({row_reg, col_reg}==10'b0101101100)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b0101101101)) color_data = 12'b010001010101;
		if(({row_reg, col_reg}==10'b0101101110)) color_data = 12'b001101011000;
		if(({row_reg, col_reg}==10'b0101101111)) color_data = 12'b001101010101;
		if(({row_reg, col_reg}==10'b0101110000)) color_data = 12'b000000010010;
		if(({row_reg, col_reg}==10'b0101110001)) color_data = 12'b000100100001;
		if(({row_reg, col_reg}==10'b0101110010)) color_data = 12'b011001100111;

		if(({row_reg, col_reg}>=10'b0101110011) && ({row_reg, col_reg}<10'b0110001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0110001001)) color_data = 12'b000011110001;
		if(({row_reg, col_reg}==10'b0110001010)) color_data = 12'b010000110100;
		if(({row_reg, col_reg}==10'b0110001011)) color_data = 12'b010001000011;
		if(({row_reg, col_reg}==10'b0110001100)) color_data = 12'b011101110111;
		if(({row_reg, col_reg}==10'b0110001101)) color_data = 12'b010001010111;
		if(({row_reg, col_reg}==10'b0110001110)) color_data = 12'b001100110100;
		if(({row_reg, col_reg}==10'b0110001111)) color_data = 12'b001000110101;
		if(({row_reg, col_reg}==10'b0110010000)) color_data = 12'b011110001000;
		if(({row_reg, col_reg}==10'b0110010001)) color_data = 12'b011001100101;
		if(({row_reg, col_reg}==10'b0110010010)) color_data = 12'b001000100010;
		if(({row_reg, col_reg}==10'b0110010011)) color_data = 12'b100010001001;

		if(({row_reg, col_reg}>=10'b0110010100) && ({row_reg, col_reg}<10'b0110101010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0110101010)) color_data = 12'b010001000100;
		if(({row_reg, col_reg}==10'b0110101011)) color_data = 12'b010101100110;
		if(({row_reg, col_reg}>=10'b0110101100) && ({row_reg, col_reg}<10'b0110101110)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==10'b0110101110)) color_data = 12'b010001000100;
		if(({row_reg, col_reg}==10'b0110101111)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==10'b0110110000)) color_data = 12'b001001000011;
		if(({row_reg, col_reg}==10'b0110110001)) color_data = 12'b010001000101;
		if(({row_reg, col_reg}==10'b0110110010)) color_data = 12'b010101010110;
		if(({row_reg, col_reg}==10'b0110110011)) color_data = 12'b100010001000;
		if(({row_reg, col_reg}==10'b0110110100)) color_data = 12'b000011100000;

		if(({row_reg, col_reg}>=10'b0110110101) && ({row_reg, col_reg}<10'b0111001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0111001001)) color_data = 12'b000011110001;
		if(({row_reg, col_reg}==10'b0111001010)) color_data = 12'b001000100011;
		if(({row_reg, col_reg}==10'b0111001011)) color_data = 12'b000000000010;
		if(({row_reg, col_reg}==10'b0111001100)) color_data = 12'b001001000110;
		if(({row_reg, col_reg}==10'b0111001101)) color_data = 12'b010101010110;
		if(({row_reg, col_reg}==10'b0111001110)) color_data = 12'b001000010010;
		if(({row_reg, col_reg}==10'b0111001111)) color_data = 12'b001101000101;
		if(({row_reg, col_reg}==10'b0111010000)) color_data = 12'b010001010110;
		if(({row_reg, col_reg}==10'b0111010001)) color_data = 12'b000100100100;
		if(({row_reg, col_reg}==10'b0111010010)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b0111010011)) color_data = 12'b100010011001;

		if(({row_reg, col_reg}>=10'b0111010100) && ({row_reg, col_reg}<10'b0111101010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0111101010)) color_data = 12'b011110001001;
		if(({row_reg, col_reg}==10'b0111101011)) color_data = 12'b000100100101;
		if(({row_reg, col_reg}==10'b0111101100)) color_data = 12'b010001010111;
		if(({row_reg, col_reg}==10'b0111101101)) color_data = 12'b001000110101;
		if(({row_reg, col_reg}==10'b0111101110)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b0111101111)) color_data = 12'b000000000001;
		if(({row_reg, col_reg}==10'b0111110000)) color_data = 12'b010001101001;
		if(({row_reg, col_reg}==10'b0111110001)) color_data = 12'b001000110100;
		if(({row_reg, col_reg}==10'b0111110010)) color_data = 12'b010001010101;
		if(({row_reg, col_reg}==10'b0111110011)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b0111110100)) color_data = 12'b000011100000;

		if(({row_reg, col_reg}>=10'b0111110101) && ({row_reg, col_reg}<10'b1000001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1000001001)) color_data = 12'b000011100000;
		if(({row_reg, col_reg}==10'b1000001010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1000001011)) color_data = 12'b000001001000;
		if(({row_reg, col_reg}==10'b1000001100)) color_data = 12'b001101000111;
		if(({row_reg, col_reg}==10'b1000001101)) color_data = 12'b010101000011;
		if(({row_reg, col_reg}==10'b1000001110)) color_data = 12'b001000010000;
		if(({row_reg, col_reg}==10'b1000001111)) color_data = 12'b010000110010;
		if(({row_reg, col_reg}==10'b1000010000)) color_data = 12'b010001010100;
		if(({row_reg, col_reg}==10'b1000010001)) color_data = 12'b000100110110;
		if(({row_reg, col_reg}==10'b1000010010)) color_data = 12'b011001101001;

		if(({row_reg, col_reg}>=10'b1000010011) && ({row_reg, col_reg}<10'b1000101010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1000101010)) color_data = 12'b100110001000;
		if(({row_reg, col_reg}==10'b1000101011)) color_data = 12'b000000100101;
		if(({row_reg, col_reg}==10'b1000101100)) color_data = 12'b011001100101;
		if(({row_reg, col_reg}==10'b1000101101)) color_data = 12'b111110100001;
		if(({row_reg, col_reg}>=10'b1000101110) && ({row_reg, col_reg}<10'b1000110000)) color_data = 12'b111110100000;
		if(({row_reg, col_reg}==10'b1000110000)) color_data = 12'b101010000011;
		if(({row_reg, col_reg}==10'b1000110001)) color_data = 12'b000000111000;
		if(({row_reg, col_reg}==10'b1000110010)) color_data = 12'b010001010101;

		if(({row_reg, col_reg}>=10'b1000110011) && ({row_reg, col_reg}<10'b1001001010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1001001010)) color_data = 12'b100110011001;
		if(({row_reg, col_reg}==10'b1001001011)) color_data = 12'b000000000010;
		if(({row_reg, col_reg}==10'b1001001100)) color_data = 12'b101001000010;
		if(({row_reg, col_reg}==10'b1001001101)) color_data = 12'b111010000000;
		if(({row_reg, col_reg}==10'b1001001110)) color_data = 12'b100001000000;
		if(({row_reg, col_reg}==10'b1001001111)) color_data = 12'b110010000000;
		if(({row_reg, col_reg}==10'b1001010000)) color_data = 12'b111101100001;
		if(({row_reg, col_reg}==10'b1001010001)) color_data = 12'b001000000011;
		if(({row_reg, col_reg}==10'b1001010010)) color_data = 12'b010001010101;

		if(({row_reg, col_reg}>=10'b1001010011) && ({row_reg, col_reg}<10'b1001101010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1001101010)) color_data = 12'b100010001000;
		if(({row_reg, col_reg}==10'b1001101011)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1001101100)) color_data = 12'b110000000000;
		if(({row_reg, col_reg}==10'b1001101101)) color_data = 12'b110100000000;
		if(({row_reg, col_reg}==10'b1001101110)) color_data = 12'b000000000011;
		if(({row_reg, col_reg}==10'b1001101111)) color_data = 12'b011000000001;
		if(({row_reg, col_reg}==10'b1001110000)) color_data = 12'b111100000000;
		if(({row_reg, col_reg}==10'b1001110001)) color_data = 12'b001100000000;
		if(({row_reg, col_reg}==10'b1001110010)) color_data = 12'b001101000100;

		if(({row_reg, col_reg}>=10'b1001110011) && ({row_reg, col_reg}<10'b1010001010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1010001010)) color_data = 12'b100110101000;
		if(({row_reg, col_reg}==10'b1010001011)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1010001100)) color_data = 12'b010100000000;
		if(({row_reg, col_reg}==10'b1010001101)) color_data = 12'b100000100011;
		if(({row_reg, col_reg}==10'b1010001110)) color_data = 12'b000001010110;
		if(({row_reg, col_reg}==10'b1010001111)) color_data = 12'b001100110101;
		if(({row_reg, col_reg}==10'b1010010000)) color_data = 12'b100100000001;
		if(({row_reg, col_reg}==10'b1010010001)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1010010010)) color_data = 12'b010001010101;
		if(({row_reg, col_reg}==10'b1010010011)) color_data = 12'b000011100000;
		if(({row_reg, col_reg}==10'b1010010100)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1010010101)) color_data = 12'b000111110000;

		if(({row_reg, col_reg}>=10'b1010010110) && ({row_reg, col_reg}<10'b1010101010)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1010101010)) color_data = 12'b011110000111;
		if(({row_reg, col_reg}==10'b1010101011)) color_data = 12'b000000000001;
		if(({row_reg, col_reg}==10'b1010101100)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1010101101)) color_data = 12'b000100100101;
		if(({row_reg, col_reg}==10'b1010101110)) color_data = 12'b001000110111;
		if(({row_reg, col_reg}==10'b1010101111)) color_data = 12'b001001000111;
		if(({row_reg, col_reg}==10'b1010110000)) color_data = 12'b001000010001;
		if(({row_reg, col_reg}==10'b1010110001)) color_data = 12'b000000000001;
		if(({row_reg, col_reg}==10'b1010110010)) color_data = 12'b010001000100;

		if(({row_reg, col_reg}>=10'b1010110011) && ({row_reg, col_reg}<10'b1011001011)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1011001011)) color_data = 12'b000100010000;
		if(({row_reg, col_reg}==10'b1011001100)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1011001101)) color_data = 12'b000100110100;
		if(({row_reg, col_reg}==10'b1011001110)) color_data = 12'b000101000111;
		if(({row_reg, col_reg}==10'b1011001111)) color_data = 12'b001100110110;
		if(({row_reg, col_reg}==10'b1011010000)) color_data = 12'b000000000001;
		if(({row_reg, col_reg}==10'b1011010001)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1011010010)) color_data = 12'b010101100101;
		if(({row_reg, col_reg}==10'b1011010011)) color_data = 12'b110011001100;
		if(({row_reg, col_reg}==10'b1011010100)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1011010101)) color_data = 12'b000011110001;

		if(({row_reg, col_reg}>=10'b1011010110) && ({row_reg, col_reg}<10'b1011101001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1011101001)) color_data = 12'b100001111000;
		if(({row_reg, col_reg}==10'b1011101010)) color_data = 12'b010101000101;
		if(({row_reg, col_reg}==10'b1011101011)) color_data = 12'b001100110010;
		if(({row_reg, col_reg}==10'b1011101100)) color_data = 12'b010000110100;
		if(({row_reg, col_reg}==10'b1011101101)) color_data = 12'b000100110011;
		if(({row_reg, col_reg}==10'b1011101110)) color_data = 12'b000101001000;
		if(({row_reg, col_reg}==10'b1011101111)) color_data = 12'b000100110110;
		if(({row_reg, col_reg}==10'b1011110000)) color_data = 12'b001000110011;
		if(({row_reg, col_reg}==10'b1011110001)) color_data = 12'b001100110011;
		if(({row_reg, col_reg}==10'b1011110010)) color_data = 12'b001101000011;
		if(({row_reg, col_reg}==10'b1011110011)) color_data = 12'b010101100110;

		if(({row_reg, col_reg}>=10'b1011110100) && ({row_reg, col_reg}<10'b1100001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1100001001)) color_data = 12'b011001100110;
		if(({row_reg, col_reg}==10'b1100001010)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1100001011)) color_data = 12'b000000010000;
		if(({row_reg, col_reg}==10'b1100001100)) color_data = 12'b010000110100;
		if(({row_reg, col_reg}==10'b1100001101)) color_data = 12'b000000110100;
		if(({row_reg, col_reg}==10'b1100001110)) color_data = 12'b001001000111;
		if(({row_reg, col_reg}==10'b1100001111)) color_data = 12'b001000110110;
		if(({row_reg, col_reg}==10'b1100010000)) color_data = 12'b001100100011;
		if(({row_reg, col_reg}==10'b1100010001)) color_data = 12'b001000110010;
		if(({row_reg, col_reg}==10'b1100010010)) color_data = 12'b000000000001;
		if(({row_reg, col_reg}==10'b1100010011)) color_data = 12'b000100010010;

		if(({row_reg, col_reg}>=10'b1100010100) && ({row_reg, col_reg}<10'b1100101001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1100101001)) color_data = 12'b011001100110;
		if(({row_reg, col_reg}==10'b1100101010)) color_data = 12'b000100000000;
		if(({row_reg, col_reg}>=10'b1100101011) && ({row_reg, col_reg}<10'b1100101101)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1100101101)) color_data = 12'b000000010100;
		if(({row_reg, col_reg}==10'b1100101110)) color_data = 12'b000100110111;
		if(({row_reg, col_reg}==10'b1100101111)) color_data = 12'b000000100110;
		if(({row_reg, col_reg}==10'b1100110000)) color_data = 12'b000000000010;
		if(({row_reg, col_reg}>=10'b1100110001) && ({row_reg, col_reg}<10'b1100110011)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1100110011)) color_data = 12'b001100100001;

		if(({row_reg, col_reg}>=10'b1100110100) && ({row_reg, col_reg}<10'b1101001001)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1101001001)) color_data = 12'b011001110111;
		if(({row_reg, col_reg}==10'b1101001010)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1101001011)) color_data = 12'b001100100010;
		if(({row_reg, col_reg}==10'b1101001100)) color_data = 12'b011101010101;
		if(({row_reg, col_reg}==10'b1101001101)) color_data = 12'b000100000001;
		if(({row_reg, col_reg}==10'b1101001110)) color_data = 12'b000100100001;
		if(({row_reg, col_reg}==10'b1101001111)) color_data = 12'b000100010001;
		if(({row_reg, col_reg}==10'b1101010000)) color_data = 12'b001100110100;
		if(({row_reg, col_reg}==10'b1101010001)) color_data = 12'b010101100101;
		if(({row_reg, col_reg}==10'b1101010010)) color_data = 12'b000000000000;
		if(({row_reg, col_reg}==10'b1101010011)) color_data = 12'b001100100011;

		if(({row_reg, col_reg}>=10'b1101010100) && ({row_reg, col_reg}<10'b1101101011)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1101101011)) color_data = 12'b100010001000;
		if(({row_reg, col_reg}==10'b1101101100)) color_data = 12'b010000110100;
		if(({row_reg, col_reg}==10'b1101101101)) color_data = 12'b011001111000;
		if(({row_reg, col_reg}==10'b1101101110)) color_data = 12'b011001111001;
		if(({row_reg, col_reg}==10'b1101101111)) color_data = 12'b011110001001;
		if(({row_reg, col_reg}==10'b1101110000)) color_data = 12'b010001010110;
		if(({row_reg, col_reg}==10'b1101110001)) color_data = 12'b011001100111;

		if(({row_reg, col_reg}>=10'b1101110010) && ({row_reg, col_reg}<10'b1110001011)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1110001011)) color_data = 12'b000011110001;
		if(({row_reg, col_reg}==10'b1110001100)) color_data = 12'b000100010011;
		if(({row_reg, col_reg}==10'b1110001101)) color_data = 12'b000100110101;
		if(({row_reg, col_reg}==10'b1110001110)) color_data = 12'b000000110111;
		if(({row_reg, col_reg}==10'b1110001111)) color_data = 12'b000000110110;
		if(({row_reg, col_reg}==10'b1110010000)) color_data = 12'b000100100011;
		if(({row_reg, col_reg}==10'b1110010001)) color_data = 12'b011001100110;

		if(({row_reg, col_reg}>=10'b1110010010) && ({row_reg, col_reg}<10'b1110101011)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1110101011)) color_data = 12'b100110011001;
		if(({row_reg, col_reg}==10'b1110101100)) color_data = 12'b001101000100;
		if(({row_reg, col_reg}==10'b1110101101)) color_data = 12'b011110001001;
		if(({row_reg, col_reg}==10'b1110101110)) color_data = 12'b011110001010;
		if(({row_reg, col_reg}==10'b1110101111)) color_data = 12'b100010001010;
		if(({row_reg, col_reg}==10'b1110110000)) color_data = 12'b010001010111;
		if(({row_reg, col_reg}==10'b1110110001)) color_data = 12'b010101100101;
		if(({row_reg, col_reg}>=10'b1110110010) && ({row_reg, col_reg}<10'b1110110101)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1110110101)) color_data = 12'b000011100000;
		if(({row_reg, col_reg}==10'b1110110110)) color_data = 12'b000011110000;
		if(({row_reg, col_reg}==10'b1110110111)) color_data = 12'b000011100000;

		if(({row_reg, col_reg}>=10'b1110111000) && ({row_reg, col_reg}<=10'b1110111101)) color_data = 12'b000011110000;
	end
endmodule