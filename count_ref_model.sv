class count_model;
mailbox #(count_trans)wr2rm;
mailbox #(count_trans)rm2sb;
count_trans w_data;
static logic [15:0]ref_count;
function new(mailbox #(count_trans)wr2rm,
mailbox #(count_trans)rm2sb);
this.wr2rm<=wr2rm;
this.rm2sb<=rm2sb;
endfunction
task counter(count_trans w_data);
if(w_data.load)
ref_count<=w_data.data_in;
wait(w_data.load==0)
begin
if(w_data.mode==1)
begin
ref_count<=ref_count+1'b1;
end
else
begin
ref_count<=ref_count-1'b1;
end
end
endtask
virtual task start;
fork
begin
forever
begin
wr2rm.get(w_data);
counter(w_data);
w_data.data_out=ref_count;
rm2sb.put(w_data);
end
end
join_none
endtask
endclass