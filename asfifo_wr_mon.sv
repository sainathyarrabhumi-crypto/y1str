class fifo_wr_mon;
virtual fifo_if.wrmon_if wr_mon_if;
mailbox #(fifo_trans)wr2rm;
fifo_trans data2wm;
fifo_trans data2rm;
function new(virtual fifo_if.wrmon_if wr_mon_if,
mailbox #(fifo_trans)wr2rm);
this.wr_mon_if=wr_mon_if;
this.wr2rm=wr2rm;
data2wm=new();
endfunction
virtual task monitor();
@(wr_mon_if.wr_mon);
wait(wr_mon_if.wr_mon.we);
@(wr_mon_if.wr_mon);
begin
data2wm.wr_rst<=wr_mon_if.wr_mon.wr_rst;
data2wm.we<=wr_mon_if.wr_mon.we;
data2wm.data_in<=wr_mon_if.wr_mon.data_in;
data2wm.full<=wr_mon_if.wr_mon.full;
data2wm.display("data from write monitor");
end
endtask
virtual task start();
fork
begin
forever
begin
monitor();
data2rm=new data2wm;
wr2rm.put(data2rm);
end
end
join_none
endtask
endclass
