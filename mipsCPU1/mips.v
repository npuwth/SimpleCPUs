module mips( clk, rst );
   input   clk;
   input   rst;
   wire PCWrite_en,RegWrire_en,ALUSrc,zero,MemWrite_en,zero_sign;
   wire [1:0] RegDst,RegWrite,npcctrl,AluOp;
   wire [3:0] aluctrl;
   wire [4:0] w_addr;
   wire [31:2] PC,NPC,PC_4;
   wire [31:0] im_dout,instr,rf_dout1,rf_dout2,flopa,flopb,ext_dout,alu_src,alu_dout,flopalu,dm_dout,flopdata,write_src;

   pc U_PC (
      .din(NPC) , .clk(clk) , .rst(rst) , .dout(PC) , .PCWrite_en(PCWrite_en)
   );

   im_4k U_IM ( 
      .addr(PC[11:2]) , .dout(im_dout)
   );

   ir U_IR (
      .instr_in(im_dout) , .clk(clk) , .rst(rst) , .instr_out(instr)
   );
   
   mux3to1 #(5) U_MUX1 (
      .A(instr[15:11]) , .B(instr[20:16]) , .C(5'b11111) , .out(w_addr) , .ctrl(RegDst)
   );

   rf U_RF (
      .r1_addr(instr[25:21]) , .r2_addr(instr[20:16]) , .w_addr(w_addr) , .w_data(write_src) , .r1_data(rf_dout1) , .r2_data(rf_dout2) , .clk(clk) , .RegWrite_en(RegWrite_en)
   );

   flop #(32) FLOP_A (
      .din(rf_dout1) , .dout(flopa) , .clk(clk) , .rst(rst)
   );

   flop #(32) FLOP_B (
      .din(rf_dout2) , .dout(flopb) , .clk(clk) , .rst(rst)
   );

   mux2to1 #(32) U_MUX2 (
      .A(flopb) , .B(ext_dout) , .out(alu_src) , .ctrl(ALUSrc)
   );

   alu U_ALU (
      .data1(flopa) , .data2(alu_src) , .result(alu_dout) , .zero(zero) , .aluctrl(aluctrl)
   );
   
   flop #(32) FLOP_ALU (
      .din(alu_dout) , .dout(flopalu) , .clk(clk) , .rst(rst)
   );

   dm_4k U_DM ( 
      .addr(flopalu[11:2]), .din(flopb), .DMWr(MemWrite_en), .clk(clk), .dout(dm_dout)
   );

   flop #(32) FLOP_DATA (
      .din(dm_dout) , .dout(flopdata) , .clk(clk) , .rst(rst)
   );
   
   mux3to1 #(32) U_MUX3 (
      .A(flopalu) , .B(flopdata) , .C({PC_4,2'b0}) , .out(write_src) , .ctrl(RegWrite)
   );

   ext U_EXT (
      .datain(instr[15:0]) , .dataout(ext_dout) , .zero_sign(zero_sign)
   );

   npc U_NPC (
      .pc(PC) , .jaddr(instr[25:0]) , .offset(ext_dout) , .zero(zero) , .pc_4(PC_4) , .npcctrl(npcctrl) , .nextpc(NPC)
   );

   ctrl U_CTRL (
      .instr(instr[31:26]) , .clk(clk) , .rst(rst) , .PCWrite_en(PCWrite_en) , .RegDst(RegDst) , .RegWrite(RegWrite) , .RegWrite_en(RegWrite_en) , .zero_sign(zero_sign) , .AluOp(AluOp) , .AluSrc(ALUSrc) , .MemWrite_en(MemWrite_en) , .NPCSrc(npcctrl)
   );

   aluctrl U_ALUCTRL (
      .funct(instr[5:0]) , .AluOp(AluOp) , .aluctrl(aluctrl)
   );
endmodule
