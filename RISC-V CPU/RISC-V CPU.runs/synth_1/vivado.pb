
�
Command: %s
1870*	planAhead2�
�read_checkpoint -auto_incremental -incremental {/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/utils_1/imports/synth_1/SPIC.dcp}Z12-2866h px� 
�
;Read reference checkpoint from %s for incremental synthesis3154*	planAhead2r
p/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/utils_1/imports/synth_1/SPIC.dcpZ12-5825h px� 
T
-Please ensure there are no constraint changes3725*	planAheadZ12-7989h px� 
i
Command: %s
53*	vivadotcl28
6synth_design -top SPIC_Pipeline -part xc7a200tfbg484-1Z4-113h px� 
:
Starting synth_design
149*	vivadotclZ4-321h px� 
{
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2
	Synthesis2

xc7a200tZ17-347h px� 
k
0Got license for feature '%s' and/or device '%s'
310*common2
	Synthesis2

xc7a200tZ17-349h px� 
�
csynth_design options have changed between reference and incremental; A full resynthesis will be run654*	vivadotclZ4-1810h px� 
o
HMultithreading enabled for synth_design using a maximum of %s processes.4828*oasys2
4Z8-7079h px� 
a
?Launching helper process for spawning children vivado processes4827*oasysZ8-7078h px� 
N
#Helper process launched with PID %s4824*oasys2
79961Z8-7075h px� 
�
%s*synth2�
�Starting Synthesize : Time (s): cpu = 00:00:02 ; elapsed = 00:00:02 . Memory (MB): peak = 1703.680 ; gain = 366.777 ; free physical = 1372 ; free virtual = 22662
h px� 
�
synthesizing module '%s'%s4497*oasys2
SPIC_Pipeline2
 2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
18@Z8-6157h px� 
�
synthesizing module '%s'%s4497*oasys2
instruction_memory2
 2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3358@Z8-6157h px� 
�
!system %s call '%s' not supported38048*oasys2

function2
fopen2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3468@Z8-11581h px� 
�
display: %s251*oasys2&
$Error: Unable to open instrument.mem2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3588@Z8-251h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
instruction_memory2
 2
02
12h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3358@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
control_unit2
 2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3658@Z8-6157h px� 
�
-case statement is not full and has no default155*oasys2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
4528@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
4728@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
4878@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
5358@Z8-155h px� 
�
-case statement is not full and has no default155*oasys2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3958@Z8-155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
control_unit2
 2
02
12h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3658@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
immediate_gen2
 2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3108@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
immediate_gen2
 2
02
12h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3108@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
register_file2
 2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
5778@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
register_file2
 2
02
12h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
5778@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
hazard_detection_unit2
 2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
2928@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
hazard_detection_unit2
 2
02
12h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
2928@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
forwarding_unit2
 2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
2678@Z8-6157h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
forwarding_unit2
 2
02
12h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
2678@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
alu2
 2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
6008@Z8-6157h px� 
�
default block is never used226*oasys2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
6128@Z8-226h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
alu2
 2
02
12h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
6008@Z8-6155h px� 
�
synthesizing module '%s'%s4497*oasys2
memory2
 2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
6818@Z8-6157h px� 
�
!system %s call '%s' not supported38048*oasys2

function2
fopen2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
7018@Z8-11581h px� 
�
display: %s251*oasys2 
Error: Unable to open data.mem2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
7138@Z8-251h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
memory2
 2
02
12h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
6818@Z8-6155h px� 
�
'done synthesizing module '%s'%s (%s#%s)4495*oasys2
SPIC_Pipeline2
 2
02
12h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
18@Z8-6155h px� 
�
qTrying to implement RAM '%s' in registers. Block RAM or DRAM implementation is not possible; see log for reasons.3901*oasys2
 Z8-4767h px� 
X
%s
*synth2@
>	1: Unable to determine number of words or word size in RAM. 
h p
x
� 
B
%s
*synth2*
(	2: No valid read/write found for RAM. 
h p
x
� 
7
%s
*synth2
RAM dissolved into registers
h p
x
� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
0Net %s in module/entity %s does not have driver.3422*oasys2
memory2
instruction_memory2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
3398@Z8-3848h px� 
�
�Message '%s' appears more than %s times and has been disabled. User can change this message limit to see more message instances.
14*common2
Synth 8-38482
100Z17-14h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
ID_EX_CSR_WRITE_reg2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
1748@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_BRANCH_reg2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
1858@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
EX_MEM_JUMP_reg2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
1868@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
MEM_WB_PC_reg2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
1908@Z8-6014h px� 
�
+Unused sequential element %s was removed. 
4326*oasys2
MEM_WB_JUMP_reg2h
d/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.srcs/sources_1/new/SPIC.v2
1968@Z8-6014h px� 
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
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[31]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[30]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[29]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[28]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[27]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[26]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[25]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[24]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[23]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[22]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[21]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[20]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[19]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[18]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[17]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[16]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[15]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[14]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[13]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[12]2
instruction_memoryZ8-7129h px� 
|
9Port %s in module %s is either unconnected or has no load4866*oasys2	
addr[1]2
instruction_memoryZ8-7129h px� 
|
9Port %s in module %s is either unconnected or has no load4866*oasys2	
addr[0]2
instruction_memoryZ8-7129h px� 
�
%s*synth2�
�Finished Synthesize : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1856.164 ; gain = 519.262 ; free physical = 1184 ; free virtual = 22475
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
�Finished Constraint Validation : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1856.164 ; gain = 519.262 ; free physical = 1174 ; free virtual = 22464
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
Loading part: xc7a200tfbg484-1
h p
x
� 
E
Loading part %s157*device2
xc7a200tfbg484-1Z21-403h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Loading Part and Timing Information : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1864.168 ; gain = 527.266 ; free physical = 1174 ; free virtual = 22464
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
7
%s
*synth2
Start Preparing Guide Design
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
�Finished Doing Graph Differ : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1864.168 ; gain = 527.266 ; free physical = 1172 ; free virtual = 22464
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
�Finished Preparing Guide Design : Time (s): cpu = 00:00:04 ; elapsed = 00:00:04 . Memory (MB): peak = 1864.168 ; gain = 527.266 ; free physical = 1172 ; free virtual = 22464
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
�Finished RTL Optimization Phase 2 : Time (s): cpu = 00:00:05 ; elapsed = 00:00:05 . Memory (MB): peak = 1864.168 ; gain = 527.266 ; free physical = 1169 ; free virtual = 22460
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
C
%s
*synth2+
)

Incremental Synthesis Report Summary:

h p
x
� 
<
%s
*synth2$
"1. Incremental synthesis run: no

h p
x
� 
�
%s
*synth2z
x   Reason for not running incremental synthesis : synth_design options have changed between reference and incremental


h p
x
� 
�
�Flow is switching to default flow due to incremental criteria not met. If you would like to alter this behaviour and have the flow terminate instead, please set the following parameter config_implementation {autoIncr.Synth.RejectBehavior Terminate}4868*oasysZ8-7130h px� 
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
,	   2 Input   32 Bit       Adders := 4     
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
.	               32 Bit    Registers := 12    
h p
x
� 
H
%s
*synth20
.	                5 Bit    Registers := 5     
h p
x
� 
H
%s
*synth20
.	                4 Bit    Registers := 1     
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
.	                1 Bit    Registers := 15    
h p
x
� 
&
%s
*synth2
+---RAMs : 
h p
x
� 
Z
%s
*synth2B
@	            2048K Bit	(65536 X 32 bit)          RAMs := 1     
h p
x
� 
W
%s
*synth2?
=	             1024 Bit	(32 X 32 bit)          RAMs := 1     
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
,	   2 Input   32 Bit        Muxes := 14    
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
,	   7 Input   32 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   4 Input   32 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   6 Input   32 Bit        Muxes := 1     
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
,	   4 Input    8 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   8 Input    4 Bit        Muxes := 2     
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
,	  11 Input    3 Bit        Muxes := 2     
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
,	   2 Input    2 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   4 Input    2 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   8 Input    1 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	  11 Input    1 Bit        Muxes := 7     
h p
x
� 
F
%s
*synth2.
,	  16 Input    1 Bit        Muxes := 1     
h p
x
� 
F
%s
*synth2.
,	   3 Input    1 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   2 Input    1 Bit        Muxes := 3     
h p
x
� 
F
%s
*synth2.
,	   4 Input    1 Bit        Muxes := 2     
h p
x
� 
F
%s
*synth2.
,	   6 Input    1 Bit        Muxes := 1     
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
DSPs: 740 (col length:100)
BRAMs: 730 (col length: RAMB18 100 RAMB36 50)
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
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[31]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[30]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[29]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[28]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[27]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[26]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[25]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[24]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[23]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[22]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[21]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[20]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[19]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[18]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[17]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[16]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[15]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[14]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[13]2
instruction_memoryZ8-7129h px� 
}
9Port %s in module %s is either unconnected or has no load4866*oasys2

addr[12]2
instruction_memoryZ8-7129h px� 
|
9Port %s in module %s is either unconnected or has no load4866*oasys2	
addr[1]2
instruction_memoryZ8-7129h px� 
|
9Port %s in module %s is either unconnected or has no load4866*oasys2	
addr[0]2
instruction_memoryZ8-7129h px� 
�
�RAM (%s) has partial Byte Wide Write Enable pattern, however no output register found in fanout of RAM. Recommended to use supported Byte Wide Write Enable template. 
4703*oasys2
MEM/mem_regZ8-6851h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Cross Boundary and Area Optimization : Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 2017.473 ; gain = 680.570 ; free physical = 1015 ; free virtual = 22315
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
%s*synth2�
�Finished Timing Optimization : Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1008 ; free virtual = 22308
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
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
�
%s*synth2�
�Finished Technology Mapping : Time (s): cpu = 00:00:10 ; elapsed = 00:00:10 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1007 ; free virtual = 22308
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
%s*synth2�
�Finished IO Insertion : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1012 ; free virtual = 22313
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
�Finished Renaming Generated Instances : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1012 ; free virtual = 22313
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
�Finished Rebuilding User Hierarchy : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1012 ; free virtual = 22313
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
�Finished Renaming Generated Ports : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1012 ; free virtual = 22313
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
�Finished Handling Custom Attributes : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1012 ; free virtual = 22313
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
�Finished Renaming Generated Nets : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1012 ; free virtual = 22313
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
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
| |BlackBox name |Instances |
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
h p
x
� 
8
%s
*synth2 
+-+--------------+----------+
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
|1     |BUFG   |     1|
h px� 
2
%s*synth2
|2     |CARRY4 |     8|
h px� 
2
%s*synth2
|3     |LUT1   |     1|
h px� 
2
%s*synth2
|4     |FDCE   |    30|
h px� 
2
%s*synth2
|5     |IBUF   |     2|
h px� 
2
%s*synth2
|6     |OBUF   |    32|
h px� 
2
%s*synth2
+------+-------+------+
h px� 
3
%s
*synth2

Report Instance Areas: 
h p
x
� 
<
%s
*synth2$
"+------+---------+-------+------+
h p
x
� 
<
%s
*synth2$
"|      |Instance |Module |Cells |
h p
x
� 
<
%s
*synth2$
"+------+---------+-------+------+
h p
x
� 
<
%s
*synth2$
"|1     |top      |       |    74|
h p
x
� 
<
%s
*synth2$
"+------+---------+-------+------+
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
�Finished Writing Synthesis Report : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1012 ; free virtual = 22313
h px� 
l
%s
*synth2T
R---------------------------------------------------------------------------------
h p
x
� 
c
%s
*synth2K
ISynthesis finished with 0 errors, 0 critical warnings and 1091 warnings.
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Runtime : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2029.348 ; gain = 692.445 ; free physical = 1012 ; free virtual = 22313
h p
x
� 
�
%s
*synth2�
�Synthesis Optimization Complete : Time (s): cpu = 00:00:12 ; elapsed = 00:00:12 . Memory (MB): peak = 2029.355 ; gain = 692.445 ; free physical = 1012 ; free virtual = 22313
h p
x
� 
B
 Translating synthesized netlist
350*projectZ1-571h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Netlist sorting complete. 2

00:00:002

00:00:002

2040.2542
0.0002
12102
22510Z17-722h px� 
S
-Analyzing %s Unisim elements for replacement
17*netlist2
8Z29-17h px� 
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
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Netlist sorting complete. 2

00:00:002

00:00:002

2081.0042
0.0002
11612
22463Z17-722h px� 
l
!Unisim Transformation Summary:
%s111*project2'
%No Unisim elements were transformed.
Z1-111h px� 
V
%Synth Design complete | Checksum: %s
562*	vivadotcl2

984fd531Z4-1430h px� 
C
Releasing license: %s
83*common2
	SynthesisZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
442
1672
02
0Z4-41h px� 
L
%s completed successfully
29*	vivadotcl2
synth_designZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
synth_design: 2

00:00:152

00:00:142

2081.0392	
744.1372
11612
22463Z17-722h px� 
�
%s peak %s Memory [%s] %s12246*common2
synth_design2

Physical2
PSS2=
;(MB): overall = 1691.720; main = 1411.353; forked = 379.149Z17-2834h px� 
�
%s peak %s Memory [%s] %s12246*common2
synth_design2	
Virtual2
VSS2=
;(MB): overall = 3027.629; main = 2081.008; forked = 998.277Z17-2834h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2
Write ShapeDB Complete: 2

00:00:002

00:00:002

2105.0162
0.0002
11582
22461Z17-722h px� 
�
 The %s '%s' has been generated.
621*common2

checkpoint2k
i/home/mingzhenjia/Complex-CPU-Design-Based-on-RISC-V/RISC-V CPU/RISC-V CPU.runs/synth_1/SPIC_Pipeline.dcpZ17-1381h px� 
�
%s4*runtcl2r
pExecuting : report_utilization -file SPIC_Pipeline_utilization_synth.rpt -pb SPIC_Pipeline_utilization_synth.pb
h px� 
\
Exiting %s at %s...
206*common2
Vivado2
Sat Apr  5 20:46:28 2025Z17-206h px� 


End Record