
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
create_project: 2

00:00:052

00:00:092	
494.5702	
180.676Z17-268h px� 
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/utils_1/imports/synth_1/top.dcpZ12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/utils_1/imports/synth_1/top.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
_
Command: %s
53*	vivadotcl2.
,synth_design -top top -part xc7k325tffg900-2Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
{
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2

xc7k325tZ17-347h px� 
k
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2

xc7k325tZ17-349h px� 
E
Loading part %s157*device2
xc7k325tffg900-2Z21-403h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
2Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
25260Z8-7075h px� 
�
%s*synth2{
yStarting RTL Elaboration : Time (s): cpu = 00:00:03 ; elapsed = 00:00:11 . Memory (MB): peak = 1398.586 ; gain = 441.621
h px� 
�
synthesizing module '%s'%s4497*oasys2
top2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/top.sv2
238@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
pll2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.runs/synth_1/.Xil/Vivado-40312-YanX/realtime/pll_stub.v2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
pll2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.runs/synth_1/.Xil/Vivado-40312-YanX/realtime/pll_stub.v2
68@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
uart2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/uart.sv2
228@Z8-6157h px� 
R
%s
*synth2:
8	Parameter CLK_FREQ bound to: 50000000 - type: integer 
h p
x
� 
O
%s
*synth27
5	Parameter BAUD_RATE bound to: 9600 - type: integer 
h p
x
� 
�
-case statement is not full and has no default155*oasys2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/uart.sv2
1478@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
uart2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/uart.sv2
228@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
twin_controller2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/twin_controller.sv2
238@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
twin_controller2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/twin_controller.sv2
238@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
student_top2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/student_top.sv2
238@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
myCPU2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
18@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
control_unit2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/control_unit.v2
38@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/control_unit.v2
1088@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/control_unit.v2
1318@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/control_unit.v2
1498@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/control_unit.v2
428@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
control_unit2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/control_unit.v2
38@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
immediate_gen2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/immediate_gen.v2
48@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
immediate_gen2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/immediate_gen.v2
48@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
register_file2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
38@Z8-6157h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
evariable '%s' is written by both blocking and non-blocking assignments, entire logic could be removed4426*oasys2
	registers2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
308@Z8-6090h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
register_file2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
38@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
hazard_detection_unit2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/hazard_detectioin_unit.v2
38@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
hazard_detection_unit2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/hazard_detectioin_unit.v2
38@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
forwarding_unit2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/forwarding_unit.v2
48@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
forwarding_unit2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/forwarding_unit.v2
48@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
alu2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/alu.v2
38@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
alu2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/alu.v2
38@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
myCPU2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
18@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
IROM2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.runs/synth_1/.Xil/Vivado-40312-YanX/realtime/IROM_stub.v2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
IROM2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.runs/synth_1/.Xil/Vivado-40312-YanX/realtime/IROM_stub.v2
68@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
perip_bridge2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/perip_bridge.sv2
228@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/perip_bridge.sv2
568@Z8-155h px� 
�
synthesizing module '%s'%s4497*oasys2
display_seg2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/display_seg.sv2
238@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
seg72
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/seg7.sv2
238@Z8-6157h px� 
�
default block is never used226*oasys2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/seg7.sv2
298@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
seg72
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/seg7.sv2
238@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
display_seg2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/display_seg.sv2
238@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
dram_driver2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/dram_driver.sv2
238@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
DRAM2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.runs/synth_1/.Xil/Vivado-40312-YanX/realtime/DRAM_stub.v2
68@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
DRAM2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.runs/synth_1/.Xil/Vivado-40312-YanX/realtime/DRAM_stub.v2
68@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
dram_driver2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/dram_driver.sv2
238@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2	
counter2
 2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/counter.sv2
238@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2	
counter2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/counter.sv2
238@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
perip_bridge2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/perip_bridge.sv2
228@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
student_top2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/student_top.sv2
238@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
top2
 2
02
12�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/top.sv2
238@Z8-6155h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
IF_ID_RST_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
1928@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
ID_EX_BRANCH_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2078@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
ID_EX_CSR_WRITE_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2098@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
ID_EX_RST_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2118@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_PC_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2138@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_MEM_READ_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2188@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_BRANCH_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2218@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_JUMP_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2228@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_BRANCH_TAKEN_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2238@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_FLUSH_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2258@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_STALL_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2268@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_RST_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2278@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
MEM_WB_PC_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2298@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
MEM_WB_JUMP_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2358@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
MEM_WB_FLUSH_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2368@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
MEM_WB_STALL_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2378@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
MEM_WB_RST_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2388@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2

WB_RST_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2408@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
WB_FLUSH_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2418@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
WB_STALL_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/SPIC.v2
2428@Z8-6014h px� 
�
9Port %s in module %s is either unconnected or has no load4866*oasys2

ID_EX_JUMP2
hazard_detection_unitZ8-7129h px� 
s
9Port %s in module %s is either unconnected or has no load4866*oasys2
clk2
register_fileZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

instr[6]2
immediate_genZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

instr[5]2
immediate_genZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

instr[4]2
immediate_genZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

instr[3]2
immediate_genZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

instr[2]2
immediate_genZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

instr[1]2
immediate_genZ8-7129h px� 
x
9Port %s in module %s is either unconnected or has no load4866*oasys2

instr[0]2
immediate_genZ8-7129h px� 
�
%s*synth2{
yFinished RTL Elaboration : Time (s): cpu = 00:00:04 ; elapsed = 00:00:14 . Memory (MB): peak = 1518.227 ; gain = 561.262
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:05 ; elapsed = 00:00:14 . Memory (MB): peak = 1518.227 ; gain = 561.262
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 1 : Time (s): cpu = 00:00:05 ; elapsed = 00:00:14 . Memory (MB): peak = 1518.227 ; gain = 561.262
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0522

1518.2272
0.000Z17-268h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
>

Processing XDC Constraints
244*projectZ1-262h px� 
=
Initializing timing engine
348*projectZ1-569h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.gen/sources_1/ip/DRAM_1/DRAM/DRAM_in_context.xdc2:
6student_top_inst/bridge_inst/dram_driver_inst/Mem_DRAM	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.gen/sources_1/ip/DRAM_1/DRAM/DRAM_in_context.xdc2:
6student_top_inst/bridge_inst/dram_driver_inst/Mem_DRAM	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.gen/sources_1/ip/IROM_1/IROM/IROM_in_context.xdc2
student_top_inst/Mem_IROM	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.gen/sources_1/ip/IROM_1/IROM/IROM_in_context.xdc2
student_top_inst/Mem_IROM	8Z20-847h px� 
�
$Parsing XDC File [%s] for cell '%s'
848*designutils2�
�c:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.gen/sources_1/ip/pll_1/pll/pll_in_context.xdc2
pll_inst	8Z20-848h px� 
�
-Finished Parsing XDC File [%s] for cell '%s'
847*designutils2�
�c:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.gen/sources_1/ip/pll_1/pll/pll_in_context.xdc2
pll_inst	8Z20-847h px� 
�
Parsing XDC File [%s]
179*designutils2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/constrs_1/new/digital_twin.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/constrs_1/new/digital_twin.xdc8Z20-178h px� 
�
�Implementation specific constraints were found while reading constraint file [%s]. These constraints will be ignored for synthesis but will be used in implementation. Impacted constraints are listed in the file [%s].
233*project2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/constrs_1/new/digital_twin.xdc2
.Xil/top_propImpl.xdcZ1-236h px� 
�
Parsing XDC File [%s]
179*designutils2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.runs/synth_1/dont_touch.xdc8Z20-179h px� 
�
Finished Parsing XDC File [%s]
178*designutils2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.runs/synth_1/dont_touch.xdc8Z20-178h px� 
H
&Completed Processing XDC Constraints

245*projectZ1-263h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1628.7302
0.000Z17-268h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2"
 Constraint Validation Runtime : 2

00:00:002
00:00:00.0142

1628.7302
0.000Z17-268h px� 

VNo compile time benefit to using incremental synthesis; A full resynthesis will be run2353*designutilsZ20-5440h px� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}2229*designutilsZ20-4379h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
Finished Constraint Validation : Time (s): cpu = 00:00:10 ; elapsed = 00:00:30 . Memory (MB): peak = 1628.730 ; gain = 671.766
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
D
%s
*synth2,
*Start Loading Part and Timing Information
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Loading part: xc7k325tffg900-2
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:10 ; elapsed = 00:00:30 . Memory (MB): peak = 1628.730 ; gain = 671.766
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
%s
*synth20
.Start Applying 'set_property' XDC Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished applying 'set_property' XDC Constraints : Time (s): cpu = 00:00:11 ; elapsed = 00:00:30 . Memory (MB): peak = 1628.730 ; gain = 671.766
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
k
3inferred FSM for state register '%s' in module '%s'802*oasys2
rx_state_reg2
uartZ8-802h px� 
k
3inferred FSM for state register '%s' in module '%s'802*oasys2
tx_state_reg2
uartZ8-802h px� 
{
3inferred FSM for state register '%s' in module '%s'802*oasys2
current_state_reg2
twin_controllerZ8-802h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                               00 |                             0000
h p
x
� 
y
%s
*synth2a
_                 iSTATE0 |                               01 |                             0001
h p
x
� 
y
%s
*synth2a
_                 iSTATE1 |                               10 |                             0010
h p
x
� 
y
%s
*synth2a
_                 iSTATE2 |                               11 |                             0011
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
rx_state_reg2

sequential2
uartZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                                0 |                             0000
h p
x
� 
y
%s
*synth2a
_                 iSTATE0 |                                1 |                             0001
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
tx_state_reg2

sequential2
uartZ8-3354h px� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
z
%s
*synth2b
`                   State |                     New Encoding |                Previous Encoding 
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
y
%s
*synth2a
_                    IDLE |                               00 |                               00
h p
x
� 
y
%s
*synth2a
_                    SEND |                               01 |                               01
h p
x
� 
y
%s
*synth2a
_                  iSTATE |                               10 |                               11
h p
x
� 

%s
*synth2
*
h p
x
� 
~
%s
*synth2f
d---------------------------------------------------------------------------------------------------
h p
x
� 
�
Gencoded FSM with state register '%s' using encoding '%s' in module '%s'3353*oasys2
current_state_reg2

sequential2
twin_controllerZ8-3354h px� 
�
!inferring latch for variable '%s'327*oasys2	
rs1_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/control_unit.v2
468@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2	
rs2_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/control_unit.v2
478@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
rd_reg2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/control_unit.v2
488@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[0]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[1]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[2]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[3]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[4]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[5]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[6]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[7]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[8]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[9]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[10]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[11]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[12]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[13]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[14]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[15]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[16]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[17]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[18]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[19]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[20]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[21]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[22]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[23]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[24]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[25]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[26]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[27]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[28]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[29]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[30]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
�
!inferring latch for variable '%s'327*oasys2
registers_reg[31]2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.srcs/sources_1/new/register_file.v2
258@Z8-327h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:12 ; elapsed = 00:00:34 . Memory (MB): peak = 1628.730 ; gain = 671.766
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Detailed RTL Component Info : 
h p
x
� 
(
%s
*synth2
+---Adders : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   32 Bit       Adders := 8     
h p
x
� 
F
%s
*synth2.
,	   3 Input   32 Bit       Adders := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   13 Bit       Adders := 3     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit       Adders := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit       Adders := 2     
h p
x
� 
&
%s
*synth2
+---XORs : 
h p
x
� 
H
%s
*synth20
.	   2 Input     32 Bit         XORs := 1     
h p
x
� 
+
%s
*synth2
+---Registers : 
h p
x
� 
H
%s
*synth20
.	               64 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               32 Bit    Registers := 13    
h p
x
� 
H
%s
*synth20
.	               16 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	               13 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	               10 Bit    Registers := 1     
h p
x
� 
H
%s
*synth20
.	                8 Bit    Registers := 22    
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 8     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                3 Bit    Registers := 2     
h p
x
� 
H
%s
*synth20
.	                1 Bit    Registers := 21    
h p
x
� 
'
%s
*synth2
+---Muxes : 
h p
x
� 
F
%s
*synth2.
,	   2 Input   64 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  33 Input   32 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input   32 Bit        Muxes := 19    
h p
x
� 
F
%s
*synth2.
,	   4 Input   32 Bit        Muxes := 7     
h p
x
� 
F
%s
*synth2.
,	   3 Input   32 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   24 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   2 Input   16 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input   13 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   4 Input   13 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input   10 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    8 Bit        Muxes := 4     
h p
x
� 
F
%s
*synth2.
,	   2 Input    5 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   8 Input    5 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  10 Input    5 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   4 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    4 Bit        Muxes := 5     
h p
x
� 
F
%s
*synth2.
,	   7 Input    4 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   2 Input    3 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	  10 Input    3 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   6 Input    3 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input    2 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   3 Input    2 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    2 Bit        Muxes := 7     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 54    
h p
x
� 
F
%s
*synth2.
,	   4 Input    1 Bit        Muxes := 6     
h p
x
� 
F
%s
*synth2.
,	   3 Input    1 Bit        Muxes := 5     
h p
x
� 
F
%s
*synth2.
,	  10 Input    1 Bit        Muxes := 7     
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Finished RTL Component Statistics 
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
s
%s
*synth2[
YPart Resources:
DSPs: 840 (col length:140)
BRAMs: 890 (col length: RAMB18 140 RAMB36 70)
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Part Resource Summary
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
E
%s
*synth2-
+Start Cross Boundary and Area Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
H
&Parallel synthesis criteria is not met4829*oasysZ8-7080h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][31]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][30]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][29]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][28]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][27]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][26]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][25]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][24]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][23]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][22]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][21]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][20]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][19]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][18]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][17]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][16]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][15]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][14]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][13]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][12]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][11]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2"
 Core_cpu/RF/registers_reg[0][10]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][9]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][8]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][7]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][6]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][5]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][4]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][3]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][2]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][1]2
student_topZ8-3332h px� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2!
Core_cpu/RF/registers_reg[0][0]2
student_topZ8-3332h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:23 ; elapsed = 00:01:06 . Memory (MB): peak = 1628.730 ; gain = 671.766
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
@
%s
*synth2(
&Start Applying XDC Timing Constraints
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Applying XDC Timing Constraints : Time (s): cpu = 00:00:27 ; elapsed = 00:01:14 . Memory (MB): peak = 1628.730 ; gain = 671.766
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
4
%s
*synth2
Start Timing Optimization
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2
}Finished Timing Optimization : Time (s): cpu = 00:00:35 ; elapsed = 00:01:32 . Memory (MB): peak = 1649.242 ; gain = 692.277
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
3
%s
*synth2
Start Technology Mapping
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
ESequential element (%s) is unused and will be removed from module %s.3332*oasys2:
8twin_controller_inst/FSM_sequential_current_state_reg[1]2
topZ8-3332h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2~
|Finished Technology Mapping : Time (s): cpu = 00:00:36 ; elapsed = 00:01:34 . Memory (MB): peak = 1649.297 ; gain = 692.332
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
-
%s
*synth2
Start IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
?
%s
*synth2'
%Start Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
B
%s
*synth2*
(Finished Flattening Before IO Insertion
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
6
%s
*synth2
Start Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Finished Final Netlist Cleanup
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2x
vFinished IO Insertion : Time (s): cpu = 00:00:40 ; elapsed = 00:01:42 . Memory (MB): peak = 1658.141 ; gain = 701.176
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
=
%s
*synth2%
#Start Renaming Generated Instances
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:40 ; elapsed = 00:01:42 . Memory (MB): peak = 1658.141 ; gain = 701.176
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
:
%s
*synth2"
 Start Rebuilding User Hierarchy
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:40 ; elapsed = 00:01:42 . Memory (MB): peak = 1658.141 ; gain = 701.176
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Renaming Generated Ports
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:40 ; elapsed = 00:01:42 . Memory (MB): peak = 1658.141 ; gain = 701.176
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
;
%s
*synth2#
!Start Handling Custom Attributes
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:40 ; elapsed = 00:01:43 . Memory (MB): peak = 1658.141 ; gain = 701.176
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
8
%s
*synth2 
Start Renaming Generated Nets
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:40 ; elapsed = 00:01:43 . Memory (MB): peak = 1658.141 ; gain = 701.176
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
9
%s
*synth2!
Start Writing Synthesis Report
h p
x
� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
/
%s
*synth2

Report BlackBoxes: 
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|      |BlackBox name |Instances |
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
=
%s
*synth2%
#|1     |pll           |         1|
h p
x
� 
=
%s
*synth2%
#|2     |IROM          |         1|
h p
x
� 
=
%s
*synth2%
#|3     |DRAM          |         1|
h p
x
� 
=
%s
*synth2%
#+------+--------------+----------+
h p
x
� 
/
%s*synth2

Report Cell Usage: 
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|      |Cell   |Count |
h px� 
2
%s*synth2
+------+-------+------+
h px� 
2
%s*synth2
|1     |DRAM   |     1|
h px� 
2
%s*synth2
|2     |IROM   |     1|
h px� 
2
%s*synth2
|3     |pll    |     1|
h px� 
2
%s*synth2
|4     |BUFG   |    12|
h px� 
2
%s*synth2
|5     |CARRY4 |    95|
h px� 
2
%s*synth2
|6     |LUT1   |    35|
h px� 
2
%s*synth2
|7     |LUT2   |   247|
h px� 
2
%s*synth2
|8     |LUT3   |   100|
h px� 
2
%s*synth2
|9     |LUT4   |   242|
h px� 
2
%s*synth2
|10    |LUT5   |   342|
h px� 
2
%s*synth2
|11    |LUT6   |  1380|
h px� 
2
%s*synth2
|12    |MUXF7  |   272|
h px� 
2
%s*synth2
|13    |MUXF8  |     8|
h px� 
2
%s*synth2
|14    |FDCE   |   689|
h px� 
2
%s*synth2
|15    |FDPE   |    16|
h px� 
2
%s*synth2
|16    |FDRE   |   113|
h px� 
2
%s*synth2
|17    |LD     |    17|
h px� 
2
%s*synth2
|18    |LDC    |   992|
h px� 
2
%s*synth2
|19    |IBUF   |     1|
h px� 
2
%s*synth2
|20    |OBUF   |    73|
h px� 
2
%s*synth2
+------+-------+------+
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:40 ; elapsed = 00:01:43 . Memory (MB): peak = 1658.141 ; gain = 701.176
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
a
%s
*synth2I
GSynthesis finished with 0 errors, 0 critical warnings and 69 warnings.
h p
x
� 
�
%s
*synth2�
Synthesis Optimization Runtime : Time (s): cpu = 00:00:34 ; elapsed = 00:01:39 . Memory (MB): peak = 1658.141 ; gain = 590.672
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:40 ; elapsed = 00:01:43 . Memory (MB): peak = 1658.141 ; gain = 701.176
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.1222

1670.1642
0.000Z17-268h px� 
V
-Analyzing %s Unisim elements for replacement
17*netlist2
1384Z29-17h px� 
X
2Unisim Transformation completed in %s CPU seconds
28*netlist2
0Z29-28h px� 
K
)Preparing netlist for logic optimization
349*projectZ1-570h px� 
Q
)Pushed %s inverter(s) to %s load pin(s).
98*opt2
02
0Z31-138h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Netlist sorting complete. 2

00:00:002
00:00:00.0012

1677.8242
0.000Z17-268h px� 
�
!Unisim Transformation Summary:
%s111*project2h
f  A total of 1009 instances were transformed.
  LD => LDCE: 17 instances
  LDC => LDCE: 992 instances
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

f7135d8cZ4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
722
1302
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
synth_design: 2

00:00:462

00:01:592

1677.8242

1171.914Z17-268h px� 
�
I%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s
268*common2
Write ShapeDB Complete: 2

00:00:002
00:00:00.0152

1677.8242
0.000Z17-268h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2�
�C:/Users/39551/Desktop/College/Contest/JinyedaCup/Complex-CPU-Design-Based-on-RISC-V/digital_twin/digital_twin.runs/synth_1/top.dcpZ17-1381h px� 
z
%s4*runtcl2^
\Executing : report_utilization -file top_utilization_synth.rpt -pb top_utilization_synth.pb
h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Tue May 20 22:53:08 2025Z17-206h px� 


End Record