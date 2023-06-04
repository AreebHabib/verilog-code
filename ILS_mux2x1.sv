// Module for mux to select between
// alu output and rdata
module ILSJ_mux2x1(
    input logic[31:0]pc_out,
    input logic[31:0]alu_out,
    input logic [31:0]d_rdata,
    input logic [1:0]wb_sel,
    output logic [31:0] wdata
);
always_comb begin
    case(wb_sel)
    2'b00:assign wdata=alu_out;
    2'b01:assign wdata=d_rdata;
    2'b10:assign wdata=pc_out + 4;
    endcase
end
endmodule