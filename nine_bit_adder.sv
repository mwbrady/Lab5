module nine_bit_adder(input logic [8:0] A, S,
    output logic [8:0] R);
  // Internal carries in the 2-bit adder
  wire c1, c2, c3, c4, c5, c6, c7, c8;
 
  full_adder FA0(.x (A[0]), .y (B[0]), .z (0), .s (S[0]), .c(c1));
  full_adder FA1(.x (A[1]), .y (B[1]), .z (c1), .s (S[1]), .c(c2));
  full_adder FA2(.x (A[2]), .y (B[2]), .z (c2), .s (S[2]), .c(c3));
  full_adder FA3(.x (A[3]), .y (B[3]), .z (c3), .s (S[3]), .c(c4));
  full_adder FA4(.x (A[4]), .y (B[4]), .z (c4), .s (S[4]), .c(c5));
  full_adder FA5(.x (A[5]), .y (B[5]), .z (c5), .s (S[5]), .c(c6));
  full_adder FA6(.x (A[6]), .y (B[6]), .z (c6), .s (S[6]), .c(c7));
  full_adder FA7(.x (A[7]), .y (B[7]), .z (c7), .s (S[7]), .c(c8));
  full_adder FA8(.x (A[8]), .y (B[8]), .z (c8), .s (S[8]));
    
endmodule