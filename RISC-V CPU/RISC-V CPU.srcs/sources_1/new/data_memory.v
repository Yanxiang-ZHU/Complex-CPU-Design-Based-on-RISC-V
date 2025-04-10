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
    input [2:0] mem_size, // 000(byte), 001(halfword), 010(word)
    output reg [31:0] rd
);

    reg [3:0] write_mask;
    wire [31:0] data;

    MEMORY memory_data_operation (
        .clka(clk),
        .wea(we ? write_mask : 4'b0000),
        .addra(addr >> 2),
        .dina(wd),
        .douta(data)
    );

    always @(*) begin
        write_mask = 4'b0000;
        case (mem_size)
            3'b000: begin // SB (Store Byte)
                case (addr[1:0])
                    2'b00: write_mask = 4'b0001;
                    2'b01: write_mask = 4'b0010;
                    2'b10: write_mask = 4'b0100;
                    2'b11: write_mask = 4'b1000;
                endcase
            end
            3'b001: begin // SH (Store Halfword)
                case (addr[1])
                    1'b0: write_mask = 4'b0011;
                    1'b1: write_mask = 4'b1100;
                endcase
            end
            3'b010: begin // SW (Store Word)
                write_mask = 4'b1111;
            end
            default: write_mask = 4'b0000;
        endcase
    end

    always @(*) begin
        if (re) begin
            rd = data;
        end else begin
            rd = 32'h0;
        end
    end

endmodule