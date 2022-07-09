`timescale 1ns / 1ps
module B_mux(
    input b_sel,
    input wire [31:0] Data2,
    input wire [31:0] ext,
    output wire [31:0] B
    );

assign B = b_sel?ext:Data2;

endmodule
