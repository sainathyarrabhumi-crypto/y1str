class fifo_env;
virtual fifo_if.wr_if wr_drv_if;
virtual fifo_if.rd_if rd_drv_if;
virtual fifo_if.wrmon_if wr_mon_if;
virtual fifo_if.rdmon_if rd_mon_if;
mailbox #(fifo_trans)gen2wr=new();
mailbox #(fifo_trans)gen2rd=new();
mailbox #(fifo_trans)wm2rm=new();
mailbox #(fifo_trans)rd2rm=new();
mailbox #(fifo_trans)rd2sb=new();
mailbox #(fifo_trans)rm2sb=new();
fifo_gen gen;
fifo_wr_driver wrd;
fifo_rd_driver rdd;
fifo_wr_mon wrm;
fifo_rd_mon rm;
fifo_ref_model ref_h;
fifo_sb sb;
function new(virtual fifo_if.wr_if wr_drv_if,
virtual fifo_if.rd_if rd_drv_if,
virtual fifo_if.wrmon_if wr_mon_if,
virtual fifo_if.rdmon_if rd_mon_if);
this.wr_drv_if=wr_drv_if;
this.rd_drv_if=rd_drv_if;
this.wr_mon_if=wr_mon_if;
this.rd_mon_if=rd_mon_if;
endfunction
virtual task build();
gen=new(gen2wr,gen2rd);
wrd=new(wr_drv_if,gen2wr);
rdd=new(rd_drv_if,gen2rd);
wrm=new(wr_mon_if,wm2rm);
rm=new(rd_mon_if,rd2rm,rd2sb); 
ref_h=new(wm2rm,rd2rm,rm2sb);
sb=new(rd2sb,rm2sb);
endtask
virtual task start();
gen.start();
wrd.start();
rdd.start();
wrm.start();
rm.start();
ref_h.start();
endtask
virtual task reset_dut();
wr_drv_if.wr_drv.we<='b0;
rd_drv_if.rd_drv.re<='b0;
repeat(5) @(wr_drv_if.wr_drv);
wr_drv_if.wr_drv.we<='b1;
repeat(5) @(wr_drv_if.wr_drv);
endtask
virtual task stop();
      wait(sb.done.triggered);
   endtask: stop 
virtual task run();
reset_dut();
start();
stop();
sb.report();
endtask
endclass