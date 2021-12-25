module ir(instr_in,clk,rst,instr_out);

  input [31:0] instr_in;
  input clk,rst;
  output reg [31:0] instr_out;

always@(posedge clk or posedge rst)
  if(rst) instr_out = 32'b0;
  else instr_out = instr_in;

endmodule
