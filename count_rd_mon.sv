class count_rd_mon;
virtual count_in.rd_mon rd_if;
mailbox #(count_trans)rd2sb;
count_trans data2rd,data2sb;
function new(virtual count_in.rd_mon rd_if,
mailbox #(count_trans)rd2sb);
this.rd_if<=rd_if;
this.rd2sb<=rd2sb;
data2rd=new;
endfunction
virtual task monitor;
@(rd_if.rd_cb);
data2rd.data_out<=rd_if.rd_cb.data_out;
endtask
virtual task start;
fork
begin
forever
begin
monitor;
data2sb=new data2rd;
rd2sb.put(data2sb);
end
end
join_none
endtask
endclass