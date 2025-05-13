// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.1 (win64) Build 1538259 Fri Apr  8 15:45:27 MDT 2016
// Date        : Tue Oct 17 00:23:04 2023
// Host        : DESKTOP-PN0654T running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               E:/source/fpga/project_uart/project_uart.srcs/sources_1/ip/PLL/PLL_stub.v
// Design      : PLL
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module PLL(clk_in1_p, clk_in1_n, clk_out1, locked)
/* synthesis syn_black_box black_box_pad_pin="clk_in1_p,clk_in1_n,clk_out1,locked" */;
  input clk_in1_p;
  input clk_in1_n;
  output clk_out1;
  output locked;
endmodule
