module full_adder (input logic x, y, z, output logic s, c);
						 
	assign s = x^y^z;
	assign c = (x&y)|(y&z)|(x&z);
	
endmodule