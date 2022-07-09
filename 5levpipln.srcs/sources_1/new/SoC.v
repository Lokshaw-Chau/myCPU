`timescale 1ns / 1ps

module SoC(
    input  wire       clk   ,
	input  wire       rst   ,
    input  wire [23:0]switch,
	output wire [23:0]led,
 	output wire [7:0] led_en,
	output wire       led_ca,
	output wire       led_cb,
    output wire       led_cc,
	output wire       led_cd,
	output wire       led_ce,
	output wire       led_cf,
	output wire       led_cg,
	output wire       led_dp 
    );
wire rst_n;
assign rst_n = ~rst;    
wire [31:0] inst;
wire [31:0] dram_rd;
wire [31:0] dram_addr;
wire [31:0] irom_addr;
wire [31:0] dram_wdin;
wire [31:0] debug_wb_pc;
wire debug_wb_have_inst;
wire debug_wb_ena;
wire debug_wb_value;
wire debug_wb_reg;
wire debug_we_we;
wire dram_we;
wire [31:0] rd_dram;
wire [31:0] rd_switch; 
wire clk_i;
assign dram_rd = (dram_we == 1)? 32'b0:
                 ((dram_addr == 32'hffff_f070)? {8'b0,switch}:rd_dram); 
cpu_top cpu_soc(
    .clk        (clk_i),
    .rst_n      (rst_n),
    .inst       (inst),
    .dram_rd    (dram_rd),
    .dram_addr  (dram_addr),
    .irom_addr  (irom_addr),
    .dram_wdin  (dram_wdin),
    .dram_we    (dram_we),
    .rf_we      (debug_wb_ena),
    .wD         (debug_wb_value),
    .wR         (debug_wb_reg)
);
wire lock;
    clk_div u_clk_div(
        .clk_in1    (clk),
        .clk_out1   (clk_i),
        .locked     (lock)
    );
// 64KB IROM
inst_mem imem (
        .a      (irom_addr[15:2]),   // input wire [13:0] a
        .spo    (inst)   // output wire [31:0] spo
    );
wire [31:0] dram_addr_tmp = dram_addr;// - 16'h4000;
//64KB DRAM
data_mem dmem (
    .clk    (clk_i),            // input wire clka
    .a      (dram_addr_tmp[15:2]),     // input wire [13:0] addra
    .spo    (rd_dram),        // output wire [31:0] douta
    .we     (dram_we),          // input wire [0:0] wea
    .d      (dram_wdin)         // input wire [31:0] dina
);
//LED_IO
wire [31:0] cal_result_led;
LED_IO io_led(
    .clk        (clk_i),
    .rst_n      (rst_n),
    .dram_we    (dram_we),
    .dram_addr  (dram_addr),
    .dram_wdin  (dram_wdin),
    .cal_result (cal_result_led)
);
//LED
LED led_soc(
    .cal_result (cal_result_led),
    .led        (led)
);
//Digital tube IO
wire [31:0] cal_result_dig;
Digtube_IO io_digtube(
    .clk        (clk_i),
    .rst_n      (rst_n),
    .dram_we    (dram_we),
    .dram_addr  (dram_addr),
    .dram_wdin  (dram_wdin),
    .cal_result (cal_result_dig)    
);
//Digital tube
Digtube digtube_soc(
    .clk        (clk_i),
    .rst_n      (rst_n),
    .cal_result (cal_result_dig),
    .leden      (led_en),
    .ledca      (led_ca),
    .ledcb      (led_cb),
    .ledcc      (led_cc),
    .ledcd      (led_cd),
    .ledce      (led_ce),
    .ledcf      (led_cf),
    .ledcg      (led_cg),
    .leddp      (led_dp)
);
endmodule
