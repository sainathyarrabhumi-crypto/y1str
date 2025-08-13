class fifo_sb;
event done;
int data_verified=0;
int rm_data_count=0;
int wm_data_count=0;
fifo_trans refdata;
fifo_trans rmdata;
fifo_trans cov_data;
mailbox #(fifo_trans)rm2sb;
mailbox #(fifo_trans)rd2sb;
covergroup fifo_coverage;
option.per_instance=1;
FULL :coverpoint cov_data.full
                              {
                                bins ZERO={0};
                                bins ONE={1};
                                }
OUT  :coverpoint cov_data.data_out
                                  {
                                    bins MIN={0};
                                    bins MID={[0:64]};
                                    bins MAX={[65:128]};
                                    }

EMPTY :coverpoint cov_data.empty
                              {
                                bins ZERO={0};
                                bins ONE={1};
                                }
                                
endgroup :fifo_coverage

function new(mailbox #(fifo_trans)rm2sb,
mailbox #(fifo_trans)rd2sb);
this.rm2sb=rm2sb;
this.rd2sb=rd2sb;
fifo_coverage=new();
endfunction
virtual task check(fifo_trans rc_data);
if(rc_data.re)
begin
if(rc_data.data_out==0)
$display("random data is not written");
else if((rc_data.data_out!==0) && (rc_data.re))
begin
if(rmdata!==rc_data)
begin
rc_data.display("received data");
rmdata.display("data2duv");
end
else
$display("mismatched");
end
cov_data=new rmdata;
fifo_coverage.sample();
data_verified++;
if(data_verified >= (no_of_trans+1));
               begin             
                  ->done;
               end
         end
   endtask: check
virtual function void report();
      $display(" ------------------------ SCOREBOARD REPORT ----------------------- \n ");
      $display(" %0d Read Data Generated, %0d Read Data Recevied, %0d Read Data Verified \n",
                                             wm_data_count,rm_data_count,data_verified);
      $display(" ------------------------------------------------------------------ \n ");
   endfunction: report
    
endclass

                               