// The Basic CPU Design

`timescale 1ns / 1ps

module SPIC (
        input clk,
        input rst,
        output [31:0] pc_out
    );

    reg [31:0] pc;
    wire [31:0] instr;
    wire [6:0] opcode = instr[6:0];
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];
    wire [4:0] rs1 = instr[19:15];
    wire [4:0] rs2 = instr[24:20];
    wire [4:0] rd = instr[11:7];

    wire reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch, csr_write,jump,error;
    wire [3:0] alu_op;
    wire [31:0] alu_result, reg_rs1, reg_rs2, imm, mem_data, csr_data;
    wire [2:0] imm_type,mem_size;




    instruction_memory IMEM(
                           .addr(pc),
                           .instr(instr)
                       );

    control_unit CU(
                     .opcode(opcode),
                     .funct3(funct3),
                     .funct7(funct7),
                     .reg_write(reg_write),
                     .alu_src(alu_src),
                     .mem_read(mem_read),
                     .mem_write(mem_write),
                     .mem_to_reg(mem_to_reg),
                     .branch(branch),
                     .jump(jump),
                     .csr_write(csr_write),
                     .alu_op(alu_op),
                     .imm_type(imm_type),
                     .mem_size(mem_size)
                 );

    immediate_gen IG(
                      .instr(instr),
                      .imm_type(imm_type),
                      .imm(imm)
                  );

    register_file RF(
                      .clk(clk),
                      .we(reg_write),
                      .rs1(rs1),
                      .rs2(rs2),
                      .rd(rd),
                      .wd(mem_to_reg ? mem_data :
                          (opcode == 7'b1101111 || opcode == 7'b1100111) ? pc + 4 :
                          (opcode == 7'b1110011 && funct3 != 3'b000) ? csr_data : alu_result),
                      .rd1(reg_rs1),
                      .rd2(reg_rs2)
                  );

    alu ALU(
            .a(reg_rs1),
            .b(alu_src ? imm : reg_rs2),
            .alu_op(alu_op),
            .pc(pc),
            .result(alu_result)
        );

    memory MEM(
               .clk(clk),
               .addr(alu_result),
               .we(mem_write),
               .re(mem_read),
               .wd(reg_rs2),
               .rd(mem_data),
               .mem_size(mem_size),
               .error(error)
           );

    csr_registers CSR(
                      .clk(clk),
                      .rst(rst),
                      .we(csr_write),
                      .addr(instr[31:20]),
                      .wd(reg_rs1),
                      .funct3(funct3),
                      .rd(csr_data)
                  );

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc <= 0;
        // 在PC更新逻辑中添加其他分支指�?
        else if (branch) begin
            case (funct3)
                3'b000:
                    pc <= (alu_result == 1) ? pc + imm : pc + 4; // BEQ
                3'b001:
                    pc <= (alu_result == 1) ? pc + imm : pc + 4; // BNE
                3'b100:
                    pc <= (alu_result == 1) ? pc + imm : pc + 4; // BLT
                3'b101:
                    pc <= (alu_result == 1) ? pc + imm : pc + 4; // BGE
                3'b110:
                    pc <= (alu_result == 1) ? pc + imm : pc + 4; // BLTU
                3'b111:
                    pc <= (alu_result == 1) ? pc + imm : pc + 4; // BGEU
                default:
                    pc <= pc + 4;
            endcase
        end
        else if (opcode == 7'b1101111)
            pc <= pc + imm; // JAL
        else if (opcode == 7'b1100111)
            pc <= reg_rs1 + imm; // JALR
        else if (opcode == 7'b1110011 && funct3 == 3'b000) begin // ECALL / EBREAK
            if (instr[31:20] == 12'h000)
                pc <= csr_data; // ECALL
            else if (instr[31:20] == 12'h001)
                pc <= csr_data; // EBREAK
        end
        else
            pc <= pc + 4;
    end

    assign pc_out = pc;
endmodule

module immediate_gen(
        input [31:0] instr,
        input [2:0] imm_type,  // 000:I, 001:S, 010:B, 011:U, 100:J
        output reg [31:0] imm
    );
    always @(*) begin
        case(imm_type)
            3'b000:
                imm = {{20{instr[31]}}, instr[31:20]}; // I-type
            3'b001:
                imm = {{20{instr[31]}}, instr[31:25], instr[11:7]}; // S-type
            3'b010:
                imm = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; // B-type
            3'b011:
                imm = {instr[31:12], 12'b0}; // U-type
            3'b100:
                imm = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:21], 1'b0}; // J-type
            default:
                imm = 32'b0;
        endcase
    end
endmodule


// 修改指令内存大小或调整寻�?方式
module instruction_memory(
        input [31:0] addr,
        output [31:0] instr
    );
    reg [31:0] memory [0:1023];
    integer index;
    integer file;
    integer r;
    reg [31:0] temp_data;

    initial begin
        file = $fopen("instructions.mem", "r");
        if (file) begin
            index = 0;
            while (!$feof(file)) begin
                r = $fscanf(file, "%x", temp_data);
                memory[index] = temp_data;
                index = index + 1;
            end
            $fclose(file);
            $display("Instruction memory loaded successfully.");
        end
        else begin
            $display("Error: Unable to open instrument.mem");
        end
    end

    assign instr = memory[addr[11:2]];
endmodule

module control_unit(
        input  [6:0] opcode,
        input  [2:0] funct3,
        input  [6:0] funct7,
        output reg reg_write,      // write register or not
        output reg alu_src,        // have immediate operand or not
        output reg mem_read,       // read from memory or not
        output reg mem_write,      // write to memory or not
        output reg mem_to_reg,     // write to register or not
        output reg branch,         // branch or not
        output reg jump,           // jump or not
        output reg csr_write,      // CSR or not
        output reg [3:0] alu_op,    // ALU operands
        output reg [2:0] imm_type,    // add imm_type as output
        output reg [2:0] mem_size
    );

    always @(*) begin
        reg_write  = 0;
        alu_src    = 0;
        mem_read   = 0;
        mem_write  = 0;
        mem_to_reg = 0;
        branch     = 0;
        jump       = 0;
        csr_write  = 0;
        alu_op     = 4'b0000;
        imm_type   = 3'b000;
        mem_size   = 3'b010; //default lw

        case (opcode)
            // R type (add, sub, and, or, xor, sll, srl, sra, slt, sltu)
            7'b0110011: begin
                reg_write = 1;
                case (funct3)
                    3'b000:
                        alu_op = (funct7 == 7'b0100000) ? 4'b0110 : 4'b0010; // sub / add
                    3'b111:
                        alu_op = 4'b0000; // and
                    3'b110:
                        alu_op = 4'b0001; // or
                    3'b100:
                        alu_op = 4'b0011; // xor
                    3'b001:
                        alu_op = 4'b0100; // sll
                    3'b101:
                        alu_op = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0101; // sra / srl
                    3'b010:
                        alu_op = 4'b1010; // slt
                    3'b011:
                        alu_op = 4'b1100; // sltu
                endcase
            end

            // I type (addi, andi, ori, xori, slli, srli, srai, slti, sltiu)
            7'b0010011: begin
                reg_write = 1;
                alu_src = 1;
                imm_type = 3'b000;
                case (funct3)
                    3'b000:
                        alu_op = 4'b0010; // addi
                    3'b111:
                        alu_op = 4'b0000; // andi
                    3'b110:
                        alu_op = 4'b0001; // ori
                    3'b100:
                        alu_op = 4'b0011; // xori
                    3'b001:
                        alu_op = 4'b0100; // slli
                    3'b101:
                        alu_op = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0101; // srai / srli
                    3'b010:
                        alu_op = 4'b1010; // slti
                    3'b011:
                        alu_op = 4'b1100; // sltiu
                endcase
            end

            // Load (LB,LH,LW,LBU,LHU)
            7'b0000011: begin
                reg_write = 1;
                alu_src = 1;
                mem_read = 1;
                mem_to_reg = 1;
                alu_op = 4'b0010; // calculate address
                imm_type = 3'b000;
                case(funct3)
                    3'b000:
                        mem_size = 3'b000; // LB
                    3'b001:
                        mem_size = 3'b001; // LH
                    3'b010:
                        mem_size = 3'b010; // LW
                    3'b100:
                        mem_size = 3'b100; // LBU
                    3'b101:
                        mem_size = 3'b101; // LHU
                endcase
            end

            // Store (SB,SH,SW)
            7'b0100011: begin
                mem_write = 1;
                alu_src = 1;
                alu_op = 4'b0010; // calculate address
                imm_type = 3'b001;
                case(funct3)
                    3'b000:
                        mem_size = 3'b000; // SB
                    3'b001:
                        mem_size = 3'b001; // SH
                    3'b010:
                        mem_size = 3'b010; // SW

                endcase
            end

            // Branch (BEQ, BNE, BLT, BGE, BLTU, BGEU)
            7'b1100011: begin
                branch = 1;
                imm_type = 3'b010;
                case (funct3)
                    3'b000:
                        alu_op = 4'b1000; // BEQ
                    3'b001:
                        alu_op = 4'b1001; // BNE
                    3'b100:
                        alu_op = 4'b1010; // BLT
                    3'b101:
                        alu_op = 4'b1011; // BGE
                    3'b110:
                        alu_op = 4'b1100; // BLTU
                    3'b111:
                        alu_op = 4'b1101; // BGEU
                endcase
            end

            // JAL
            7'b1101111: begin
                reg_write = 1;
                jump = 1;
                imm_type = 3'b100;
            end

            // JALR
            7'b1100111: begin
                reg_write = 1;
                jump = 1;
                alu_src=1;
                imm_type = 3'b000;
            end

            //LUI
            7'b0110111: begin
                reg_write = 1;
                alu_src = 1;
                imm_type = 3'b011;
                alu_op = 4'b1110;
            end
            //AUIPC
            7'b0010111: begin
                reg_write = 1;
                alu_src = 1;
                imm_type = 3'b011;
                alu_op = 4'b1111;
            end

            // CSR (ECALL, EBREAK, CSRRW, CSRRS, CSRRC, etc.)
            7'b1110011: begin
                case (funct3)
                    3'b000: begin
                        csr_write = 1;
                        // ECALL, EBREAK
                    end
                    3'b001: begin  // CSRRW
                        reg_write = 1;
                        csr_write = 1;
                    end
                    3'b010: begin  // CSRRS
                        reg_write = 1;
                        csr_write = 1;
                    end
                    3'b011: begin  // CSRRC
                        reg_write = 1;
                        csr_write = 1;
                    end
                    3'b101: begin  // CSRRWI
                        reg_write = 1;
                        csr_write = 1;
                        alu_src = 1;
                        imm_type = 3'b000;
                    end
                    3'b110: begin  // CSRRSI
                        reg_write = 1;
                        csr_write = 1;
                        alu_src = 1;
                        imm_type = 3'b000;
                    end
                    3'b111: begin  // CSRRCI
                        reg_write = 1;
                        csr_write = 1;
                        alu_src = 1;
                        imm_type = 3'b000;
                    end
                endcase
            end
        endcase
    end
endmodule


module register_file(
        input clk,
        input we,
        input [4:0] rs1, rs2, rd,
        input [31:0] wd,
        output [31:0] rd1, rd2
    );
    reg [31:0] registers [0:31];
    assign rd1 = registers[rs1];
    assign rd2 = registers[rs2];
    always @(posedge clk) if (we)
            registers[rd] <= wd;
endmodule
module alu(
        input [31:0] a, b,
        input [3:0] alu_op,
        input [31:0] pc,
        output reg [31:0] result
    );
    always @(*) begin
        case (alu_op)
            4'b0010:
                result = a + b; // ADD
            4'b0110:
                result = a - b; // SUB
            4'b0000:
                result = a & b; // AND
            4'b0001:
                result = a | b; // OR
            4'b0011:
                result = a ^ b; // XOR
            4'b0101:
                result = a >> b[4:0]; // SRL
            4'b0111:
                result = a >>> b[4:0]; // SRA
            4'b0100:
                result = a << b[4:0]; // SLL
            4'b1000:
                result = (a == b) ? 32'd1 : 32'd0; // BEQ
            4'b1001:
                result = (a != b) ? 32'd1 : 32'd0; // BNE
            4'b1010:
                result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0; // SLT, BLT
            4'b1100:
                result = (a < b) ? 32'd1 : 32'd0; // SLTU, BLTU
            4'b1011:
                result = ($signed(a) >= $signed(b)) ? 32'd1 : 32'd0; // BGE
            4'b1101:
                result = (a >= b) ? 32'd1 : 32'd0; // BGEU
            4'b1110:
                result = b; // LUI
            4'b1111:
                result = pc+b; //auipc
            default:
                result = 32'b0;
        endcase
    end
endmodule


`define MEM_SIZE        32'h0000_FFFF
`define TEXT_START      32'h0000_0000
`define TEXT_END        32'h0000_3FFF
`define DATA_START      32'h0000_4000
`define DATA_END        32'h0000_7FFF
`define HEAP_START      32'h0000_8000
`define HEAP_END        32'h0000_BFFF
`define STACK_START     32'h0000_C000
`define STACK_END       32'h0000_FFFF

module memory(
        input clk,
        input [31:0] addr,
        input we, re,
        input [31:0] wd,
        input [2:0] mem_size, //000(byte) 001(halfword) 010(word) 100(unsigned byte) 101(unsigned halfword)
        output reg [31:0] rd,
        output reg error
    );

    reg [31:0] mem [0:`MEM_SIZE];

    integer file, r, index;
    reg [31:0] temp_data;
    reg [31:0] word_data;
    reg [15:0] half_data;
    reg [7:0] byte_data;

    initial begin
        // Load data.mem
        file = $fopen("data.mem", "r");
        if (file) begin
            index = `DATA_START >> 2;
            while (!$feof(file)) begin
                r = $fscanf(file, "%x", temp_data);
                mem[index] = temp_data;
                index = index + 1;
            end
            $fclose(file);
            $display("Data memory loaded successfully.");
        end
        else begin
            $display("Error: Unable to open data.mem");
        end
    end

    always @(posedge clk) begin
        error <= 0;
        if (we) begin
            case (1'b1)
                (addr >= `DATA_START && addr <= `DATA_END),
                (addr >= `HEAP_START && addr <= `HEAP_END),
                (addr >= `STACK_START && addr <= `STACK_END): begin
                    case (mem_size)
                        3'b000: begin  // SB (存储字节)
                            case (addr[1:0])
                                2'b00:
                                    mem[addr >> 2][7:0] <= wd[7:0];
                                2'b01:
                                    mem[addr >> 2][15:8] <= wd[7:0];
                                2'b10:
                                    mem[addr >> 2][23:16] <= wd[7:0];
                                2'b11:
                                    mem[addr >> 2][31:24] <= wd[7:0];
                            endcase
                        end
                        3'b001: begin  // SH (存储半字)
                            if (addr[0] != 0) begin
                                error <= 1;  // 半字地址必须对齐到2字节边界
                            end
                            else begin
                                case (addr[1])
                                    1'b0:
                                        mem[addr >> 2][15:0] <= wd[15:0];
                                    1'b1:
                                        mem[addr >> 2][31:16] <= wd[15:0];
                                endcase
                            end
                        end
                        3'b010: begin  // SW (存储字)
                            if (addr[1:0] != 2'b00) begin
                                error <= 1;  // 字地址必须对齐到4字节边界
                            end
                            else begin
                                mem[addr >> 2] <= wd;
                            end
                        end
                        default:
                            error <= 1;
                    endcase
                end
                (addr >= `TEXT_START && addr <= `TEXT_END): error <= 1;
                default:
                    error <= 1;
            endcase
        end
    end

    always @(*) begin
        if (re) begin
            word_data = mem[addr >> 2];
            case (mem_size)
                3'b000: begin  // LB (加载有符号字节)
                    case (addr[1:0])
                        2'b00:
                            byte_data = word_data[7:0];
                        2'b01:
                            byte_data = word_data[15:8];
                        2'b10:
                            byte_data = word_data[23:16];
                        2'b11:
                            byte_data = word_data[31:24];
                    endcase
                    rd = {{24{byte_data[7]}}, byte_data};  // 符号扩展
                    error = 0;
                end
                3'b001: begin  // LH (加载有符号半字)
                    if (addr[0] != 0) begin
                        rd = 32'h0;
                        error = 1;  // 半字地址必须对齐到2字节边界
                    end
                    else begin
                        case (addr[1])
                            1'b0:
                                half_data = word_data[15:0];
                            1'b1:
                                half_data = word_data[31:16];
                        endcase
                        rd = {{16{half_data[15]}}, half_data};  // 符号扩展
                        error = 0;
                    end
                end
                3'b010: begin  // LW (加载字)
                    if (addr[1:0] != 2'b00) begin
                        rd = 32'h0;
                        error = 1;  // 字地址必须对齐到4字节边界
                    end
                    else if (addr <= `MEM_SIZE) begin
                        rd = word_data;
                        error = 0;
                    end
                    else begin
                        rd = 32'h0;
                        error = 1;
                    end
                end
                3'b100: begin  // LBU (加载无符号字节)
                    case (addr[1:0])
                        2'b00:
                            byte_data = word_data[7:0];
                        2'b01:
                            byte_data = word_data[15:8];
                        2'b10:
                            byte_data = word_data[23:16];
                        2'b11:
                            byte_data = word_data[31:24];
                    endcase
                    rd = {24'b0, byte_data};  // 零扩展
                    error = 0;
                end
                3'b101: begin  // LHU (加载无符号半字)
                    if (addr[0] != 0) begin
                        rd = 32'h0;
                        error = 1;  // 半字地址必须对齐到2字节边界
                    end
                    else begin
                        case (addr[1])
                            1'b0:
                                half_data = word_data[15:0];
                            1'b1:
                                half_data = word_data[31:16];
                        endcase
                        rd = {16'b0, half_data};  // 零扩展
                        error = 0;
                    end
                end
                default: begin
                    rd = 32'h0;
                    error = 1;
                end
            endcase
        end
        else begin
            rd = 32'h0;
            error = 0;
        end
    end

endmodule

// Properly structured CSR module
module csr_registers(
        input clk,
        input rst,          // Reset signal
        input we,           // Write enable
        input [11:0] addr,  // CSR address
        input [31:0] wd,    // Write data
        input [2:0] funct3, // Function code for operation type
        output reg [31:0] rd // Read data
    );

    // CSR registers storage
    reg [31:0] csr_mem [0:4095];

    // CSR address constants
    localparam CSR_MTVEC    = 12'h305; // Exception handler address
    localparam CSR_MSTATUS  = 12'h300; // Machine status
    localparam CSR_MIE      = 12'h304; // Machine interrupt enable
    localparam CSR_MSCRATCH = 12'h340; // Scratch register
    localparam CSR_MEPC     = 12'h341; // Exception PC save
    localparam CSR_MCAUSE   = 12'h342; // Exception cause
    localparam CSR_MTVAL    = 12'h343; // Exception value
    localparam CSR_MIP      = 12'h344; // Machine interrupt pending

    // Initialize CSR registers
    initial begin
        csr_mem[CSR_MTVEC]    = 32'h0;
        csr_mem[CSR_MSTATUS]  = 32'h0;
        csr_mem[CSR_MIE]      = 32'h0;
        csr_mem[CSR_MSCRATCH] = 32'h0;
        csr_mem[CSR_MEPC]     = 32'h0;
        csr_mem[CSR_MCAUSE]   = 32'h0;
        csr_mem[CSR_MTVAL]    = 32'h0;
        csr_mem[CSR_MIP]      = 32'h0;
    end

    // CSR write logic (synchronous)
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset critical CSR registers
            csr_mem[CSR_MTVEC]    <= 32'h0;
            csr_mem[CSR_MSTATUS]  <= 32'h0;
            csr_mem[CSR_MIE]      <= 32'h0;
            csr_mem[CSR_MSCRATCH] <= 32'h0;
            csr_mem[CSR_MEPC]     <= 32'h0;
            csr_mem[CSR_MCAUSE]   <= 32'h0;
            csr_mem[CSR_MTVAL]    <= 32'h0;
            csr_mem[CSR_MIP]      <= 32'h0;
        end
        else if (we) begin
            case (funct3)
                3'b001: begin // CSRRW - Atomic swap
                    csr_mem[addr] <= wd;
                end
                3'b010: begin // CSRRS - Read and set bits
                    csr_mem[addr] <= csr_mem[addr] | wd;
                end
                3'b011: begin // CSRRC - Read and clear bits
                    csr_mem[addr] <= csr_mem[addr] & ~wd;
                end
                3'b101: begin // CSRRWI - Immediate swap
                    csr_mem[addr] <= {27'b0, wd[4:0]};
                end
                3'b110: begin // CSRRSI - Immediate set bits
                    csr_mem[addr] <= csr_mem[addr] | {27'b0, wd[4:0]};
                end
                3'b111: begin // CSRRCI - Immediate clear bits
                    csr_mem[addr] <= csr_mem[addr] & ~{27'b0, wd[4:0]};
                end
                default: begin
                    // No change to CSR register
                end
            endcase
        end
    end

    // CSR read logic (combinational)
    always @(*) begin
        rd = csr_mem[addr];
    end
endmodule
