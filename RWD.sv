module R_WD(
    input logic clk,
    input logic reset,
    input logic [31:0]rdata2,
    output logic [31:0]RWD
);
always @(posedge clk,posedge reset)begin
    if (reset) RWD=0;
    else RWD=rdata2;
end    
endmodule