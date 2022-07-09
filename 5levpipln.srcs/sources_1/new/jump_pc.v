`timescale 1ns / 1ps

module jump_pc(
    input [31:0] ext,
    input [31:0] pc,
    input [1:0] j_sel,
    output reg [31:0] pc_jump,
    input [31:0] alu_C
    );
    always@ (*) begin
        if (j_sel[0])
            pc_jump = alu_C;
        else 
            pc_jump = pc + ext; 
    end
endmodule
