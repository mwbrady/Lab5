//Two-always example for state machine

module control (input  logic Clk, Reset, ClearA_LoadB, Run, M,
                output logic Shift, Clr_Ld, Add, Sub, Load);

    // Declare signals curr_state, next_state of type enum
    // with enum values of A, B, ..., F as the state values
	// Note that the length implies a max of 8 states, so you will need to bump this up for 8-bits
    enum logic [4:0]    {ADD1, ADD2, ADD3, ADD4, ADD5, ADD6, ADD7, SUM, 
                        SHIFT1, SHIFT2, SHIFT3, SHIFT4, SHIFT5, SHIFT6, SHIFT7, SHIFT8
                        HALT, CLRLD}   curr_state, next_state; 

	//updates flip flop, current state is the only one
    always_ff @ (posedge Clk)
    begin
        if (Reset)
            curr_state <= CLRLD;
        else 
            curr_state <= next_state;
    end

    // Assign outputs based on state
	always_comb
    begin
        
		  next_state  = curr_state;	//required because I haven't enumerated all possibilities below
        unique case (curr_state) 

            HALT:   if (ClearA_LoadB)
                        next_state = CLRLD;
            CLRLD:  begin
                        if (run && M)
                            next_state = ADD1;
                        else if (run && (~M))
                            next_state = SHIFT1;
                    end
            ADD1 :    next_state = SHIFT1;
            SHIFT1: begin
                        if (M)
                            next_state = ADD2;
                        else
                            next_state = SHIFT2;
            ADD2 :    next_state = SHIFT2;
            SHIFT2: begin
                        if (M)
                            next_state = ADD3;
                        else
                            next_state = SHIFT3;
            ADD3 :    next_state = SHIFT3;
            SHIFT3: begin
                        if (M)
                            next_state = ADD4;
                        else
                            next_state = SHIFT4;
            ADD4 :    next_state = SHIFT4;
            SHIFT4: begin
                        if (M)
                            next_state = ADD5;
                        else
                            next_state = SHIFT5;
            ADD5 :    next_state = SHIFT5;
            SHIFT5: begin
                        if (M)
                            next_state = ADD6;
                        else
                            next_state = SHIFT6;
            ADD6 :    next_state = SHIFT6;
            SHIFT6: begin
                        if (M)
                            next_state = ADD7;
                        else
                            next_state = SHIFT7;
            ADD7 :    next_state = SHIFT7;
            SHIFT7: begin
                        if (M)
                            next_state = SUB;
                        else
                            next_state = SHIFT8;
            SUB :    next_state = SHIFT8;
            SHIFT8: next_state = HALT;
							  
        endcase

        default:  //default case
              begin 
                Clr_Ld = 1'b0;
                Shift = 1'b0;
                Add = 1'b0;
                Sub = 1'b0;
                Load = 1'b0;
   
		  // Assign outputs based on ‘state’
        case (curr_state) 
	       CLRLD: Clr_Ld = 1'b1;
           ADD1: Add = 1'b1;
	   	   SHIFT1: Shift = 1'b1;
           ADD2: Add = 1'b1;
           SHIFT2: Shift = 1'b1;
           ADD3: Add = 1'b1;
           SHIFT3: Shift = 1'b1;
           ADD4: Add = 1'b1;
           SHIFT4: Shift = 1'b1;
           ADD5: Add = 1'b1;
           SHIFT5: Shift = 1'b1;
           ADD6: Add = 1'b1;
           SHIFT6: Shift = 1'b1;
           ADD7: Add = 1'b1;
           SHIFT8: Shift = 1'b1;
           SUM: begin
                    Add = 1'b1;
                    Sub = 1'b1;
                end
           SHIFT1: Shift = 1'b1;
        endcase
    end

endmodule
