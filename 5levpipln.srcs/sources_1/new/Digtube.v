`timescale 1ns / 1ps

module Digtube(
    input            clk,
    input            rst_n,
    input  [31:0]    cal_result,
    output  reg [7:0]leden,
	output  reg      ledca,
	output  reg      ledcb,
    output  reg      ledcc,
	output  reg      ledcd,
	output  reg      ledce,
	output  reg      ledcf,
	output  reg      ledcg,
	output  reg      leddp
);
wire locked;

reg [19:0]cnt;
wire cnt_end = (cnt == 20'd20000);
reg flag;

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)          flag <= 1'd0;
    else if(flag)       flag <= 1'd1;
end

always @ (posedge clk or negedge rst_n) begin
    if (~rst_n)         cnt <= 20'd0;
    else if (cnt_end)    cnt <= 20'd0;
    else    cnt <= cnt + 1;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n)          leden <= 8'b01111111;
    else if(cnt_end)   leden <= {leden[0], leden[7:1]};
    else leden <= leden;
end

always @ (posedge clk or negedge rst_n) begin
    if(~rst_n) {ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg } <=7'b1111111;
    else
       begin
        case(leden)
            8'b01111111:begin
                case(cal_result[31:28])
                    4'hf:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0111000;
                    4'he:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0110000;
                    4'hd:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1000010;
                    4'hc:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1110010;
                    4'hb:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1100000;
                    4'ha:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001000;
                    4'h9:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001100;
                    4'h8:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0000000;
                    4'h7:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001111;
                    4'h6:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0100000;
                    4'h5:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0100100;
                    4'h4:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1001100;
                    4'h3:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0000110;
                    4'h2:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0010010;
                    4'h1:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1001111;
                    default:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000001;
                endcase 
            end
            8'b10111111:begin
                case(cal_result[27:24])
                    4'hf:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0111000;
                    4'he:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0110000;
                    4'hd:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1000010;
                    4'hc:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1110010;
                    4'hb:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1100000;
                    4'ha:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001000;
                    4'h9:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001100;
                    4'h8:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000000;
                    4'h7:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001111;
                    4'h6:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100000;
                    4'h5:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100100;
                    4'h4:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001100;
                    4'h3:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000110;
                    4'h2:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0010010;
                    4'h1:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001111;
                    default:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000001;
                endcase 
            end
            8'b11011111:begin
                case(cal_result[23:20])
                    4'hf:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0111000;
                    4'he:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0110000;
                    4'hd:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1000010;
                    4'hc:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1110010;
                    4'hb:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1100000;
                    4'ha:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001000;
                    4'h9:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001100;
                    4'h8:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000000;
                    4'h7:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001111;
                    4'h6:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100000;
                    4'h5:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100100;
                    4'h4:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001100;
                    4'h3:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000110;
                    4'h2:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0010010;
                    4'h1:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001111;
                    default:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000001;
                endcase 
            end
            8'b11101111:begin
                case(cal_result[19:16])
                    4'hf:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0111000;
                    4'he:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0110000;
                    4'hd:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1000010;
                    4'hc:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1110010;
                    4'hb:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1100000;
                    4'ha:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001000;
                    4'h9:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001100;
                    4'h8:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000000;
                    4'h7:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001111;
                    4'h6:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100000;
                    4'h5:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100100;
                    4'h4:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001100;
                    4'h3:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000110;
                    4'h2:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0010010;
                    4'h1:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001111;
                    default:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000001;
                endcase 
            end
            8'b11110111:begin
                case(cal_result[15:12])
                    4'hf:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0111000;
                    4'he:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0110000;
                    4'hd:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1000010;
                    4'hc:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1110010;
                    4'hb:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1100000;
                    4'ha:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001000;
                    4'h9:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001100;
                    4'h8:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000000;
                    4'h7:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001111;
                    4'h6:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100000;
                    4'h5:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100100;
                    4'h4:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001100;
                    4'h3:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000110;
                    4'h2:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0010010;
                    4'h1:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001111;
                    default:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000001;
                endcase 
            end
            8'b11111011:begin
                case(cal_result[11:8])
                    4'hf:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0111000;
                    4'he:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0110000;
                    4'hd:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1000010;
                    4'hc:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1110010;
                    4'hb:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1100000;
                    4'ha:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001000;
                    4'h9:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001100;
                    4'h8:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000000;
                    4'h7:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001111;
                    4'h6:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100000;
                    4'h5:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100100;
                    4'h4:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001100;
                    4'h3:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000110;
                    4'h2:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0010010;
                    4'h1:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001111;
                    default:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000001;
                endcase 
            end
            8'b11111101:begin
                case(cal_result[7:4])
                    4'hf:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0111000;
                    4'he:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0110000;
                    4'hd:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1000010;
                    4'hc:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1110010;
                    4'hb:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1100000;
                    4'ha:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001000;
                    4'h9:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001100;
                    4'h8:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000000;
                    4'h7:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001111;
                    4'h6:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100000;
                    4'h5:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100100;
                    4'h4:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001100;
                    4'h3:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000110;
                    4'h2:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0010010;
                    4'h1:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001111;
                    default:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000001;
                endcase 
            end
            8'b11111110:begin
                case(cal_result[3:0])
                    4'hf:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0111000;
                    4'he:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0110000;
                    4'hd:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1000010;
                    4'hc:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1110010;
                    4'hb:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b1100000;
                    4'ha:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <= 7'b0001000;
                    4'h9:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001100;
                    4'h8:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000000;
                    4'h7:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0001111;
                    4'h6:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100000;
                    4'h5:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0100100;
                    4'h4:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001100;
                    4'h3:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000110;
                    4'h2:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0010010;
                    4'h1:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b1001111;
                    default:{ledca, ledcb, ledcc,ledcd, ledce, ledcf, ledcg} <=7'b0000001;
                endcase 
            end
        endcase
    end
end
endmodule
