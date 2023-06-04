module pE_instruction(
    input logic clk,
    input logic reset,
    input logic [31:0]o_p_instruction,
    output logic [31:0]o_pE_instruction
);
always @(posedge clk,posedge reset)begin
    if (reset) o_pE_instruction=0;
    else o_pE_instruction=o_p_instruction;
end    
endmodule