`timescale 1ns / 1ps

module ALU(
    input wire [2:0] op,
    input wire [31:0] A,
    input wire [31:0] B,
    output reg [31:0] C,
    output reg [1:0] zero
    );
wire [31:0] neg_B;
assign neg_B = ~B + 1; 

always @(*) begin
    case (op)
        3'b000: C = A + B;//add
        3'b001: C = A << B[4:0];//sll
        3'b010: C = $signed(A) >>> B[4:0];//sra
        3'b011: C = A + neg_B;//sub
        3'b100: C = A^B;//xor
        3'b101: C = A >> B[4:0];//srl
        3'b110: C = A | B;
        3'b111: C = A & B; 
    endcase
end
//zero
always @(*) begin
    if (C == 0) begin
        zero = 2'b10;
    end
    else begin
        if (C[31] == 1) begin
            zero = 2'b01;
        end
        else begin
            zero = 2'b00;
        end
    end
end

endmodule
