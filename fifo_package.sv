package fifo_pkg;
int no_of_trans=1;
`include "asfifo_trans.sv"
`include "asfifo_generator.sv"
`include "asfifo_wr_driver.sv"
`include "asfifo_rd_driver.sv"
`include "asfifo_wr_mon.sv"
`include "asfifo_rd_mon.sv"
`include "asfifo_ref_model.sv"
`include "asfifo_sb.sv"
`include "asfifo_env.sv"
`include "fifo_test.sv"
endpackage
