module SWTICH_IO(
    output     [31:0]   dram_rd,
    input      [31:0]   cal_result
    );  
    assign dram_rd = cal_result;
endmodule