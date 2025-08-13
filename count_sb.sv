class sb;
mailbox #(count_trans)ref2sb;
mailbox #(count_trans)rm2sb;
count_trans rmdata;
count_trans sbdata;
event done;
static int rm_data,data_verified,sb_data;
function new(mailbox #(count_trans)ref2sb,
mailbox #(count_trans)rm2sb);
this.ref2sb=ref2sb;
this.rm2sb=rm2sb;
endfunction
virtual task check(count_trans rdata);
if(rmdata.data_out==rdata.data_out)
$display("count matches");
else
$display("count mismatches");
data_verified++;
if(data_verified>=no_of_transactions+2)
begin
->done;
end
endtask
virtual function void report();
$display("-------scoreboard report-------------");
$display("data generated=%d",rm_data);
$display("data verified=%d",data_verified);
$display("-----------");
endfunction
virtual task start();
fork
begin
forever
begin
ref2sb.get(rmdata);
rm_data++;
rm2sb.get(sbdata);
sb_data++;
check(sbdata);
end
end
join_none
endtask
endclass
