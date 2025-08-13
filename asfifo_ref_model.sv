class fifo_ref_model;
mailbox #(fifo_trans)wr2rm;
mailbox #(fifo_trans)rd2rm;
mailbox #(fifo_trans)rm2sb;
fifo_trans datafwm;
fifo_trans datafrm;
logic [7:0]ref_data[int];
function new(mailbox #(fifo_trans)wr2rm,
mailbox #(fifo_trans)rd2rm,
mailbox #(fifo_trans)rm2sb);
this.wr2rm=wr2rm;
this.rd2rm=rd2rm;
this.rm2sb=rm2sb;
endfunction
virtual task mem_write(fifo_trans datafwm);
if(datafwm.we)
begin
ref_data[datafwm.wr_rst]=datafwm.wr_rst;
ref_data[datafwm.data_in]=datafwm.data_in;
ref_data[datafwm.full]=datafwm.full;
end
endtask
virtual task mem_read(fifo_trans datafrm);
if((datafrm.re)&&(ref_data.exists(datafrm.data_out)))
begin
datafrm.data_out=ref_data[datafrm.data_out];
datafrm.empty=ref_data[datafrm.empty];
end
endtask
virtual task start();
fork
begin
fork
begin
forever
begin
wr2rm.get(datafwm);
mem_write(datafwm);
end
forever
begin
rd2rm.get(datafrm);
mem_read(datafrm);
rm2sb.put(datafrm);
end
end
join
end
join_none
endtask
endclass