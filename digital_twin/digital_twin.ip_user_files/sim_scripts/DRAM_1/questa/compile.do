vlib questa_lib/work
vlib questa_lib/msim

vlib questa_lib/msim/xpm
vlib questa_lib/msim/dist_mem_gen_v8_0_14
vlib questa_lib/msim/xil_defaultlib

vmap xpm questa_lib/msim/xpm
vmap dist_mem_gen_v8_0_14 questa_lib/msim/dist_mem_gen_v8_0_14
vmap xil_defaultlib questa_lib/msim/xil_defaultlib

vlog -work xpm -64 -incr -mfcu  -sv "+incdir+../../../../digital_twin.gen/sources_1/ip/ILA_DRAM/hdl/verilog" \
"/home/mingzhenjia/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/home/mingzhenjia/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -64 -93  \
"/home/mingzhenjia/Xilinx/Vivado/2023.2/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work dist_mem_gen_v8_0_14 -64 -incr -mfcu  "+incdir+../../../../digital_twin.gen/sources_1/ip/ILA_DRAM/hdl/verilog" \
"../../../ipstatic/simulation/dist_mem_gen_v8_0.v" \

vlog -work xil_defaultlib -64 -incr -mfcu  "+incdir+../../../../digital_twin.gen/sources_1/ip/ILA_DRAM/hdl/verilog" \
"../../../../digital_twin.gen/sources_1/ip/DRAM_1/sim/DRAM.v" \

vlog -work xil_defaultlib \
"glbl.v"

