// This module implements the ALU (Arithmetic Logic Unit) for a RISC-V processor. It performs various arithmetic and logical operations based on the control signals provided. The ALU can also handle branch instructions and immediate values.

module alu(
        input [31:0] a, b,
        input [31:0] ID_EX_IMM,
        input [4:0] alu_op,
        input [31:0] pc,
        output reg [31:0] result,
        output reg branch_taken
    );
    always @(*) begin
        result = 32'b0;
        branch_taken = 1'b0;

        case (alu_op)
            5'b00010:
                result = a + b;        // ADD
            5'b00110:
                result = a - b;        // SUB
            5'b00000:
                result = a & b;        // AND
            5'b00001:
                result = a | b;        // OR
            5'b00011:
                result = a ^ b;        // XOR
            5'b00100:
                result = a << b[4:0];  // SLL
            5'b00101:
                result = a >> b[4:0];  // SRL
            5'b00111:
                result = $signed(a) >>> b[4:0];  // SRA

            5'b01000: begin                       // BEQ
                result = (a == b) ? ID_EX_IMM : 32'd0;
                branch_taken = (a == b);
            end
            5'b01001: begin                       // BNE
                result = (a != b) ? ID_EX_IMM : 32'd0;
                branch_taken = (a != b);
            end
            5'b01010: begin                       // BLT
                result = ($signed(a) < $signed(b)) ? ID_EX_IMM : 32'd0;
                branch_taken = ($signed(a) < $signed(b));
            end
            5'b01011: begin                       // BGE
                result = ($signed(a) >= $signed(b)) ? ID_EX_IMM : 32'd0;
                branch_taken = ($signed(a) >= $signed(b));
            end
            5'b01100: begin                       // BLTU
                result = (a < b) ? ID_EX_IMM : 32'd0;
                branch_taken = (a < b);
            end
            5'b01101: begin                       // BGEU
                result = (a >= b) ? ID_EX_IMM : 32'd0;
                branch_taken = (a >= b);
            end

            5'b01110:
                result = b;                      // LUI
            5'b01111:
                result = pc + b;                 // AUIPC (PC + imm)
            
            // jal, jalr    
            5'b10001:
                result = pc + 4;
            
            // slt, slti
            5'b11010: begin
                result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            end
            
            // sltu, sltiu
            5'b11100: begin
                result = (a < b) ? 32'd1 : 32'd0;
            end
                

            default: begin
                result = 32'b0;
                branch_taken = 1'b0;
            end
        endcase
    end
endmodule
