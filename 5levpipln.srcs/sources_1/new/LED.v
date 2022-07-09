module LED(
    input   [31:0]      cal_result,
    output  [23:0]      led
);
assign led = ~cal_result[23:0];
endmodule