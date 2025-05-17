// This module implements the ALU (Arithmetic Logic Unit) for a RISC-V processor. It performs various arithmetic and logical operations based on the control signals provided. The ALU can also handle branch instructions and immediate values.

module alu(
        input [31:0] a, b,
        input [3:0] alu_op,
        input [31:0] pc,
        output reg [31:0] result,
        output reg branch_taken
    );
    always @(*) begin
        result = 32'b0;
        branch_taken = 1'b0;

        case (alu_op)
            4'b0001:
                result = pc + 4;
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
                result = $signed(a) >>> b[4:0];  // SRA

            4'b1000: begin                       // BEQ
                result = (a == b) ? 32'd1 : 32'd0;
                branch_taken = (a == b);
            end
            4'b1001: begin                       // BNE
                result = (a != b) ? 32'd1 : 32'd0;
                branch_taken = (a != b);
            end
            4'b1010: begin                       // BLT
                result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
                branch_taken = ($signed(a) < $signed(b));
            end
            4'b1011: begin                       // BGE
                result = ($signed(a) >= $signed(b)) ? 32'd1 : 32'd0;
                branch_taken = ($signed(a) >= $signed(b));
            end
            4'b1100: begin                       // BLTU
                result = (a < b) ? 32'd1 : 32'd0;
                branch_taken = (a < b);
            end
            4'b1101: begin                       // BGEU
                result = (a >= b) ? 32'd1 : 32'd0;
                branch_taken = (a >= b);
            end

            4'b1110:
                result = b;                      // LUI
            4'b1111:
                result = pc + b;                 // AUIPC (PC + imm)

            default: begin
                result = 32'b0;
                branch_taken = 1'b0;
            end
        endcase
    end
endmodule
