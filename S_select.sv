module S_select(input logic [7:0] S, Sinv,
      input logic Sub,
      output logic [7:0] s);
       
       // Why @ S???
  always @(S or Sub)
  begin: case_process
  
  case(Sub)
  1'b0 :  s = S;
  1'b1 :  s = Sinv; 
  default: s = 1'b0; 
  endcase 
  end
 
endmodule