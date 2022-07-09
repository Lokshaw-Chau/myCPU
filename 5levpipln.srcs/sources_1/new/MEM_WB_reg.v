`timescale 1ns / 1ps

module MEM_WB_reg(
    input       clk,
    input       rst_n,
    input       rf_we_i,
    input [1:0] wd_sel_i,
    input [31:0] pc_i,
    input [31:0] dram_rd_i,
    input [31:0] alu_C_i,
    input [31:0] ext_i,
    input [4:0]  wR_i,
    output       rf_we_o,
    output [1:0] wd_sel_o,
    output [31:0] pc_o,
    output [31:0] dram_rd_o,
    output [31:0] alu_C_o,
    output [31:0] ext_o,
    output [4:0] wR_o
    );
    reg       rf_we;
    reg [1:0] wd_sel;
    reg [31:0] pc;
    reg [31:0] dram_rd;
    reg [31:0] alu_C;
    reg [31:0] ext;
    reg [4:0]  wR;
    assign wR_o = wR;
    assign rf_we_o = rf_we;
    assign wd_sel_o = wd_sel;
    assign pc_o = pc;
    assign alu_C_o = alu_C;
    assign dram_rd_o = dram_rd;
    assign ext_o = ext;

    always@(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            rf_we <= 0;
            wd_sel <= 2'b0;
            pc <= 32'b0;
            alu_C <= 32'b0;
            dram_rd <= 32'b0;
            ext <= 32'b0;
            wR <= 5'b0;
        end
        else begin
            rf_we <= rf_we_i;
            wd_sel <= wd_sel_i;
            pc <= pc_i;
            alu_C <= alu_C_i;
            dram_rd <= dram_rd_i;
            ext <= ext_i;
            wR <= wR_i;            
        end
    end
endmodule
