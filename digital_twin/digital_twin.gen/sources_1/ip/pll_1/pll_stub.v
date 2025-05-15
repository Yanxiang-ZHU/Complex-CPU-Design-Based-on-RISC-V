// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Thu May 15 17:11:45 2025
// Host        : YanX running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/39551/Desktop/College
//               Files/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.gen/sources_1/ip/pll_1/pll_stub.v}
// Design      : pll
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
module pll(clk_out1, clk_out2, locked, clk_in1_p, clk_in1_n)
/* synthesis syn_black_box black_box_pad_pin="locked,clk_in1_p,clk_in1_n" */
/* synthesis syn_force_seq_prim="clk_out1" */
/* synthesis syn_force_seq_prim="clk_out2" */;
  output clk_out1 /* synthesis syn_isclock = 1 */;
  output clk_out2 /* synthesis syn_isclock = 1 */;
  output locked;
  input clk_in1_p;
  input clk_in1_n;
endmodule
