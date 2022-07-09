module switch(
    input [23:0] switch,
    output reg [31:0] opnum
    );
    always@(*) begin
        opnum = {8'b0,switch[23:0]};
    end
endmodule