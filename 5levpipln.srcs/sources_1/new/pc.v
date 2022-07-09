`timescale 1ns / 1ps

module pc(
    input               clk,
    input               rst_n,  
    input  wire [31:0]  npc,
    output wire [31:0]  pc 
);
parameter INIT_PC = 32'b0;  // 假设0为CPU复位后的首条指令对应地址
reg [31:0] program_counter;
reg first_time;
assign pc = program_counter;

always @(posedge clk or negedge rst_n) begin
    if( ~rst_n ) begin
        program_counter <= INIT_PC;
        first_time <= 1'b0;
    end
    else 
        if (first_time == 1'b0)
            first_time <= 1'b1;
        else
            program_counter <= npc;
end

endmodule
