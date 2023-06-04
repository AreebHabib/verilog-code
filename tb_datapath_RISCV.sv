module tb_datapath_RISCV;
  logic clk;                     
  logic reset;                    
datapath_RISCV dp_uut(.clk(clk),.reset(reset));
  
  initial begin
    clk = 0;
    forever begin
      #10 clk = ~clk;
    end
  end
  initial begin
    fork 
      reset_sequence();
    join
  end

  task reset_sequence();
                      reset <=    0;
    @(posedge clk); reset <= #1 1;
    @(posedge clk); reset <= #1 0;
  endtask

endmodule