module sext(
    input wire [31:7] din,
    input wire [2:0] op,
    output wire [31:0] ext
    );
    reg [31:0] ext_reg;
    assign ext = ext_reg;
    always @(*) begin
        case (op)
            3'b000: ext_reg = {{20{din[31]}},din[31:20]};//I
            3'b001: ext_reg = {{20{din[31]}},din[31:25],din[11:7]};//S
            3'b010: ext_reg = {{20{din[31]}},din[31],din[7],din[30:25],din[11:8],1'b0};//B
            3'b011: ext_reg = {din[31:12],12'b0};//U
            3'b100: ext_reg = {{12{din[31]}},din[19:12],din[20],din[30:21],1'b0};//J
        endcase
    end
endmodule