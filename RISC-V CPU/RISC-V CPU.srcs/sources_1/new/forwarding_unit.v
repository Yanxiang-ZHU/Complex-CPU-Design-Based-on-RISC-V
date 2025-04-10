// This module implements a forwarding unit for a pipelined processor. (Optimize the data hazard)
// Solve the data hazard of ID_EX_RS1_ADDR(a) and ID_EX_RS2_ADDR(b) separately.

module forwarding_unit(
        input [4:0] ID_EX_RS1_ADDR, ID_EX_RS2_ADDR,
        input [4:0] EX_MEM_RD, MEM_WB_RD,
        input EX_MEM_REG_WRITE, MEM_WB_REG_WRITE,
        output reg [1:0] forward_a, forward_b
    );

    always @(*) begin 
        // forward = 00 means no forwarding; forward = 01 means from MEM_WB; forward = 10 means from EX_MEM.
        forward_a = 2'b00;
        forward_b = 2'b00;

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
    end
endmodule