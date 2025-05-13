@echo off
set xv_path=E:\\Xilinx\\Vivado\\2016.1\\bin
call %xv_path%/xsim uart_drive_tb_behav -key {Behavioral:sim_1:Functional:uart_drive_tb} -tclbatch uart_drive_tb.tcl -view E:/source/fpga/project_uart/uart_tx_tb_behav.wcfg -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
