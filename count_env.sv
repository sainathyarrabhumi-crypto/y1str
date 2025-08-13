class count_env;
virtual count_in.drv driv_if;
virtual count_in.wr_mon wr_if;
virtual count_in.rd_mon rd_if;
mailbox #(count_trans)gen2drv=new();
mailbox #(count_trans)wr2rm=new();
mailbox #(count_trans)rd2sb=new();
mailbox #(count_trans)rm2sb=new();
function new(virtual count_in.drv driv_if,
virtual count_in.wr_mon wr_if,
virtual count_in.rd_mon rd_if);
this.driv_if<=driv_if;
this.wr_if<=wr_if;
this.rd_if<=rd_if;
endfunction
count_gen gen_h;
driver drv_h;
count_wr_mon wr_h;
count_rd_mon rd_h;
count_model ref_h;
count_sb sb_h;
virtual task reset_duv():
@(driv_if.dr_cb);
driv_if.dr_cb.reset<=1'b1;
repeat(2)
@(driv_if.dr_cb);
driv_if.ddr_cb.reset=1'b0;
endtask

virtual task build();
gen_h=new(gen2drv);
drv_h=new(gen2drv,driv_if);
wr_h=new(wr_if,wr2rm);
rd_h=new(rd_if,rd2sb);
ref_h=new(rm2sb); 
sb_h=new(rd2sb,rm2sb);
endtask
virtual task start();
gen_h.start;
drv_h.start;
wr_h.start;
ref_h.start;
rd_h.start;
sb_h.start;
endtask
virtual task stop();
if(wait(done.triggered))
endtask
virtual task run();
reset_duv();
start();
stop();
sb_h.report();
endtask
endclass