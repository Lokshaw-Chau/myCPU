`timescale 1ns / 1ps

module Reg_wD_mux(
    input wire [1:0] wd_sel,
    input wire [31:0] rd,
    input wire [31:0] c,
    input wire [31:0] ext,
    input wire [31:0] pc4,
    output reg [31:0] wD
    );
    
always @(*) begin
    case (wd_sel)
        2'b00: wD = c;
        2'b01: wD = rd;
        2'b10: wD = pc4 + 4;
        2'b11: wD = ext;
    endcase
end
endmodule
