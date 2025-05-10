# **RISC-V 五级流水顺序双发射处理器 (Basic Functionality Spec)**

## **1. 引言**

本文档旨在详细描述一款五级流水线、顺序双发射的 RISC-V 处理器。该处理器将实现 RV32I 基本指令集，并满足基本功能要求，为后续的扩展和优化提供基础平台。

## **2. 设计目标**

*   包含RV32I的所有指令
*   五级流水线

## **3. 设计参数定义**

| 参数名称       | 值                   | 描述                                                         |
| -------------- | -------------------- | ------------------------------------------------------------ |
| **ISA**        | RV32I                | 支持 RISC-V 32 位整数指令集基础规范                          |
| **流水线级数** | 5                    | 五级流水线：取指 (IF)、译码 (ID)、执行 (EX)、访存 (MEM)、写回 (WB) |

## **4. 微架构概述**

该处理器采用五级流水线结构，以提高指令执行的并发度和吞吐率。处理器支持顺序双发射，在每个时钟周期可以尝试发射两条指令进入执行阶段。为了处理数据冒险、控制冒险和结构冒险，需要实现流水线控制逻辑。为了支持更复杂的程序执行，处理器具备异常和中断处理能力。

### **4.1. 流水线阶段**

1.  **取指 (Instruction Fetch, IF):**
    *   负责从指令存储器获取指令。
    *   检测并报告取指阶段的异常 (例如，指令地址未对齐)。

2.  **译码 (Instruction Decode, ID):**
    *   对取指阶段获取的指令进行解码，识别指令类型和操作数。
    *   进行寄存器读取和依赖关系检查。
    *   为执行阶段准备操作数和控制信号。
    *   支持双发射宽度, 每个周期解码两条指令。
    *   检测并报告译码阶段的异常 (例如，非法指令)。

3.  **执行 (Execute, EX):**
    *   执行解码后的指令操作，例如算术逻辑运算、比较运算等。
    *   至少包含两个 ALU 执行单元，可以并行执行两条指令的 ALU 操作。
    *   可以包含其他执行单元 (例如移位器、乘除法器等)。
    *   处理分支指令的条件判断和目标地址计算。
    *   检测并报告执行阶段的异常 (例如，除零错误)。

4.  **访存 (Memory Access, MEM):**
    *   执行访存指令 (load, store)。
    *   根据指令类型进行数据存储器 (D-Cache, 在基本功能要求中可简化为数据存储器) 的读写操作。
    *   支持不定周期访存，需要处理存储器就绪信号。
    *   检测并报告访存阶段的异常 (例如，访存地址未对齐、页错误)。

5.  **写回 (Write Back, WB):**
    *   将执行结果或访存结果写回寄存器堆。
    *   支持双发射宽度, 每个周期写回两条指令的结果。
    *   检测并报告写回阶段的异常 (例如，写回冲突，虽然在基本流水线中通常不会出现)。

## **5. 模块端口定义及功能描述 **

请注意：为了实现正确的流水线操作，除了以下定义的模块，还需要实现一个关键的“流水线控制逻辑” (Pipeline Control Logic)。该逻辑并非作为一个独立的模块列出端口，而是分布在各个流水线阶段，或集中在一个控制单元中。它负责处理数据冒险、控制冒险、结构冒险（在需要时），并生成流水线停顿、冲刷、转发等控制信号，以确保指令的正确顺序执行和流水线的平稳运行。以下模块的端口定义和功能描述中，会明确指出哪些信号与流水线控制逻辑相关。

以下列出各主要模块的端口定义及功能描述。信号命名约定： `Module_SignalName_Direction_Datawidth`，方向 `I` 表示输入， `O` 表示输出。

### **5.1. 指令取指模块 (IF - Instruction Fetch)**

| 端口名称                        | 方向 | 位宽 | 功能描述                                                     |
| :------------------------------ | :--- | :--- | :----------------------------------------------------------- |
| clk                        | I    | 1    | 时钟信号                                                     |
| rst                      | I    | 1    | 复位信号                                                     |
| **--- 指令存储器接口 ---**      |      |      |                                                              |
| IF_ID_INSTR             | O    | 32   | 输出指令 |
| clk              | I    | 1    | 时钟信号 |
| .addr(pc)                 | I     | 32     | 程序计数器，也就是取指令的地址        |
| **--- PC 及控制流输入 ---**     |      |      |                                                              |
| IF_PC_Update_I                  | I    | 32   | 输入的用于更新PC的值 (来自PC更新逻辑，例如分支跳转、异常处理)。 |
| IF_PC_Update_Enable_I           | I    | 1    | 使能PC更新，通常在分支预测错误、跳转或异常时有效。           |
| IF_PredictedTaken_I             | I    | 1    | 来自分支预测器的分支预测结果 (针对IF阶段PC[0])，指示分支是否预测为发生跳转。 |
| IF_PredictedTargetAddr_I        | I    | 32   | 来自分支预测器的分支目标地址预测 (针对IF阶段PC[0])，用于分支跳转预取的目标地址。 |
| IF_BranchTaken_I                | I    | 1    | 来自 EX 阶段的实际分支判断结果，指示分支是否实际发生，用于分支预测器更新和流水线控制逻辑进行分支预测错误恢复。 **(注意：这是单个信号，代表流水线中第一个解决的分支结果)** |
| IF_BranchTargetAddr_I           | I    | 32   | 来自 EX 阶段的实际分支目标地址，用于分支预测器更新和流水线控制逻辑进行分支预测错误恢复。 **(注意：这是单个信号)** |
| **--- 流水线控制输入 ---**      |      |      |                                                              |
| IF_FetchEnable_I                | I    | 1    | 使能取指，用于流水线控制，通常由流水线控制逻辑根据流水线状态和指令执行需求进行控制 (例如，发生停顿时可能禁止取指)。 |
| IF_Stall_I                      | I    | 1    | 输入的停顿信号，来自流水线控制逻辑 (例如下游阶段请求停顿)，指示 IF 阶段是否需要停顿。 |
| **--- 输出到 IF/ID 寄存器 ---** |      |      |                                                              |
| IF_Instr_Out_O[2]               | O    | 32   | 输出的指令 (每个发射槽位一个)，双发射宽度，最多两条指令，传递到 IF/ID 寄存器。 |
| IF_PC_Out_O[2]                  | O    | 32   | 输出的指令对应的PC值 (每个发射槽位一个)，双发射宽度，传递到 IF/ID 寄存器。 |
| **--- 状态与异常输出 ---**      |      |      |                                                              |
| IF_Stall_O                      | O    | 1    | 输出的停顿请求信号，指示 IF 阶段自身是否因为等待资源 (例如，指令存储器未就绪) 而请求停顿，该信号需要传递给流水线控制逻辑。 |
| IF_ExceptionReq_O               | O    | 1    | 异常请求信号输出，指示 IF 阶段检测到异常 (例如，指令地址未对齐)。 |
| IF_ExceptionID_O                | O    | ~4   | 异常 ID 输出，指示 IF 阶段检测到的异常类型 (位宽取决于异常编码)。 |

### **5.2. 指令译码模块 (ID - Instruction Decode)**

| 端口名称                            | 方向 | 位宽 | 功能描述                                                     |
| :---------------------------------- | :--- | :--- | :----------------------------------------------------------- |
| ID_Clk_I                            | I    | 1    | 时钟信号                                                     |
| ID_Reset_I                          | I    | 1    | 复位信号                                                     |
| **--- 输入来自 IF/ID 寄存器 ---**   |      |      |                                                              |
| ID_Instr_In_I[2]                    | I    | 32   | 输入的指令 (双发射宽度)，来自 IF/ID 寄存器。                 |
| ID_PC_In_I[2]                       | I    | 32   | 输入的指令对应的 PC 值 (双发射宽度)，来自 IF/ID 寄存器。     |
| **--- 寄存器堆读端口接口 ---**      |      |      | **(需要4个读端口: Instr0-rs1, Instr0-rs2, Instr1-rs1, Instr1-rs2)** |
| ID_RF_RAddr1_Instr0_Out_O           | O    | 5    | 寄存器堆读端口1地址输出，用于 **第一条指令 (Instr0)** 的 rs1 字段。 |
| ID_RF_REnable1_Instr0_Out_O         | O    | 1    | 寄存器堆读端口1使能输出，用于 **第一条指令 (Instr0)** 的读取。 |
| ID_RF_RAddr2_Instr0_Out_O           | O    | 5    | 寄存器堆读端口2地址输出，用于 **第一条指令 (Instr0)** 的 rs2 字段。 |
| ID_RF_REnable2_Instr0_Out_O         | O    | 1    | 寄存器堆读端口2使能输出，用于 **第一条指令 (Instr0)** 的读取。 |
| ID_RF_RData1_Instr0_In_I            | I    | 32   | 寄存器堆读端口1数据输入，用于 **第一条指令 (Instr0)**，接收从寄存器堆读取的第一个操作数 (rs1 data)。 |
| ID_RF_RData2_Instr0_In_I            | I    | 32   | 寄存器堆读端口2数据输入，用于 **第一条指令 (Instr0)**，接收从寄存器堆读取的第二个操作数 (rs2 data)。 |
| ID_RF_RAddr1_Instr1_Out_O           | O    | 5    | 寄存器堆读端口3地址输出，用于 **第二条指令 (Instr1)** 的 rs1 字段。 |
| ID_RF_REnable1_Instr1_Out_O         | O    | 1    | 寄存器堆读端口3使能输出，用于 **第二条指令 (Instr1)** 的读取。 |
| ID_RF_RAddr2_Instr1_Out_O           | O    | 5    | 寄存器堆读端口4地址输出，用于 **第二条指令 (Instr1)** 的 rs2 字段。 |
| ID_RF_REnable2_Instr1_Out_O         | O    | 1    | 寄存器堆读端口4使能输出，用于 **第二条指令 (Instr1)** 的读取。 |
| ID_RF_RData1_Instr1_In_I            | I    | 32   | 寄存器堆读端口3数据输入，用于 **第二条指令 (Instr1)**，接收从寄存器堆读取的第一个操作数 (rs1 data)。 |
| ID_RF_RData2_Instr1_In_I            | I    | 32   | 寄存器堆读端口4数据输入，用于 **第二条指令 (Instr1)**，接收从寄存器堆读取的第二个操作数 (rs2 data)。 |
| **--- 输出到 ID/EX 寄存器 ---**     |      |      |                                                              |
| ID_Instr_Out_O[2]                   | O    | 32   | 输出的指令 (双发射宽度)，传递到 ID/EX 寄存器 (可选，主要用于调试或异常处理)。 |
| ID_PC_Out_O[2]                      | O    | 32   | 输出的指令对应的 PC 值 (双发射宽度)，传递到 ID/EX 寄存器。   |
| ID_RS1Data_Out_O[2]                 | O    | 32   | 输出的寄存器堆读取的 rs1 数据 (双发射宽度)，传递到 ID/EX 寄存器。 |
| ID_RS2Data_Out_O[2]                 | O    | 32   | 输出的寄存器堆读取的 rs2 数据 (双发射宽度)，传递到 ID/EX 寄存器。 |
| ID_Immediate_Out_O[2]               | O    | 32   | 输出的指令中的立即数 (符号扩展后，双发射宽度)，传递到 ID/EX 寄存器。 |
| ID_RegWriteAddr_Out_O[2]            | O    | 5    | 输出的寄存器写地址 (rd 字段，双发射宽度)，传递到 ID/EX 寄存器。 |
| **--- 控制信号输出 (到 ID/EX) ---** |      |      |                                                              |
| ID_ALUOp_Out_O[2]                   | O    | ~4-6 | 输出的 ALU 操作类型控制信号 (位宽取决于ALU实现，双发射宽度)，传递到 ID/EX 寄存器。 |
| ID_MemOp_Out_O[2]                   | O    | ~3   | 输出的访存操作类型控制信号 (例如 Load, Store, None, 以及类型 L/S - B/H/W，位宽取决于编码，双发射宽度)，传递到 ID/EX 寄存器。 |
| ID_RegWriteEnable_Out_O[2]          | O    | 1    | 输出的寄存器写使能控制信号 (双发射宽度)，传递到 ID/EX 寄存器。 |
| ID_BranchCtrl_Out_O[2]              | O    | ~3-4 | 输出的分支控制信号 (例如 BEQ, BNE, JAL, JALR, 无分支，位宽取决于编码，双发射宽度)，传递到 ID/EX 寄存器。 |
| ID_CSROP_Out_O                      | O    | ~2-3 | 输出的 CSR 操作类型控制信号 (例如 R/W/S/C，**单发射宽度**)。 |
| ID_CSRAddr_Out_O                    | O    | 12   | 输出的 CSR 寄存器地址 (**单发射宽度**)。                     |
| **--- 流水线控制接口 ---**          |      |      |                                                              |
| ID_Stall_I                          | I    | 1    | 输入的停顿信号，来自流水线控制逻辑 (例如 EX 或 MEM 阶段请求停顿)。 |
| ID_Flush_I                          | I    | 1    | 流水线冲刷信号输入，用于处理分支预测错误或异常，该信号由流水线控制逻辑生成，用于清空 ID 阶段。 |
| ID_Stall_O                          | O    | 1    | 输出的停顿请求信号，指示 ID 阶段是否因为需要停顿 (例如，数据冒险 RAW、结构冒险、指令非法等) 而请求停顿，传递给流水线控制逻辑。 |
| **--- 异常输出 ---**                |      |      |                                                              |
| ID_ExceptionReq_O                   | O    | 1    | 异常请求信号输出，指示 ID 阶段检测到异常 (例如，非法指令)。  |
| ID_ExceptionID_O                    | O    | ~4   | 异常 ID 输出，指示 ID 阶段检测到的异常类型。                 |

### **5.3. 执行模块 (EX - Execute)**

| 端口名称                             | 方向 | 位宽 | 功能描述                                                     |
| :----------------------------------- | :--- | :--- | :----------------------------------------------------------- |
| EX_Clk_I                             | I    | 1    | 时钟信号                                                     |
| EX_Reset_I                           | I    | 1    | 复位信号                                                     |
| **--- 输入来自 ID/EX 寄存器 ---**    |      |      | (这里使用 ID/EX 寄存器输出作为 EX 的输入)                    |
| EX_PC_In_I[2]                        | I    | 32   | 输入的指令 PC 值。                                           |
| EX_RS1Data_In_I[2]                   | I    | 32   | 输入的 rs1 数据 (可能来自寄存器堆或转发)。                   |
| EX_RS2Data_In_I[2]                   | I    | 32   | 输入的 rs2 数据 (可能来自寄存器堆或转发)。                   |
| EX_Immediate_In_I[2]                 | I    | 32   | 输入的立即数。                                               |
| EX_RegWriteAddr_In_I[2]              | I    | 5    | 输入的目的寄存器地址 (rd)。                                  |
| EX_ALUOp_In_I[2]                     | I    | ~4-6 | 输入的 ALU 操作控制信号。                                    |
| EX_MemOp_In_I[2]                     | I    | ~3   | 输入的访存操作控制信号。                                     |
| EX_RegWriteEnable_In_I[2]            | I    | 1    | 输入的写回使能信号。                                         |
| EX_BranchCtrl_In_I[2]                | I    | ~3-4 | 输入的分支控制信号。                                         |
| EX_CSROP_In_I                        | I    | ~2-3 | 输入的 CSR 操作控制信号 (**单发射**)。                       |
| EX_CSRAddr_In_I                      | I    | 12   | 输入的 CSR 地址 (**单发射**)。                               |
| **--- 转发输入 (来自 MEM/WB) ---**   |      |      |                                                              |
| EX_ForwardData_MEM_I[2]              | I    | 32   | 来自 MEM 阶段的转发数据 (例如 Load 结果或 ALU 结果)。        |
| EX_ForwardAddr_MEM_I[2]              | I    | 5    | 来自 MEM 阶段转发数据的目标寄存器地址。                      |
| EX_ForwardValid_MEM_I[2]             | I    | 1    | 指示来自 MEM 阶段的转发数据是否有效。                        |
| EX_ForwardData_WB_I[2]               | I    | 32   | 来自 WB 阶段的转发数据 (刚完成写回的数据)。                  |
| EX_ForwardAddr_WB_I[2]               | I    | 5    | 来自 WB 阶段转发数据的目标寄存器地址。                       |
| EX_ForwardValid_WB_I[2]              | I    | 1    | 指示来自 WB 阶段的转发数据是否有效。                         |
| **--- 输出到 EX/MEM 寄存器 ---**     |      |      |                                                              |
| EX_ALUResult_Out_O[2]                | O    | 32   | ALU 执行结果输出 (双发射宽度)。                              |
| EX_MemAddr_Out_O[2]                  | O    | 32   | 访存指令的地址输出 (双发射宽度)。                            |
| EX_MemWData_Out_O[2]                 | O    | 32   | 访存指令 (Store) 的写数据输出 (双发射宽度)。                 |
| EX_MemOp_Out_O[2]                    | O    | ~3   | 访存操作类型输出，传递到 MEM 阶段 (双发射宽度)。             |
| EX_MemReq_Out_O[2]                   | O    | 1    | 访存请求信号输出，指示当前指令是否为访存指令 (双发射宽度)。  |
| EX_RegWData_Out_O[2]                 | O    | 32   | 需要写回寄存器的结果数据输出 (例如 ALU 结果，或者 CSR 读数据，双发射宽度)，传递到 EX/MEM (最终到 WB)。 |
| EX_RegWEnable_Out_O[2]               | O    | 1    | 寄存器写使能信号输出 (双发射宽度)，传递到 EX/MEM。           |
| EX_RegWAddr_Out_O[2]                 | O    | 5    | 寄存器写地址输出 (双发射宽度)，传递到 EX/MEM。               |
| EX_CSRRdata_Out_O                    | O    | 32   | CSR 寄存器读数据输出 (**单发射宽度**)，用于 csrrw 等指令，传递到 EX/MEM (最终写回)。 |
| **--- 分支结果输出 (反馈给 IF) ---** |      |      |                                                              |
| EX_BranchTaken_Out_O                 | O    | 1    | 分支判断结果输出 (**单发射宽度**)，指示是否有分支发生跳转 (基于流水线中优先的那个分支指令)，用于 IF 阶段更新 PC 和 BP。 |
| EX_BranchTargetAddr_Out_O            | O    | 32   | 分支目标地址输出 (**单发射宽度**)，如果 `EX_BranchTaken_Out_O` 为 1，则此为跳转目标地址，用于 IF 阶段更新 PC 和 BP。 |
| **--- 转发输出 (给自身或 ID) ---**   |      |      |                                                              |
| EX_ForwardALUResult_Out_O[2]         | O    | 32   | ALU 执行结果，用于数据转发 (双发射宽度)，旁路到后续指令的 EX 阶段输入。 |
| EX_ForwardRegWData_Out_O[2]          | O    | 32   | 需要写回寄存器的数据 (例如 ALU 结果)，用于数据转发 (双发射宽度)。 |
| EX_ForwardRegWAddr_Out_O[2]          | O    | 5    | 需要写回寄存器的目标地址，用于数据转发 (双发射宽度)。        |
| **--- 流水线控制与异常 ---**         |      |      |                                                              |
| EX_Stall_I                           | I    | 1    | 输入的停顿信号 (例如 MEM 阶段请求停顿)。                     |
| EX_Stall_O                           | O    | 1    | 输出的停顿请求信号，指示 EX 阶段是否因为需要停顿 (例如，多周期操作未完成，虽然基本要求没有) 而请求停顿，传递给流水线控制逻辑。 |
| EX_Flush_O                           | O    | 1    | 流水线冲刷信号输出，用于处理分支预测错误或异常，该信号由流水线控制逻辑生成，用于清空 IF 和 ID 阶段。 |
| EX_ExceptionReq_O                    | O    | 1    | 异常请求信号输出，指示 EX 阶段检测到异常 (例如，除零错误)。  |
| EX_ExceptionID_O                     | O    | ~4   | 异常 ID 输出，指示 EX 阶段检测到的异常类型。                 |

### **5.4. 访存模块 (MEM - Memory Access)**

| 端口名称                           | 方向 | 位宽 | 功能描述                                                     |
| :--------------------------------- | :--- | :--- | :----------------------------------------------------------- |
| MEM_Clk_I                          | I    | 1    | 时钟信号                                                     |
| MEM_Reset_I                        | I    | 1    | 复位信号                                                     |
| **--- 输入来自 EX/MEM 寄存器 ---** |      |      | (这里使用 EX/MEM 寄存器输出作为 MEM 的输入)                  |
| MEM_ALUResult_In_I[2]              | I    | 32   | 输入的来自 EX 阶段的 ALU 结果 (例如用于地址计算或非访存指令的结果)。 |
| MEM_MemAddr_In_I[2]                | I    | 32   | 输入的访存地址。                                             |
| MEM_MemWData_In_I[2]               | I    | 32   | 输入的 Store 指令写数据。                                    |
| MEM_MemOp_In_I[2]                  | I    | ~3   | 输入的访存操作类型。                                         |
| MEM_MemReq_In_I[2]                 | I    | 1    | 输入的访存请求信号。                                         |
| MEM_RegWData_In_I[2]               | I    | 32   | 输入的需要写回寄存器的数据 (对于非 Load 指令，此数据直接来自 EX)。 |
| MEM_RegWEnable_In_I[2]             | I    | 1    | 输入的写回使能信号。                                         |
| MEM_RegWAddr_In_I[2]               | I    | 5    | 输入的写回目标寄存器地址。                                   |
| **--- 数据存储器接口 ---**         |      |      |                                                              |
| MEM_DataMemAddr_O[2]               | O    | 32   | 数据存储器地址输出 (双发射宽度)。**控制逻辑需处理单端口冲突。** |
| MEM_DataMemWData_O[2]              | O    | 32   | 数据存储器写数据输出 (双发射宽度)。**控制逻辑需处理单端口冲突。** |
| MEM_DataMemWEnable_O[2]            | O    | 1    | 数据存储器写使能输出 (双发射宽度, 通常根据 MemOp 决定)。**控制逻辑需处理单端口冲突。** |
| MEM_DataMemReq_O[2]                | O    | 1    | 数据存储器请求信号输出 (双发射宽度, 基于 MemReq_In)。**控制逻辑需处理单端口冲突。** |
| MEM_DataMemRdata_I[2]              | I    | 32   | 数据存储器读数据输入 (双发射宽度)。                          |
| MEM_DataMemReady_I[2]              | I    | 1    | 数据存储器就绪信号输入 (双发射宽度)，用于处理不定周期访存。  |
| **--- 输出到 MEM/WB 寄存器 ---**   |      |      |                                                              |
| MEM_Rdata_Out_O[2]                 | O    | 32   | 读数据输出 (Load 指令的结果，双发射宽度)，传递到 MEM/WB 寄存器。 |
| MEM_RegWData_Out_O[2]              | O    | 32   | 需要写回寄存器的结果数据输出 (双发射宽度)。对于 Load 指令，这是 `MEM_Rdata_Out_O`；对于其他指令，这是透传的 `MEM_RegWData_In_I`。传递到 MEM/WB。 |
| MEM_RegWEnable_Out_O[2]            | O    | 1    | 寄存器写使能信号输出 (双发射宽度)，传递到 MEM/WB。           |
| MEM_RegWAddr_Out_O[2]              | O    | 5    | 寄存器写地址输出 (双发射宽度)，传递到 MEM/WB。               |
| **--- 转发输出 (给 EX) ---**       |      |      |                                                              |
| MEM_ForwardRegWData_Out_O[2]       | O    | 32   | 需要写回寄存器的数据 (例如 Load 结果或 ALU 结果)，用于数据转发 (双发射宽度)，旁路到后续指令的 EX 阶段输入。 |
| MEM_ForwardRegWAddr_Out_O[2]       | O    | 5    | 需要写回寄存器的目标地址，用于数据转发 (双发射宽度)。        |
| **--- 流水线控制与异常 ---**       |      |      |                                                              |
| MEM_Stall_I                        | I    | 1    | 输入的停顿信号 (例如 WB 阶段请求停顿，虽然少见)。            |
| MEM_Stall_O                        | O    | 1    | 输出的停顿请求信号，指示 MEM 阶段是否因为等待资源 (例如，数据存储器未就绪 Data Cache Miss) 而请求停顿，传递给流水线控制逻辑。 |
| MEM_ExceptionReq_O                 | O    | 1    | 异常请求信号输出，指示 MEM 阶段检测到异常 (例如，访存地址未对齐、页错误)。 |
| MEM_ExceptionID_O                  | O    | ~4   | 异常 ID 输出，指示 MEM 阶段检测到的异常类型。                |

### **5.5. 写回模块 (WB - Write Back)**

| 端口名称                           | 方向 | 位宽 | 功能描述                                                     |
| :--------------------------------- | :--- | :--- | :----------------------------------------------------------- |
| WB_Clk_I                           | I    | 1    | 时钟信号                                                     |
| WB_Reset_I                         | I    | 1    | 复位信号                                                     |
| **--- 输入来自 MEM/WB 寄存器 ---** |      |      | (这里使用 MEM/WB 寄存器输出作为 WB 的输入)                   |
| WB_RegWData_In_I[2]                | I    | 32   | 输入的需要写回寄存器的数据 (双发射宽度)。                    |
| WB_RegWEnable_In_I[2]              | I    | 1    | 输入的写回使能信号 (双发射宽度)。                            |
| WB_RegWAddr_In_I[2]                | I    | 5    | 输入的写回目标寄存器地址 (双发射宽度)。                      |
| **--- 寄存器堆写端口接口 ---**     |      |      | **(需要2个写端口: Instr0-rd, Instr1-rd)**                    |
| WB_RF_WAddr_Instr0_Out_O           | O    | 5    | 寄存器堆写端口1地址输出，用于 **第一条指令 (Instr0)** 的 rd。 |
| WB_RF_WData_Instr0_Out_O           | O    | 32   | 寄存器堆写端口1数据输出，用于 **第一条指令 (Instr0)**。      |
| WB_RF_WEnable_Instr0_Out_O         | O    | 1    | 寄存器堆写端口1写使能输出，用于 **第一条指令 (Instr0)**。    |
| WB_RF_WAddr_Instr1_Out_O           | O    | 5    | 寄存器堆写端口2地址输出，用于 **第二条指令 (Instr1)** 的 rd。 |
| WB_RF_WData_Instr1_Out_O           | O    | 32   | 寄存器堆写端口2数据输出，用于 **第二条指令 (Instr1)**。      |
| WB_RF_WEnable_Instr1_Out_O         | O    | 1    | 寄存器堆写端口2写使能输出，用于 **第二条指令 (Instr1)**。    |
| **--- 流水线控制与异常 ---**       |      |      |                                                              |
| WB_Stall_I                         | I    | 1    | 输入的停顿信号 (来自外部或调试逻辑，通常 WB 阶段不接收来自下游的停顿)。 |
| WB_Stall_O                         | O    | 1    | 输出的停顿信号，指示 WB 阶段是否需要停顿 (例如，结构冒险 - 如果写端口冲突，但我们设计了2个写端口；或者等待调试)。该信号传递给流水线控制逻辑 (通常 WB 不主动请求停顿)。 |
| WB_ExceptionReq_O                  | O    | 1    | 异常请求信号输出，指示 WB 阶段检测到异常 (例如，写回冲突 - 如果只有一个写端口，但在我们的设计中不应该发生)。 |
| WB_ExceptionID_O                   | O    | ~4   | 异常 ID 输出，指示 WB 阶段检测到的异常类型。                 |

### **5.6. 寄存器堆 (RF - Register File)**

| 端口名称                     | 方向 | 位宽 | 功能描述                                    |
| :--------------------------- | :--- | :--- | :------------------------------------------ |
| RF_Clk_I                     | I    | 1    | 时钟信号                                    |
| RF_Reset_I                   | I    | 1    | 复位信号                                    |
| **--- 读端口 (共 4 个) ---** |      |      | (输入来自 ID 模块)                          |
| RF_RAddr1_Instr0_In_I        | I    | 5    | 读端口1地址输入 (来自 ID, Instr0, rs1)。    |
| RF_REnable1_Instr0_In_I      | I    | 1    | 读端口1使能输入 (来自 ID, Instr0)。         |
| RF_RData1_Instr0_Out_O       | O    | 32   | 读端口1数据输出 (到 ID, Instr0, rs1 data)。 |
| RF_RAddr2_Instr0_In_I        | I    | 5    | 读端口2地址输入 (来自 ID, Instr0, rs2)。    |
| RF_REnable2_Instr0_In_I      | I    | 1    | 读端口2使能输入 (来自 ID, Instr0)。         |
| RF_RData2_Instr0_Out_O       | O    | 32   | 读端口2数据输出 (到 ID, Instr0, rs2 data)。 |
| RF_RAddr1_Instr1_In_I        | I    | 5    | 读端口3地址输入 (来自 ID, Instr1, rs1)。    |
| RF_REnable1_Instr1_In_I      | I    | 1    | 读端口3使能输入 (来自 ID, Instr1)。         |
| RF_RData1_Instr1_Out_O       | O    | 32   | 读端口3数据输出 (到 ID, Instr1, rs1 data)。 |
| RF_RAddr2_Instr1_In_I        | I    | 5    | 读端口4地址输入 (来自 ID, Instr1, rs2)。    |
| RF_REnable2_Instr1_In_I      | I    | 1    | 读端口4使能输入 (来自 ID, Instr1)。         |
| RF_RData2_Instr1_Out_O       | O    | 32   | 读端口4数据输出 (到 ID, Instr1, rs2 data)。 |
| **--- 写端口 (共 2 个) ---** |      |      | (输入来自 WB 模块)                          |
| RF_WAddr_Instr0_In_I         | I    | 5    | 写端口1地址输入 (来自 WB, Instr0, rd)。     |
| RF_WData_Instr0_In_I         | I    | 32   | 写端口1数据输入 (来自 WB, Instr0)。         |
| RF_WEnable_Instr0_In_I       | I    | 1    | 写端口1写使能输入 (来自 WB, Instr0)。       |
| RF_WAddr_Instr1_In_I         | I    | 5    | 写端口2地址输入 (来自 WB, Instr1, rd)。     |
| RF_WData_Instr1_In_I         | I    | 32   | 写端口2数据输入 (来自 WB, Instr1)。         |
| RF_WEnable_Instr1_In_I       | I    | 1    | 写端口2写使能输入 (来自 WB, Instr1)。       |

### **5.7. 控制单元模块 (CU - Control Unit - 可作为流水线控制逻辑的一部分)**

（待补充）

### **5.8. CSR 单元模块 (CSR Unit)**

（待补充）

### **5.9. 分支预测器模块 (BP - Branch Predictor)**

（待补充）

### **5.10. 流水线寄存器 (Pipeline Registers)**

流水线寄存器用于连接相邻的流水线阶段，传递指令和控制信息。它们是实现流水线的关键组件，需要包含时钟和复位信号，以及可能的清空逻辑（由 Flush 信号控制）。

**5.10.1. IF/ID 寄存器组 (IF_ID_Reg)**

| 寄存器名称           | 位宽 | 功能描述                                                     |
| :------------------- | :--- | :----------------------------------------------------------- |
| IF_ID_Instr_O[2]     | 32   | 传递指令 (双发射宽度)。                                      |
| IF_ID_PC_O[2]        | 32   | 传递指令的 PC 值 (双发射宽度)。                              |
| IF_ID_Valid_O[2]     | 1    | 指令有效位 (双发射宽度)，由流水线控制逻辑控制，用于处理流水线气泡和停顿。 |
| IF_ID_ExceptionReq_O | 1    | 传递 IF 阶段的异常请求信号。                                 |
| IF_ID_ExceptionID_O  | ~4   | 传递 IF 阶段的异常 ID。                                      |
| *--- 控制信号 ---*   |      |                                                              |
| IF_ID_Clk            | 1    | 时钟信号                                                     |
| IF_ID_Reset          | 1    | 复位信号                                                     |
| IF_ID_Flush          | 1    | 冲刷信号 (来自流水线控制逻辑)，用于清空寄存器内容 (通常将 Valid 置 0)。 |
| IF_ID_Stall          | 1    | 停顿信号 (来自流水线控制逻辑)，用于保持寄存器内容不变。      |

**5.10.2. ID/EX 寄存器组 (ID_EX_Reg)**

| 寄存器名称                | 位宽 | 功能描述                                    |
| :------------------------ | :--- | :------------------------------------------ |
| ID_EX_Instr_O[2]          | 32   | 传递指令 (可选，用于调试/异常)。            |
| ID_EX_PC_O[2]             | 32   | 传递指令的 PC 值。                          |
| ID_EX_RS1Data_O[2]        | 32   | 传递 rs1 操作数数据。                       |
| ID_EX_RS2Data_O[2]        | 32   | 传递 rs2 操作数数据。                       |
| ID_EX_Immediate_O[2]      | 32   | 传递立即数。                                |
| ID_EX_RegWriteAddr_O[2]   | 5    | 传递目的寄存器地址 (rd)。                   |
| ID_EX_ALUOp_O[2]          | ~4-6 | 传递 ALU 操作控制信号。                     |
| ID_EX_MemOp_O[2]          | ~3   | 传递访存操作控制信号。                      |
| ID_EX_RegWriteEnable_O[2] | 1    | 传递写回使能信号。                          |
| ID_EX_BranchCtrl_O[2]     | ~3-4 | 传递分支控制信号。                          |
| ID_EX_CSROP_O             | ~2-3 | 传递 CSR 操作控制信号 (**单发射**)。        |
| ID_EX_CSRAddr_O           | 12   | 传递 CSR 地址 (**单发射**)。                |
| ID_EX_Valid_O[2]          | 1    | 指令有效位 (双发射宽度)。                   |
| ID_EX_ExceptionReq_O      | 1    | 传递 ID 阶段的异常请求信号 (或来自 IF/ID)。 |
| ID_EX_ExceptionID_O       | ~4   | 传递 ID 阶段的异常 ID (或来自 IF/ID)。      |
| *--- 控制信号 ---*        |      |                                             |
| ID_EX_Clk                 | 1    | 时钟信号                                    |
| ID_EX_Reset               | 1    | 复位信号                                    |
| ID_EX_Flush               | 1    | 冲刷信号。                                  |
| ID_EX_Stall               | 1    | 停顿信号。                                  |

**5.10.3. EX/MEM 寄存器组 (EX_MEM_Reg)**

| 寄存器名称             | 位宽 | 功能描述                                            |
| :--------------------- | :--- | :-------------------------------------------------- |
| EX_MEM_PC_O[2]         | 32   | 传递指令的 PC 值 (主要用于异常处理)。               |
| EX_MEM_ALUResult_O[2]  | 32   | 传递 ALU 执行结果。                                 |
| EX_MEM_MemAddr_O[2]    | 32   | 传递访存地址。                                      |
| EX_MEM_MemWData_O[2]   | 32   | 传递 Store 指令的写数据。                           |
| EX_MEM_MemOp_O[2]      | ~3   | 传递访存操作类型。                                  |
| EX_MEM_MemReq_O[2]     | 1    | 传递访存请求信号。                                  |
| EX_MEM_RegWData_O[2]   | 32   | 传递需要写回寄存器的数据 (对于非访存指令)。         |
| EX_MEM_RegWEnable_O[2] | 1    | 传递写回使能信号。                                  |
| EX_MEM_RegWAddr_O[2]   | 5    | 传递写回目标寄存器地址。                            |
| EX_MEM_CSRRdata_O      | 32   | 传递 CSR 读取数据 (**单发射**)。                    |
| EX_MEM_Valid_O[2]      | 1    | 指令有效位 (双发射宽度)。                           |
| EX_MEM_ExceptionReq_O  | 1    | 传递 EX 阶段的异常请求信号 (或来自 ID/EX)。         |
| EX_MEM_ExceptionID_O   | ~4   | 传递 EX 阶段的异常 ID (或来自 ID/EX)。              |
| *--- 控制信号 ---*     |      |                                                     |
| EX_MEM_Clk             | 1    | 时钟信号                                            |
| EX_MEM_Reset           | 1    | 复位信号                                            |
| EX_MEM_Flush           | 1    | 冲刷信号 (通常 EX/MEM 不会被冲刷，除非有特殊设计)。 |
| EX_MEM_Stall           | 1    | 停顿信号。                                          |

**5.10.4. MEM/WB 寄存器组 (MEM_WB_Reg)**

| 寄存器名称             | 位宽 | 功能描述                                                     |
| :--------------------- | :--- | :----------------------------------------------------------- |
| MEM_WB_PC_O[2]         | 32   | 传递指令的 PC 值 (主要用于异常处理)。                        |
| MEM_WB_Rdata_O[2]      | 32   | 传递 Load 指令读取的数据。                                   |
| MEM_WB_RegWData_O[2]   | 32   | 传递最终需要写回寄存器的数据 (可能是 ALU 结果、Load 结果或 CSR 结果)。 |
| MEM_WB_RegWEnable_O[2] | 1    | 传递写回使能信号。                                           |
| MEM_WB_RegWAddr_O[2]   | 5    | 传递写回目标寄存器地址。                                     |
| MEM_WB_Valid_O[2]      | 1    | 指令有效位 (双发射宽度)。                                    |
| MEM_WB_ExceptionReq_O  | 1    | 传递 MEM 阶段的异常请求信号 (或来自 EX/MEM)。                |
| MEM_WB_ExceptionID_O   | ~4   | 传递 MEM 阶段的异常 ID (或来自 EX/MEM)。                     |
| *--- 控制信号 ---*     |      |                                                              |
| MEM_WB_Clk             | 1    | 时钟信号                                                     |
| MEM_WB_Reset           | 1    | 复位信号                                                     |
| MEM_WB_Flush           | 1    | 冲刷信号 (通常 MEM/WB 不会被冲刷)。                          |
| MEM_WB_Stall           | 1    | 停顿信号 (通常 MEM/WB 不会停顿下游)。                        |

### **5.11. 异常处理单元 (EHU - Exception Handling Unit)**

（待补充）

## **6. 模块内部功能描述**

### **6.1. 指令取指模块 (IF)**

*   **指令地址生成 (Instruction Address Generation):**  根据当前 PC 值和分支预测结果, 生成下一条指令的地址。
*   **指令缓存 (Instruction Cache) (可选):**  基本功能要求中可简化为直接访问指令存储器, 后续可添加 I-Cache。
*   **指令存储器接口 (Instruction Memory Interface):**  与指令存储器交互, 发送地址请求, 接收指令数据。支持不定周期访存, 需要处理 `req` 和 `ready` 信号。
*   **分支预测接口 (Branch Prediction Interface):**  与分支预测器交互, 获取分支预测结果。
*   **指令获取 (Instruction Fetching):**  从指令存储器获取指令, 并缓存到 IF 阶段寄存器。
*   **PC 更新 (PC Update):**  根据指令类型 (顺序执行、分支跳转、异常入口) 更新 PC 值。
*   **异常检测 (Exception Detection):**  检测取指阶段的异常, 例如指令地址未对齐 (Instruction Address Misaligned)。
*   **停顿和冲刷处理 (Stall and Flush Handling):**  响应流水线控制逻辑的停顿和冲刷信号。

### **6.2. 指令译码模块 (ID)**

*   **指令解码 (Instruction Decode):**  解析指令的 opcode、funct3、funct7 等字段, 识别指令类型。
*   **寄存器读取 (Register Read):**  根据指令的 rs1 和 rs2 字段, 从寄存器堆读取操作数。
*   **立即数提取 (Immediate Extraction):**  提取指令中的立即数字段。
*   **控制信号生成 (Control Signal Generation):**  根据指令类型, 生成执行阶段需要的控制信号 (例如, ALU 操作类型、访存操作类型、写回使能等)。
*   **数据冒险检测 (Data Hazard Detection):**  检测数据冒险 (RAW, WAR, WAW), 并将冒险信息传递给流水线控制逻辑。
*   **结构冒险检测 (Structural Hazard Detection) (可选):**  检测结构冒险 (例如, 资源冲突), 并将冒险信息传递给流水线控制逻辑。
*   **异常检测 (Exception Detection):**  检测译码阶段的异常, 例如非法指令 (Illegal Instruction)。
*   **停顿和冲刷处理 (Stall and Flush Handling):**  响应流水线控制逻辑的停顿和冲刷信号。

### **6.3. 执行模块 (EX)**

*   **ALU 执行单元 (ALU Execution Unit):**  实现算术逻辑运算、比较运算等。至少包含两个 ALU 单元, 支持并行执行。
*   **分支处理单元 (Branch Processing Unit):**  计算分支指令的条件判断结果, 计算分支目标地址。
*   **访存地址计算 (Memory Address Calculation):**  计算 load 和 store 指令的有效地址。
*   **执行结果生成 (Execution Result Generation):**  生成 ALU 运算结果、访存地址、访存数据、寄存器写回数据等。
*   **数据转发逻辑 (Data Forwarding Logic) (可选):**  实现数据转发路径, 将 EX 阶段的结果旁路转发到后续指令的 EX 阶段。
*   **CSR 操作 (CSR Operation):**  执行 CSR 指令, 与 CSR 单元交互进行 CSR 寄存器的读写。
*   **异常检测 (Exception Detection):**  检测执行阶段的异常, 例如除零错误 (Division by Zero)。
*   **停顿和冲刷处理 (Stall and Flush Handling):**  响应流水线控制逻辑的停顿和冲刷信号。

### **6.4. 访存模块 (MEM)**

*   **地址访问 (Address Access):**  根据 EX 阶段提供的地址, 访问数据存储器。
*   **数据读写 (Data Read/Write):**  执行 load 指令的读操作, store 指令的写操作。
*   **数据缓存 (Data Cache) (可选):**  基本功能要求中可简化为直接访问数据存储器, 后续可添加 D-Cache。
*   **数据存储器接口 (Data Memory Interface):**  与数据存储器交互, 发送地址、数据和控制信号, 接收读数据和就绪信号。支持不定周期访存, 需要处理 `req` 和 `ready` 信号。
*   **数据返回 (Data Return):**  将从数据存储器读取的数据传递到 WB 阶段。
*   **数据转发逻辑 (Data Forwarding Logic) (可选):**  实现数据转发路径, 将 MEM 阶段的 load 数据旁路转发到后续指令的 EX 阶段。
*   **异常检测 (Exception Detection):**  检测访存阶段的异常, 例如访存地址未对齐 (Memory Address Misaligned)、页错误 (Page Fault)。
*   **停顿和冲刷处理 (Stall and Flush Handling):**  响应流水线控制逻辑的停顿和冲刷信号。

### **6.5. 写回模块 (WB)**

*   **结果选择 (Result Selection):**  选择需要写回寄存器的结果 (来自 EX 或 MEM 阶段)。
*   **寄存器写入 (Register Write Back):**  将结果写回寄存器堆的指定寄存器地址。
*   **异常检测 (Exception Detection):**  检测写回阶段的异常 (例如，写回冲突，虽然在基本流水线中通常不会出现)。
*   **停顿和冲刷处理 (Stall and Flush Handling):**  响应流水线控制逻辑的停顿和冲刷信号 (通常 WB 阶段不需要停顿)。

## **7. 指令集架构支持 (ISA Support)**

### **7.1. RV32I 指令集 (RV32I Spec)**

*   该处理器需要完整支持 RV32I 基本整数指令集

### **7.2. CSR 指令和寄存器 (CSR Spec)**

*   支持 `csrrw` 指令用于 CSR 寄存器的读写。
*   实现 `mtime` (Machine Time) 和 `mcycle` (Machine Cycle) 两个 CSR 寄存器。

## **8. 分支预测机制 (Branch Predictor)**

### **8.1. Bi-mode 分支预测器 (Bi-mode Branch Predictor)**

*   采用 Bi-mode 分支预测器, 以提高分支预测的准确率。
*   预测器需要考虑分支指令的历史信息和当前行为, 进行动态预测。
*   （待补充）

## **9. 存储器子系统 (Memory Subsystem)**

### **9.1. 基本存储器模型**

*   基本功能要求下, 假设指令存储器和数据存储器均为单周期访问 (可通过设置外部存储器模块实现单周期响应)。
*   存储器接口需要支持指令读取和数据读写操作，并包含请求和就绪信号以支持不定周期访存。
*   （待补充）

## **10. 性能目标 (Performance Goals)**

### **10.1. Drystone 测试 (Drystone)**

*   处理器需要能够成功运行 Drystone 基准测试程序。
*   Drystone 测试结果可以作为衡量处理器基本功能和性能的指标。

## **11. 缩略语:**

*   ISA: 指令集架构 (Instruction Set Architecture)
*   RV32I: RISC-V 32 位整数指令集基础规范
*   CSR: 控制状态寄存器 (Control and Status Register)
*   ALU: 算术逻辑单元 (Arithmetic Logic Unit)
*   PC: 程序计数器 (Program Counter)
*   IF: 取指 (Instruction Fetch)
*   ID: 译码 (Instruction Decode)
*   EX: 执行 (Execute)
*   MEM: 访存 (Memory Access)
*   WB: 写回 (Write Back)
*   EHU: 异常处理单元 (Exception Handling Unit)

