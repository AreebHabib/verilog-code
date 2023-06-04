
// Instruction Memory for single cycle processor
//256 bytes
module imem(
    input [31:0] address,
    output logic [31:0] instruction    
);


logic [31:0] instr_mem [0:63];
initial begin
    $readmemh("E:/Computer Architecture/Computer Architecture Lab/CA_Lab/Lab7/instructions.txt",instr_mem);
end


// initial begin
//     $readmemh("C://Users//Dell//Desktop//instructions.txt", instr_mem);
// end
always_comb begin : read_instr
    instruction = instr_mem[address[31:2]];// word addressible memory
end
endmodule