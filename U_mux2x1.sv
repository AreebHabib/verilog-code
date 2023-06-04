// Module for mux to select between
// pc  and rdata1
module U_mux2x1(
    input logic[31:0] pc_out,
    input logic [31:0] rdata1,
    input logic sel_A,
    output logic[31:0]alu_opr1
);
always_comb begin
    case(sel_A)
    1'b0:assign alu_opr1=pc_out;
    1'b1:assign alu_opr1=rdata1;
    endcase
end
endmodule