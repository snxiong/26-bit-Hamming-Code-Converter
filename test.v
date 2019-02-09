`include "HammingConverter32.v"

module test();

	reg [25:0] data;
	wire [31:0] parityData;
	reg clock, reset;
		
//	hamming my_hammingMod(clock, data, parityData);
	
	initial begin
		#15
		$display("Converets a 26-bit code into its 32-bit hamming code equivalent");  
		$display("Data	     =       %b  %h", data, data);
		$monitor("Hamming Code = %b %h",parityData,  parityData);	
	end
	
	
	initial begin
		//$monitor("#1 Parity Data = %b", parityData);
		clock = 0;
		reset = 0;
		#5 data = 26'b01101100011101010100110101;// $display("#1 data = %b", data);
		#10 $finish;
	
	end
	
	always begin
		#5 clock = !clock;
	end
		
	hamming my_hammingMod(clock, reset, data, parityData);
/*	
	initial begin
		#1; data = 12'b111100001100; $display("data = %b", data);
		#1 $finish;
	end	
	//	hamming my_hammingMod(clock, reset, data, parityData);
*/
	//reg [9:0] a;
	//integer i;
	/*
	initial begin
	#1; a = 6'b111111;
		for(i = 0; i < 8; i = i +1)begin
			$display("a[%d] = %d",i, a[i]);
		end
	$display("a = %b", a);
	end	
	
	initial begin
		
	#1; a = 8'b11111111;
	end
	*/
	
endmodule
