module top;
import fifo_pkg::*;
fifo_if in();
base_test test_h1;
base_test_extend1 test2;
base_test_extend2 test3;
reg wr_clk,rd_clk;
asfifo duv(.wr_clk(in.wr_clk),.rd_clk(in.rd_clk),.we(in.we),.re(in.re),.wr_rst(in.wr_rst),.rd_rst(in.rd_rst),.data_in(in.data_in),.data_out(in.data_out),.full(in.full),.empty(in.empty));
initial 
begin
wr_clk=1'b0;
forever
#10 wr_clk=~wr_clk;
end
initial 
begin
rd_clk=1'b0;
forever
#10 rd_clk=~rd_clk;
end
initial 
begin
`ifdef VCS
         $fsdbDumpvars(0, top);
        `endif
if($test$plusargs("TEST1"))
begin
test_h1=new(in,in,in,in);
no_of_trans=16;
test_h1.build();
test_h1.run();
end
if($test$plusargs("TEST2"))
begin
test_h1=new(in,in,in,in);
no_of_trans=16;
test2.build();
test2.run();
end
if($test$plusargs("TEST3"))
begin
test_h1=new(in,in,in,in);
no_of_trans=16;
test3.build();
test3.run();
end
end
endmodule