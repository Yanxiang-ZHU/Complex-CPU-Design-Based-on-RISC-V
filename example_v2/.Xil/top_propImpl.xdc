set_property SRC_FILE_INFO {cfile:d:/yanjiusheng1/jingyeda/Digital_twin/project_uart/project_uart.gen/sources_1/ip/PLL_1/PLL.xdc rfile:../project_uart.gen/sources_1/ip/PLL_1/PLL.xdc id:1 order:EARLY scoped_inst:PLL_inst/inst} [current_design]
current_instance PLL_inst/inst
set_property src_info {type:SCOPED_XDC file:1 line:57 export:INPUT save:INPUT read:READ} [current_design]
set_input_jitter [get_clocks -of_objects [get_ports clk_in1_p]] 0.050
