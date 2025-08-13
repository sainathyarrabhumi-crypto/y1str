module count_16(mode,clk,reset,data_out,load,data_in);
input mode,clk,reset,load;
input [15:0]data_in;
output reg[15:0]data_out;
reg [15:0]count;
always@(posedge clk)
begin
if(reset)
begin
data_out<=16'b0;
count<=16'b0;
end
else if(load)
begin
count<=16'b0;
data_out<=data_in;
end
else
begin 
if(!load && mode)
begin
count<=count+1'b1;
data_out<=count;
end
else if(!load && !mode)
begin
count<=count-1'b1;
data_out<=count;
end
else
data_out<=16'b0;
end
end
endmodule

