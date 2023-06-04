module p_immediate_gen(
    input logic clk,
    input logic reset,
    input logic [31:0]out_im_gen,
    output logic [31:0]o_p_immediate_gen
);
always @(posedge clk,posedge reset)begin
    if (reset) o_p_immediate_gen=0;
    else o_p_immediate_gen=out_im_gen;
end    
endmodule