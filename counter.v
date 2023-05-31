module counter(clk,rst,count);
output reg [5:0]count;
input clk,rst;

wire count_en;
reg next_count;
reg cntup,cntdn,state;
always @(posedge clk or negedge rst)
	begin
	if (~rst)
		count <=6'b0;
	else if (count_en)
		count<=next_count;
end

always @(*)begin
	next_count=count;
	if (state==cntup)
		next_count<=count+1'b1;
	else if (state==cntdn)
		next_count<=count-1'b1;
end

assign count_en=1'b1; //(state==(cntup|cntdn))? 1'b1:1'b0;

endmodule
	

