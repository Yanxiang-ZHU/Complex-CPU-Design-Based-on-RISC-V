// This module generates immediate values based on the instruction format and the immediate type specified. It takes a 32-bit instruction and an immediate type as inputs, and outputs a 32-bit immediate value.
// This module should be applied after CONTROL_UNIT, which generates the immediate type.

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