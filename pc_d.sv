module pc_d(
    input logic clk,
    input logic reset,
    input logic [31:0]pc_f_out,
    output logic [31:0]pc_d_out
);
always @(posedge clk,posedge reset)begin
    if (reset) pc_d_out=0;
    else pc_d_out=pc_f_out;
end    
endmodule