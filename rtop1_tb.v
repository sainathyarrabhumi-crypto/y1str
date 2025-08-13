`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:21:35 03/11/2025 
// Design Name: 
// Module Name:    rtop1_tb 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module rtop1_tb();
reg clk,resetn,read_enable0,read_enable1,read_enable2,pkt_valid;
wire valid_out0,valid_out1,valid_out2,error,busy;
reg [7:0]data_in;
wire [7:0]data_out0,data_out1,data_out2;
rtop1 r1(.clk(clk),.resetn(resetn),.read_enable0(read_enable0),.read_enable1(read_enable1),.read_enable2(read_enable2),.pkt_valid(pkt_valid),.valid_out0(valid_out0),.valid_out1(valid_out1),.valid_out2(valid_out2),.error(error),.busy(busy),.data_in(data_in),.data_out0(data_out0),.data_out1(data_out1),.data_out2(data_out2));
integer i;
initial
begin
clk=0;
forever
#0.5 clk=~clk;
end
task initialize;
begin
{read_enable0,read_enable1,read_enable2,pkt_valid,data_in}=12'b0000000000;
end
endtask
task rst_t();
begin
@(negedge clk);
resetn=1'b0;
@(negedge clk);
resetn=1'b1;
end
endtask
task pkt_gen9();
reg [7:0]header,payload_data,parity;
reg [5:0]payload_length;
reg [1:0]addr;
begin
@(negedge clk);
wait(~busy)
payload_length=6'd9;
addr=2'd0;
header={payload_length,addr};
parity=8'd0;
data_in=header;
pkt_valid=1'b1;
parity=parity^header;
@(negedge clk)
wait(busy)
for(i=0;i<payload_length;i=i+1)
begin
@(negedge clk);
payload_data={$random}%256;
data_in=payload_data;
parity=parity^payload_data;
end
@(negedge clk)
pkt_valid=1'b0;
data_in=parity;
end
endtask 
task pkt_gen14();
reg [7:0]header,payload_data,parity;
reg [5:0]payload_length;
reg [1:0]addr;
begin
@(negedge clk)
wait(~busy)
payload_length=6'd14;
addr=2'b01;
pkt_valid=1'b1;
header={payload_length,addr};
parity=8'b0;
data_in=header;
parity=parity^header;
@(negedge clk)
wait(busy)
for(i=0;i<payload_length;i=i+1)
begin
@(negedge clk)
payload_data={$random}%256;
data_in=payload_data;
parity=parity^payload_data;
end
@(negedge clk)
pkt_valid=1'b0;
data_in=parity;
end
endtask 
task pkt_gen16();
reg [7:0]header,payload_data,parity;
reg [5:0]payload_length;
reg [1:0]addr;
begin
@(negedge clk);
wait(~busy)
payload_length=6'd16;
addr=2'b10;
pkt_valid=1'b1;
header={payload_length,addr};
parity=8'b0;
data_in=header;
parity=parity^header;
@(negedge clk)
wait(busy)
for(i=0;i<payload_length;i=i+1)
begin
    @(negedge clk);
     payload_data={$random}%256;
          data_in=payload_data;
           parity=parity^payload_data;
end
@(negedge clk);
pkt_valid=1'b0;
data_in=parity;
end
endtask 
initial
begin
initialize;
rst_t;
#1;
pkt_gen9();
wait(valid_out0)
@(negedge clk)
read_enable0=1'b1;
#10;
pkt_gen14();
wait(valid_out1)
@(negedge clk)
read_enable1=1'b1;
#20;
pkt_gen16();
wait(valid_out2)
@(negedge clk)
read_enable2=1'b1;
#30;
end
endmodule
