`timescale 1ns / 1ps

module RegFile(
    input clk,
    input we,
    input wire [4:0] rD1,
    input wire [4:0] rD2,
    input wire [4:0] wR,
    input wire [31:0] wD,
    output wire [31:0] Data1,
    output wire [31:0] Data2
    );
//¼Ä´æÆ÷¶Ñ
reg [31:0]DataReg[31:0];
//Êä³ö
assign Data1= (rD1==5'd0)?32'b0:DataReg[rD1];
assign Data2= (rD2==5'd0)?32'b0:DataReg[rD2];

always @(posedge clk) begin
    if(we && wR!=5'b00000) begin
        DataReg[wR] <= wD; 
    end
end

endmodule
