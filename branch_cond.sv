module branch_cond (
    input logic [31:0] rdata1,
    input logic [31:0] rdata2,
    input logic [2:0] br_type,
    output logic br_taken
);
always_comb begin : branch_block
    case(br_type)
        3'b000:  br_taken=0;
        3'b001: begin
            if (rdata1==rdata2) br_taken=1;
            else  br_taken=0;
        end
        3'b010: begin
            if ($signed(rdata1)>=$signed(rdata2)) br_taken=1;
            else br_taken=0;
        end
        3'b011: begin
            if (rdata1>=rdata2) br_taken=1;
            else br_taken=0;
        end
        3'b100: begin
            if ($signed(rdata1)<$signed(rdata2)) br_taken=1;
            else br_taken=0;
        end
        3'b101: begin
            if (rdata1<rdata2) br_taken=1;
            else br_taken=0;
        end
        3'b110: begin
            if (rdata1 != rdata2) br_taken=1;
            else br_taken=0;
        end
        3'b111: begin
            br_taken=1;
        end
    endcase
end
    
endmodule