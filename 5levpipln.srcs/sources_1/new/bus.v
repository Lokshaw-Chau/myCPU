`timescale 1ns / 1ps

module bus(
    input           clk,
    input           rst,
    input   [31:0]  dram_wdin,
    input           dram_we,
    input   [31:0]  dram_addr,
    output  [31:0]  dram_rd
);
    parameter SWITCH_ADDR = 32'hffff_0070;
    wire [31:0] rd_dram;
    wire [31:0] rd_switch; 
    assign dram_rd = (dram_we == 1)? 32'b0:
                     ((dram_addr == SWITCH_ADDR)? rd_switch:rd_dram); 
    
endmodule
