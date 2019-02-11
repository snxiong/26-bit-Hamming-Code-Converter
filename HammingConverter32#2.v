// finalized version of hamming code converter
// to be used with test2.v
module hamming
(
	input clock, reset,
	input [25:0] data, 
	output reg [31:0] parityData
);
	
	wire [5:0] parityBits;
	integer i;
	integer j = 0;	
	
	always@(posedge clock or posedge reset)
	begin
	
		parityData[0] = parityBits[0];	
		parityData[1] = parityBits[1];	
		parityData[2] = data[0];
		parityData[3] = parityBits[2];	
		parityData[4] = data[1];
		parityData[5] = data[2];
		parityData[6] = data[3];
		parityData[7] = parityBits[3];	
		parityData[8] = data[4];
		parityData[9] = data[5];
		parityData[10] = data[6];
		parityData[11] = data[7];
		parityData[12] = data[8];
		parityData[13] = data[9];
		parityData[14] = data[10];
		parityData[15] = parityBits[4];
		parityData[16] = data[11];
		parityData[17] = data[12];
		parityData[18] = data[13];
		parityData[19] = data[14];
		parityData[20] = data[15];
		parityData[21] = data[16];
		parityData[22] = data[17];
		parityData[23] = data[18];
		parityData[24] = data[19];
		parityData[25] = data[20];
		parityData[26] = data[21];
		parityData[27] = data[22];
		parityData[28] = data[23];
		parityData[29] = data[24];
		parityData[30] = data[25];
		parityData[31] = parityBits[5];
		
		//#10	
		//$display("#3 parity Bits = %b", parityBits);	
		//$display("#3 data = %b", data);

		//#5	
		//$monitor("#3 parity Data = %b", parityData);

	end

	p1Parity p1_Mod(clock, reset, parityData, parityBits[0]); // Assigns parity P1
	p2Parity p2_Mod(clock, reset, parityData, parityBits[1]); // Assigns parity P2
	p4Parity p4_Mod(clock, reset, parityData, parityBits[2]); // Assigns parity P4
	p8Parity p8_Mod(clock, reset, parityData, parityBits[3]); // Assigns parity P8	
	p16Parity p16_Mod(clock, reset, parityData, parityBits[4]); // Assigns parity P16
	cParity c_Mod(clock, reset, parityData, parityBits[5]); // Assigns overall C
		
endmodule

// cBit = p1 xor p2 xor d0 xor p4 xor d1 xor d2 xor d3 xor p8 xor d4 xor d5
// xor d6 xor d7 xor d8 xor d9 xor d10 xor p16 xor d11 xor d12 xor d13 xor d14
// xor d15 xor d16 xor d17 xor d18 xor d19 xor d20 xor d21 xor d22 xor d23 xor
// d24 xor d25
module cParity
(	
	input clock, reset,
	input [31:0] parityData,
	output reg cBit
);
	integer i;
	integer amount = 0;
	
	always@(posedge clock or posedge reset)
	begin
		for(i = 0; i < 31; i = i + 1)begin
			if(parityData[i] == 1)
				amount = amount + 1;
		end
		
		if((amount % 2) == 1)
			cBit = 1;
		else
			cBit = 0;
			
	end	
	
endmodule

// p1Bit = d1 xor d3 xor d4 xor d6 xor d8 xor d10 xor d11 xor d13 xor d15 xor
// d17 xor d19 xor d21 xor d23 xor d25
module p1Parity
(
	input clock, reset,
	input [31:0] parityData,
	output  reg p1Bit
);

	integer i;
	integer amount = 0;
	 
	always@(posedge clock or posedge reset)
	begin	
		for(i = 2; i < 32; i = i + 2)begin
			if(parityData[i] == 1)
				amount = amount + 1;
		end
		if((amount % 2) == 1)
			p1Bit = 1;
		else
			p1Bit = 0;				
	end
	
endmodule

// p2Bit = d0 xor d2 xor d3 xor d5 xor d6 xor d9 xor d10 xor d12 xor d13 xor
// d16 xor d17 xor d20 xor d21 xor d24 xor d25	
module p2Parity
(
	input clock, reset,
	input [31:0] parityData,
	output reg p2Bit
);
	
	integer i, j;
	integer amount = 0;
	
	always@(posedge clock or posedge reset)
	begin
		for(i = 1; i < 32; i = i + 4)begin
			for(j = i; i < j + 1; i = i + 1)begin
				if(parityData[j] == 1)
					amount = amount + 1;
			end
		end

		if((amount % 2) == 1)
			p2Bit = 1;
		else
			p2Bit = 0;
	end		
endmodule

// p4Bit = d1 xor d2 xor d3 xor d7 xor d8 xor d9 xor d10 xor d14 xor d15 xor
// d16 xor d17 xor d22 xor d23 xor d24 xor d25
module p4Parity
(
	input clock, reset,
	input [31:0] parityData,
	output reg  p4Bit
);
	
	integer i, j;
	integer amount = 0;

	always@(posedge clock or posedge reset)
	begin
		for(i = 3; i < 32; i = i + 8)begin
			for(j = i; i < j + 3; i = i + 1)begin
				if(parityData[j] == 1)
					amount = amount + 1;
			end
		end
	
		if((amount % 2) == 1)
			p4Bit = 1;
		else
			p4Bit = 0;
	end

endmodule

// p8Bit = d4 xor d5 xor d6 xor d7 xor d8 xor d9 xor d10 xor d18 xor d19 xor
// d20 xor d21 xor d22 xor d23 xor d24 xor d25
module p8Parity
(
	input clock, reset,
	input [31:0] parityData,
	output reg p8Bit
);

	integer i, j;
	integer amount = 0;
	
	always@(posedge clock or posedge reset)
	begin
		for(i = 7; i < 32; i = i + 16)begin
			for(j = i; i < j + 7; i = i + 1)begin
				if(parityData[j] == 1)
					amount = amount + 1;	
			end
		end
		
		if((amount % 2) == 1)
			p8Bit = 1;
		else
			p8Bit = 0;	
	end
endmodule

// p16Bit = d11 xor d12 xor d13 xor d14 xor d15 xor d16 xor d17 xor d18 xor
// d19 xor d20 xor d21 xor d22 xor d23 xor d24 xor d25
module p16Parity
(
	input clock, reset,
	input [31:0] parityData,
	output reg p16Bit
);

	integer i;
	
	integer amount = 0;

	always@(posedge clock or posedge reset)
	begin
		for(i = 15; i < 31; i = i + 1)begin
			if(parityData[i] == 1)
				amount = amount + 1;
		end
		
		if((amount % 2) == 1)
			p16Bit = 1;
		else
			p16Bit = 0;
			
		end
endmodule
