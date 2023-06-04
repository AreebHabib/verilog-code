module p_radata1(
    input logic clk,
    input logic reset,
    input logic [31:0]rdata1,
    output logic [31:0]o_p_rdata1
);
always @(posedge clk,posedge reset)begin
    if (reset) o_p_rdata1=0;
    else o_p_rdata1=rdata1;
end    
endmodule