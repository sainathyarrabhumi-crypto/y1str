interface fifo_if();
logic wr_clk,rd_clk,wr_rst,rd_rst,we,re;
logic [7:0]data_in;
logic [7:0]data_out;
logic full,empty;
clocking wr_drv@(posedge wr_clk);
default input #1 output #1;
output wr_rst;
output we;
output data_in;
endclocking
clocking rd_drv@(posedge rd_clk);
default input #1 output #1;
output rd_rst;
output re;
endclocking
clocking rd_mon@(posedge rd_clk);
default input #1 output #1;
input rd_rst;
input re;
input data_out;
input empty;
endclocking
clocking wr_mon@(posedge wr_clk);
default input #1 output #1;
input wr_rst;
input we;
input data_in;
input full;
endclocking
modport wr_if(clocking wr_drv);
modport rd_if(clocking rd_drv);
modport wrmon_if(clocking wr_mon);
modport rdmon_if(clocking rd_mon);
endinterface