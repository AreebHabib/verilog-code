// Register file for single cycle processor
//32 register of 32 bit each
module register_file(
    input clk,reset,reg_wr,
    input [4:0] raddr1,raddr2,waddr,
    input [31:0] wdata,
    output logic [31:0] rdata1,rdata2
);
// integer i;
logic rf_wr_valid;
assign rf_wr_valid=|waddr & reg_wr;
logic [31:0] reg_file [0:31];
// initial begin
//     $readmemh("E:/EE semester 7/RISCV/Single_Cycle_R&I_type_Intruction/register_file.txt",reg_file);
// end
// $readmemh("register_files.txt",reg_file);
// [31:0]reg_file[0]=32'h00000000;
// Read is asynchronous operaton in register file 
always_comb begin : read_instr
        assign rdata1 = (|raddr1)?reg_file[raddr1]:'0;
        assign rdata2 = (|raddr2)?reg_file[raddr2]:'0;
end
// Write is synchronous operaton in register file 
always_ff @( negedge clk, posedge reset ) begin : write_instr
    if (reset)begin

        reg_file<='{default:'0};
    end
    else if (rf_wr_valid) reg_file[waddr]<=wdata;
end
endmodule
