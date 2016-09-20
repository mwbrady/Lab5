module eight_bit_multiplier (
	input logic [7:0] S,
	input logic Clk, Reset, Run, ClearA_LoadB,
	output logic [6:0] AhexU, AhexL, BhexU, BhexL,
	output logic [7:0] Aval, Bval,
	output logic X
);

logic Shift, bin, Sub, c1, Clr_Ld, Reset_SH, ClearA_LoadB_SH, Run_SH;
logic [7:0] Data_OutA, Data_OutB, Data_InA, C, Sel, D, A, B, Z, S_S;
logic M, L;

assign C = ~S;
assign Aval = Data_OutA[7:0];
assign Bval = Data_OutB[7:0];

	 //Instantiation of modules here
	reg_X    		reg_unitA (
						.Load(L),
				        .Clk(Clk),
				        .Reset(Clr_Ld),
				        .Shift_En(Shift),
				        .D(Data_InA[7:0]),
				        .Data_Out(Data_OutA[7:0]),
				        .Shift_In(X),
				        .Shift_Out(bin)
				        );
	reg_X				reg_unitB (
						.Load(Clr_Ld),
				        .Clk(Clk),
				        .Reset(Reset),
				        .Shift_En(Shift),
				        .D(S_S[7:0]),
				        .Data_Out(Data_OutB[7:0]),
				        .Shift_In(bin),
				        .Shift_Out(M)
						);
	nine_bit_adder	adder2 (
						.A({0, C[7:0]}),
						.B(9'h001), 
						.S({c1, Z[7:0]})
						);
	nine_bit_adder	adder (
						.A({X, Data_Out[7:0]}),
						.S({X, Sel[7:0]}),
						.R({X, Data_In[7:0]})
						);
    S_select		select1 (
    					.S(S_S[7:0]),
    					.Sinv(Z[7:0]),
    					.s(Sel[7:0]),
    					.Sub
    					);
	control         control_unit (
                        .Clk,
                        .Reset(Reset_SH),
                        .M,
                        .ClearA_LoadB(ClearA_LoadB_SH),
                        .Run(Run_SH),
                        .Shift,
                        .Clr_LD,
                        .Add(L),
                        .Sub
                        );
	 HexDriver        HexAL (
                        .In0(A[3:0]),
                        .Out0(AhexL) );
	 HexDriver        HexBL (
                        .In0(B[3:0]),
                        .Out0(BhexL) );
								
	 //When you extend to 8-bits, you will need more HEX drivers to view upper nibble of registers, for now set to 0
	 HexDriver        HexAU (
                        .In0(A[7:4]),
                        .Out0(AhexU) );	
	 HexDriver        HexBU (
                       .In0(B[7:4]),
                        .Out0(BhexU) );
								
	  //Input synchronizers required for asynchronous inputs (in this case, from the switches)
	  //These are array module instantiations
	  //Note: S stands for SYNCHRONIZED, H stands for active HIGH
	  //Note: We can invert the levels inside the port assignments
	  sync button_sync[3:0] (Clk, {~Reset, ~ClearA_LoadB, ~Run}, {Reset_SH, ClearA_LoadB_SH, Run_SH});
	  sync Din_sync[7:0] (Clk, S, S_S);
	  
endmodule