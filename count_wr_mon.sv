class count_wr_mon;
virtual count_in.wr_mon wr_if;
mailbox #(count_trans)wr2rm;
count_trans rd_data;
count_trans send_data;
function new(virtual count_in.wr_mon wr_if,
mailbox #(count_trans)wr2rm);
this.wr_if<=wr_if;
this.wr2rm<=wr2rm;
rd_data=new;
endfunction
virtual task monitor;
@(wr_if.wr_cb);
rd_data.load<=wr_if.wr_cb.load;
rd_data.data_in<=wr_if.wr_cb.data_in;
rd_data.mode<=wr_if.wr_cb.mode;
rd_data.display("from write monitor");
endtask
virtual task start;
fork
begin
forever
begin
monitor;
send_data=new rd_data;
wr2rm.put(send_data);
end
end
join_none
endtask
endclass



