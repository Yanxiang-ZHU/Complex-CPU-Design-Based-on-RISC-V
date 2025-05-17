// Control Unit for RISC-V Processor. This module generates control signals based on the opcode and funct3/funct7 fields of the instruction. It determines whether to write to registers, read from memory, perform ALU operations, etc.

module control_unit(
        input  [31:0] instr,       // instruction input
        output reg reg_write,       // write register or not
        output reg alu_src,         // have immediate operand or not
        output reg mem_read,        // read from memory or not
        output reg mem_write,       // write to memory or not
        output reg mem_to_reg,      // write to register or not
        output reg branch,          // branch or not
        output reg jump,            // jump or not
        output reg csr_write,       // CSR or not
        output reg [3:0] alu_op,    // ALU operands
        output reg [2:0] imm_type,  // add imm_type as output
        output reg [2:0] mem_size,
        output reg [4:0] rs1,
        output reg [4:0] rs2,
        output reg [4:0] rd,
        output reg [6:0] opcode
    );
   // ID stage signals (RISC-V instruction format)
    always @(*) begin
        opcode <= instr[6:0];
    end
    wire [2:0] funct3 = instr[14:12];
    wire [6:0] funct7 = instr[31:25];
 

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
                rs1 = instr[19:15];
                rs2 = instr[24:20];
                rd = instr[11:7];
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
                rs1 = instr[19:15];
                rs2 = 5'bz;
                rd = instr[11:7];
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
                rs1 = instr[19:15];
                rs2 = 5'bz;
                rd = instr[11:7];
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
                rs1 = instr[19:15];
                rs2 = instr[24:20];
                rd = 5'bz;
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
                rs1 = instr[19:15];
                rs2 = instr[24:20];
                rd = 5'bz;
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
                alu_op = 4'b0001;
                rs1 = 5'bz;
                rs2 = 5'bz;
                rd = instr[11:7];
            end

            // JALR
            7'b1100111: begin
                reg_write = 1;
                jump = 1;
                alu_src=1;
                imm_type = 3'b000;
                alu_op = 4'b0001;
                rs1 = 5'bz;
                rs2 = 5'bz;
                rd = instr[11:7];
            end

            //LUI
            7'b0110111: begin
                reg_write = 1;
                alu_src = 1;
                imm_type = 3'b011;
                alu_op = 4'b1110;
                rs1 = 5'bz;
                rs2 = 5'bz;
                rd = instr[11:7];
            end

            //AUIPC
            7'b0010111: begin
                reg_write = 1;
                alu_src = 1;
                imm_type = 3'b011;
                alu_op = 4'b1111;
                rs1 = 5'bz;
                rs2 = 5'bz;
                rd = instr[11:7];
            end

            // // CSR (ECALL, EBREAK, CSRRW, CSRRS, CSRRC, etc.)
            // 7'b1110011: begin
            //     case (funct3)
            //         3'b000: begin
            //             if (funct7 == 7'b0000000) begin
            //                 // ECALL
            //             end else if (funct7 == 7'b0000001) begin
            //                 // EBREAK
            //             end
            //         end
            //         3'b001: begin  // CSRRW
            //             reg_write = 1;
            //             csr_write = 1;
            //         end
            //         3'b010: begin  // CSRRS
            //             reg_write = 1;
            //             csr_write = 1;
            //         end
            //         3'b011: begin  // CSRRC
            //             reg_write = 1;
            //             csr_write = 1;
            //         end
            //         3'b101: begin  // CSRRWI
            //             reg_write = 1;
            //             csr_write = 1;
            //             alu_src = 1;
            //             imm_type = 3'b000;
            //         end
            //         3'b110: begin  // CSRRSI
            //             reg_write = 1;
            //             csr_write = 1;
            //             alu_src = 1;
            //             imm_type = 3'b000;
            //         end
            //         3'b111: begin  // CSRRCI
            //             reg_write = 1;
            //             csr_write = 1;
            //             alu_src = 1;
            //             imm_type = 3'b000;
            //         end
            //     endcase
            // end
        endcase
    end
endmodule