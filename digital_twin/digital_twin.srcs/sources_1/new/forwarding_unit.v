// This module implements a forwarding unit for a pipelined processor. (Optimize the data hazard)
// Solve the data hazard of ID_EX_RS1_ADDR(a) and ID_EX_RS2_ADDR(b) separately.

module forwarding_unit(
        input [4:0] ID_EX_RS1_ADDR, ID_EX_RS2_ADDR,
        input [4:0] ID_EX_RD,EX_MEM_RD, MEM_WB_RD,
        input EX_MEM_REG_WRITE, MEM_WB_REG_WRITE,ID_EX_MEM_WRITE,
        input jump,
        input [4:0] rs1,
        output reg [1:0] forward_a, forward_b,
        output reg [1:0] forward_mem,
        output reg [1:0] forward_jalr
    );

    always @(*) begin
        // forward = 00 means no forwarding; forward = 01 means from MEM_WB; forward = 10 means from EX_MEM.
        forward_a = 2'b00;
        forward_b = 2'b00;
        forward_mem = 2'b00;

        // logic for Forward A
        if (EX_MEM_REG_WRITE && EX_MEM_RD != 0 && EX_MEM_RD == ID_EX_RS1_ADDR)
            forward_a = 2'b10;
        else if (MEM_WB_REG_WRITE && MEM_WB_RD != 0 && MEM_WB_RD == ID_EX_RS1_ADDR)
            forward_a = 2'b01;

        // logic for Forward B
        if (EX_MEM_REG_WRITE && EX_MEM_RD != 0 && EX_MEM_RD == ID_EX_RS2_ADDR)
            forward_b = 2'b10;
        else if (MEM_WB_REG_WRITE && MEM_WB_RD != 0 && MEM_WB_RD == ID_EX_RS2_ADDR)
            forward_b = 2'b01;

        if (ID_EX_MEM_WRITE && EX_MEM_RD != 0 && EX_MEM_RD == ID_EX_RS2_ADDR)
            forward_mem = 2'b01;
        else if (ID_EX_MEM_WRITE && MEM_WB_RD != 0 && MEM_WB_RD == ID_EX_RS2_ADDR)
            forward_mem = 2'b10;

        if ( jump && ID_EX_RD !=0&& rs1 == ID_EX_RD )
            forward_jalr = 2'b01;
        else if ( jump && EX_MEM_RD !=0 && rs1 == EX_MEM_RD )
            forward_jalr = 2'b10;
        else if (jump && MEM_WB_RD !=0 && rs1 == MEM_WB_RD )
            forward_jalr = 2'b11;
        else
            forward_jalr = 2'b00;


    end
endmodule
