module execute(i_pc, i_imm, i_op1, i_op2,
               i_ALUSrc_op2, i_ALUop, i_jump, i_extOp,
               i_beq, i_bne, i_exception,
               o_op2, o_ALUres, o_nextPC, o_pcsrc,
               o_nop, o_unknown_func, o_arithmetic_overflow,
               o_eret, o_mfc0, o_mtc0
               );
  
  input  [31:0] i_pc; //address from pc
  input  [25:0] i_imm; //immidiate constant input
  input  [31:0] i_op1, i_op2; //operandrs input
  input         i_ALUSrc_op2;
  input  [ 5:0] i_ALUop;
  input         i_jump, i_beq, i_bne; //condition control
  input         i_extOp; // extender control
  input         i_exception; //

  output [31:0] o_op2;
  output [31:0] o_ALUres;
  output [31:0] o_nextPC;
  output  [1:0] o_pcsrc;
  output        o_nop;
  output        o_unknown_func;
  output        o_arithmetic_overflow;
  output        o_eret;
  output        o_mfc0, o_mtc0;
  
  wire               zerof; // zero flag - alures=0
  wire               ALUSrc_op1;
  wire        [31:0] extended; //value after extender
  wire        [31:0] aluOp1; // first alu operand
  wire        [31:0] aluOp2; //second alu operand
  wire        [ 5:0] ALUCtrl; //aclu control code
  wire               jr;      // for JR command purpose
  wire               nop;     // for NOP command purpose
  wire               unknown_func; // signal for unknown function of R-type instruction
  wire               arithmetic_overflow; //
  wire               eret;
  wire               mfc0, mtc0;
  
  signExtend EXTENDER( .i_data    (i_imm[15:0]), 
                       .i_control (i_extOp), 
                       .o_data    (extended)
                      );

  mux2in1 ALUSOURCE_OP2 ( .i_dat0    (i_op2), 
                          .i_dat1    (extended), 
                          .i_control  (i_ALUSrc_op2), 
                          .o_dat      (aluOp2)
                        );

  mux2in1 ALUSOURCE_OP1 ( .i_dat0   (i_op1),
                          .i_dat1   ({27'b0,i_imm[10:6]}),
                          .i_control(ALUSrc_op1),
                          .o_dat    (aluOp1)
                        );

  alu ALU ( .i_op1  (aluOp1), 
            .i_op2  (aluOp2), 
            .i_control(ALUCtrl), 
            .o_result(o_ALUres), 
            .o_overflow(arithmetic_overflow),
            .o_zf(zerof)
          );

  aluControl ALUCONTROL(
                        .i_aluOp(i_ALUop), 
                        .i_func(i_imm[5:0]), 
                        .i_r_field({i_imm[25:21], i_imm[10:6]}),
                        .o_aluControl(ALUCtrl),
                        .o_ALUSrc_op1(ALUSrc_op1),
                        .o_jr(jr),
                        .o_nop(nop),
                        .o_unknown_func(unknown_func),
                        .o_eret(eret),
                        .o_mfc0(mfc0), 
                        .o_mtc0(mtc0)
                        );
  nextPC NEXTPC (
                  .i_pc(i_pc), 
                  .i_imm(i_imm), 
                  .i_jump(i_jump), 
                  .i_beq(i_beq), 
                  .i_bne(i_bne), 
                  .i_zerof(zerof),
                  .i_jr(jr), 
                  .i_Rs(aluOp1),
                  .i_eret(eret),
                  .i_exception(i_exception), 
                  .o_nextpc(o_nextPC), 
                  .o_pcsrc(o_pcsrc)
                ); 

  assign o_op2 = i_op2;
  assign o_nop = nop;
  assign o_unknown_func = unknown_func;
  assign o_arithmetic_overflow = arithmetic_overflow;
  assign o_eret = eret;
  assign o_mfc0 = mfc0; 
  assign o_mtc0 = mtc0;
  
endmodule
