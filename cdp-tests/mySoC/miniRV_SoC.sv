module miniRV_SoC (
        input  logic         fpga_rst,   // High active
        input  logic         fpga_clk,

        output logic         debug_wb_have_inst, // 当前时钟周期是否有指令写回 (对单周期CPU，可在复位后恒置1)
        output logic [31:0]  debug_wb_pc,        // 当前写回的指令的PC (若wb_have_inst=0，此项可为任意值)
        output logic         debug_wb_ena,       // 指令写回时，寄存器堆的写使能 (若wb_have_inst=0，此项可为任意值)
        output logic [ 4:0]  debug_wb_reg,       // 指令写回时，写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
        output logic [31:0]  debug_wb_value      // 指令写回时，写入寄存器的值 (若wb_ena或wb_have_inst=0，此项可为任意值)

    );
    logic        cpu_clk = fpga_clk;
    logic [1:0]  offset;
    logic [31:0] data;
    logic [31:0] rdata;

    myCPU Core_cpu (
              .rst            (fpga_rst),
              .clk            (cpu_clk),
              .debug_wb_have_inst (debug_wb_have_inst), // 当前时钟周期是否有指令写回 (对单周期CPU，可在复位后恒置1)
              .debug_wb_pc (debug_wb_pc),
              .debug_wb_ena (debug_wb_ena),       // 指令写回时，寄存器堆的写使能 (若wb_have_inst=0，此项可为任意值)
              .debug_wb_reg (debug_wb_reg),      // 指令写回时，写入的寄存器号 (若wb_ena或wb_have_inst=0，此项可为任意值)
              .debug_wb_value (debug_wb_value)     // 指令写回时，写入寄存器的值 (若wb_ena或wb_have_inst=0，此项可为任意值)


          );

    assign offset = Core_cpu.EX_MEM_ALU_RESULT[1:0]; // 取出地址的低两位

    always @(*) begin
        case (Core_cpu.EX_MEM_MEM_SIZE[1:0])
            2'b00:  begin
                case(offset[1:0])
                    2'b00:
                        data = {rdata[31:8], Core_cpu.EX_MEM_RS2[7:0]};
                    2'b01:
                        data = {rdata[31:16], Core_cpu.EX_MEM_RS2[7:0], rdata[7:0]};
                    2'b10:
                        data = {rdata[31:24], Core_cpu.EX_MEM_RS2[7:0], rdata[15:0]};
                    2'b11:
                        data = {Core_cpu.EX_MEM_RS2[7:0], rdata[23:0]};
                endcase
            end
            2'b01: begin
                case(offset[1])
                    1'b0:
                        data = {rdata[31:16], Core_cpu.EX_MEM_RS2[15:0]};
                    1'b1:
                        data = {Core_cpu.EX_MEM_RS2[15:0], rdata[15:0]};
                endcase
            end
            2'b10: begin
                data = Core_cpu.EX_MEM_RS2;
            end
            default: begin
                data = Core_cpu.EX_MEM_RS2;
            end
        endcase
    end

    always @(*) begin
        Core_cpu.mem_data = 0;
        case (Core_cpu.EX_MEM_MEM_SIZE[1:0])
            2'b00:  begin
                case(offset[1:0])
                    2'b00:
                        Core_cpu.mem_data = {(Core_cpu.EX_MEM_MEM_SIZE[2]? 24'b0 : (rdata[7] ? 24'hffffff : 24'b0)), rdata[7:0]};
                    2'b01:
                        Core_cpu.mem_data = {(Core_cpu.EX_MEM_MEM_SIZE[2]? 24'b0 : (rdata[15] ? 24'hffffff : 24'b0)), rdata[15:8]};
                    2'b10:
                        Core_cpu.mem_data = {(Core_cpu.EX_MEM_MEM_SIZE[2]? 24'b0 : (rdata[23] ? 24'hffffff : 24'b0)), rdata[23:16]};
                    2'b11:
                        Core_cpu.mem_data = {(Core_cpu.EX_MEM_MEM_SIZE[2]? 24'b0 : (rdata[31] ? 24'hffffff : 24'b0)), rdata[31:24]};
                endcase
            end
            2'b01: begin
                case(offset[1])
                    1'b0:
                        Core_cpu.mem_data = {(Core_cpu.EX_MEM_MEM_SIZE[2]? 16'b0 : (rdata[15] ? 16'hffff : 16'b0)), rdata[15:0]};
                    1'b1:
                        Core_cpu.mem_data = {(Core_cpu.EX_MEM_MEM_SIZE[2]? 16'b0 : (rdata[31] ? 16'hffff : 16'b0)), rdata[31:16]};
                endcase
            end
            2'b10: begin
                Core_cpu.mem_data = rdata;
            end
            default: begin
                Core_cpu.mem_data = 0;
            end
        endcase
    end

    // 下面两个模块，只需要实例化代码和连线代码，不需要创建IP核

    IROM Mem_IROM (
             .a          (Core_cpu.pc >> 2),       // 连接到CPU的当前PC值
             .spo        (Core_cpu.instr)     // 将指令输出到CPU的指令总线
         );

    DRAM Mem_DRAM (
             .clk        (cpu_clk),           // 共享CPU时钟
             .a          (Core_cpu.EX_MEM_ALU_RESULT >> 2), // ALU计算结果作为地址
             .spo        (rdata), // 将读取数据送回CPU
             .we         (Core_cpu.EX_MEM_MEM_WRITE), // 使用CPU的写使能信号
             .d          (data)       // 写入数据来自CPU的RS2寄存器
         );

endmodule
