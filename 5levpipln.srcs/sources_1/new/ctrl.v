`timescale 1ns / 1ps

module ctrl(
    input wire [6:0] opcode,
    input wire [2:0] fun3,
    input wire [6:0] fun7,
    output reg       dram_we,
    output reg [2:0] branch,
    output reg       b_sel,
    output reg [2:0] alu_op,
    output reg       rf_we,
    output reg [1:0] wd_sel,
    output reg [2:0] sext_sel,
    output reg [1:0] j_sel
    );
    
    always @(*) begin
        case (opcode)
            //R
            7'b0110011:begin
                dram_we = 0;
                branch = 3'b000;
                b_sel = 0;
                rf_we = 1;
                wd_sel = 2'b00;
                sext_sel = 3'b000;
                j_sel = 2'b00;
                case (fun3)
                    3'b000:begin
                        case (fun7[5])
                            1'b1: alu_op = 3'b011;//sub
                            default: alu_op = 3'b000;//add
                        endcase
                    end
                    3'b101:begin
                        case (fun7[5])
                            1'b1: alu_op = 3'b010;//sra
                            default: alu_op = 3'b101;//srl
                        endcase
                    end
                    default: alu_op = fun3;
                endcase
            end
            //I
            7'b0010011:begin
                dram_we = 0;
                branch = 3'b000;
                b_sel = 1;
                rf_we = 1;
                wd_sel = 2'b00;
                sext_sel = 3'b000;
                j_sel = 2'b00;
                case (fun3) 
                    3'b101:begin
                        case (fun7[5])
                            1'b1: alu_op = 3'b010;//srai
                            default: alu_op = 3'b101;//srli
                        endcase
                    end
                    default: alu_op = fun3;
                endcase
            end
            //I:lw
            7'b0000011:begin
                dram_we = 0;
                branch = 3'b000;
                b_sel = 1;
                rf_we = 1;
                wd_sel = 2'b01;
                sext_sel = 3'b000;
                j_sel = 2'b00;
                alu_op = 3'b000;
            end
            //I:jalr
            7'b1100111:begin
                dram_we = 0;
                branch = 3'b000;
                b_sel = 1;
                rf_we = 1;
                wd_sel = 2'b10;
                sext_sel = 3'b000;
                j_sel = 2'b11;
                alu_op = 3'b000;
            end
            //S
            7'b0100011:begin
                dram_we = 1;
                branch = 3'b000;
                b_sel = 1;
                rf_we = 0;
                wd_sel = 2'b00;
                sext_sel = 3'b001;
                alu_op = 3'b000;//add
                j_sel = 2'b00;
            end
            //B
            7'b1100011:begin
                dram_we = 0;
                b_sel = 0;
                rf_we = 0;
                wd_sel = 2'b00;
                sext_sel = 3'b010;
                alu_op = 3'b011;//sub
                branch = {1'b1,fun3[2],fun3[0]};
                j_sel = 2'b00;
            end
            //U
            7'b0110111:begin
                dram_we = 0;
                b_sel = 1;
                rf_we = 1;
                wd_sel = 2'b11;
                sext_sel = 3'b011;
                alu_op = 3'b000;
                branch = 3'b000;
                j_sel = 2'b00;
            end
            //J
            7'b1101111:begin
                dram_we = 0;
                b_sel = 1;
                rf_we = 1;
                wd_sel = 2'b10;
                sext_sel = 3'b100;
                alu_op = 3'b000;//add
                branch = 3'b000;
                j_sel = 2'b10;
            end
        endcase
    end
endmodule