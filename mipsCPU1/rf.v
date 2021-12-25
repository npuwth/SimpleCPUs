module rf(r1_addr,r2_addr,w_addr,w_data,r1_data,r2_data,clk,RegWrite_en);

  input [25:21] r1_addr;
  input [20:16] r2_addr;
  input [15:11] w_addr;
  input [31:0] w_data;
  input clk,RegWrite_en;
  output [31:0] r1_data;
  output [31:0] r2_data;

  reg [31:0] rmem[31:0];

  assign r1_data = rmem[r1_addr];
  assign r2_data = rmem[r2_addr];

always@(posedge clk)
  if(RegWrite_en)
    rmem[w_addr] = w_data;
  else
    rmem[w_addr] = rmem[w_addr];

endmodule
