module pc_f(
    input logic clk,
    input logic reset,
    input logic [31:0]pc_out,
    output logic [31:0]pc_f_out
);
always @(posedge clk,posedge reset)begin
    if (reset) pc_f_out=0;
    else pc_f_out=pc_out;
end    
endmodule