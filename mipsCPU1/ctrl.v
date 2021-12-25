module ctrl(instr,clk,rst,PCWrite_en,RegDst,RegWrite,RegWrite_en,zero_sign,AluOp,AluSrc,MemWrite_en,NPCSrc);

parameter IF=3'b000,ID=3'b001,EX=3'b010,MEM=3'b011,WB=3'b100;
parameter R=6'b0,ORI=6'b001101,LW=6'b100011,SW=6'b101011,BEQ=6'b000100,JAL=6'b000011;

  input [31:26] instr;
  input clk;
  input rst;
  output reg PCWrite_en,RegWrite_en,zero_sign,AluSrc,MemWrite_en;
  output reg [1:0] RegDst,RegWrite,AluOp,NPCSrc;
  reg [2:0] state, nextstate;

always@(posedge clk or posedge rst)
  if(rst)
    state <= IF;
  else 
    state <= nextstate;

always@(state,instr)
case(state)
  IF:begin
      nextstate = ID;
      PCWrite_en = 0;
      RegWrite_en = 0;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 0;
      NPCSrc = 0;
  end
  ID:begin
      nextstate = EX;
      PCWrite_en = 0;
      RegWrite_en = 0;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 0;
      NPCSrc = 0;
  end
  EX:begin
      if(instr==R)
      begin
      nextstate = WB;
      PCWrite_en = 0;
      RegWrite_en = 0;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 2'b11;
      NPCSrc = 0;
      end
      else if(instr==ORI)
      begin
      nextstate = WB;
      PCWrite_en = 0;
      RegWrite_en = 0;
      zero_sign = 0;
      AluSrc = 1;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 2'b10;
      NPCSrc = 0;
      end
      else if(instr==LW)
      begin
      nextstate = MEM;
      PCWrite_en = 0;
      RegWrite_en = 0;
      zero_sign = 1;
      AluSrc = 1;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 0;
      NPCSrc = 0;
      end
      else if(instr==SW)
      begin
      nextstate = MEM;
      PCWrite_en = 0;
      RegWrite_en = 0;
      zero_sign = 1;
      AluSrc = 1;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 0;
      NPCSrc = 0;
      end
      else if(instr==BEQ)
      begin
      nextstate = IF;
      PCWrite_en = 1;
      RegWrite_en = 0;
      zero_sign = 1;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 2'b01;
      NPCSrc = 2'b01;
      end
      else
      begin
      nextstate = IF;
      PCWrite_en = 1;
      RegWrite_en = 1;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 2'b10;
      RegWrite = 2'b10;
      AluOp = 0;
      NPCSrc = 2'b10;
      end
  end
  MEM:begin
      if(instr==LW)
      begin
      nextstate = WB;
      PCWrite_en = 0;
      RegWrite_en = 0;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 0;
      NPCSrc = 0;
      end
      else
      begin
      nextstate = IF;
      PCWrite_en = 1;
      RegWrite_en = 0;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 1;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 0;
      NPCSrc = 0;
      end
  end
  WB:begin
      if(instr==R)
      begin
      nextstate = IF;
      PCWrite_en = 1;
      RegWrite_en = 1;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 0;
      NPCSrc = 0;
      end
      else if(instr==ORI)
      begin
      nextstate = IF;
      PCWrite_en = 1;
      RegWrite_en = 1;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 2'b01;
      RegWrite = 0;
      AluOp = 0;
      NPCSrc = 0;
      end
      else
      begin
      nextstate = IF;
      PCWrite_en = 1;
      RegWrite_en = 1;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 2'b01;
      RegWrite = 2'b01;
      AluOp = 0;
      NPCSrc = 0;
      end
  end
  default:
      begin
      nextstate = IF;
      PCWrite_en = 0;
      RegWrite_en = 0;
      zero_sign = 0;
      AluSrc = 0;
      MemWrite_en = 0;
      RegDst = 0;
      RegWrite = 0;
      AluOp = 0;
      NPCSrc = 0;
      end
endcase

endmodule