class driver;
virtual count_in.drv driv_if;
mailbox #(count_trans)gen2drv;
count_trans data2send;
function new(virtual count_in.drv driv_if,
mailbox #(count_trans)gen2drv);
this.driv_if<=driv_if;
this.gen2drv<=gen2drv;
endfunction
virtual task drive;
@(driv_if.dr_cb);
driv_if.dr_cb.load<=data2send.load;
driv_if.dr_cb.mode<=data2send.mode;
driv_if.dr_cb.data_in<=data2send.data_in;
endtask
virtual task start;
fork
begin
forever
begin
gen2drv.get(data2send);
drive;
end
end
join_none
endtask
endclass