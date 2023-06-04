module data_memory (
    input logic clk,
    input logic reset,
    input logic [31:0]daddr,
    input logic [31:0]dwdata,
    input logic cs,
    input logic wr,
    input logic rd,
    // input logic [1:0]mask,
    input logic[2:0]lsbwh,//select between load store, byte, word, haldfword
    output logic [31:0]d_rdata
);
     logic [31:0] data_mem [0:2047];// Word addressible memory
    // logic [7:0] data_mem [0:2048];//Byte addressible memory
//Load  Read operation (Reading from data memory and writing it to register file)
always_comb begin : Read_operation_Load_operation
    if(!cs)begin
        if (rd) begin 
            if (lsbwh==0)  assign d_rdata=data_mem[daddr[31:2]];//Loading word for byte addressible memory
            else if (lsbwh==1) begin
                    if (!daddr[1]) assign d_rdata={{16{data_mem[daddr[31:2]][15]}},{data_mem[daddr[31:2]][15:0]}};
                    else if (daddr[1])  assign d_rdata={{16{data_mem[daddr[31:2]][15]}},{data_mem[daddr[31:2]][31:16]}};  
                               end
            else if (lsbwh==2) begin
                    if (!daddr[1]) assign d_rdata={16'b0,{data_mem[daddr[31:2]][15:0]}};
                    else if (daddr[1])  assign d_rdata={16'b0,{data_mem[daddr[31:2]][31:16]}};  
                               end
            else if (lsbwh==3) begin
                    if (daddr[1:0]==0) assign d_rdata={24'b0,{data_mem[daddr[31:2]][7:0]}};
                    else if (daddr[1:0]==1) assign d_rdata={24'b0,{data_mem[daddr[31:2]][15:8]}};
                    else if (daddr[1:0]==2) assign d_rdata={24'b0,{data_mem[daddr[31:2]][23:16]}};
                    else if (daddr[1:0]==3) assign d_rdata={24'b0,{data_mem[daddr[31:2]][31:24]}};
                               end
            else if (lsbwh==4) begin
                    if (daddr[1:0]==0)      assign d_rdata={{24{data_mem[daddr[31:2]][7]}},{data_mem[daddr[31:2]][7:0]}};
                    else if (daddr[1:0]==1) assign d_rdata={{24{data_mem[daddr[31:2]][15]}},{data_mem[daddr[31:2]][15:8]}};
                    else if (daddr[1:0]==2) assign d_rdata={{24{data_mem[daddr[31:2]][23]}},{data_mem[daddr[31:2]][23:16]}};
                    else if (daddr[1:0]==3) assign d_rdata={{24{data_mem[daddr[31:2]][31]}},{data_mem[daddr[31:2]][31:24]}};
                               end
        end
    end
end

//Store synchronous data  for store operation
always_ff @( negedge clk,posedge reset ) begin : write_instr
    if (reset)begin

        data_mem<='{default:'0};
    end
    // else if (rd) data_mem[daddr]<=dwdata;
    else if (!rd & !cs)begin
         if (lsbwh==0) data_mem[daddr[31:2]]<=dwdata;//storing word for byte addressible memory
        else if (lsbwh==1) begin
            if (!daddr[1]) data_mem[daddr[31:2]]<={data_mem[daddr[31:2]][31:16],16'b0}+{{16'b0,dwdata[15:0]}};//storing half word
            else if (daddr[1]) data_mem[daddr[31:2]]<={16'b0,data_mem[daddr[31:2]][15:0]}+{{dwdata[15:0]},16'b0};//storing half word 
        end 
        else if (lsbwh==2) begin
            if (daddr[1:0]==0)  data_mem[daddr[31:2]]<={data_mem[daddr[31:2]][31:8],8'b0}+{{24'b0,dwdata[7:0]}};
            else if (daddr[1:0]==1)  data_mem[daddr[31:2]]<={data_mem[daddr[31:2]][31:16],8'b0,data_mem[daddr[31:2]][7:0]}+{{16'b0,dwdata[7:0],8'b0}};//storing half word
            else if (daddr[1:0]==2)  data_mem[daddr[31:2]]<={data_mem[daddr[31:2]][31:24],8'b0,data_mem[daddr[31:2]][15:0]}+{{8'b0,dwdata[7:0],16'b0}};
            else if (daddr[1:0]==3)  data_mem[daddr[31:2]]<={8'b0,data_mem[daddr[31:2]][23:0]}+{{dwdata[7:0],24'b0}};
        end 
    end
end
endmodule