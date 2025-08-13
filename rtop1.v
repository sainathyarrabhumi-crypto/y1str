`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    09:21:18 03/11/2025 
// Design Name: 
// Module Name:    rtop1 
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
module rtop1(clk,resetn,read_enable0,read_enable1,read_enable2,pkt_valid,valid_out0,valid_out1,valid_out2,error,busy,data_in,data_out0,data_out1,data_out2);
input clk,resetn,read_enable0,read_enable1,read_enable2,pkt_valid;
output valid_out0,valid_out1,valid_out2,error,busy;
input [7:0]data_in;
output [7:0]data_out0,data_out1,data_out2;
wire [2:0]write_enb;
wire softreset0,softreset1,softreset2,low_pkt_valid,fifo_empty_0,fifo_empty_1,fifo_empty_2;
wire detect_add,ld_state,laf_state,full_state,write_enb_reg,rst_int_reg;
wire parity_done,err;
wire [7:0]d_out;
wire fifo_full;
wire full0,full1,full2;
fsm2 dut(.clk(clk),.resetn(resetn),.pkt_valid(pkt_valid),.parity_done(parity_done),.data_in(data_in[1:0]),.softreset0(softreset0),.softreset1(softreset1),.softreset2(softreset2),.fifo_full(fifo_full),.low_pkt_valid(low_pkt_valid),.fifo_empty_0(fifo_empty_0),.fifo_empty_1(fifo_empty_1),.fifo_empty_2(fifo_empty_2),.busy(busy),.detect_add(detect_add),.ld_state(ld_state),.laf_state(laf_state),.full_state(full_state),.write_enb_reg(write_enb_reg),.rst_int_reg(rst_int_reg),.lfd_state(lfd_state));
syn1 u1(.clk(clk),.resetn(resetn),.detect_add(detect_add),.wrenable_reg(write_enb_reg),.read_enable0(read_enable0),.read_enable1(read_enable1),.read_enable2(read_enable2),.empty0(fifo_empty_0),.empty1(fifo_empty_1),.empty2(fifo_empty_2),.full0(full0),.full1(full1),.full2(full2),.valid_out0(valid_out0),.valid_out1(valid_out1),.valid_out2(valid_out2),.softreset0(softreset0),.softreset1(softreset1),.softreset2(softreset2),.we(write_enb),.fifo_full(fifo_full),.data_in(data_in[1:0]));
register1 sut(.clk(clk),.resetn(resetn),.pkt_valid(pkt_valid),.fifo_full(fifo_full),.rst_int_reg(rst_int_reg),.detect_add(detect_add),.ld_state(ld_state),.lfd_state(lfd_state),.laf_state(laf_state),.full_state(full_state),.data_in(data_in),.parity_done(parity_done),.err(error),.low_pkt_valid(low_pkt_valid),.dout(d_out[7:0]));
fifo a1(.clk(clk),.resetn(resetn),.softreset(softreset0),.we(write_enb[0]),.re(read_enable0),.data_in(d_out),.lfd_state(lfd_state),.data_out(data_out0),.full(full0),.empty(fifo_empty_0));
fifo a2(.clk(clk),.resetn(resetn),.softreset(softreset1),.we(write_enb[1]),.re(read_enable1),.data_in(d_out),.lfd_state(lfd_state),.data_out(data_out1),.full(full1),.empty(fifo_empty_1));
fifo a3(.clk(clk),.resetn(resetn),.softreset(softreset2),.we(write_enb[2]),.re(read_enable2),.data_in(d_out),.lfd_state(lfd_state),.data_out(data_out2),.full(full2),.empty(fifo_empty_2));
endmodule
