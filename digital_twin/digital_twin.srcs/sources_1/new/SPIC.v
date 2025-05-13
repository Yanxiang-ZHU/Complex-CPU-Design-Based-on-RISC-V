module SPIC_Pipeline (
        input clk,
        input rst
    );

    // pc register
    reg [31:0] pc = 32'h80000000;
    wire [31:0] next_pc;

    // Pipeline registers
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

    // Data paths -- restore the next pc (normal or branch or jump)
    wire [31:0] pc_plus_4 = pc + 4;
    wire [31:0] branch_target = EX_MEM_PC + EX_MEM_ALU_RESULT;
    wire [31:0] jump_target = EX_MEM_PC + ID_EX_IMM;
    assign next_pc = (EX_MEM_BRANCH_TAKEN) ? branch_target :
           (ID_EX_JUMP) ? jump_target :
           pc_plus_4;

    // Instruction memory interface
    wire [31:0] instr;
    instruction_memory IMEM(
        .clk(clk),
        .addr(pc),
        .instr(instr)
    );

    // ID stage signals (RISC-V instruction format)
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
        .rs1(ID_EX_RS1_ADDR),
        .rs2(ID_EX_RS2_ADDR),
        .rd(MEM_WB_RD),
        .wd(MEM_WB_MEM_TO_REG ? MEM_WB_MEM_DATA : MEM_WB_ALU_RESULT),
        .rd1(reg_rs1),
        .rd2(reg_rs2)
    );

    // Hazard detection -- two cases: load-use hazard and branch hazard
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
    wire [31:0] alu_in1 = (forward_a == 2'b00) ? reg_rs1 :
        (forward_a == 2'b01) ? (MEM_WB_MEM_TO_REG ? MEM_WB_MEM_DATA : MEM_WB_ALU_RESULT) :
        (forward_a == 2'b10) ? EX_MEM_ALU_RESULT : reg_rs1;
    wire [31:0] alu_in2 = (forward_b == 2'b00) ? (ID_EX_ALU_SRC ? ID_EX_IMM : reg_rs2) :
        (forward_b == 2'b01) ? (MEM_WB_MEM_TO_REG ? MEM_WB_MEM_DATA : MEM_WB_ALU_RESULT) :
        (forward_b == 2'b10) ? EX_MEM_ALU_RESULT :
        (ID_EX_ALU_SRC ? ID_EX_IMM : reg_rs2);  // alu_in2 can be immediate while alu_in1 is not

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
    data_memory MEM(
        .clk(clk),
        .addr(EX_MEM_ALU_RESULT),
        .we(EX_MEM_MEM_WRITE),
        .re(EX_MEM_MEM_READ),
        .wd(EX_MEM_RS2),
        .rd(mem_data),
        .mem_size(EX_MEM_MEM_SIZE)
    );

    // Pipeline CPU 
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all pipeline registers
            pc <= 32'h80000000;
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

endmodule



