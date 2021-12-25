module aluctrl(funct,AluOp,aluctrl);

  input [5:0] funct;
  input [1:0] AluOp;
  output reg [3:0] aluctrl;

always@(funct,AluOp)
  if(AluOp==2'b00)
    aluctrl = 4'b0010; //add
  else if(AluOp==2'b01)
    aluctrl = 4'b0110; //sub
  else if(AluOp==2'b10)
    aluctrl = 4'b0001; //or
  else
    if(funct==6'b100001)
      aluctrl = 4'b0010;
    else if(funct==6'b100011)
      aluctrl = 4'b0110;
    else if(funct==6'b100100)
      aluctrl = 4'b0000;
    else
      aluctrl = 4'b0001;

endmodule
