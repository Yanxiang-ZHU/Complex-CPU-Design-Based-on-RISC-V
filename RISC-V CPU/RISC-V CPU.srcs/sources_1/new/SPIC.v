module SPIC_Pipeline (
        input clk,
        input rst,
        output [31:0] pc_out
    );
    // Pipeline registers
    reg [31:0] pc;
    wire [31:0] next_pc;
    reg [31:0] IF_ID_PC, IF_ID_INSTR;
    reg [31:0] ID_EX_PC, ID_EX_RS1, ID_EX_RS2, ID_EX_IMM;
    reg [4:0]  ID_EX_RD, ID_EX_RS1_ADDR, ID_EX_RS2_ADDR;
    reg [3:0]  ID_EX_ALU_OP;
    reg        ID_EX_REG_WRITE, ID_EX_ALU_SRC, ID_EX_MEM_READ, ID_EX_MEM_WRITE;
    reg        ID_EX_MEM_TO_REG, ID_EX_BRANCH, ID_EX_JUMP, ID_EX_CSR_WRITE;
    reg [2:0]  ID_EX_MEM_SIZE;
    reg [31:0] EX_MEM_PC, EX_MEM_ALU_RESULT, EX_MEM_RS2;
    reg [4:0]  EX_MEM_RD;
    reg        EX_MEM_REG_WRITE, EX_MEM_MEM_READ, EX_MEM_MEM_WRITE;
    reg        EX_MEM_MEM_TO_REG, EX_MEM_BRANCH, EX_MEM_JUMP, EX_MEM_BRANCH_TAKEN;
    reg [2:0]  EX_MEM_MEM_SIZE;
    reg [31:0] MEM_WB_PC, MEM_WB_ALU_RESULT, MEM_WB_MEM_DATA;
    reg [4:0]  MEM_WB_RD;
    reg        MEM_WB_REG_WRITE, MEM_WB_MEM_TO_REG, MEM_WB_JUMP;

    // Data paths
    wire [31:0] pc_plus_4 = pc + 4;
    wire [31:0] branch_target = EX_MEM_PC + EX_MEM_ALU_RESULT;
    wire [31:0] jump_target = ID_EX_PC + ID_EX_IMM;
    assign next_pc = (EX_MEM_BRANCH_TAKEN) ? branch_target :
           (ID_EX_JUMP) ? jump_target :
           pc_plus_4;

    // Instruction memory interface
    wire [31:0] instr;
    instruction_memory IMEM(.addr(pc), .instr(instr));

    // ID stage signals
    wire [6:0] opcode = IF_ID_INSTR[6:0];
    wire [2:0] funct3 = IF_ID_INSTR[14:12];
    wire [6:0] funct7 = IF_ID_INSTR[31:25];
    wire [4:0] rs1 = IF_ID_INSTR[19:15];
    wire [4:0] rs2 = IF_ID_INSTR[24:20];
    wire [4:0] rd = IF_ID_INSTR[11:7];

    // Control signals
    wire reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch, jump, csr_write;
    wire [3:0] alu_op;
    wire [2:0] imm_type, mem_size;

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

    // Immediate generator
    wire [31:0] imm;
    immediate_gen IG(
                      .instr(IF_ID_INSTR),
                      .imm_type(imm_type),
                      .imm(imm)
                  );

    // Register file
    wire [31:0] reg_rs1, reg_rs2;
    register_file RF(
                      .clk(clk),
                      .we(MEM_WB_REG_WRITE),
                      .rs1(rs1),
                      .rs2(rs2),
                      .rd(MEM_WB_RD),
                      .wd(MEM_WB_MEM_TO_REG ? MEM_WB_MEM_DATA : MEM_WB_ALU_RESULT),
                      .rd1(reg_rs1),
                      .rd2(reg_rs2)
                  );

    // Hazard detection
    wire stall, flush;
    hazard_detection_unit HDU(
                              .ID_EX_MEM_READ(ID_EX_MEM_READ),
                              .ID_EX_RD(ID_EX_RD),
                              .IF_ID_RS1(rs1),
                              .IF_ID_RS2(rs2),
                              .EX_MEM_BRANCH_TAKEN(EX_MEM_BRANCH_TAKEN),
                              .ID_EX_JUMP(ID_EX_JUMP),
                              .stall(stall),
                              .flush(flush)
                          );

    // Forwarding unit
    wire [1:0] forward_a, forward_b;

    forwarding_unit FU(
                        .ID_EX_RS1_ADDR(ID_EX_RS1_ADDR),
                        .ID_EX_RS2_ADDR(ID_EX_RS2_ADDR),
                        .EX_MEM_RD(EX_MEM_RD),
                        .MEM_WB_RD(MEM_WB_RD),
                        .EX_MEM_REG_WRITE(EX_MEM_REG_WRITE),
                        .MEM_WB_REG_WRITE(MEM_WB_REG_WRITE),
                        .forward_a(forward_a),
                        .forward_b(forward_b)
                    );

    // ALU inputs with forwarding
    wire [31:0] alu_in1 = (forward_a == 2'b00) ? ID_EX_RS1 :
         (forward_a == 2'b01) ? (MEM_WB_MEM_TO_REG ? MEM_WB_MEM_DATA : MEM_WB_ALU_RESULT) :
         (forward_a == 2'b10) ? EX_MEM_ALU_RESULT : ID_EX_RS1;

    wire [31:0] alu_in2 = (forward_b == 2'b00) ? (ID_EX_ALU_SRC ? ID_EX_IMM : ID_EX_RS2) :
         (forward_b == 2'b01) ? (MEM_WB_MEM_TO_REG ? MEM_WB_MEM_DATA : MEM_WB_ALU_RESULT) :
         (forward_b == 2'b10) ? EX_MEM_ALU_RESULT :
         (ID_EX_ALU_SRC ? ID_EX_IMM : ID_EX_RS2);

    // ALU
    wire [31:0] alu_result;
    wire branch_taken;
    alu ALU(
            .a(alu_in1),
            .b(alu_in2),
            .alu_op(ID_EX_ALU_OP),
            .pc(ID_EX_PC),
            .result(alu_result),
            .branch_taken(branch_taken)
        );

    // Data memory
    wire [31:0] mem_data;
    wire error;
    memory MEM(
               .clk(clk),
               .addr(EX_MEM_ALU_RESULT),
               .we(EX_MEM_MEM_WRITE),
               .re(EX_MEM_MEM_READ),
               .wd(EX_MEM_RS2),
               .rd(mem_data),
               .mem_size(EX_MEM_MEM_SIZE),
               .error(error)
           );

    // Pipeline update
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all pipeline registers
            pc <= 32'b0;
            IF_ID_PC <= 32'b0;
            IF_ID_INSTR <= 32'b0;

            ID_EX_PC <= 32'b0;
            ID_EX_RS1 <= 32'b0;
            ID_EX_RS2 <= 32'b0;
            ID_EX_IMM <= 32'b0;
            ID_EX_RD <= 5'b0;
            ID_EX_RS1_ADDR <= 5'b0;
            ID_EX_RS2_ADDR <= 5'b0;
            ID_EX_ALU_OP <= 4'b0;
            ID_EX_REG_WRITE <= 1'b0;
            ID_EX_ALU_SRC <= 1'b0;
            ID_EX_MEM_READ <= 1'b0;
            ID_EX_MEM_WRITE <= 1'b0;
            ID_EX_MEM_TO_REG <= 1'b0;
            ID_EX_BRANCH <= 1'b0;
            ID_EX_JUMP <= 1'b0;
            ID_EX_CSR_WRITE <= 1'b0;
            ID_EX_MEM_SIZE <= 3'b0;

            EX_MEM_PC <= 32'b0;
            EX_MEM_ALU_RESULT <= 32'b0;
            EX_MEM_RS2 <= 32'b0;
            EX_MEM_RD <= 5'b0;
            EX_MEM_REG_WRITE <= 1'b0;
            EX_MEM_MEM_READ <= 1'b0;
            EX_MEM_MEM_WRITE <= 1'b0;
            EX_MEM_MEM_TO_REG <= 1'b0;
            EX_MEM_BRANCH <= 1'b0;
            EX_MEM_JUMP <= 1'b0;
            EX_MEM_BRANCH_TAKEN <= 1'b0;
            EX_MEM_MEM_SIZE <= 3'b0;

            MEM_WB_PC <= 32'b0;
            MEM_WB_ALU_RESULT <= 32'b0;
            MEM_WB_MEM_DATA <= 32'b0;
            MEM_WB_RD <= 5'b0;
            MEM_WB_REG_WRITE <= 1'b0;
            MEM_WB_MEM_TO_REG <= 1'b0;
            MEM_WB_JUMP <= 1'b0;
        end
        else begin
            // PC update
            pc <= next_pc;

            // IF/ID stage
            if (!stall) begin
                IF_ID_PC <= pc;
                IF_ID_INSTR <= (flush || EX_MEM_BRANCH_TAKEN || ID_EX_JUMP) ? 32'h00000013 : instr; // NOP on flush/branch/jump
            end

            // ID/EX stage
            if (!stall) begin
                ID_EX_PC <= IF_ID_PC;
                ID_EX_RS1 <= reg_rs1;
                ID_EX_RS2 <= reg_rs2;
                ID_EX_IMM <= imm;
                ID_EX_RD <= rd;
                ID_EX_RS1_ADDR <= rs1;
                ID_EX_RS2_ADDR <= rs2;
                ID_EX_ALU_OP <= alu_op;
                ID_EX_REG_WRITE <= reg_write;
                ID_EX_ALU_SRC <= alu_src;
                ID_EX_MEM_READ <= mem_read;
                ID_EX_MEM_WRITE <= mem_write;
                ID_EX_MEM_TO_REG <= mem_to_reg;
                ID_EX_BRANCH <= branch;
                ID_EX_JUMP <= jump;
                ID_EX_CSR_WRITE <= csr_write;
                ID_EX_MEM_SIZE <= mem_size;
            end
            else begin
                // Insert bubble (NOP)
                ID_EX_REG_WRITE <= 1'b0;
                ID_EX_MEM_READ <= 1'b0;
                ID_EX_MEM_WRITE <= 1'b0;
                ID_EX_BRANCH <= 1'b0;
                ID_EX_JUMP <= 1'b0;
                ID_EX_CSR_WRITE <= 1'b0;
            end

            // EX/MEM stage
            EX_MEM_PC <= ID_EX_PC;
            EX_MEM_ALU_RESULT <= alu_result;
            EX_MEM_RS2 <= ID_EX_RS2;
            EX_MEM_RD <= ID_EX_RD;
            EX_MEM_REG_WRITE <= ID_EX_REG_WRITE;
            EX_MEM_MEM_READ <= ID_EX_MEM_READ;
            EX_MEM_MEM_WRITE <= ID_EX_MEM_WRITE;
            EX_MEM_MEM_TO_REG <= ID_EX_MEM_TO_REG;
            EX_MEM_BRANCH <= ID_EX_BRANCH;
            EX_MEM_JUMP <= ID_EX_JUMP;
            EX_MEM_BRANCH_TAKEN <= branch_taken && ID_EX_BRANCH;
            EX_MEM_MEM_SIZE <= ID_EX_MEM_SIZE;

            // MEM/WB stage
            MEM_WB_PC <= EX_MEM_PC;
            MEM_WB_ALU_RESULT <= EX_MEM_ALU_RESULT;
            MEM_WB_MEM_DATA <= mem_data;
            MEM_WB_RD <= EX_MEM_RD;
            MEM_WB_REG_WRITE <= EX_MEM_REG_WRITE;
            MEM_WB_MEM_TO_REG <= EX_MEM_MEM_TO_REG;
            MEM_WB_JUMP <= EX_MEM_JUMP;
        end
    end

    assign pc_out = pc;
endmodule


module forwarding_unit(
        input [4:0] ID_EX_RS1_ADDR, ID_EX_RS2_ADDR,
        input [4:0] EX_MEM_RD, MEM_WB_RD,
        input EX_MEM_REG_WRITE, MEM_WB_REG_WRITE,
        output reg [1:0] forward_a, forward_b
    );

    always @(*) begin
        // 初始化输出，避免锁存器
        forward_a = 2'b00;
        forward_b = 2'b00;

        // Forward A 逻辑
        if (EX_MEM_REG_WRITE && EX_MEM_RD != 0 && EX_MEM_RD == ID_EX_RS1_ADDR)
            forward_a = 2'b10;
        else if (MEM_WB_REG_WRITE && MEM_WB_RD != 0 && MEM_WB_RD == ID_EX_RS1_ADDR)
            forward_a = 2'b01;

        // Forward B 逻辑
        if (EX_MEM_REG_WRITE && EX_MEM_RD != 0 && EX_MEM_RD == ID_EX_RS2_ADDR)
            forward_b = 2'b10;
        else if (MEM_WB_REG_WRITE && MEM_WB_RD != 0 && MEM_WB_RD == ID_EX_RS2_ADDR)
            forward_b = 2'b01;
    end
endmodule
module hazard_detection_unit(
        input ID_EX_MEM_READ,
        input [4:0] ID_EX_RD,
        input [4:0] IF_ID_RS1, IF_ID_RS2,
        input EX_MEM_BRANCH_TAKEN,
        input ID_EX_JUMP,        // 添加跳转信号
        output reg stall,
        output reg flush
    );
    always @(*) begin
        // 加载-使用冒险
        stall = ID_EX_MEM_READ && (ID_EX_RD == IF_ID_RS1 || ID_EX_RD == IF_ID_RS2);

        // 分支预测失败或跳转
        flush = EX_MEM_BRANCH_TAKEN || ID_EX_JUMP;
    end
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

    // 确保x0始终为0
    initial
        registers[0] = 32'b0;

    assign rd1 = (rs1 == 5'b0) ? 32'b0 : registers[rs1];
    assign rd2 = (rs2 == 5'b0) ? 32'b0 : registers[rs2];

    always @(posedge clk) begin
        if (we && rd != 5'b0) // 确保不写入x0
            registers[rd] <= wd;
    end
endmodule


module alu(
        input [31:0] a, b,
        input [3:0] alu_op,
        input [31:0] pc,
        output reg [31:0] result,
        output reg branch_taken
    );
    always @(*) begin
        // 默认值
        result = 32'b0;
        branch_taken = 1'b0;

        case (alu_op)
            4'b0010:
                result = a + b;        // ADD
            4'b0110:
                result = a - b;        // SUB
            4'b0000:
                result = a & b;        // AND
            4'b0001:
                result = a | b;        // OR
            4'b0011:
                result = a ^ b;        // XOR
            4'b0100:
                result = a << b[4:0];  // SLL
            4'b0101:
                result = a >> b[4:0];  // SRL
            4'b0111:
                result = $signed(a) >>> b[4:0]; // SRA (算术右移)

            // 分支指令
            4'b1000: begin                  // BEQ
                result = (a == b) ? 32'd1 : 32'd0;
                branch_taken = (a == b);
            end
            4'b1001: begin                  // BNE
                result = (a != b) ? 32'd1 : 32'd0;
                branch_taken = (a != b);
            end
            4'b1010: begin                  // BLT
                result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
                branch_taken = ($signed(a) < $signed(b));
            end
            4'b1011: begin                  // BGE
                result = ($signed(a) >= $signed(b)) ? 32'd1 : 32'd0;
                branch_taken = ($signed(a) >= $signed(b));
            end
            4'b1100: begin                  // BLTU
                result = (a < b) ? 32'd1 : 32'd0;
                branch_taken = (a < b);
            end
            4'b1101: begin                  // BGEU
                result = (a >= b) ? 32'd1 : 32'd0;
                branch_taken = (a >= b);
            end

            // 其他指令
            4'b1110:
                result = b;            // LUI (直接输出立即数)
            4'b1111:
                result = pc + b;       // AUIPC (PC + 立即数)

            default: begin
                result = 32'b0;
                branch_taken = 1'b0;
            end
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


