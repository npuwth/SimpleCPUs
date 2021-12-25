module pc(din,clk,rst,dout,PCWrite_en);

  input [31:2] din;
  input clk,rst,PCWrite_en;
  output reg [31:2] dout;

always@(posedge clk or posedge rst)
  if(rst) dout = 30'b0000_0000_0000_0000_0011_0000_0000_00;
  else if(PCWrite_en)
    dout = din;
  else dout = dout;
   
endmodule
