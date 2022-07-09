`timescale 1ns / 1ps

module npc_mux(
    input               branch,
    input       [1:0]   j_op,
    input       [31:0]  pc4,
    input       [31:0]  pc_jump,
    output reg  [31:0]  next_pc
    );
    always @(*) begin
        if (branch || j_op[1]) next_pc = pc_jump;
        else next_pc = pc4+4;
    end
endmodule
