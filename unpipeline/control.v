module control(i_instrCode, 
               o_regDst,
               o_jump, 
               o_beq,
			         o_bne,
               o_memToReg,
               o_aluOp,
               o_memWrite,
               o_aluSrc,
               o_regWrite,
               o_extOp
               );

localparam OP_RTYPE = 6'h0, OP_ADDI = 6'h8, OP_ADDIU = 6'h9;
localparam OP_LW = 6'h23, OP_SW = 6'h2B;
localparam OP_BEQ = 6'h4, OP_J = 6'h2, OP_BNE = 6'h5;   
  
input     [5:0]  i_instrCode; // there was[15:0] 
output    reg      o_regDst;
output    reg      o_jump; 
output    reg      o_beq;
output	  reg      o_bne;
output    reg      o_memToReg;
output    reg [1:0]o_aluOp;
output    reg      o_memWrite;
output    reg      o_aluSrc;
output    reg      o_regWrite;
output    reg      o_extOp;

always @(i_instrCode) begin
    case(i_instrCode)
      OP_RTYPE: 
        begin
          o_regDst   <= 1'b1;
		      o_regWrite <= 1'b1;
      		o_aluSrc   <= 1'b0;
      		o_beq   	<= 1'b0;
			    o_bne		<= 1'b0;
      		o_jump	    <= 1'b0;
      		o_memWrite <= 1'b0;
      		o_memToReg <= 1'b0;
      		o_aluOp    <= 2'b10;
      		o_extOp    <= 1'b0;
      		end
	   OP_ADDI:
      		begin
      		o_regDst   <= 1'b0;
		      o_regWrite <= 1'b1;
      		o_aluSrc   <= 1'b1;
      		o_beq   <= 1'b0;
			    o_bne	<= 1'b0;
      		o_jump	    <= 1'b0;
      		o_memWrite <= 1'b0;
      		o_memToReg <= 1'b0;
      		o_aluOp    <= 2'b00;
      		o_extOp    <= 1'b1;
      		end
  		 OP_ADDIU:
  		    begin
      		o_regDst   <= 1'b0;
		      o_regWrite <= 1'b1;
      		o_aluSrc   <= 1'b1;
      		o_beq   <= 1'b0;
			    o_bne	<= 1'b0;
      		o_jump	    <= 1'b0;
      		o_memWrite <= 1'b0;
      		o_memToReg <= 1'b0;
      		o_aluOp    <= 2'b00;
      		o_extOp    <= 1'b1;
      		end
  	  OP_LW:
	      begin
      		o_regDst   <= 1'b0;
      		o_regWrite <= 1'b1;
      		o_aluSrc   <= 1'b1;
      		o_beq   <= 1'b0;
			    o_bne	<= 1'b0;
      		o_jump	    <= 1'b0;
      		o_memWrite <= 1'b0;
      		o_memToReg <= 1'b1;
      		o_aluOp    <= 2'b00;
      		o_extOp    <= 1'b1;
      		end
  	  OP_SW:
	      begin
      		o_regDst   <= 1'bz;
      		o_regWrite <= 1'b0;
      		o_aluSrc   <= 1'b1;
      		o_beq   <= 1'b0;
			    o_bne	<= 1'b0;
      		o_jump	    <= 1'b0;
      		o_memWrite <= 1'b1;
      		o_memToReg <= 1'bz;
      		o_aluOp    <= 2'b00;
      		o_extOp    <= 1'b1;
      		end
  	  OP_J:
	     	begin
      		o_regDst   <= 1'bz;
      		o_regWrite <= 1'b0;
      		o_aluSrc   <= 1'bz;
			    o_bne		<=1'b0;
      		o_beq   <= 1'b0;
      		o_jump	    <= 1'b1;
      		o_memWrite <= 1'b0;
      		o_memToReg <= 1'bz;
      		o_aluOp    <= 2'bzz;
      		o_extOp    <= 1'b0;
      		end
  	  OP_BEQ:
      		begin
      		o_regDst   <= 1'bz;
      		o_regWrite <= 1'b0;
      		o_aluSrc   <= 1'b0;
			    o_bne	<= 1'b0;
      		o_beq   <= 1'b1;
      		o_jump	    <= 1'b0;
      		o_memWrite <= 1'b0;
      		o_memToReg <= 1'bz;
      		o_aluOp    <= 2'b01;
      		o_extOp    <= 1'b0;
      		end
	  OP_BNE:
      		begin
      		o_regDst   <= 1'bz;
      		o_regWrite <= 1'b0;
      		o_aluSrc   <= 1'b0;
			    o_bne	<= 1'b1;
      		o_beq   <= 1'b0;
      		o_jump	    <= 1'b0;
      		o_memWrite <= 1'b0;
      		o_memToReg <= 1'bz;
      		o_aluOp    <= 2'b01;
      		o_extOp    <= 1'b0;
      		end
  	endcase
  end	
endmodule
        
        