class fifo_trans;
rand logic [7:0]data_in;
logic wr_rst,rd_rst;
logic [7:0]data_out;
logic  full,empty;
logic we,re;
static int no_of_trans;
constraint s1{if(!full)
                we==1'b1;
                else
                we==1'b0;
                }
constraint s2{if(!empty)
                re==1'b1;
                else
                re==1'b0;}
function void display(string msg);
$display("message=%s",msg);
$display("trans=%d",no_of_trans);
$display("write=%d,read=%d,data_in=%d,data_out=%d,full=%d,empty=%d",we,re,data_in,data_out,full,empty);
endfunction
endclass                                