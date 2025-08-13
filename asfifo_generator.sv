class fifo_gen;
mailbox #(fifo_trans)gen2wr;
mailbox #(fifo_trans)gen2rd;
fifo_trans data2drv;
fifo_trans gen2drv;
function new(mailbox #(fifo_trans)gen2wr,
mailbox #(fifo_trans)gen2rd);
this.gen2wr=gen2wr;
this.gen2rd=gen2rd;
data2drv=new();
endfunction
task start();
fork
begin
for(int i=0;i<=no_of_trans;i++)
begin
gen2drv=new();
assert(gen2drv.randomize());
data2drv=new gen2drv;
gen2wr.put(data2drv);
gen2rd.put(data2drv);
end
end
join_none
endtask
endclass