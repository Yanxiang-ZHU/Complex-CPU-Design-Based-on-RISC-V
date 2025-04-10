// This module implements a simple memory system for a RISC-V processor. It supports read and write operations, as well as different memory sizes (byte, halfword, word). The memory is initialized from a file called "data.mem". The module also checks for address alignment and generates an error signal if the address is not aligned correctly or if the access is out of bounds.

`define MEM_SIZE        16'hFFFF
`define TEXT_START      16'h0000
`define TEXT_END        16'h3FFF
`define DATA_START      16'h4000
`define DATA_END        16'h7FFF
`define HEAP_START      16'h8000
`define HEAP_END        16'hBFFF
`define MIMO_START      16'hC000
`define MIMO_END        16'hFFFF

module data_memory(
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
                (addr >= `MIMO_START && addr <= `MIMO_END): begin
                    case (mem_size)
                        3'b000: begin  // SB
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
                        3'b001: begin  // SH
                            if (addr[0] != 0) begin
                                error <= 1;
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
                        3'b010: begin  // SW
                            if (addr[1:0] != 2'b00) begin
                                error <= 1;
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
                3'b000: begin  // LB
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
                    rd = {{24{byte_data[7]}}, byte_data};
                    error = 0;
                end
                3'b001: begin  // LH
                    if (addr[0] != 0) begin
                        rd = 32'h0;
                        error = 1;
                    end
                    else begin
                        case (addr[1])
                            1'b0:
                                half_data = word_data[15:0];
                            1'b1:
                                half_data = word_data[31:16];
                        endcase
                        rd = {{16{half_data[15]}}, half_data};
                        error = 0;
                    end
                end
                3'b010: begin  // LW
                    if (addr[1:0] != 2'b00) begin
                        rd = 32'h0;
                        error = 1;
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
                3'b100: begin  // LBU
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
                    rd = {24'b0, byte_data};
                    error = 0;
                end
                3'b101: begin  // LHU
                    if (addr[0] != 0) begin
                        rd = 32'h0;
                        error = 1;
                    end
                    else begin
                        case (addr[1])
                            1'b0:
                                half_data = word_data[15:0];
                            1'b1:
                                half_data = word_data[31:16];
                        endcase
                        rd = {16'b0, half_data};
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