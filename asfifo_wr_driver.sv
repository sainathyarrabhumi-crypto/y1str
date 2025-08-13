class fifo_wr_driver;
virtual fifo_if.wr_if wr_drv_if;
mailbox #(fifo_trans)gen2wr;
fifo_trans data2wr;
function new(virtual fifo_if.wr_if wr_drv_if,
mailbox #(fifo_trans)gen2wr);
this.wr_drv_if=wr_drv_if;
this.gen2wr=gen2wr;
endfunction
virtual task driver();
@(wr_drv_if.wr_drv);
wr_drv_if.wr_drv.wr_rst<=data2wr.wr_rst;
wr_drv_if.wr_drv.we<=data2wr.we;
wr_drv_if.wr_drv.data_in<=data2wr.data_in;
repeat(2);
@(wr_drv_if.wr_drv);
wr_drv_if.wr_drv.we<='b0;
endtask
virtual task start();
fork
begin
forever
begin
gen2wr.get(data2wr);
driver();
end
end
join_none
endtask
endclass