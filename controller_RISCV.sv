//Controller for RISC-V
module controller_RISCV (
    input logic [6:0]funct7,
    input logic [2:0]funct3,
    input logic [6:0]opcode,
    output logic reg_wr,
    output logic [3:0]alu_op,
    output logic [3:0]en_imm,
    output logic sel_B,
    output logic sel_A,
    output logic [1:0]wb_sel,
    output logic wr,
    output logic rd,
    // output logic [1:0]mask,
    output logic[2:0]lsbwh,
    output logic cs,
    output logic [2:0] br_type
);

always_comb begin
    case(opcode)
        7'b0110011:begin  //R type instruction
            reg_wr=1;
            sel_B=0;
            sel_A=1;
            cs=1;
            wb_sel=0;
            br_type=0;// br_taken=0
            case(funct7)
                7'b0000000:begin
                    case(funct3)
                        3'b000:alu_op=1;
                        3'b111:alu_op=3;
                        3'b110:alu_op=4;
                        3'b100:alu_op=5;
                        3'b001:alu_op=6;
                        3'b101:alu_op=7;
                        3'b010:alu_op=9;
                        3'b011:alu_op=10;
                    endcase
                            end
                7'b0100000:begin
                case(funct3)
                    3'b000:alu_op=2;
                    3'b101:alu_op=8;
                endcase
                    end
            endcase
                    end//End of R type instruction

        7'b0010011:begin  //I type instruction
            br_type=0;// br_taken=0
            sel_B=1;
            sel_A=1;
            reg_wr=1;
            en_imm=1;
            cs=1;
            wb_sel=2'b00;
            case(funct3)
                    3'b000:alu_op=1;
                    3'b111:alu_op=3;
                    3'b110:alu_op=4;
                    3'b100:alu_op=5;
                    3'b010:alu_op=9;
                    3'b011:alu_op=10;
                    3'b001:begin
                        case(funct7)
                            7'b0000000:alu_op=6;
                        endcase
                        end
                    3'b101:begin
                        case(funct7)
                            7'b0000000:alu_op=7;
                            7'b0100000:alu_op=8;
                        endcase
                        end
            endcase
                    end//End of I type instruction
        7'b0000011:begin  //I type load  instruction
                br_type=0;// br_taken=0
                case(funct3)
                        3'b010:begin
                            reg_wr=1;
                            sel_B=1;
                            sel_A=1;
                            en_imm=1;
                            alu_op=1;
                            cs=0;// Reading from Data Memory when cs=0
                            wb_sel=1;
                            rd=1;//Loading from Data memory and storing in instruction memory
                            lsbwh=0;//Load word
                        end
                        3'b101:begin
                            reg_wr=1;
                            sel_B=1;
                            sel_A=1;
                            en_imm=1;
                            alu_op=1;
                            cs=0;// Reading from Data Memory when cs=0
                            wb_sel=1;
                            rd=1;//Loading from Data memory and storing in instruction memory
                            lsbwh=2;//Load half word unsigned
                        end
                        3'b001:begin
                            reg_wr=1;
                            sel_B=1;
                            sel_A=1;
                            en_imm=1;
                            alu_op=1;
                            cs=0;// Reading from Data Memory when cs=0
                            wb_sel=1;
                            rd=1;//Loading from Data memory and storing in instruction memory
                            lsbwh=1;//Load half word signed extended
                        end
                        3'b100:begin
                            reg_wr=1;
                            sel_B=1;
                            sel_A=1;
                            en_imm=1;
                            alu_op=1;
                            cs=0;// Reading from Data Memory when cs=0
                            wb_sel=1;
                            rd=1;//Loading from Data memory and storing in instruction memory
                            lsbwh=3;//Load byte unsigned
                        end
                        3'b000:begin
                            reg_wr=1;
                            sel_B=1;
                            sel_A=1;
                            en_imm=1;
                            alu_op=1;
                            cs=0;// Reading from Data Memory when cs=0
                            wb_sel=1;
                            rd=1;//Loading from Data memory and storing in instruction memory
                            lsbwh=4;//Load byte signed
                        end
                endcase
        end//End of I type load instruction
        7'b0110111:begin  //LUI type instruction
            br_type=0;// br_taken=0
            reg_wr=1;
            en_imm=2;
            sel_B=1;
            sel_A=0;
            alu_op=11;
            wb_sel=0;
            cs=1;
        end//End of LUI type instruction
        7'b0010111:begin  //AUIPC type instruction
            br_type=0;// br_taken=0
            reg_wr=1;
            en_imm=2;
            sel_B=1;
            sel_A=0;
            alu_op=1;
            wb_sel=0;
            cs=1;
        end//End of AUIPC type instruction
        7'b0100011:begin  //S type instruction
            br_type=0;// br_taken=0
                    reg_wr=0;
                    sel_A=1;
                    en_imm=3;
                    sel_B=1;
                    alu_op=1;
                    cs=0;
                    rd=0;
                    wr=0;
            case(funct3)
                3'b010:begin //store word
                    lsbwh=0;//store word
                end
                3'b001:begin //store half word
                    lsbwh=1;//store half word
                end
                3'b000:begin //store byte
                    lsbwh=2;//store byte
                end
            endcase 
        end//End of S type instruction
        7'b1100011:begin  //B type instruction
            en_imm=4;
            sel_A=0;
            sel_B=1;
            reg_wr=0;
            alu_op=1;
            case(funct3)
                3'b000:begin 
                    br_type=1;//beq Branch if equal
                end
                3'b101:begin 
                    br_type=2;//bge branch if greater or equal signed
                end
                3'b111:begin 
                    br_type=3;//bgeu branch if greater or equal unsigned
                end
                3'b100:begin 
                    br_type=4;//blt branch if less than (signed)
                end
                3'b110:begin 
                    br_type=5;//bltu branch if less than (unsigned)
                end
                3'b001:begin 
                    br_type=6;// Not equal
                end
            endcase 
        end//End of B type instruction
        7'b1101111:begin  //J type instruction
            wb_sel=2;
            reg_wr=1;
            sel_B=1;
            sel_A=0;
            alu_op=1;
            en_imm=5;
            br_type=7;//only for j type
        end//End of J type instruction
    endcase
end
endmodule

