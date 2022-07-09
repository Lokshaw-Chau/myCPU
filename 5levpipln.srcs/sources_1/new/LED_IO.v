`timescale 1ns / 1ps

module LED_IO(
    input           clk,
    input           rst_n,
    input           dram_we,
    input [31:0]    dram_addr,
    input [31:0]    dram_wdin,
    output[31:0]    cal_result
    );  
    
    reg [31:0] calresult;
    assign cal_result =calresult;
    always @(posedge clk or negedge rst_n) begin
        if (~rst_n)
            calresult = 32'hffff_ffff;
        else begin
            if( dram_we && dram_addr == 32'hffff_f060)
                calresult = dram_wdin;
        end
    end
endmodule
