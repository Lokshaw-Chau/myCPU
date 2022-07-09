`timescale 1ns / 1ps

module IF_ID_reg(
    input             clk,
    input             rst_n,
    input   [31:0]    pc_i,
    input   [31:0]    inst_i,
    output  [31:0]    pc_o,
    output  [31:0]    inst_o
    );
    reg [31:0] pc;
    reg [31:0] inst;
    assign inst_o = inst;
    assign pc_o = pc;
    always@(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            pc <= 32'b0;
            inst <= 32'b0;
        end
        else begin
            pc <= pc_i;
            inst <= inst_i;
        end
    end
endmodule
