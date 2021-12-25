module flop(din,dout,clk,rst);
parameter width = 32;

  input [width-1:0] din;
  input clk,rst;
  output reg [width-1:0] dout;

always@(posedge clk or posedge rst)
  if(rst) dout = 0;
  else dout = din;

endmodule

