module p_radata2(
    input logic clk,
    input logic reset,
    input logic [31:0]rdata2,
    output logic [31:0]o_p_rdata2
);
always @(posedge clk,posedge reset)begin
    if (reset) o_p_rdata2=0;
    else o_p_rdata2=rdata2;
end    
endmodule