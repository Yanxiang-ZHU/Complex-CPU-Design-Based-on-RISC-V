module SPIC_Pipeline (
        input clk,
        input rst,
//        output debug_wb_have_inst, // 当前时钟周期是否有指令写�? (对单周期CPU，可在复位后恒置1)
//        output [31:0] debug_wb_pc,
//        output debug_wb_ena,       // 指令写回时，寄存器堆的写使能 (若wb_have_inst=0，此项可为任意�??)
//        output [4:0] debug_wb_reg,      // 指令写回时，写入的寄存器�? (若wb_ena或wb_have_inst=0，此项可为任意�??)
//        output [31:0] debug_wb_value     // 指令写回时，写入寄存器的�? (若wb_ena或wb_have_inst=0，此项可为任意�??)
        output [31:0] irom_addr,
        input [31:0] irom_data,
        output [31:0] perip_addr,
        output perip_wen,
        output [2:0] perip_mask,
        output [31:0] perip_wdata,
        input [31:0] perip_rdata
    );

    // pc register
    wire [31:0] pc;


    // Pipeline registers
    reg [31:0] IF_ID_PC,IF_ID_INSTR;
    reg        IF_ID_RST;
    reg [31:0] ID_EX_PC, ID_EX_RS1, ID_EX_RS2, ID_EX_IMM;
    reg [4:0]  ID_EX_RD, ID_EX_RS1_ADDR, ID_EX_RS2_ADDR;
    reg [4:0]  ID_EX_ALU_OP;
    reg        ID_EX_REG_WRITE, ID_EX_ALU_SRC, ID_EX_MEM_READ, ID_EX_MEM_WRITE;
    reg        ID_EX_MEM_TO_REG, ID_EX_BRANCH, ID_EX_JUMP, ID_EX_CSR_WRITE;
    reg [2:0]  ID_EX_MEM_SIZE;
    reg        ID_EX_RST;
    reg [31:0] EX_MEM_PC, EX_MEM_ALU_RESULT, EX_MEM_RS2;
    reg [4:0]  EX_MEM_RD;
    reg        EX_MEM_REG_WRITE, EX_MEM_MEM_READ, EX_MEM_MEM_WRITE;
    reg        EX_MEM_MEM_TO_REG, EX_MEM_BRANCH, EX_MEM_JUMP, EX_MEM_BRANCH_TAKEN;
    reg [2:0]  EX_MEM_MEM_SIZE;
    reg        EX_MEM_FLUSH, EX_MEM_STALL;
    reg        EX_MEM_RST;
    reg [31:0] MEM_WB_PC, MEM_WB_ALU_RESULT, MEM_WB_MEM_DATA;
    reg [4:0]  MEM_WB_RD;
    reg        MEM_WB_REG_WRITE, MEM_WB_MEM_TO_REG, MEM_WB_JUMP;
    reg        MEM_WB_FLUSH, MEM_WB_STALL;
    reg        MEM_WB_RST;
    reg        WB_RST;
    reg        WB_FLUSH;
    reg        WB_STALL;

    // Data paths -- restore the next pc (normal or branch or jump)
    wire signed [31:0] imm;
    wire [31:0] alu_result;
    wire branch_taken;
    reg [31:0] pc_plus_4;
    wire [31:0] reg_rs1, reg_rs2;
    wire [6:0] opcode;
    wire [31:0] branch_target = ID_EX_PC + alu_result;
    wire [1:0] forward_a, forward_b;
    wire [1:0] forward_mem;
    wire [1:0] forward_jalr;
    wire [31:0] jump_target = (opcode==7'b1100111)?($signed(imm)+(forward_jalr==2'b01 ? alu_result : (forward_jalr == 2'b10 ? EX_MEM_ALU_RESULT : (forward_jalr == 2'b11 ? MEM_WB_ALU_RESULT : reg_rs1)))):(IF_ID_PC + imm);
    wire jump;
    wire [4:0] rs1, rs2, rd;


    // Instruction memory interface
    wire [31:0] instr;
    wire [31:0] instr_new;
    wire flush;
    
    assign irom_addr = pc;
    assign instr = irom_data;
    
    assign pc = (branch_taken) ? branch_target : (jump) ? jump_target :pc_plus_4;
    assign instr_new=(flush) ? 32'h00000013 : IF_ID_INSTR;


    // Control signals
    wire reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch, csr_write;
    wire [4:0] alu_op;
    wire [2:0] imm_type;
    wire [2:0] mem_size;

    control_unit CU(
                     .instr(instr_new),
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
                     .mem_size(mem_size),
                     .rs1(rs1),
                     .rs2(rs2),
                     .rd(rd),
                     .opcode(opcode)
                 );

    // Immediate generator
    immediate_gen IG(
                      .instr(instr_new),
                      .imm_type(imm_type),
                      .imm(imm)
                  );
    // Register file
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

    // Hazard detection -- two cases: load-use hazard and branch hazard
    wire stall;
    hazard_detection_unit HDU(
                              .ID_EX_MEM_READ(ID_EX_MEM_READ),
                              .ID_EX_RD(ID_EX_RD),
                              .IF_ID_RS1(rs1),
                              .IF_ID_RS2(rs2),
                              .ID_EX_JUMP(ID_EX_JUMP),
                              .branch_taken(branch_taken),
                              .stall(stall),
                              .flush(flush)
                          );

    // Forwarding unit
    forwarding_unit FU(
                        .ID_EX_RS1_ADDR(ID_EX_RS1_ADDR),
                        .ID_EX_RS2_ADDR(ID_EX_RS2_ADDR),
                        .ID_EX_RD(ID_EX_RD),
                        .jump(jump),
                        .rs1(rs1),
                        .EX_MEM_RD(EX_MEM_RD),
                        .MEM_WB_RD(MEM_WB_RD),
                        .EX_MEM_REG_WRITE(EX_MEM_REG_WRITE),
                        .MEM_WB_REG_WRITE(MEM_WB_REG_WRITE),
                        .ID_EX_MEM_WRITE(ID_EX_MEM_WRITE),
                        .forward_a(forward_a),
                        .forward_b(forward_b),
                        .forward_mem(forward_mem),
                        .forward_jalr(forward_jalr)
                    );

    // ALU inputs with forwarding
    wire [31:0] alu_in1 = (forward_a == 2'b00) ? ID_EX_RS1 :
         (forward_a == 2'b01) ? (MEM_WB_MEM_TO_REG ? MEM_WB_MEM_DATA : MEM_WB_ALU_RESULT) :
         (forward_a == 2'b10) ? EX_MEM_ALU_RESULT : ID_EX_RS1;
    wire [31:0] alu_in2 = (forward_b == 2'b00) ? (ID_EX_ALU_SRC ? ID_EX_IMM : ID_EX_RS2) :
         (forward_b == 2'b01) ? (ID_EX_ALU_SRC ? ID_EX_IMM : (MEM_WB_MEM_TO_REG ? MEM_WB_MEM_DATA : MEM_WB_ALU_RESULT)) :
         (forward_b == 2'b10) ? (ID_EX_ALU_SRC ? ID_EX_IMM : EX_MEM_ALU_RESULT) :
         (ID_EX_ALU_SRC ? ID_EX_IMM : ID_EX_RS2);  // alu_in2 can be immediate while alu_in1 is not

    // ALU
    alu ALU(
            .a(alu_in1),
            .b(alu_in2),
            .ID_EX_IMM(ID_EX_IMM),
            .alu_op(ID_EX_ALU_OP),
            .pc(ID_EX_PC),
            .result(alu_result),
            .branch_taken(branch_taken)
        );


    wire [31:0] mem_data;
    assign perip_addr = EX_MEM_ALU_RESULT;
    assign perip_wen = EX_MEM_MEM_WRITE;
    assign perip_mask = EX_MEM_MEM_SIZE;
    assign perip_wdata = EX_MEM_RS2;
    assign mem_data = perip_rdata;

    // Pipeline CPU
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            pc_plus_4 <= 32'h8000_0000;
            // Reset all pipeline registers
            IF_ID_PC <= 32'b0;
            IF_ID_INSTR<=32'b0;
            IF_ID_RST <= 1'b1;

            ID_EX_PC <= 32'b0;
            ID_EX_RS1 <= 32'b0;
            ID_EX_RS2 <= 32'b0;
            ID_EX_IMM <= 32'b0;
            ID_EX_RD <= 5'b0;
            ID_EX_RS1_ADDR <= 5'b0;
            ID_EX_RS2_ADDR <= 5'b0;
            ID_EX_ALU_OP <= 5'b0;
            ID_EX_REG_WRITE <= 1'b0;
            ID_EX_ALU_SRC <= 1'b0;
            ID_EX_MEM_READ <= 1'b0;
            ID_EX_MEM_WRITE <= 1'b0;
            ID_EX_MEM_TO_REG <= 1'b0;
            ID_EX_BRANCH <= 1'b0;
            ID_EX_JUMP <= 1'b0;
            ID_EX_CSR_WRITE <= 1'b0;
            ID_EX_MEM_SIZE <= 3'b0;
            ID_EX_RST <= 1'b1;

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
            EX_MEM_FLUSH <= 1'b0;
            EX_MEM_STALL <= 1'b0;
            EX_MEM_RST <= 1'b1;

            MEM_WB_PC <= 32'b0;
            MEM_WB_ALU_RESULT <= 32'b0;
            MEM_WB_MEM_DATA <= 32'b0;
            MEM_WB_RD <= 5'b0;
            MEM_WB_REG_WRITE <= 1'b0;
            MEM_WB_MEM_TO_REG <= 1'b0;
            MEM_WB_JUMP <= 1'b0;
            MEM_WB_FLUSH <= 1'b0;
            MEM_WB_STALL <= 1'b0;
            MEM_WB_RST <= 1'b1;

            WB_RST <= 1'b1;
            WB_FLUSH <= 1'b0;
            WB_STALL <= 1'b0;
        end
        else begin
            // IF/ID stage
            if (!stall) begin
                pc_plus_4 <= pc + 4;
                IF_ID_PC <= pc;
                IF_ID_INSTR<=instr;
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
                ID_EX_RST <= rst;
            end
            else begin

                // Insert bubble (NOP): 清零�????有字段，而丝仅仅是控制信�????
                //                ID_EX_PC         <= 32'b0;
                //                ID_EX_RS1        <= 32'b0;
                //                ID_EX_RS2        <= 32'b0;
                //                ID_EX_IMM        <= 32'b0;
                //                ID_EX_RD         <= 5'b0;
                //                ID_EX_RS1_ADDR   <= 5'b0;
                //                ID_EX_RS2_ADDR   <= 5'b0;
                //                ID_EX_ALU_OP     <= 4'b0;
                ID_EX_REG_WRITE  <= 1'b0;
                ID_EX_ALU_SRC    <= 1'b0;
                ID_EX_MEM_READ   <= 1'b0;
                ID_EX_MEM_WRITE  <= 1'b0;
                ID_EX_MEM_TO_REG <= 1'b0;
                ID_EX_BRANCH     <= 1'b0;
                ID_EX_JUMP       <= 1'b1;
                ID_EX_CSR_WRITE  <= 1'b0;
                //                ID_EX_MEM_SIZE   <= 3'b0;
            end

            // EX/MEM stage
            EX_MEM_PC <= ID_EX_PC;
            EX_MEM_ALU_RESULT <= alu_result;
            EX_MEM_RS2 <= (forward_mem == 2'b01) ? EX_MEM_ALU_RESULT : ((forward_mem == 2'b10) ? MEM_WB_ALU_RESULT : ID_EX_RS2);
            EX_MEM_RD <= ID_EX_RD;
            EX_MEM_REG_WRITE <= ID_EX_REG_WRITE;
            EX_MEM_MEM_READ <= ID_EX_MEM_READ;
            EX_MEM_MEM_WRITE <= ID_EX_MEM_WRITE;
            EX_MEM_MEM_TO_REG <= ID_EX_MEM_TO_REG;
            EX_MEM_BRANCH <= ID_EX_BRANCH;
            EX_MEM_JUMP <= ID_EX_JUMP;
            EX_MEM_BRANCH_TAKEN <= branch_taken && ID_EX_BRANCH;
            EX_MEM_MEM_SIZE <= ID_EX_MEM_SIZE;
            EX_MEM_FLUSH <= flush;
            EX_MEM_STALL <= stall;
            EX_MEM_RST <= ID_EX_RST;

            // MEM/WB stage
            MEM_WB_PC <= EX_MEM_PC;
            MEM_WB_ALU_RESULT <= EX_MEM_ALU_RESULT;
            MEM_WB_MEM_DATA <= mem_data;
            MEM_WB_RD <= EX_MEM_RD;
            MEM_WB_REG_WRITE <= EX_MEM_REG_WRITE;
            MEM_WB_MEM_TO_REG <= EX_MEM_MEM_TO_REG;
            MEM_WB_JUMP <= EX_MEM_JUMP;
            MEM_WB_FLUSH <= EX_MEM_FLUSH;
            MEM_WB_STALL <= EX_MEM_STALL;
            MEM_WB_RST <= EX_MEM_RST;

            WB_RST<=MEM_WB_RST;
            WB_FLUSH<=MEM_WB_FLUSH;
            WB_STALL<=MEM_WB_STALL;
        end
    end
//    assign debug_wb_have_inst = (!(WB_FLUSH || WB_STALL) && (!WB_RST)); // 当前时钟周期是否有指令写�?
//    assign debug_wb_pc        = MEM_WB_PC;         // 写回阶段的指令地�?
//    assign debug_wb_ena       = MEM_WB_REG_WRITE;  // 寄存器文件写使能
//    assign debug_wb_reg       = MEM_WB_RD;         // 写回目标寄存器编�?
//    assign debug_wb_value     = MEM_WB_MEM_TO_REG ? MEM_WB_MEM_DATA : MEM_WB_ALU_RESULT; // 写回数据
endmodule


