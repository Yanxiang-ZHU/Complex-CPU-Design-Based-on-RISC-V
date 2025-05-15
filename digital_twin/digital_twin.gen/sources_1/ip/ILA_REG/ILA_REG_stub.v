// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
// Date        : Thu May 15 19:17:14 2025
// Host        : YanX running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub {c:/Users/39551/Desktop/College
//               Files/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.gen/sources_1/ip/ILA_REG/ILA_REG_stub.v}
// Design      : ILA_REG
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "ila,Vivado 2023.2" *)
module ILA_REG(clk, probe0, probe1, probe2, probe3, probe4, probe5)
/* synthesis syn_black_box black_box_pad_pin="probe0[4:0],probe1[4:0],probe2[4:0],probe3[31:0],probe4[31:0],probe5[31:0]" */
/* synthesis syn_force_seq_prim="clk" */;
  input clk /* synthesis syn_isclock = 1 */;
  input [4:0]probe0;
  input [4:0]probe1;
  input [4:0]probe2;
  input [31:0]probe3;
  input [31:0]probe4;
  input [31:0]probe5;
endmodule
