class test;
virtual count_in.drv driv_if;
virtual count_in.wr_mon wr_if;
virtual count_in.rd_mon rd_if;
count_env env_h;
function new(virtual count_in.drv driv_if,
virtual count_in.wr_mon wr_if,
virtual count_in.rd_mon rd_if);
this.driv_if=driv_if;
this.wr_if=wr_if;
this.rd_if=rd_if;
env_h=new(driv_if,wr_if,rd_if);
endfunction
virtual task build;
env_h.build;
endtask
virtual task run;
env_h.run;
endtask
endclass
