module regFile(i_clk, 
               i_raddr1, 
               i_raddr2, 
               i_waddr, 
               i_wdata, 
               i_we,
               o_rdata1,
               o_rdata2 
               );
               
input           i_clk, i_we;
input   [4:0]   i_raddr1, i_raddr2, i_waddr;
input   [31:0]  i_wdata;           
output  [31:0]  o_rdata1, o_rdata2;

reg [31:0] memory [0:31];

assign o_rdata1 = memory[i_raddr1];
assign o_rdata2 = memory[i_raddr2]; 

always @ (posedge i_clk) begin
    if(i_we) memory[i_waddr] <= i_wdata;  
    memory[0] <= 32'b0;
end

endmodule

    
  