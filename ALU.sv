module ALU(
    input logic[31:0]alu_opr1,alu_opr2,
    input logic [3:0] alu_op,
    output logic[31:0]alu_out
);
// logic [31:0]temp;
// temp=alu_opr2;
always_comb begin : ALU_operation
	//adding a comment for future
        case(alu_op)
            4'h1: alu_out=alu_opr1 + alu_opr2;                          //ADD
            4'h2: alu_out=alu_opr1 - alu_opr2;                          //SUBTRACT
            4'h3: alu_out=alu_opr1 & alu_opr2;                          //bitwise AND
            4'h4: alu_out=alu_opr1 | alu_opr2;                          //bitwise OR
            4'h5: alu_out=alu_opr1 ^ alu_opr2;                          //bitwise XOR
            4'h6: alu_out=alu_opr1 << alu_opr2;                         //Shift Left Logical(rs1 by the amount of rs2)
            4'h7: alu_out=alu_opr1 >> alu_opr2;                         //Shift right Logical (zero extended)
            4'h8:alu_out = $signed(alu_opr1) >>> alu_opr2[4:0];         //Shift right Arithmatic
            4'h9: alu_out=($signed(alu_opr1) < $signed(alu_opr2));//Set less than(signed) 
            4'ha: alu_out = (alu_opr1 < alu_opr2);              //Set less than(unsigned)
            4'hb: alu_out = alu_opr2;              //LUI
        endcase 
end

endmodule
