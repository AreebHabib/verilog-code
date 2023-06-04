module immediate_gen (
    input logic [3:0]en_imm,
    input logic [31:0]instruction,
    output logic [31:0]out_im_gen
);
logic [6:0]opcode;
logic temp;
assign opcode=instruction[6:0];
assign temp=instruction[31];
always_comb begin : imm_gen_block
    case(en_imm)
        4'b0001:begin    //I type instruction 
            // assign out_im_gen={1'b0,instruction[31:20]};
           
            // assign out_im_gen={ 20{instruction[31]},instruction[31:20]};
            out_im_gen={{20{temp}},instruction[31:20]};
        end
        4'b0010:begin    //U type instruction 
            out_im_gen={{instruction[31:12]},12'b0}; //For LUI & auipc
        end
        4'b0011:begin    //S type instruction 
            // out_im_gen={{instruction[31:25]},{instruction[11:7]}}; //For LUI & auipc
            out_im_gen={{20{instruction[31]}},{{instruction[31:25]},{instruction[11:7]}}};
        end
        4'b0100:begin // B type 
            out_im_gen={{20{instruction[31]}},{instruction[7]},{instruction[30:25]},{instruction[11:8]},1'b0};
        end
        4'b0101:begin // J type 
            out_im_gen={{12{instruction[31]}},{instruction[19:12]},{instruction[20]},{instruction[30:21]},1'b0};
        end
    endcase
end  
endmodule