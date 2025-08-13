class count_gen;
count_trans trans2drv;
count_trans data2drv;
mailbox #(count_trans)gen2drv;
function new(mailbox #(count_trans)gen2drv);
this.gen2drv<=gen2drv;
trans2drv=new;
endfunction
virtual task start;
fork
begin
for(int i=0;i<=no_of_transactions;i++)
begin
assert(trans2drv.randomize());
data2drv=new trans2drv;
gen2drv.put(data2drv);
end
end
join_none
endtask
endclass