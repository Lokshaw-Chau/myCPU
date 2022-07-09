`timescale 1ns / 1ps
module cpu(
    input clk,
    input rst_n,
    input wire [31:0] inst,
    input wire [31:0] dram_rd,
    output wire [31:0] dram_addr,
    output wire [31:0] irom_addr,
    output wire [31:0] dram_wdin,
    output wire dram_we,
    output wire rf_we,
    output wire [31:0] wD,
    output wire [4:0] wR
    );
    
    wire       dram_we_id;
    wire [2:0] branch_id;
    wire       b_sel_id;
    wire [2:0] alu_op_id;
    wire [1:0] wd_sel_id;
    wire [1:0] j_sel_id;
    wire [2:0] sext_sel;
    wire       rf_we_id;
    
    wire dram_we_ex;
    wire [2:0] branch_ex;
    wire       b_sel_ex;
    wire [2:0] alu_op_ex;
    wire       rf_we_ex;
    wire [1:0] wd_sel_ex;
    wire [1:0] j_sel_ex;
    wire [31:0] pc_ex;
    wire [31:0] Data1_ex;
    wire [31:0] Data2_ex;
    wire [31:0] ext_ex;
    wire [4:0]  wR_ex;
    
    wire        dram_we_mem;
    wire        rf_we_mem;
    wire [1:0]  wd_sel_mem;
    wire [31:0] pc_mem;
    wire [31:0] alu_C_mem;
    wire [31:0] Data2_mem;
    wire [31:0] ext_mem;
    wire [4:0]  wR_mem;
    wire [31:0] pc_jump;
    
    wire [31:0] dram_rd_mem;
    
    wire        rf_we_wb;
    wire [1:0]  wd_sel_wb;
    wire [31:0] pc_wb;
    wire [31:0] alu_C_wb;
    wire [31:0] dram_rd_wb;
    wire [31:0] ext_wb;
    wire [4:0]  wR_wb;
    //IF
    wire [31:0] pc_if;
    wire [31:0] npc_if;
    wire npc_branch;
    
    assign irom_addr = pc_if;
    //pc_mux
    npc_mux npc_mux_cpu(
        .branch     (npc_branch),
        .j_op       (j_sel_ex),
        .pc4        (pc_if),
        .pc_jump    (pc_jump),
        .next_pc    (npc_if)
    );
    //PC
    pc pc_cpu(
        .clk    (clk),
        .rst_n  (rst_n),
        .npc    (npc_if),
        .pc     (pc_if)
    );
    //IF/ID
    wire [31:0] pc_id;
    wire [31:0] inst_id;
    IF_ID_reg IF_ID_reg_cpu(
        .clk    (clk),
        .rst_n  (rst_n),
        .pc_i   (pc_if),
        .inst_i (inst),
        .pc_o   (pc_id),
        .inst_o (inst_id)
    );
    //ID

    ctrl ctrl_cpu(
        .opcode (inst_id[6:0]),
        .fun3   (inst_id[14:12]),
        .fun7   (inst_id[31:25]),
        .dram_we    (dram_we_id),
        .branch     (branch_id),
        .b_sel      (b_sel_id),
        .alu_op     (alu_op_id),
        .rf_we      (rf_we_id),
        .wd_sel     (wd_sel_id),
        .sext_sel   (sext_sel),
        .j_sel      (j_sel_id)
    );
    //reg_file
    wire [31:0] Data1_id;
    wire [31:0] Data2_id;
    RegFile regfile_cpu(
        .clk        (clk),
        .we         (rf_we_wb),
        .rD1        (inst_id[19:15]),
        .rD2        (inst_id[24:20]),
        .wR         (wR_wb),
        .wD         (wD),
        .Data1      (Data1_id),
        .Data2      (Data2_id)
    );
    //sext
    wire [31:0] ext_id;
    sext sext_cpu(
        .din    (inst[31:7]),
        .op     (sext_sel),
        .ext    (ext_id)
    );
    //ID/EX
    ID_EX_reg ID_EX_reg_cpu(
        .clk          (clk),
        .rst_n        (rst_n),
        .dram_we_i    (dram_we_id),
        .branch_i     (branch_id),
        .b_sel_i      (b_sel_id),
        .alu_op_i     (alu_op_id),
        .rf_we_i      (rf_we_id),
        .wd_sel_i     (wd_sel_id),
        .j_sel_i      (j_sel_id),
        .pc_i         (pc_id),
        .Data1_i      (Data1_id),
        .Data2_i      (Data2_id),
        .ext_i        (ext_id),
        .wR_i         (inst[11:7]),
        .dram_we_o    (dram_we_ex),
        .branch_o     (branch_ex),
        .b_sel_o      (b_sel_ex),
        .alu_op_o     (alu_op_ex),
        .rf_we_o      (rf_we_ex),
        .wd_sel_o     (wd_sel_ex),
        .j_sel_o      (j_sel_ex),
        .pc_o         (pc_ex),
        .Data1_o      (Data1_ex),
        .Data2_o      (Data2_ex),
        .ext_o        (ext_ex),
        .wR_o         (wR_ex)
    );
    //EX
    //B_mux
    wire [31:0] alu_B;
    B_mux B_mux_cpu(
        .b_sel  (b_sel_ex),
        .Data2  (Data2_ex),
        .ext    (ext_ex),
        .B      (alu_B)
    );
    //ALU
    wire [31:0] alu_C_ex;
    wire [1:0]  zero;
    ALU ALU_cpu(
        .op     (alu_op_ex),
        .A      (Data1_ex),
        .B      (alu_B),
        .C      (alu_C_ex),
        .zero   (zero)
    );
    //branch_ctrl
    branch_crtl branch_ctrl_cpu(
        .branch (branch_ex),
        .zero   (zero),
        .op     (npc_branch)
    );
    //jump_pc
    jump_pc jump_pc_cpu(
        .ext        (ext_ex),
        .pc         (pc_ex),
        .j_sel      (j_sel_ex),
        .pc_jump    (pc_jump),
        .alu_C      (alu_C_ex)
    );
    //EX/MEM
    EX_MEM_reg EX_MEM_reg_cpu(
        .clk          (clk),
        .rst_n        (rst_n),
        .dram_we_i    (dram_we_ex),
        .rf_we_i      (rf_we_ex),
        .wd_sel_i     (wd_sel_ex),
        .pc_i         (pc_ex),
        .alu_C_i      (alu_C_ex),
        .Data2_i      (Data2_ex),
        .ext_i        (ext_ex),
        .wR_i         (wR_ex),
        .dram_we_o    (dram_we_mem),
        .rf_we_o      (rf_we_mem),
        .wd_sel_o     (wd_sel_mem),
        .pc_o         (pc_mem),
        .alu_C_o      (alu_C_mem),
        .Data2_o      (Data2_mem),
        .ext_o        (ext_mem),
        .wR_o         (wR_mem)
    );
    //MEM
    assign dram_addr = alu_C_mem;
    assign dram_wdin = Data2_mem;
    assign dram_we = dram_we_mem;
    assign dram_rd = dram_rd_mem;
    //MEM/WB
    MEM_WB_reg MEM_WB_reg_cpu(
        .clk          (clk),
        .rst_n        (rst_n),
        .rf_we_i      (rf_we_mem),
        .wd_sel_i     (wd_sel_mem),
        .pc_i         (pc_mem),
        .alu_C_i      (alu_C_mem),
        .dram_rd_i    (dram_rd_mem),
        .ext_i        (ext_mem),
        .wR_i         (wR_mem),
        .rf_we_o      (rf_we_wb),
        .wd_sel_o     (wd_sel_wb),
        .pc_o         (pc_wb),
        .alu_C_o      (alu_C_wb),
        .dram_rd_o    (dram_rd_wb),
        .ext_o        (ext_wb),
        .wR_o         (wR_wb)
    );
    //WB
    Reg_wD_mux Reg_wD_mux_cpu(
        .wd_sel       (wd_sel_wb),
        .rd           (dram_rd_wb),
        .c            (alu_C_wb),
        .ext          (ext_wb),
        .pc4          (pc_wb),
        .wD           (wD)
    );
endmodule
