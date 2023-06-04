module program_counter (  input clk,               
                  input logic reset, 
                  input logic [31:0] alu_out,
                  input logic br_taken,             
                  output logic[31:0] pc_out);  
  always @ (posedge clk,posedge reset) begin
    if (reset) pc_out <=0;
    else begin
            if (br_taken) pc_out <= alu_out; 
            else pc_out <= pc_out + 4;
    end
  end
endmodule