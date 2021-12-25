module npc(pc,jaddr,offset,zero,pc_4,npcctrl,nextpc);

  input [31:2] pc;
  input [25:0] jaddr;
  input [31:0] offset;
  input zero;
  input [1:0] npcctrl;
  output [31:2] pc_4;
  output reg [31:2] nextpc;

  assign pc_4 = pc + 1;

always@(pc_4,jaddr,offset,zero,npcctrl)
  if(npcctrl == 2'b00)
    nextpc = pc_4;
  else if(npcctrl == 2'b01)
    if(zero)
      nextpc = pc_4 + offset[29:0];
    else nextpc = pc_4;
  else
    nextpc = {pc_4[31:28],jaddr};

endmodule