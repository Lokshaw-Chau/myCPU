`timescale 1ns / 1ps

module ID_EX_reg(
    input       clk,
    input       rst_n,
    input       dram_we_i,
    input [2:0] branch_i,
    input       b_sel_i,
    input [2:0] alu_op_i,
    input       rf_we_i,
    input [1:0] wd_sel_i,
    input [1:0] j_sel_i,
    input [31:0] pc_i,
    input [31:0] Data1_i,
    input [31:0] Data2_i,
    input [31:0] ext_i,
    input [4:0]  wR_i,
    output       dram_we_o,
    output [2:0] branch_o,
    output       b_sel_o,
    output [2:0] alu_op_o,
    output       rf_we_o,
    output [1:0] wd_sel_o,
    output [1:0] j_sel_o,
    output [31:0] pc_o,
    output [31:0] Data1_o,
    output [31:0] Data2_o,
    output [31:0] ext_o,
    output [4:0] wR_o
    );
    reg       dram_we;
    reg [2:0] branch;
    reg       b_sel;
    reg [2:0] alu_op;
    reg       rf_we;
    reg [1:0] wd_sel;
    reg [1:0] j_sel;
    reg [31:0] pc;
    reg [31:0] Data1;
    reg [31:0] Data2;
    reg [31:0] ext;
    reg [4:0]  wR;
    assign wR_o = wR;
    assign dram_we_o = dram_we;
    assign branch_o = branch;
    assign b_sel_o = b_sel;
    assign alu_op_o = alu_op;
    assign rf_we_o = rf_we;
    assign wd_sel_o = wd_sel;
    assign j_sel_o = j_sel;
    assign pc_o = pc;
    assign Data1_o = Data1;
    assign Data2_o = Data2;
    assign ext_o = ext;

    
    always@(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            dram_we <= 0;
            branch <= 3'b0;
            b_sel <= 2'b0;
            alu_op <= 3'b0;
            rf_we <= 0;
            wd_sel <= 2'b0;
            j_sel <= 2'b0;
            pc <= 32'b0;
            Data1 <= 32'b0;
            Data2 <= 32'b0;
            ext <= 32'b0;
            wR <= 5'b0;
        end
        else begin
            dram_we <= dram_we_i;
            branch <= branch_i;
            b_sel <= b_sel_i;
            alu_op <= alu_op_i;
            rf_we <= rf_we_i;
            wd_sel <= wd_sel_i;
            j_sel <= j_sel_i;
            pc <= pc_i;
            Data1 <= Data1_i;
            Data2 <= Data2_i;
            ext <= ext_i;
            wR <= wR_i;
        end
    end
endmodule
