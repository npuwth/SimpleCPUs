module pc(din,clk,rst,dout,PCWrite_en);

  input [31:0] din;
  input clk,rst,PCWrite_en;
  output reg [31:0] dout;

always@(posedge clk or posedge rst)
  if(rst) dout = 32'b0000_0000_0000_0000_0011_0000_0000_0000;
  else if(PCWrite_en)
    dout = din;
  else dout = dout;
   
endmodule

