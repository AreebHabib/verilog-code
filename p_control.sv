module p_control(
    input logic clk,
    input logic reg_wr,
    input logic rd,
    input logic cs,
    input logic [1:0]wb_sel,
    input logic br_taken,
    output logic reg_wrE,
    output logic rdE,
    output logic csE,
    output logic [1:0]wb_selE,
    output logic br_takenE
);
always @(posedge clk)begin
    if (clk) begin 
            reg_wrE=reg_wr;
            csE=cs;
            rdE=rd;
            wb_selE=wb_sel;
            br_takenE=br_taken;
    end
end  

endmodule