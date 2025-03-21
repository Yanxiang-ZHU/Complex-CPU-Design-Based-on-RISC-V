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
    
    wire reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch, csr_write;
    wire [3:0] alu_op;
    wire [31:0] alu_result, reg_rs1, reg_rs2, imm, mem_data, csr_data;
    
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
        .alu_op(alu_op)
    );

    
    register_file RF(
        .clk(clk), 
        .we(reg_write), 
        .rs1(rs1), 
        .rs2(rs2), 
        .rd(rd),
        .wd(mem_to_reg ? mem_data : alu_result),
        .rd1(reg_rs1), 
        .rd2(reg_rs2)
    );
    
    alu ALU(
        .a(reg_rs1), 
        .b(alu_src ? imm : reg_rs2), .alu_op(alu_op),
        .result(alu_result)
    );
    
    memory MEM(
        .clk(clk), 
        .addr(alu_result), 
        .we(mem_write), 
        .re(mem_read), 
        .wd(reg_rs2),
        .rd(mem_data)
    );
    
    csr_registers CSR(
        .clk(clk), 
        .we(csr_write), 
        .addr(instr[31:20]), 
        .wd(reg_rs1),
        .rd(csr_data)
    );
    
    always @(posedge clk or posedge rst) begin
        if (rst) pc <= 0;
        else if (branch & (alu_result == 0)) pc <= pc + imm;
        else if (opcode == 7'b1101111) pc <= pc + imm; // JAL
        else if (opcode == 7'b1100111) pc <= reg_rs1 + imm; // JALR
        else if (opcode == 7'b1110011 && funct3 == 3'b000) begin // ECALL / EBREAK
            if (instr[31:20] == 12'h000) pc <= csr_data; // ECALL
            else if (instr[31:20] == 12'h001) pc <= csr_data; // EBREAK
        end
        else pc <= pc + 4;
    end
    
    assign pc_out = pc;
endmodule

module instruction_memory(
    input [31:0] addr,
    output [31:0] instr
);
    reg [31:0] memory [0:255];             // instructions are stored in ROM !!
    assign instr = memory[addr[9:2]];
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
    output reg [3:0] alu_op    // ALU operands
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

        case (opcode)
            // R type (add, sub, and, or, xor, sll, srl, sra)
            7'b0110011: begin
                reg_write = 1;
                case (funct3)
                    3'b000: alu_op = (funct7 == 7'b0100000) ? 4'b0110 : 4'b0010; // sub / add
                    3'b111: alu_op = 4'b0000; // and
                    3'b110: alu_op = 4'b0001; // or
                    3'b100: alu_op = 4'b0011; // xor
                    3'b001: alu_op = 4'b0100; // sll
                    3'b101: alu_op = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0101; // sra / srl
                endcase
            end

            // I type (addi, andi, ori, xori, slli, srli, srai)
            7'b0010011: begin
                reg_write = 1;
                alu_src = 1;
                case (funct3)
                    3'b000: alu_op = 4'b0010; // addi
                    3'b111: alu_op = 4'b0000; // andi
                    3'b110: alu_op = 4'b0001; // ori
                    3'b100: alu_op = 4'b0011; // xori
                    3'b001: alu_op = 4'b0100; // slli
                    3'b101: alu_op = (funct7 == 7'b0100000) ? 4'b0111 : 4'b0101; // srai / srli
                endcase
            end

            // Load (LW)
            7'b0000011: begin
                reg_write = 1;
                alu_src = 1;
                mem_read = 1;
                mem_to_reg = 1;
                alu_op = 4'b0010; // calculate address
            end

            // Store (SW)
            7'b0100011: begin
                mem_write = 1;
                alu_src = 1;
                alu_op = 4'b0010; // calculate address
            end

            // Branch (BEQ, BNE)
            7'b1100011: begin
                branch = 1;
                case (funct3)
                    3'b000: alu_op = 4'b1000; // BEQ
                    3'b001: alu_op = 4'b1001; // BNE
                endcase
            end

            // JAL
            7'b1101111: begin
                reg_write = 1;
                jump = 1;
            end

            // JALR
            7'b1100111: begin
                reg_write = 1;
                jump = 1;
            end

            // CSR (ECALL, EBREAK)
            7'b1110011: begin
                csr_write = 1;
                case (funct3)
                    3'b000: begin
                        if (funct7 == 7'b0000000) begin
                            // ECALL
                            alu_op = 4'b1110;
                        end else if (funct7 == 7'b0000001) begin
                            // EBREAK
                            alu_op = 4'b1111;
                        end
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
    always @(posedge clk) if (we) registers[rd] <= wd;
endmodule

// ALU
module alu(
    input [31:0] a, b,
    input [3:0] alu_op,
    output reg [31:0] result
);
    always @(*) begin
        case (alu_op)
            4'b0010: result = a + b; // ADD
            4'b0110: result = a - b; // SUB
            4'b0000: result = a & b; // AND
            4'b0001: result = a | b; // OR
            4'b0011: result = a ^ b; // XOR
            default: result = 0;
        endcase
    end
endmodule

module memory(
    input clk,
    input [31:0] addr,
    input we, re,
    input [31:0] wd,
    output reg [31:0] rd
);
    reg [31:0] mem [0:255];
    always @(posedge clk) if (we) mem[addr[9:2]] <= wd;
    always @(*) begin
        if (re)
            rd = mem[addr[9:2]];
        else
            rd = 0;
    end
endmodule

module csr_registers(
    input clk,
    input we,
    input [11:0] addr,
    input [31:0] wd,
    output reg [31:0] rd
);
    reg [31:0] csr_mem [0:4095];
    always @(posedge clk) if (we) csr_mem[addr] <= wd;
    always @(*) begin
        rd = csr_mem[addr];
    end
endmodule
