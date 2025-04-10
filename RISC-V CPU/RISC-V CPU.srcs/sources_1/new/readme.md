# SPIC Pipeline CPU Design

This repository contains the implementation of a RISC-V-based pipelined CPU, named **SPIC_Pipeline**, designed to execute RISC-V instructions efficiently. The design includes a 5-stage pipeline architecture with hazard detection, forwarding, and control logic to handle data dependencies and control flow.

## Features

- **5-Stage Pipeline**: Implements the classic instruction pipeline stages:
  - **IF (Instruction Fetch)**
  - **ID (Instruction Decode)**
  - **EX (Execute)**
  - **MEM (Memory Access)**
  - **WB (Write Back)**

- **Hazard Detection**: Includes a hazard detection unit to handle load-use hazards and control hazards.

- **Forwarding Unit**: Implements data forwarding to resolve data dependencies between pipeline stages.

- **Control Unit**: Decodes instructions and generates control signals for the pipeline.

- **Immediate Generator**: Generates immediate values for I-type, S-type, B-type, U-type, and J-type instructions.

- **ALU**: Performs arithmetic and logical operations, as well as branch condition evaluation.

- **Instruction and Data Memory**: Supports loading instructions and data from external memory files (`instructions.mem` and `data.mem`).

## File Structure

- **`SPIC.v`**: The main Verilog file implementing the SPIC_Pipeline CPU.
- **`instructions.mem`**: Memory file containing RISC-V instructions to be executed.
- **`data.mem`**: Memory file containing initial data for the program.

## Module Overview

### 1. `SPIC_Pipeline`
The top-level module that integrates all components of the CPU. It includes:
- Pipeline registers for each stage.
- Data paths for instruction flow and data forwarding.
- Control logic for branching and jumping.

### 2. `instruction_memory`
Loads instructions from `instructions.mem` and provides them to the pipeline during the fetch stage.

### 3. `control_unit`
Generates control signals based on the opcode and function fields of the instruction.

### 4. `immediate_gen`
Generates immediate values for instructions based on their type (I, S, B, U, J).

### 5. `register_file`
Implements the RISC-V register file with 32 registers. Ensures that register `x0` always holds the value `0`.

### 6. `alu`
Performs arithmetic and logical operations, as well as branch condition evaluation.

### 7. `memory`
Implements data memory for load and store instructions. Supports byte, halfword, and word accesses with alignment checks.

### 8. `hazard_detection_unit`
Detects hazards and stalls the pipeline when necessary to prevent incorrect execution.

### 9. `forwarding_unit`
Resolves data hazards by forwarding data from later pipeline stages to earlier stages.

## Pipeline Stages

1. **Instruction Fetch (IF)**:
   - Fetches the instruction from memory.
   - Calculates the next program counter (`pc`).

2. **Instruction Decode (ID)**:
   - Decodes the instruction.
   - Reads registers and generates control signals.

3. **Execute (EX)**:
   - Performs ALU operations.
   - Calculates branch and jump targets.

4. **Memory Access (MEM)**:
   - Reads or writes data to memory.

5. **Write Back (WB)**:
   - Writes results back to the register file.

## How to Use

1. **Prepare Instruction and Data Memory**:
   - Write your RISC-V instructions in `instructions.mem`.
   - Initialize data memory in `data.mem`.

2. **Simulate the Design**:
   - Use a Verilog simulator (e.g., ModelSim, Vivado) to simulate the `SPIC_Pipeline` module.
   - Observe the outputs and pipeline behavior.

3. **Run Testbench**:
   - Use the provided testbench (`tb_riscv.sv`) to verify the functionality of the CPU.

## Example Instruction Memory (`instructions.mem`)

```plaintext
00000513  # addi x1, x0, 10   (x1 = 10)
00000A93  # addi x2, x0, 20   (x2 = 20)
002081B3  # add  x3, x1, x2   (x3 = x1 + x2)
00302023  # sw   x3, 0x1000(x0)  (store x3 to memory at 0x1000)
00002103  # lw   x4, 0x1000(x0)  (load memory at 0x1000 to x4)
```

## Example Data Memory (`data.mem`)

```plaintext
00000000  # Address 0x1000: Initial data 0
00000000  # Address 0x1004: Initial data 0
00000000  # Address 0x1008: Initial data 0
```

## Simulation

To simulate the design:

1. Load the SPIC.v file into your Verilog simulator.
2. Provide the instructions.mem and data.mem files as inputs.
3. Run the simulation and observe the pipeline behavior.

## Future Improvements

Add support for floating-point instructions;

Implement branch prediction to reduce control hazards;

Optimize pipeline performance with advanced forwarding and stalling mechanisms.

## License

This project is licensed under the MIT License. Feel free to use and modify it for educational and research purposes.