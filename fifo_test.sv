class fifo_trans1 extends fifo_trans;
constraint random_val{if(full)
                       we==1'b1;
                       }
endclass
class fifo_trans2 extends fifo_trans;
constraint seed_ran{if(empty)
                      re==1'b1;
                      }
endclass
class base_test;
virtual fifo_if.wr_if wr_drv_if;
virtual fifo_if.rd_if rd_drv_if;
virtual fifo_if.wrmon_if wr_mon_if;
virtual fifo_if.rdmon_if rd_mon_if;
fifo_env env_h;
function new(virtual fifo_if.wr_if wr_drv_if,
virtual fifo_if.rd_if rd_drv_if,
virtual fifo_if.wrmon_if wr_mon_if,
virtual fifo_if.rdmon_if rd_mon_if); 
this.wr_drv_if=wr_drv_if;
this.rd_drv_if=rd_drv_if;
this.wr_mon_if=wr_mon_if;
this.rd_mon_if=rd_mon_if;
env_h=new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);
endfunction
virtual task build();
env_h.build();
endtask
virtual task run();
env_h.run();
endtask
endclass       
class base_test_extend1 extends base_test;
fifo_trans1 data_h1;
virtual fifo_if.wr_if wr_drv_if;
virtual fifo_if.rd_if rd_drv_if;
virtual fifo_if.wrmon_if wr_mon_if;
virtual fifo_if.rdmon_if rd_mon_if;
function new(virtual fifo_if.wr_if wr_drv_if,
virtual fifo_if.rd_if rd_drv_if,
virtual fifo_if.wrmon_if wr_mon_if,
virtual fifo_if.rdmon_if rd_mon_if); 
super.new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);
this.wr_drv_if=wr_drv_if;
this.rd_drv_if=rd_drv_if;
this.wr_mon_if=wr_mon_if;
this.rd_mon_if=rd_mon_if;
endfunction
virtual task build();
env_h.build();
endtask
virtual task run();
data_h1=new();
env_h.gen.data2drv=data_h1;
env_h.run();
endtask
endclass
class base_test_extend2 extends base_test;
fifo_trans data_h2;
virtual fifo_if.wr_if wr_drv_if;
virtual fifo_if.rd_if rd_drv_if;
virtual fifo_if.wrmon_if wr_mon_if;
virtual fifo_if.rdmon_if rd_mon_if;
function new(virtual fifo_if.wr_if wr_drv_if,
virtual fifo_if.rd_if rd_drv_if,
virtual fifo_if.wrmon_if wr_mon_if,
virtual fifo_if.rdmon_if rd_mon_if); 
super.new(wr_drv_if,rd_drv_if,wr_mon_if,rd_mon_if);
this.wr_drv_if=wr_drv_if;
this.rd_drv_if=rd_drv_if;
this.wr_mon_if=wr_mon_if;
this.rd_mon_if=rd_mon_if;
endfunction
virtual task build();
env_h.build();
endtask
virtual task run();
data_h2=new();
env_h.gen.data2drv=data_h2;
env_h.run();
endtask
endclass


                 