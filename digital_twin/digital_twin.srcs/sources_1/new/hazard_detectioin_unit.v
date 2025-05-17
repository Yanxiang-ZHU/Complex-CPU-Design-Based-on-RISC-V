// This module implements a hazard detection unit for a RISC-V processor. It detects hazards in the pipeline and generates control signals to handle them. 

module hazard_detection_unit(
        input ID_EX_MEM_READ,
        input [4:0] ID_EX_RD,
        input [4:0] IF_ID_RS1, IF_ID_RS2,
        input branch_taken,
        input ID_EX_JUMP,
        output reg stall,
        output reg flush
    );
    
    wire hazard1, hazard2;
    assign hazard1 = (IF_ID_RS1 == 5'bz) ? 0 : (ID_EX_RD == IF_ID_RS1);
    assign hazard2 = (IF_ID_RS2 == 5'bz) ? 0 : (ID_EX_RD == IF_ID_RS2);
    
    always @(*) begin
        stall = ID_EX_MEM_READ && (hazard1 || hazard2);
        flush = branch_taken || ID_EX_JUMP;
    end
endmodule
