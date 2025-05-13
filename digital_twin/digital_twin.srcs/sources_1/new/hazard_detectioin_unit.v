// This module implements a hazard detection unit for a RISC-V processor. It detects hazards in the pipeline and generates control signals to handle them. 

module hazard_detection_unit(
        input ID_EX_MEM_READ,
        input [4:0] ID_EX_RD,
        input [4:0] IF_ID_RS1, IF_ID_RS2,
        input EX_MEM_BRANCH_TAKEN,
        input ID_EX_JUMP,
        output reg stall,
        output reg flush
    );
    always @(*) begin
        stall = ID_EX_MEM_READ && (ID_EX_RD == IF_ID_RS1 || ID_EX_RD == IF_ID_RS2);
        flush = EX_MEM_BRANCH_TAKEN || ID_EX_JUMP;
    end
endmodule
