`timescale 1ns / 1ps

module npc(
    input branch,
    input [1:0] op,
    input [31:0] alu_c,
    input wire [31:0] pc,
    input wire [31:0] imm,
    output wire [31:0] npc
    );

    reg [31:0]next_pc;
    assign npc = next_pc;
    
    always @(*) begin
        if (branch|| op[1]) begin
            if(op[0] == 1) 
                next_pc = alu_c;
            else
                next_pc = pc + imm;
        end
        else begin
            next_pc = pc + 4;
        end
    end
endmodule
