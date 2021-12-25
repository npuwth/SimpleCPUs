module alu(data1,data2,result,zero,aluctrl);

  input [31:0] data1;
  input [31:0] data2;
  input [3:0] aluctrl;
  output reg [31:0] result;
  output zero;
  
  assign zero = (result==0);

always@(data1,data2,aluctrl)
case(aluctrl)
  4'b0000:result = data1&data2;
  4'b0001:result = data1|data2;
  4'b0010:result = data1+data2;
  4'b0110:result = data1-data2;
  4'b0111:result = data1<data2?1:0;
  4'b1100:result = !(data1||data2);
  default:result = 32'b0;
endcase

endmodule