module npc(pc_4,imm,jaddr,raddr,NPCSrc,npc);

  input [31:0] pc_4;
  input [31:0] imm;
  input [25:0] jaddr;
  input [31:0] raddr;
  input [2:0] NPCSrc;
  output reg [31:0] npc;

always@(pc_4,imm,jaddr,raddr,NPCSrc)
  if(NPCSrc == 3'b000) //normal
    npc = pc_4;
  else if(NPCSrc == 3'b001) //branch
    npc = pc_4 + {imm[29:0],2'b0};
  else if(NPCSrc == 3'b010) //j,jal
    npc = {pc_4[31:28],jaddr,2'b0};
  else if(NPCSrc == 3'b011) //jr,jalr
    npc = raddr;
  else //error
    npc = 32'h8000_0180;

endmodule