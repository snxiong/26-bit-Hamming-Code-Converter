module hamming
(
	input clock, reset,
	input [25:0] data, 
	output reg [31:0] parityData
);
	
	wire [5:0] parityBits;
	
	
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

	
	p1Parity p1_Mod(clock, reset, data, parityBits[0]);
	p2Parity p2_Mod(clock, reset, data, parityBits[1]);
	p4Parity p4_Mod(clock, reset, data, parityBits[2]);
	p8Parity p8_Mod(clock, reset, data, parityBits[3]);				
	p16Parity p16_Mod(clock, reset, data, parityBits[4]);
	cParity c_Mod(clock, reset, data,parityBits ,parityBits[5]);
	


	always@(*)
	begin
	#15
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
		parityData[31] = parityData[5];
	end

/*	

	integer i;
	integer j = 0;
	
	always @(posedge clock)
		for(i = 0; i < 32; i = i + 1) begin
			if(i == 0)	// aasigning p1
				assign parityData[i] = parityBits[0];
			else if(i == 1)	// assigning p2
				assign parityData[i] = parityBits[1];
			else if(i == 3)
				assign parityData[i] = parityBits[2];
			else if(i == 7)
				assign parityData[i] = parityBits[3];
			else if(i == 15)
				assign parityData[i] = parityBits[4];
			else
				assign parityData[i] = data[j];
				j = j + 1;
			
		end
*/	
			
	
endmodule

module cParity
(	
	input clock, reset,
	input [25:0] data,
	input [5:0] parityData,
	output reg cBit
);
	wire [29:0] xor0;
	// c = p1 xor p2 xor d1 xor p4 xor d1 xor d2 xor d3 xor p8 xor d4 xor d5 xor
	// d6 xor d7 xor d8 xor d9 xor d10 xor p16 xor d11 xor d12 xor d13 xor
	// d14 xor d15 xor d16 xor d17 xor d18 xor d19 xor d20 xor d21 xor d22
	// xor d23 xor d24 xor d25
	xor(xor0[0], parityData[0], parityData[1]);
	xor(xor0[1], xor0[0], data[0]);
	xor(xor0[2], xor0[1], parityData[2]);
	xor(xor0[3], xor0[2], data[1]);
	xor(xor0[4], xor0[3], data[2]);
	xor(xor0[5], xor0[4], data[3]);
	xor(xor0[6], xor0[5], parityData[3]);
	xor(xor0[7], xor0[6], data[4]);
	xor(xor0[8], xor0[7], data[5]);
	xor(xor0[9], xor0[8], data[6]);
	xor(xor0[10], xor0[9], data[7]);
	xor(xor0[11], xor0[10], data[8]);
	xor(xor0[12], xor0[11], data[9]);
	xor(xor0[13], xor0[12], data[10]);
	xor(xor0[14], xor0[13], parityData[4]);
	xor(xor0[15], xor0[14], data[11]);
	xor(xor0[16], xor0[15], data[12]);
	xor(xor0[17], xor0[16], data[13]);
	xor(xor0[18], xor0[17], data[14]);
	xor(xor0[19], xor0[18], data[15]);
	xor(xor0[20], xor0[19], data[16]);
	xor(xor0[21], xor0[20], data[17]);
	xor(xor0[22], xor0[21], data[18]);
	xor(xor0[23], xor0[22], data[19]);
	xor(xor0[24], xor0[23], data[20]);
	xor(xor0[25], xor0[24], data[21]);
	xor(xor0[26], xor0[25], data[22]);
	xor(xor0[27], xor0[26], data[23]);
	xor(xor0[28], xor0[27], data[24]);
	xor(xor0[29], xor0[28], data[25]);

	always@(*)
	begin
	//	xor(xor0, parityData[0], parityData[1]);
		cBit = xor0[29];
		//$display("#4 data = %b", data);
	end
		
	/*
	always@(*)
	begin
		cBit = xor0;
	end	
*/
	//assign cBit = xor0;
/*
	initial begin
		cBit = xor0;
		#5; $monitor("data = %b\nc = %b", data, cBit);
	end
*/	
endmodule

module p1Parity
(
	input clock, reset,
	input [25:0] data,
	output  reg p1Bit
);
	wire [13:0] xor1;
	
	// p1 = d0 xor d1 xor d3 xor d4 xor d6 xor d8 xor d10 xor d11 xor d13
	// xor d15 xor d17 xor d19 xor d21 xor d23 xor d25
	xor(xor1[0], data[0], data[1]);
	xor(xor1[1], xor1[0], data[3]);
	xor(xor1[2], xor1[1], data[4]);
	xor(xor1[3], xor1[2], data[6]);
	xor(xor1[4], xor1[3], data[8]);
	xor(xor1[5], xor1[4], data[10]);
	xor(xor1[6], xor1[5], data[11]);
	xor(xor1[7], xor1[6], data[13]);
	xor(xor1[8], xor1[7], data[15]);
	xor(xor1[9], xor1[8], data[17]);
	xor(xor1[10], xor1[9], data[19]);
	xor(xor1[11], xor1[10], data[21]);
	xor(xor1[12], xor1[11], data[23]);
	xor(xor1[13], xor1[12], data[25]);
	
	always@(*)
	begin
	//	xor(xor1, data[0], data[1]);
		p1Bit = xor1[13];
		//$display("#5 data = %b, p1bit = %b", data, p1Bit);
	end
	//assign p1Bit = xor1;
/*	
	initial begin
		p1Bit = xor1;
		#5 $monitor("p1 = %b", p1Bit);
	end
*/	
endmodule
	
module p2Parity
(
	input clock, reset,
	input [25:0] data,
	output reg p2Bit
);
	
	wire [13:0] xor2;
	
	// p2 = d0 xor s2 xor s3 xor s5 xor s6 xor d9 xor d10 xor d12 xor d13
	// xor d16 xor d17 xor d20 xor d21 xor d23 xor d24
	xor(xor2[0], data[0], data[2]);
	xor(xor2[1], xor2[0], data[3]);
	xor(xor2[2], xor2[1], data[5]);
	xor(xor2[3], xor2[2], data[6]);
	xor(xor2[4], xor2[3], data[9]);
	xor(xor2[5], xor2[4], data[10]);
	xor(xor2[6], xor2[5], data[12]);
	xor(xor2[7], xor2[6], data[13]);
	xor(xor2[8], xor2[7], data[16]);
	xor(xor2[9], xor2[8], data[17]);
	xor(xor2[10], xor2[9], data[20]);
	xor(xor2[11], xor2[10], data[21]);
	xor(xor2[12], xor2[11], data[23]);
	xor(xor2[13], xor2[12], data[24]);
	
	always@(*)
	begin
		p2Bit = xor2[13];
		//$display("#6 p2 bit = %b", p2Bit);
	end	

	//assign p2Bit = xor2;
	
/*
	initial begin
		p2Bit = xor2;
		$display("data = %b\np2 = %b",data, p2Bit);
	end
*/	
endmodule

module p4Parity
(
	input clock, reset,
	input [25:0] data,
	output reg  p4Bit
);
	wire [13:0] xor3;
	
	// p4 = d1 xor d2 xor d3 xor d7 xor d8 xor d9 xor d10 xor d14 xor d15
	// xor d16 xor d17 xor d22 xor d23 xor d24 xor d25
	xor(xor3[0], data[1], data[2]);
	xor(xor3[1], xor3[0], data[3]);
	xor(xor3[2], xor3[1], data[7]);
	xor(xor3[3], xor3[2], data[8]);
	xor(xor3[4], xor3[3], data[9]);
	xor(xor3[5], xor3[4], data[10]);
	xor(xor3[6], xor3[5], data[14]);
	xor(xor3[7], xor3[6], data[15]);
	xor(xor3[8], xor3[7], data[16]);
	xor(xor3[9], xor3[8], data[17]);
	xor(xor3[10], xor3[9], data[22]);
	xor(xor3[11], xor3[10], data[23]);
	xor(xor3[12], xor3[11], data[24]);
	xor(xor3[13], xor3[12], data[25]);

	always@(*)
	begin
		p4Bit = xor3[13];
		//$display("#7 p4 bit = %b", p4Bit);
	end

	//assign p4Bit = xor3;
/*
	initial begin
		p4Bit = xor3;
		$display("data = %b\np3 = %b",data,  p4Bit);
	end
*/		
endmodule

module p8Parity
(
	input clock, reset,
	input [25:0] data,
	output reg p8Bit
);

	wire [13:0]xor4;
	
	// p8 = d4 xor d5 xor d6 xor d7 xor d8 xor d9 xor d10 xor d18 xor d19
	// xor d20 xor d21 xor d22 xor d23 xor d24 xor d25	
	xor(xor4[0], data[4], data[5]);
	xor(xor4[1], xor4[0], data[6]);
	xor(xor4[2], xor4[1], data[7]);
	xor(xor4[3], xor4[2], data[8]);
	xor(xor4[4], xor4[3], data[9]);
	xor(xor4[5], xor4[4], data[10]);
	xor(xor4[6], xor4[5], data[18]);
	xor(xor4[7], xor4[6], data[19]);
	xor(xor4[8], xor4[7], data[20]);
	xor(xor4[9], xor4[8], data[21]);
	xor(xor4[10], xor4[9], data[22]);
	xor(xor4[11], xor4[10], data[23]);
	xor(xor4[12], xor4[11], data[24]);
	xor(xor4[13], xor4[12], data[25]);
	
	always@(*)
	begin
		p8Bit = xor4[13];
	end
	
	//assign p8Bit = xor4;
/*
	initial begin
		p8Bit = xor4;
		$display("data = %b\np8 = %b", data, p8Bit);
	end
*/	
endmodule

module p16Parity
(
	input clock, reset,
	input [25:0] data,
	output reg p16Bit
);

	wire [13:0]xor5;
	
	// p16 = d11 xor d12 xor d13 xor d14 xor d15 xor d16 xor d17 xor d18
	// xor d19 xor d19 xor d20 xor d21 xor d22 xor d23 xor d24 xor d25
	xor(xor5[0], data[11], data[12]);
	xor(xor5[1], xor5[0], data[13]);
	xor(xor5[2], xor5[1], data[14]);
	xor(xor5[3], xor5[2], data[15]);
	xor(xor5[4], xor5[3], data[16]);
	xor(xor5[5], xor5[4], data[17]);
	xor(xor5[6], xor5[5], data[18]);
	xor(xor5[7], xor5[6], data[19]);
	xor(xor5[8], xor5[7], data[20]);
	xor(xor5[9], xor5[8], data[21]);
	xor(xor5[10], xor5[9], data[22]);
	xor(xor5[11], xor5[10], data[23]);
	xor(xor5[12], xor5[11], data[24]);
	xor(xor5[13], xor5[12], data[25]);
	
	always@(*)
	begin	
		
		p16Bit = xor5[13];
		//i#10;	$display("p16 bit = %b", p16Bit);
	end
	
	//assign p16Bit = xor5;
	
/*	
	initial begin
		p16Bit = xor5;
		$display("data = %b\np16 = %b",data,  p16Bit);
	end
*/	
endmodule
/*
module hammingScheme
(	input [3:0] data, 
	output [7:0] parityData
);
	//reg [3:0] data; // holds d7 d6 d5 d3
	//output [7:0] parityData;
	wire c;
	wire [2:0] parity; // holds p1 p2 p4
	wire xor1, xor2, xor3, c1, c2, c3, c4, c5, c6;
	
	// finding p1, p1 = d3 xor d5 xor d7
	xor(xor1, data[1], data[3]); // xor1 = d5 xor d7
	xor(parity[0], xor1, data[0]); // firstParity[0] = xor1 xor d3
	
	// finding p2, p2 = d3 xor d6 xor d7
	xor(xor2, data[2], data[3]); // xor2 = d6 xor d7
	xor(parity[1], xor2, data[0]);
	
	//finding p4, p4 = d5 xor d6 xor d7
	xor(xor3, data[3], data[2]);
	xor(parity[2], xor3, data[1]);

	//finding c, c = d7 xor d6 xor d5 xor p4 xor d3 xor p2 xor p1
	xor(c1, parity[0], parity[1]);
	xor(c2, c1, data[0]);
	xor(c3, c2, parity[2]);
	xor(c4, c3, data[1]);
	xor(c5, c4, data[2]);
	xor(c, c5, data[3]);
 
	//hamming code creation
	assign parityData[7] = c;
	assign parityData[6] = data[3];
	assign parityData[5] = data[2];
	assign parityData[4] = data[1];
	assign parityData[3] = parity[2];
	assign parityData[2] = data[0];
	assign parityData[1] = parity[1];
	assign parityData[0] = parity[0];	
	
endmodule
*/
