module p_instruction(
    input logic clk,
    input logic reset,
    input logic [31:0]instruction,
    output logic [31:0]o_p_instruction
);
always @(posedge clk,posedge reset)begin
    if (reset) o_p_instruction=0;
    else o_p_instruction=instruction;
end    
endmodule