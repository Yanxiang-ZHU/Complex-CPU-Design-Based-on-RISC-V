# Complex-CPU-Design-Based-on-RISC-V
The repository is built for Jingyeda Cup by Cai Xinyu, Cheng Renlong and Zhu Yanxiang, implementing a high-performance CPU based on RISC-V structure. 

![CPU Architecture Diagram](https://github.com/user-attachments/assets/0ae41818-eb57-48dc-92f5-cbb5fb49dd50)


## Overview

This repository contains the complete Vivado source code and CDP trace testing framework for a UART-based single-issue five-stage pipeline CPU implementation. The CPU is fully functional, having passed all trace tests, Vivado simulation, and FPGA bitstream verification.

## Architecture

The CPU follows a classic five-stage pipeline architecture (Fetch, Decode, Execute, Memory, Writeback) with several advanced features:

- **Branch prediction and detection** mechanisms
- **On-chip memory** consisting of IROM (instruction) and DRAM (data) BRAM blocks
- **UART interface** for external communication

## Repository Structure

```
.
├── digital_twin/digital_twin.srcs/
│   ├── sources/
│   │   ├── new/
│   │   │   ├── SPIC.v          
│   │   │   ├── control_unit.v
│   │   │   ├── alu.v
│   │   │   ├── hazard_detection.v
│   │   │   ├── forward_unit.v
│   │   │   └── ......
│   ├── coe/
│   │   ├── irom.coe        # Instruction BRAM
│   │   └── dram.coe        # Data BRAM
│   ├── constrs/            # Timing and pin constraints
│   ├── sims/               # Testbenches and simulation files
│   └── ......
└── cdp_tests/              # CDP trace test framework
    ├── bin                 # test case
    │   ├── add.bin    
    │   ├── .......
    │   ├── xor.bin
    │   └── xori.bin
    ├── asm                 # Disassembly file of the instruction test case, for debugging
    │   ├── add.dump
    │   ├── .......
    │   ├── xor.dump
    │   └── xori.dump
    ├── csrc
    │   ├── dut.h
    │   └── test.cpp
    ├── golden_model
    │   ├── emu.c
    │   ├── include/...
    │   └── stage/...
    ├── waveform            # Waveform file generated after running the test, for debugging
    │   ├── add.vcd
    │   ├── ........
    │   └── xori.vcd
    ├── mySoC               #  Verilog code of the implemented SoC
    |   ├── defines.vh
    │   ├── miniRV_SoC.v（or miniLA_SoC.v）
    |   ├── myCPU.v
    |   ├── Bridge.v
    │   └── ......
    ├── Makefile
    └──  ......
```

## Features

- **Complete Pipeline Implementation**
  - Five classic pipeline stages (IF, ID, EX, MEM, WB)
  - Register file with forwarding paths
  - Memory access unit

- **Hazard Resolution**
  - Data hazard detection and forwarding
  - Control hazard management for branches
  - Pipeline stalling when necessary

- **Memory System**
  - Two separate on-chip BRAM modules
  - IROM for instruction storage
  - DRAM for data operations

- **External Interface**
  - UART communication framework
  - Standardized protocol for loading programs and debugging

## Verification

This CPU design has been rigorously tested through multiple methods:

1. **CDP Trace Testing**: All instruction tests passed successfully
2. **Vivado Simulation**: Waveform analysis confirms correct operation
3. **FPGA Implementation**: Hardware verification on actual FPGA confirms functionality

## Implementation Details

The core architecture is centered around the myCPU top-level design, which interconnects various computational modules including:

- Control unit for instruction decoding and control signal generation
- ALU for arithmetic and logical operations
- Hazard detection unit to identify and resolve pipeline conflicts
- Forwarding unit for data bypassing to minimize stalls
- Register file for CPU state storage
- Program counter and branch handling logic

## Getting Started

### Prerequisites

- Vivado 2023.2 or newer
- Python 3.6+ (for trace testing)
- FPGA board (tested on JINYEDA Remote FPGA)

### Running Trace Tests

```bash
cd cdp_trace
make
python run_all tests.py
```

### Results

![Trace Result](https://github.com/user-attachments/assets/5d12887e-4442-43ad-a2c6-c0368bd3d217)

![Remote FPGA Result](https://github.com/user-attachments/assets/553bdf01-3e88-4af2-b460-f14d4d5cafd6)

