// This module implements a hazard detection unit for a RISC-V processor. It detects hazards in the pipeline and generates control signals to handle them. 

module hazard_detection_unit(
        input ID_EX_MEM_READ,
        input [4:0] ID_EX_RD,
        input [4:0] IF_ID_RS1, IF_ID_RS2,
        input branch_taken,
        output reg stall,
        output reg flush
    );
    always @(*) begin
        stall = ID_EX_MEM_READ && (ID_EX_RD == IF_ID_RS1 || ID_EX_RD == IF_ID_RS2);
        flush = branch_taken;
    end
endmodule
