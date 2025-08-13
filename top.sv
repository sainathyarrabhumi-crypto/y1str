module top;
import count_package::*;
reg clk;
count_in duv_if(clk);
test test_h;
count_16 duv(.clk(clk),.load(duv_if.load),.mode(duv_if.mode),.data_in(duv_if.data_in),.reset(duv_if.reset),.data_out(duv_if.data_out));
initial
begin
clk=1'b0;
forever
#10 clk=~clk;
end
initial
begin
test_h=new(duv_if,duv_if,duv_if);
no_of_transactions=300;
test_h.build;
test_h.run;
end
endmodule