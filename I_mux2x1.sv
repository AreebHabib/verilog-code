// Module for mux to select between
// immediate value and rdata2
module I_mux2x1(
    input logic [31:0]rdata2,
    input logic [31:0]out_im_gen,
    input logic sel_B,
    output logic [31:0]alu_opr2 
);
always_comb begin
    case(sel_B)
    1'b0:assign alu_opr2=rdata2;
    1'b1:assign alu_opr2=out_im_gen;
    endcase
end
endmodule