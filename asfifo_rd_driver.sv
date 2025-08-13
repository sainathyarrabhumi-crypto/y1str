class fifo_rd_driver;
virtual fifo_if.rd_if rd_drv_if;
mailbox #(fifo_trans)gen2rd;
fifo_trans data2rd;
function new(virtual fifo_if.rd_if rd_drv_if,
mailbox #(fifo_trans)gen2rd);
this.rd_drv_if=rd_drv_if;
this.gen2rd=gen2rd;
endfunction
virtual task driver();
@(rd_drv_if.rd_drv);
rd_drv_if.rd_drv.rd_rst<=data2rd.rd_rst;
rd_drv_if.rd_drv.re<=data2rd.re;
repeat(2);
@(rd_drv_if.rd_drv);
rd_drv_if.rd_drv.re<='b0;
endtask
virtual task start();
fork
begin
forever
begin
gen2rd.get(data2rd);
driver();
end
end
join_none
endtask
endclass