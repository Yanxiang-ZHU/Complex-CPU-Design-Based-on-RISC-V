// This module implements a register file for a RISC-V processor. It contains 32 registers, each 32 bits wide. The module supports read and write operations, with the ability to write to a specified register on the rising edge of the clock. The register x0 is hardwired to always return 0 and cannot be written to.

module register_file(
        input clk,
        input we,
        input [4:0] rs1, rs2, rd,
        input [31:0] wd,
        output [31:0] rd1, rd2
    );

    // generate 32 registers in RISC-V architecture
    reg [31:0] registers [0:31];

    integer i = 0;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end

    assign rd1 = (rs1 == 5'b0) ? 32'b0 : registers[rs1];
    assign rd2 = (rs2 == 5'b0) ? 32'b0 : registers[rs2];

    always @(posedge clk) begin
        if (we && rd != 5'b0)
            registers[rd] <= wd;
    end
endmodule
