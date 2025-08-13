    module asfifo(
	 input  wr_clk, rd_clk,
    input  wr_rst, rd_rst,
    input  we, re,
    input  [7:0] data_in,
    output reg [7:0] data_out,
    output full, empty
);

reg [7:0] mem[0:15];         // FIFO memory
reg [4:0] wr_ptr_bin, wr_ptr_gray;
reg [4:0] rd_ptr_bin, rd_ptr_gray;
reg [4:0] wr_ptr_sync1, wr_ptr_sync2;
reg [4:0] rd_ptr_sync1, rd_ptr_sync2;

// ---- WRITE POINTER ----
always @(posedge wr_clk or posedge wr_rst) begin
  if (wr_rst) begin
    wr_ptr_bin <= 0;
    wr_ptr_gray <= 0;
  end else if (we && !full) begin
    mem[wr_ptr_bin[3:0]] <= data_in;
    wr_ptr_bin <= wr_ptr_bin + 1'b1;
    wr_ptr_gray <= (wr_ptr_bin + 1'b1) ^ ((wr_ptr_bin + 1'b1) >> 1);
  end
end

// ---- READ POINTER ----
always @(posedge rd_clk or posedge rd_rst) begin
  if (rd_rst) begin
    rd_ptr_bin <= 0;
    rd_ptr_gray <= 0;
    data_out <= 0;
  end else if (re && !empty) begin
    data_out <= mem[rd_ptr_bin[3:0]];
    rd_ptr_bin <= rd_ptr_bin + 1'b1;
    rd_ptr_gray <= (rd_ptr_bin + 1'b1) ^ ((rd_ptr_bin + 1'b1) >> 1);
  end
end

// ---- POINTER SYNCHRONIZERS ----
always @(posedge rd_clk or posedge rd_rst) begin
  if (rd_rst) {wr_ptr_sync1, wr_ptr_sync2} <= 0;
  else begin
    wr_ptr_sync1 <= wr_ptr_gray;
    wr_ptr_sync2 <= wr_ptr_sync1;
  end
end

always @(posedge wr_clk or posedge wr_rst) begin
  if (wr_rst) {rd_ptr_sync1, rd_ptr_sync2} <= 0;
  else begin
    rd_ptr_sync1 <= rd_ptr_gray;
    rd_ptr_sync2 <= rd_ptr_sync1;
  end
end

// ---- GRAY TO BINARY FUNCTION ----
function [4:0] gray_to_bin(input [4:0] g);
  integer i;
  begin
    gray_to_bin[4] = g[4];
    for (i = 3; i >= 0; i = i-1)
      gray_to_bin[i] = gray_to_bin[i+1] ^ g[i];
  end
endfunction

wire [4:0] rd_bin_sync = gray_to_bin(rd_ptr_sync2);
wire [4:0] wr_bin_sync = gray_to_bin(wr_ptr_sync2);

// ---- STATUS FLAGS ----
assign empty = (rd_ptr_gray == wr_ptr_sync2);
assign full  = (wr_ptr_gray[4:3] == ~rd_ptr_sync2[4:3]) &&
               (wr_ptr_gray[2:0] ==  rd_ptr_sync2[2:0]);

endmodule
