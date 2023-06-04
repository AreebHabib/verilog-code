module p_waddr(
    input logic clk,
    input logic reset,
    input logic [4:0] pwaddr,
    output logic [4:0]o_p_waddr
);
always @(posedge clk,posedge reset)begin
    if (reset) o_p_waddr=0;
    else o_p_waddr=pwaddr;
end    
endmodule