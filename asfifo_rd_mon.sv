class fifo_rd_mon;
virtual fifo_if.rdmon_if rd_mon_if;
mailbox #(fifo_trans)rd2rm;
mailbox #(fifo_trans)rd2sb;
fifo_trans data2rmon;
fifo_trans data2ref;
fifo_trans data2sb;
function new(virtual fifo_if.rdmon_if rd_mon_if,
mailbox #(fifo_trans)rd2rm,
mailbox #(fifo_trans)rd2sb);
this.rd_mon_if=rd_mon_if;
this.rd2rm=rd2rm;
data2rmon=new();
endfunction
virtual task monitor();
@(rd_mon_if.rd_mon);
wait(rd_mon_if.rd_mon.re);
@(rd_mon_if.rd_mon);
begin
data2rmon.rd_rst<=rd_mon_if.rd_mon.rd_rst;
data2rmon.re<=rd_mon_if.rd_mon.re;
data2rmon.data_out<=rd_mon_if.rd_mon.data_out;
data2rmon.empty<=rd_mon_if.rd_mon.empty;
data2rmon.display("from read monitor");
end
endtask
virtual task start();
fork
begin
forever
begin
monitor();
data2ref=new data2rmon;
data2sb=new data2rmon;
rd2rm.put(data2ref);
rd2sb.put(data2sb);
end
end
join_none
endtask
endclass