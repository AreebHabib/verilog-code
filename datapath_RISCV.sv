// Data path for RISCV single cycle
module datapath_RISCV(input clk,reset);
// logic [31:0] address;
logic [31:0] instruction; 
logic reg_wr;//Input
// logic [4:0]waddr;
logic [3:0]en_imm; // Signal to enable immediate generator block
logic sel_B;//Mux signal for selecting immediate output
logic [31:0]out_im_gen;//output of immediate

logic sel_A;
logic [1:0]wb_sel;

logic cs;
logic csE;
logic wr;
logic rd;
// logic [1:0]mask;
logic [31:0]d_rdata;
logic [31:0] alu_opr1;
logic [31:0] alu_opr2;
// ALU
logic [31:0] wdata,rdata1,rdata2;
logic [3:0] alu_op; //Input
logic [31:0]daddr;
logic[2:0]lsbwh;
logic [2:0] br_type;
logic [2:0] br_typee;
logic br_taken;
logic br_takene;
logic [31:0]pc_out;
logic [31:0]pc_f_out;
logic [31:0]o_p_instruction;
logic [31:0]o_pE_instruction;
logic [31:0]pc_d_out;
// logic [31:0]o_p_rdata1;
// logic [31:0]o_p_rdata2;
logic [31:0]o_p_immediate_gen;
logic reg_wrE;
logic sel_AE;
logic sel_BE;
logic rdE;
logic [1:0]wb_selE;
logic [2:0]br_typeE;
logic [31:0]alu_out;
logic [31:0]RWD;

program_counter pc_uut(.clk(clk),.reset(reset),.alu_out(daddr),.br_taken(br_takene),.pc_out(pc_out));  

imem imem_uut(.address(pc_out),.instruction(instruction));
pc_f pc_f(
    .clk(clk),
    .reset(reset),
    .pc_out(pc_out),
    .pc_f_out(pc_f_out)
);
p_instruction p_instruction(
    .clk(clk),
    .reset(reset),
    .instruction(instruction),
    .o_p_instruction(o_p_instruction)
);
pE_instruction pE_instruction(
    .clk(clk),
    .reset(reset),
    .o_p_instruction(o_p_instruction),
    .o_pE_instruction(o_pE_instruction)
);
register_file rf_uut(.clk(clk),.reset(reset),.reg_wr(reg_wrE),
.raddr1(o_p_instruction[19:15]),.raddr2(o_p_instruction[24:20]),
.waddr(o_pE_instruction[11:7]),.wdata(wdata),
.rdata1(rdata1),.rdata2(rdata2)
);
pc_d pc_d(
    .clk(clk),
    .reset(reset),
    .pc_f_out(pc_f_out),
    .pc_d_out(pc_d_out)
);

ALU alu_uut(
    .alu_opr1(alu_opr1),.alu_opr2(alu_opr2),
    .alu_op(alu_op),
    .alu_out(alu_out)
);
RALU RALU(
    .clk(clk),
    .reset(reset),
    .alu_out(alu_out),
    .RALU(daddr)
);

controller_RISCV  contr_uut(
    .funct7(o_p_instruction[31:25]),
    .funct3(o_p_instruction[14:12]),
    .opcode(o_p_instruction[6:0]),
    .reg_wr(reg_wr),
    .alu_op(alu_op),
    .en_imm(en_imm),
    .sel_B(sel_B),
    .sel_A(sel_A),
    .wb_sel(wb_sel),
    .wr(wr),
    .rd(rd),
    //.mask(mask),
    .lsbwh(lsbwh),
    .cs(cs),
    .br_type(br_type)
);

immediate_gen imm_gen_uut (
    .en_imm(en_imm),
    .instruction(o_p_instruction),
    .out_im_gen(out_im_gen)
);

I_mux2x1 I_mux2x1_uut(
    .rdata2(rdata2),
    .out_im_gen(out_im_gen),
    .sel_B(sel_B),
    .alu_opr2(alu_opr2) 
);

U_mux2x1 U_mux2x1_uut(
    .pc_out(pc_f_out),
    .rdata1(rdata1),
    .sel_A(sel_A),
    .alu_opr1(alu_opr1)
);


R_WD R_WD(
    .clk(clk),
    .reset(reset),
    .rdata2(rdata2),
    .RWD(RWD)
);
data_memory data_memory_uut(
    .clk(clk),
    .reset(reset),
    .daddr(daddr),
    .dwdata(RWD),
    .cs(csE),
    .wr(wr),
    .rd(rdE),
    //.mask(mask),
    .lsbwh(lsbwh),
    .d_rdata(d_rdata)
);

ILSJ_mux2x1 ILSJ_mux2x1_uut(
    .pc_out(pc_d_out),
    .alu_out(daddr),
    .d_rdata(d_rdata),
    .wb_sel(wb_selE),
    .wdata(wdata)
);

branch_cond branch_cond(
    .rdata1(rdata1),
    .rdata2(rdata2),
    .br_type(br_type),
    .br_taken(br_taken)
);

p_control p_control(
    .clk(clk),
    .reg_wr(reg_wr),
    .rd(rd),
    .cs(cs),
    .wb_sel(wb_sel),
    .br_taken(br_taken),
    .reg_wrE(reg_wrE),
    .rdE(rdE),
    .csE(csE),
    .wb_selE(wb_selE),
    .br_takenE(br_takene)
);

endmodule