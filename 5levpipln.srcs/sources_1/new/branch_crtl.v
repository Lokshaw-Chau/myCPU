`timescale 1ns / 1ps

module branch_crtl(
    input wire [2:0] branch,
    input wire [1:0] zero,
    output wire op
    );

    assign op = ((zero[1]==1&&branch==3'b100)||
                 (zero[1]==0&&branch==3'b101)||
                 (zero[0]==1&&branch==3'b110)||
                 (zero[0]==0&&branch==3'b111))?1:0;

endmodule
