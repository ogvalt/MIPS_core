module decode (i_clk, i_rst_n, i_c_regDst, i_c_regWrite, 
               i_Rs, i_Rt, i_Rd, i_wrDataToReg, i_wrAddr,
               i_mfc0, i_cop0_data,
               o_decode_op1, o_decode_op2,o_wrAddr);
  
  input         i_clk, i_rst_n;
  input         i_c_regDst, i_c_regWrite; //control signal
  
  input  [4:0]  i_Rs;
  input  [4:0]  i_Rt; 
  input  [4:0]  i_Rd; //addr of reg in regFile

  input         i_mfc0;
  input  [31:0] i_cop0_data;
  
  input  [31:0] i_wrDataToReg; //data that need to be wrote into regFile
  input  [4:0]  i_wrAddr; //input of write address
  
  output [31:0] o_decode_op1; 
  output [31:0] o_decode_op2; //operandrs
  
  output [4:0]  o_wrAddr; //output of write address (need for corect pipelining)
    
  wire   [31:0] wr_source_select;

  assign  wr_source_select = (i_mfc0) ? i_cop0_data : i_wrDataToReg;

  regFile REGISTERS(  .i_clk    (i_clk), 
                      .i_raddr1 (i_Rs), 
                      .i_raddr2 (i_Rt), 
                      .i_waddr  (o_wrAddr),
                      .i_wdata  (wr_source_select), 
                      .i_we     (i_c_regWrite), 
                      .o_rdata1 (o_decode_op1),
                      .o_rdata2 (o_decode_op2)
                    );

  mux2in1 #(.WIDTH(5)) REGDEST ( 
                    .i_dat0(i_Rt), 
                    .i_dat1(i_Rd), 
                    .i_control(i_c_regDst), 
                    .o_dat(o_wrAddr)
                    );
  
endmodule
