module RALU(
    input logic clk,
    input logic reset,
    input logic [31:0]alu_out,
    output logic [31:0]RALU
);
always @(posedge clk,posedge reset)begin
    if (reset) RALU=0;
    else RALU=alu_out;
end    
endmodule