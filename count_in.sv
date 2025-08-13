interface count_in(input bit clk);
logic[15:0]data_in;
logic [15:0]data_out;
logic load;
logic mode;
logic reset;
clocking dr_cb@(posedge clk);
default input #1 output #1;
output data_in;
output load;
output mode;
output reset;
endclocking
clocking wr_cb@(posedge clk);
default input #1 output #1;
input data_in;
input load;
input mode;
endclocking
clocking rd_cb@(posedge clk);
default input #1 output #1;
input data_out;
endclocking
modport drv(clocking dr_cb);
modport wr_mon(clocking wr_cb);
modport rd_mon(clocking rd_cb);
endinterface