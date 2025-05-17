// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2023.2 (lin64) Build 4029153 Fri Oct 13 20:13:54 MDT 2023
// Date        : Sun May 18 01:21:10 2025
// Host        : mingzhenjia-OMEN-by-HP-Gaming-Laptop-16-wf0xxx running 64-bit Ubuntu 22.04.5 LTS
// Command     : write_verilog -force -mode funcsim -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ IROM_sim_netlist.v
// Design      : IROM
// Purpose     : This verilog netlist is a functional simulation representation of the design and should not be modified
//               or synthesized. This netlist cannot be used for SDF annotated simulation.
// Device      : xc7k325tffg900-2
// --------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

(* CHECK_LICENSE_TYPE = "IROM,dist_mem_gen_v8_0_14,{}" *) (* downgradeipidentifiedwarnings = "yes" *) (* x_core_info = "dist_mem_gen_v8_0_14,Vivado 2023.2" *) 
(* NotValidForBitStream *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix
   (a,
    spo);
  input [11:0]a;
  output [31:0]spo;

  wire \<const0> ;
  wire [11:0]a;
  wire [31:0]\^spo ;
  wire [31:0]NLW_U0_dpo_UNCONNECTED;
  wire [31:0]NLW_U0_qdpo_UNCONNECTED;
  wire [31:0]NLW_U0_qspo_UNCONNECTED;
  wire [30:3]NLW_U0_spo_UNCONNECTED;

  assign spo[31] = \^spo [31];
  assign spo[30] = \<const0> ;
  assign spo[29] = \<const0> ;
  assign spo[28] = \<const0> ;
  assign spo[27] = \<const0> ;
  assign spo[26:25] = \^spo [26:25];
  assign spo[24] = \<const0> ;
  assign spo[23:20] = \^spo [23:20];
  assign spo[19] = \<const0> ;
  assign spo[18] = \^spo [18];
  assign spo[17] = \<const0> ;
  assign spo[16:15] = \^spo [16:15];
  assign spo[14] = \<const0> ;
  assign spo[13] = \^spo [13];
  assign spo[12] = \<const0> ;
  assign spo[11] = \<const0> ;
  assign spo[10] = \^spo [10];
  assign spo[9] = \<const0> ;
  assign spo[8:7] = \^spo [8:7];
  assign spo[6] = \<const0> ;
  assign spo[5:4] = \^spo [5:4];
  assign spo[3] = \<const0> ;
  assign spo[2:0] = \^spo [2:0];
  GND GND
       (.G(\<const0> ));
  (* C_FAMILY = "kintex7" *) 
  (* C_HAS_D = "0" *) 
  (* C_HAS_DPO = "0" *) 
  (* C_HAS_DPRA = "0" *) 
  (* C_HAS_I_CE = "0" *) 
  (* C_HAS_QDPO = "0" *) 
  (* C_HAS_QDPO_CE = "0" *) 
  (* C_HAS_QDPO_CLK = "0" *) 
  (* C_HAS_QDPO_RST = "0" *) 
  (* C_HAS_QDPO_SRST = "0" *) 
  (* C_HAS_WE = "0" *) 
  (* C_MEM_TYPE = "0" *) 
  (* C_PIPELINE_STAGES = "0" *) 
  (* C_QCE_JOINED = "0" *) 
  (* C_QUALIFY_WE = "0" *) 
  (* C_REG_DPRA_INPUT = "0" *) 
  (* c_addr_width = "12" *) 
  (* c_default_data = "0" *) 
  (* c_depth = "4096" *) 
  (* c_elaboration_dir = "./" *) 
  (* c_has_clk = "0" *) 
  (* c_has_qspo = "0" *) 
  (* c_has_qspo_ce = "0" *) 
  (* c_has_qspo_rst = "0" *) 
  (* c_has_qspo_srst = "0" *) 
  (* c_has_spo = "1" *) 
  (* c_mem_init_file = "IROM.mif" *) 
  (* c_parser_type = "1" *) 
  (* c_read_mif = "1" *) 
  (* c_reg_a_d_inputs = "0" *) 
  (* c_sync_enable = "1" *) 
  (* c_width = "32" *) 
  (* is_du_within_envelope = "true" *) 
  decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_dist_mem_gen_v8_0_14 U0
       (.a(a),
        .clk(1'b0),
        .d({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .dpo(NLW_U0_dpo_UNCONNECTED[31:0]),
        .dpra({1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0,1'b0}),
        .i_ce(1'b1),
        .qdpo(NLW_U0_qdpo_UNCONNECTED[31:0]),
        .qdpo_ce(1'b1),
        .qdpo_clk(1'b0),
        .qdpo_rst(1'b0),
        .qdpo_srst(1'b0),
        .qspo(NLW_U0_qspo_UNCONNECTED[31:0]),
        .qspo_ce(1'b1),
        .qspo_rst(1'b0),
        .qspo_srst(1'b0),
        .spo(\^spo ),
        .we(1'b0));
endmodule
`pragma protect begin_protected
`pragma protect version = 1
`pragma protect encrypt_agent = "XILINX"
`pragma protect encrypt_agent_info = "Xilinx Encryption Tool 2023.2"
`pragma protect key_keyowner="Synopsys", key_keyname="SNPS-VCS-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
uwBH4JaTzmENPjp1VK18+NmHqz3idKCCPayqakkK6bYDVk0JtRfycJYNxbcnLmlw5yuLTcDXBBKk
FqBPE2n7wWKg9tfz2Y8PrWAvnbsIFMfxBK8sfWUf8PPnz8vUwwMHjbXUWcgCgvtygj/TbB+jcZ8Z
CjYnBZ8tNdKOO1iDLpQ=

`pragma protect key_keyowner="Aldec", key_keyname="ALDEC15_001", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
Ff7o4KDFniNgPFT3cDZtw4HhiKzFbOFtLXtuci0MZhgQ8oZ15BcuowAfxUJXngU8JkWI9cbWKkG8
h/PODwnWEt4eK4VDKRk6Hw3QkZiKAa1N3QupC8D5bR7vJ/+RhJwSayz9t2JpdZaEhKgCgqTcX6oZ
4fCEOmSTUWVob+DXV4UfaMyfVm5VI0wxZ7q0mjFx+pdkt56PuNREX9kH4a9Ma1P0sYo8XaTpANLa
JC6eXOuUQlp40M9F/NL1Xajpys0YfGx8AveMAFEyfRmHZs+NbXmny/79vednrm+FhwtS9LveegmF
NZW9jiiR+9Igeraaz+QXPc6JO/nCDTr4Fuwusg==

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VELOCE-RSA", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=128)
`pragma protect key_block
enb/INzHPP7GNdz8dyyqgVCJiMs9JXcjMywZXhzPersGm0A258UOUwtOqcF1rO7lnrKwTeWbNFVN
dO3BxXBpzGnYWUqDda208CYV9hTWFhfySQdX58qn1Z8QY5G7KniMCVjaGuPPCfToPOOdbAxR9XUp
XbMr0vrZKWxz8nBhGYc=

`pragma protect key_keyowner="Mentor Graphics Corporation", key_keyname="MGC-VERIF-SIM-RSA-2", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
RKZNANfa63/n14iwmSxsB/UeV76BNqjEiYgjlZ2LdFWOArCv6D+jhC4sjGMiaz8GJ8J5kQeiWB0Y
e1+zdHflgzODs6eVC82MlEcfgP0vdDIBn0PP8rVDg5O31eQuJ7n5zn4XJu+vzjpkvJIHKrktAsP4
jg+LRxcTOu0dILImk7Vwgyuwhi8OxNN+jBVbLVxdNj0l5aQMgRZlU/8FVh3u958SH7z/fHnwGaOw
P8QgNv0ZZblWvpxa8TJIwlgVb9354a0eyD9XsKy5VfuUG03nmputxNzUuIUmGtBGCqx+4D4pyCch
j/ixD5iiKRmeKD1/RtGzxmrJap7SAHMuzic1Hw==

`pragma protect key_keyowner="Real Intent", key_keyname="RI-RSA-KEY-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
OQMD0qoDy+4W8+jfTV63GDTwmjWvJILCTofeYJTZqWc2KhrzQXwVMW48dTyIriC6bA4bmXD5BwcB
W2gGbVUvY1Y1+wEFEwYIC0LiPrJO0DhpM1JhP2vkxnTEwaODiEp5x3XqHgsiys0I2/9mE4z4Hlbl
jzftQ/8sVSYokhMp9eaIHk3HNCSBllv90qeBfH3fOdVI2gA1r/22PktttbkyKji24r7jM5o4aMIc
Sp6u0DCnD2cSPCuCuMW3A9sFRuTKbXiLAeeymFIAXHKYQgWXXOqmbKHrk4GviHQyz31C9d+hm6dh
RMtaCyWnhqo3QE/QxP0TsYk3CgkjDCU+KK/ozA==

`pragma protect key_keyowner="Xilinx", key_keyname="xilinxt_2022_10", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
uV1eryjGs1SHbpKIAk5r3BY2SLKX9RlfGw6gbw/UtzBYt4U7vTBIy+x767ojEcmbGLos8kr8vilV
cnNOnsbu7vOAUIe+1PgpaPaCkv2OTPXaE0tfps6+Q6D3zB6j2a2FE1gRIPOniwAdlIn69jL2tuWD
M2BN1efQhi0lZHuKtTgzBOVXIg+zbTiH2k2kHWThOi6WayoBEny+g88wRi6pUBeB6aW3ezFYNmsl
zeOY9xmt+UhRMcr87DCcZdmjsIk6VrsIKF60y93pM0IoQ56iWpQ2OKZK+Ng9qC+pNHBEYEhiMQFb
kUesHtcFOIS7Ok6S9O9SMgf7lMQFOh9w0L31UA==

`pragma protect key_keyowner="Metrics Technologies Inc.", key_keyname="DSim", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
GM2VxmvaiVBg1DsqOLewt6rcWtfH/Gj1QS7fUSMudF5qJ2fn+TXd8kcCwwrxdcXNXjoVi2As5jmL
yw1/NZreemrkS1YCJJDxmnE8CW2q9/4N4a79kApF1VfD5XdpaULhVn+Eb+jXCQFG+GEEOvnPb0Me
bbfRkfc0DAIWgtG2D81EQ28mg7KAWtsDpdUCi+BKdIAj8RXoTiQbFbiBeT7EiRIrz2PQF9nhQBfF
FjlrCNwDP4hRQJQeZcf/1Pl8SFyKGQb6iVF+VhhCVCunL7VBmzaCOW/gowPM7hRM2dvzmxcgeKfs
dZx/fy2rk1iokUi+3B+Jc6CycMWbHu8EfCh7iQ==

`pragma protect key_keyowner="Atrenta", key_keyname="ATR-SG-RSA-1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=384)
`pragma protect key_block
NSZoNMCco4gpYPcg8pb9mtee1JxEWDcDzt6wnS0LeSPMi2upLvQXnSQKMvJGGOKStJOcu1eu7x33
4Xa3ApbjbfZ+lgs1PYlyY4V+B2Lio1EEo1uzZVWFrVFvmknOZwj6Gcmj5N/osaiqKaeIw7NTTbyX
HNHOabVsQJ540qnP4u/nzS/h/AQcm0PFLadGZtHJZEzyQDSSdghD/y/OLprdBcInfQDwAxQuJpCy
ExX4lD2WMrCkymNBS9NMH0vYh4kvpYKRO/oHuGcOZVg0p8vfMmz/BJDHuxTcS3FpLT0WxGVcmUIk
cuqKQFiVwwgnW9AfYkbsMrwfl9po2pofaAY2JC5ZTMyO1qEfSu4fxTRJNnDRvW65KkMdJhZFa36p
82hcDlaYvBowndZfMc42Sxt+ZULFDTFN0HT50iteAG1yEvJ9jKBiJla+kDQJB0VD0kj4+k8aBug3
uPKVykvf1/Uaw8NoW591pML42qlh8v1RzAm6aDnPRdsDaCc5Dq9QDPuE

`pragma protect key_keyowner="Cadence Design Systems.", key_keyname="CDS_RSA_KEY_VER_1", key_method="rsa"
`pragma protect encoding = (enctype="BASE64", line_length=76, bytes=256)
`pragma protect key_block
oRNld8VrAuP/xHUguZzkh8+wROOItnvw1FQUP5KHjxeh8nudEYH2PGefTPsV73QyEruJanGifjCR
m8XHiIxqAY9fk4CAm+2n67YLFUEHjC1Qri9htrL4W5fnj7OIdzcwttvmGEuGOuYOFA98RcnR0jSL
Nyqq5u/eILCh2MiKiELfsBjRv/WckpboJ+gzO1btduECvdBGjsIcjjHiIzPwNSGxnX3G6zG9OiWq
hXP2Jh0Ril7rGbajit90p+gJpDpuLee/aOh0BUXbYYLU0YIXK8bskgMir7D6cfu5oWDKwYH6/YRR
tFjIhRzFsqwjtmaxUnGTZzxsWGazk+uFfHXl7w==

`pragma protect data_method = "AES128-CBC"
`pragma protect encoding = (enctype = "BASE64", line_length = 76, bytes = 9424)
`pragma protect data_block
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
epHC4A802DIgv/0Vv9nCAqkp5Q==
`pragma protect end_protected
`ifndef GLBL
`define GLBL
`timescale  1 ps / 1 ps

module glbl ();

    parameter ROC_WIDTH = 100000;
    parameter TOC_WIDTH = 0;
    parameter GRES_WIDTH = 10000;
    parameter GRES_START = 10000;

//--------   STARTUP Globals --------------
    wire GSR;
    wire GTS;
    wire GWE;
    wire PRLD;
    wire GRESTORE;
    tri1 p_up_tmp;
    tri (weak1, strong0) PLL_LOCKG = p_up_tmp;

    wire PROGB_GLBL;
    wire CCLKO_GLBL;
    wire FCSBO_GLBL;
    wire [3:0] DO_GLBL;
    wire [3:0] DI_GLBL;
   
    reg GSR_int;
    reg GTS_int;
    reg PRLD_int;
    reg GRESTORE_int;

//--------   JTAG Globals --------------
    wire JTAG_TDO_GLBL;
    wire JTAG_TCK_GLBL;
    wire JTAG_TDI_GLBL;
    wire JTAG_TMS_GLBL;
    wire JTAG_TRST_GLBL;

    reg JTAG_CAPTURE_GLBL;
    reg JTAG_RESET_GLBL;
    reg JTAG_SHIFT_GLBL;
    reg JTAG_UPDATE_GLBL;
    reg JTAG_RUNTEST_GLBL;

    reg JTAG_SEL1_GLBL = 0;
    reg JTAG_SEL2_GLBL = 0 ;
    reg JTAG_SEL3_GLBL = 0;
    reg JTAG_SEL4_GLBL = 0;

    reg JTAG_USER_TDO1_GLBL = 1'bz;
    reg JTAG_USER_TDO2_GLBL = 1'bz;
    reg JTAG_USER_TDO3_GLBL = 1'bz;
    reg JTAG_USER_TDO4_GLBL = 1'bz;

    assign (strong1, weak0) GSR = GSR_int;
    assign (strong1, weak0) GTS = GTS_int;
    assign (weak1, weak0) PRLD = PRLD_int;
    assign (strong1, weak0) GRESTORE = GRESTORE_int;

    initial begin
	GSR_int = 1'b1;
	PRLD_int = 1'b1;
	#(ROC_WIDTH)
	GSR_int = 1'b0;
	PRLD_int = 1'b0;
    end

    initial begin
	GTS_int = 1'b1;
	#(TOC_WIDTH)
	GTS_int = 1'b0;
    end

    initial begin 
	GRESTORE_int = 1'b0;
	#(GRES_START);
	GRESTORE_int = 1'b1;
	#(GRES_WIDTH);
	GRESTORE_int = 1'b0;
    end

endmodule
`endif
